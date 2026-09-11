return {
	Play221041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 221041001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play221041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST31 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_4_0.name = "ST31"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST31 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST31

				arg_1_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST31" then
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

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 1.375

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(221041001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 55 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 55)

				if (55 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 55)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play221041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 221041002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play221041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.675

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(221041002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 27 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 27)

				if (27 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 27)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play221041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 221041003
		arg_13_1.duration_ = 5.43

		local var_13_0 = {
			ja = 5.433,
			ko = 2.933,
			zh = 2.933
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
				arg_13_0:Play221041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1076ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1076ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1076ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1076ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1076ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1076ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1076ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1076ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1076ui_story == nil then
				arg_13_1.var_.characterEffect1076ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1076ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1076ui_story then
				arg_13_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action6_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.25

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(221041003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 10 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 10)

				if (10 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 10)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041003", "story_v_out_221041.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_221041", "221041003", "story_v_out_221041.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_221041", "221041003", "story_v_out_221041.awb")

						arg_13_1:RecordAudio("221041003", var_16_15)
						arg_13_1:RecordAudio("221041003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_221041", "221041003", "story_v_out_221041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_221041", "221041003", "story_v_out_221041.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 221041004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play221041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1076ui_story = arg_17_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1076ui_story"].transform.position).z)
				arg_17_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1076ui_story"].transform.localEulerAngles = arg_17_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1076ui_story"].transform.position).z)
				arg_17_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1076ui_story"].transform.localEulerAngles = arg_17_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1076ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1076ui_story == nil then
				arg_17_1.var_.characterEffect1076ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1076ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1076ui_story then
				arg_17_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 0.875

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

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(221041004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 35 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 35)

				if (35 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 35)) > 0 and var_20_4 < var_20_7 then
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
				actorName = "1076ui_story",
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
	Play221041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 221041005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play221041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.275

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(221041005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 51 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 51)

				if (51 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 51)) > 0 and var_24_0 < var_24_3 then
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
	Play221041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 221041006
		arg_25_1.duration_ = 6.37

		local var_25_0 = {
			ja = 6.066,
			ko = 6.366,
			zh = 6.366
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
				arg_25_0:Play221041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.bgs_.ST45 == nil then
				local var_28_0 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST45")
				var_28_0.name = "ST45"
				var_28_0.transform.parent = arg_25_1.stage_.transform
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_.ST45 = var_28_0
			end

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				local var_28_1 = arg_25_1.bgs_.ST45

				arg_25_1.bgs_.ST45.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_2 = var_28_1:GetComponent("SpriteRenderer")

				if var_28_2 and var_28_2.sprite then
					local var_28_3 = 2 * (var_28_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_1.transform.localScale = Vector3.New(var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "ST45" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_4 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_5 = 2

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_5 then
				local var_28_6 = Color.New(0, 0, 0)

				var_28_6.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_4) / var_28_5)
				arg_25_1.mask_.color = var_28_6
			end

			if arg_25_1.time_ >= var_28_4 + var_28_5 and arg_25_1.time_ < var_28_4 + var_28_5 + arg_28_0 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = 1
				arg_25_1.mask_.color = var_28_7
			end

			local var_28_8 = 2

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 then
				local var_28_10 = Color.New(0, 0, 0)

				var_28_10.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_8) / var_28_9)
				arg_25_1.mask_.color = var_28_10
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 then
				local var_28_11 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_11.a = 0
				arg_25_1.mask_.color = var_28_11
			end

			local var_28_12 = arg_25_1.actors_["1076ui_story"].transform

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= 4 + arg_28_0 then
				arg_25_1.var_.moveOldPos1076ui_story = var_28_12.localPosition
			end

			local var_28_13 = 0.001

			if 4 <= arg_25_1.time_ and arg_25_1.time_ < 4 + var_28_13 then
				var_28_12.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_25_1.time_ - 4) / var_28_13)
				var_28_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_12.position).x, (manager.ui.mainCamera.transform.position - var_28_12.position).y, (manager.ui.mainCamera.transform.position - var_28_12.position).z)
				var_28_12.localEulerAngles.z = 0
				var_28_12.localEulerAngles.x = 0
				var_28_12.localEulerAngles = var_28_12.localEulerAngles
			end

			if arg_25_1.time_ >= 4 + var_28_13 and arg_25_1.time_ < 4 + var_28_13 + arg_28_0 then
				var_28_12.localPosition = Vector3.New(0, -1.06, -6.2)
				var_28_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_12.position).x, (manager.ui.mainCamera.transform.position - var_28_12.position).y, (manager.ui.mainCamera.transform.position - var_28_12.position).z)
				var_28_12.localEulerAngles.z = 0
				var_28_12.localEulerAngles.x = 0
				var_28_12.localEulerAngles = var_28_12.localEulerAngles
			end

			local var_28_14 = arg_25_1.actors_["1076ui_story"]

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= 4 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1076ui_story == nil then
				arg_25_1.var_.characterEffect1076ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_15 = 0.200000002980232

			if 4 <= arg_25_1.time_ and arg_25_1.time_ < 4 + var_28_15 and not isNil(var_28_14) then
				if arg_25_1.var_.characterEffect1076ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 4 + var_28_15 and arg_25_1.time_ < 4 + var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1076ui_story then
				arg_25_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= 4 + arg_28_0 then
				arg_25_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= 4 + arg_28_0 then
				arg_25_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_17 = 4
			local var_28_18 = 0.3

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_19 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_19:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_20 = arg_25_1:GetWordFromCfg(221041006)
				local var_28_21 = arg_25_1:FormatText(var_28_20.content)

				arg_25_1.text_.text = var_28_21

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_23 = 12 <= 0 and var_28_18 or var_28_18 * (utf8.len(var_28_21) / 12)

				if (12 <= 0 and var_28_18 or var_28_18 * (utf8.len(var_28_21) / 12)) > 0 and var_28_18 < var_28_23 then
					arg_25_1.talkMaxDuration = var_28_23
					var_28_17 = var_28_17 + 0.3

					if var_28_23 + var_28_17 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_17
					end
				end

				arg_25_1.text_.text = var_28_21
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041006", "story_v_out_221041.awb") ~= 0 then
					local var_28_24 = manager.audio:GetVoiceLength("story_v_out_221041", "221041006", "story_v_out_221041.awb") / 1000

					if var_28_24 + var_28_17 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_24 + var_28_17
					end

					if var_28_20.prefab_name ~= "" and arg_25_1.actors_[var_28_20.prefab_name] ~= nil then
						local var_28_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_20.prefab_name].transform, "story_v_out_221041", "221041006", "story_v_out_221041.awb")

						arg_25_1:RecordAudio("221041006", var_28_25)
						arg_25_1:RecordAudio("221041006", var_28_25)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_221041", "221041006", "story_v_out_221041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_221041", "221041006", "story_v_out_221041.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_26 = var_28_17 + 0.3
			local var_28_27 = math.max(var_28_18, arg_25_1.talkMaxDuration)

			if var_28_17 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_26 + var_28_27 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_26) / var_28_27

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_26 + var_28_27 and arg_25_1.time_ < var_28_26 + var_28_27 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play221041007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 221041007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play221041008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1076ui_story = arg_31_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).z)
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles = arg_31_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).z)
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles = arg_31_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1076ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1076ui_story == nil then
				arg_31_1.var_.characterEffect1076ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1076ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_2)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1076ui_story then
				arg_31_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_34_3 = 0
			local var_34_4 = 1.65

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_5 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(221041007).content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 66 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 66)

				if (66 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 66)) > 0 and var_34_4 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_3
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_8 = math.max(var_34_4, arg_31_1.talkMaxDuration)

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_8 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_3) / var_34_8

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_3 + var_34_8 and arg_31_1.time_ < var_34_3 + var_34_8 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221041008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 221041008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play221041009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 1.9

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

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(221041008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 76 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 76)

				if (76 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 76)) > 0 and var_38_0 < var_38_3 then
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
	Play221041009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 221041009
		arg_39_1.duration_ = 8.5

		local var_39_0 = {
			ja = 8.5,
			ko = 6.533,
			zh = 6.533
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
				arg_39_0:Play221041010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1076ui_story = arg_39_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1076ui_story"].transform.position).z)
				arg_39_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1076ui_story"].transform.localEulerAngles = arg_39_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_39_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1076ui_story"].transform.position).z)
				arg_39_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1076ui_story"].transform.localEulerAngles = arg_39_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1076ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1076ui_story == nil then
				arg_39_1.var_.characterEffect1076ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1076ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1076ui_story then
				arg_39_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action6_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_4 = 0
			local var_42_5 = 0.6

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(221041009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 24 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 24)

				if (24 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 24)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041009", "story_v_out_221041.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041009", "story_v_out_221041.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_221041", "221041009", "story_v_out_221041.awb")

						arg_39_1:RecordAudio("221041009", var_42_11)
						arg_39_1:RecordAudio("221041009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_221041", "221041009", "story_v_out_221041.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_221041", "221041009", "story_v_out_221041.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_12 and arg_39_1.time_ < var_42_4 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play221041010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 221041010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play221041011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1076ui_story = arg_43_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1076ui_story"].transform.position).z)
				arg_43_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1076ui_story"].transform.localEulerAngles = arg_43_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1076ui_story"].transform.position).z)
				arg_43_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1076ui_story"].transform.localEulerAngles = arg_43_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1076ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1076ui_story == nil then
				arg_43_1.var_.characterEffect1076ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1076ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_2)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1076ui_story then
				arg_43_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_46_3 = 0
			local var_46_4 = 1.675

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_3 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_5 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(221041010).content)

				arg_43_1.text_.text = var_46_5

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_7 = 67 <= 0 and var_46_4 or var_46_4 * (utf8.len(var_46_5) / 67)

				if (67 <= 0 and var_46_4 or var_46_4 * (utf8.len(var_46_5) / 67)) > 0 and var_46_4 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_3 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_3
					end
				end

				arg_43_1.text_.text = var_46_5
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_8 = math.max(var_46_4, arg_43_1.talkMaxDuration)

			if var_46_3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_3 + var_46_8 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_3) / var_46_8

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_3 + var_46_8 and arg_43_1.time_ < var_46_3 + var_46_8 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play221041011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 221041011
		arg_47_1.duration_ = 13.7

		local var_47_0 = {
			ja = 13.7,
			ko = 12.933,
			zh = 12.933
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
				arg_47_0:Play221041012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1076ui_story = arg_47_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1076ui_story"].transform.position).z)
				arg_47_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1076ui_story"].transform.localEulerAngles = arg_47_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_47_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1076ui_story"].transform.position).z)
				arg_47_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1076ui_story"].transform.localEulerAngles = arg_47_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1076ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1076ui_story == nil then
				arg_47_1.var_.characterEffect1076ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1076ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1076ui_story then
				arg_47_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_4 = 0
			local var_50_5 = 1.375

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(221041011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 55 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 55)

				if (55 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 55)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041011", "story_v_out_221041.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041011", "story_v_out_221041.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_221041", "221041011", "story_v_out_221041.awb")

						arg_47_1:RecordAudio("221041011", var_50_11)
						arg_47_1:RecordAudio("221041011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_221041", "221041011", "story_v_out_221041.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_221041", "221041011", "story_v_out_221041.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_12 and arg_47_1.time_ < var_50_4 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play221041012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 221041012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play221041013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1076ui_story = arg_51_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1076ui_story"].transform.position).z)
				arg_51_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1076ui_story"].transform.localEulerAngles = arg_51_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1076ui_story"].transform.position).z)
				arg_51_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1076ui_story"].transform.localEulerAngles = arg_51_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1076ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1076ui_story == nil then
				arg_51_1.var_.characterEffect1076ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1076ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_2)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1076ui_story then
				arg_51_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_54_3 = 0
			local var_54_4 = 0.825

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_5 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(221041012).content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 33 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 33)

				if (33 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 33)) > 0 and var_54_4 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_3
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_4, arg_51_1.talkMaxDuration)

			if var_54_3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_3 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_3) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_3 + var_54_8 and arg_51_1.time_ < var_54_3 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play221041013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 221041013
		arg_55_1.duration_ = 3.73

		local var_55_0 = {
			ja = 3.733,
			ko = 3.466,
			zh = 3.466
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play221041014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1076ui_story = arg_55_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1076ui_story"].transform.position).z)
				arg_55_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1076ui_story"].transform.localEulerAngles = arg_55_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_55_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1076ui_story"].transform.position).z)
				arg_55_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1076ui_story"].transform.localEulerAngles = arg_55_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1076ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1076ui_story == nil then
				arg_55_1.var_.characterEffect1076ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1076ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1076ui_story then
				arg_55_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.225

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(221041013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 9 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 9)

				if (9 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 9)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041013", "story_v_out_221041.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041013", "story_v_out_221041.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_221041", "221041013", "story_v_out_221041.awb")

						arg_55_1:RecordAudio("221041013", var_58_11)
						arg_55_1:RecordAudio("221041013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_221041", "221041013", "story_v_out_221041.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_221041", "221041013", "story_v_out_221041.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play221041014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 221041014
		arg_59_1.duration_ = 9

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play221041015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 2 < arg_59_1.time_ and arg_59_1.time_ <= 2 + arg_62_0 then
				local var_62_0 = arg_59_1.bgs_.ST31

				arg_59_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_62_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_1 = var_62_0:GetComponent("SpriteRenderer")

				if var_62_1 and var_62_1.sprite then
					local var_62_2 = 2 * (var_62_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_62_0.transform.localScale = Vector3.New(var_62_2 / var_62_1.sprite.bounds.size.y < var_62_2 * manager.ui.mainCameraCom_.aspect / var_62_1.sprite.bounds.size.x and var_62_2 * manager.ui.mainCameraCom_.aspect / var_62_1.sprite.bounds.size.x or var_62_2 / var_62_1.sprite.bounds.size.y, var_62_2 / var_62_1.sprite.bounds.size.y < var_62_2 * manager.ui.mainCameraCom_.aspect / var_62_1.sprite.bounds.size.x and var_62_2 * manager.ui.mainCameraCom_.aspect / var_62_1.sprite.bounds.size.x or var_62_2 / var_62_1.sprite.bounds.size.y, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "ST31" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_3 = 0

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_3 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_4 = 2

			if var_62_3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_3 + var_62_4 then
				local var_62_5 = Color.New(0, 0, 0)

				var_62_5.a = Mathf.Lerp(0, 1, (arg_59_1.time_ - var_62_3) / var_62_4)
				arg_59_1.mask_.color = var_62_5
			end

			if arg_59_1.time_ >= var_62_3 + var_62_4 and arg_59_1.time_ < var_62_3 + var_62_4 + arg_62_0 then
				local var_62_6 = Color.New(0, 0, 0)

				var_62_6.a = 1
				arg_59_1.mask_.color = var_62_6
			end

			local var_62_7 = 2

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_8 = 2

			if var_62_7 <= arg_59_1.time_ and arg_59_1.time_ < var_62_7 + var_62_8 then
				local var_62_9 = Color.New(0, 0, 0)

				var_62_9.a = Mathf.Lerp(1, 0, (arg_59_1.time_ - var_62_7) / var_62_8)
				arg_59_1.mask_.color = var_62_9
			end

			if arg_59_1.time_ >= var_62_7 + var_62_8 and arg_59_1.time_ < var_62_7 + var_62_8 + arg_62_0 then
				local var_62_10 = Color.New(0, 0, 0)

				arg_59_1.mask_.enabled = false
				var_62_10.a = 0
				arg_59_1.mask_.color = var_62_10
			end

			local var_62_11 = arg_59_1.actors_["1076ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1076ui_story = var_62_11.localPosition
			end

			local var_62_12 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_12 then
				var_62_11.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_12)
				var_62_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_11.position).x, (manager.ui.mainCamera.transform.position - var_62_11.position).y, (manager.ui.mainCamera.transform.position - var_62_11.position).z)
				var_62_11.localEulerAngles.z = 0
				var_62_11.localEulerAngles.x = 0
				var_62_11.localEulerAngles = var_62_11.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_12 and arg_59_1.time_ < 0 + var_62_12 + arg_62_0 then
				var_62_11.localPosition = Vector3.New(0, 100, 0)
				var_62_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_11.position).x, (manager.ui.mainCamera.transform.position - var_62_11.position).y, (manager.ui.mainCamera.transform.position - var_62_11.position).z)
				var_62_11.localEulerAngles.z = 0
				var_62_11.localEulerAngles.x = 0
				var_62_11.localEulerAngles = var_62_11.localEulerAngles
			end

			local var_62_13 = arg_59_1.actors_["1076ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_13) and arg_59_1.var_.characterEffect1076ui_story == nil then
				arg_59_1.var_.characterEffect1076ui_story = var_62_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_14 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_14 and not isNil(var_62_13) then
				if arg_59_1.var_.characterEffect1076ui_story and not isNil(var_62_13) then
					arg_59_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_14)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_14 and arg_59_1.time_ < 0 + var_62_14 + arg_62_0 and not isNil(var_62_13) and arg_59_1.var_.characterEffect1076ui_story then
				arg_59_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_15 = 4
			local var_62_16 = 0.85

			if 4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_17 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_17:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(221041014).content)

				arg_59_1.text_.text = var_62_18

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 34 <= 0 and var_62_16 or var_62_16 * (utf8.len(var_62_18) / 34)

				if (34 <= 0 and var_62_16 or var_62_16 * (utf8.len(var_62_18) / 34)) > 0 and var_62_16 < var_62_20 then
					arg_59_1.talkMaxDuration = var_62_20
					var_62_15 = var_62_15 + 0.3

					if var_62_20 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_20 + var_62_15
					end
				end

				arg_59_1.text_.text = var_62_18
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_21 = var_62_15 + 0.3
			local var_62_22 = math.max(var_62_16, arg_59_1.talkMaxDuration)

			if var_62_15 + 0.3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_21 + var_62_22 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_21) / var_62_22

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_21 + var_62_22 and arg_59_1.time_ < var_62_21 + var_62_22 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play221041015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 221041015
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play221041016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1076ui_story = arg_65_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).z)
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles = arg_65_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_65_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1076ui_story"].transform.position).z)
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1076ui_story"].transform.localEulerAngles = arg_65_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1076ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1076ui_story == nil then
				arg_65_1.var_.characterEffect1076ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1076ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1076ui_story then
				arg_65_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.05

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(221041015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 2 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 2)

				if (2 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 2)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041015", "story_v_out_221041.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041015", "story_v_out_221041.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_221041", "221041015", "story_v_out_221041.awb")

						arg_65_1:RecordAudio("221041015", var_68_11)
						arg_65_1:RecordAudio("221041015", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_221041", "221041015", "story_v_out_221041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_221041", "221041015", "story_v_out_221041.awb")
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
				actorName = "1076ui_story",
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
	Play221041016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 221041016
		arg_69_1.duration_ = 7.23

		local var_69_0 = {
			ja = 7.233,
			ko = 6.8,
			zh = 6.8
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play221041017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_72_0 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_69_1.stage_.transform)

				var_72_0.name = "1072ui_story"
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1072ui_story"] = var_72_0

				local var_72_1 = var_72_0:GetComponentInChildren(typeof(CharacterEffect))

				var_72_1.enabled = true

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_1.transform, false)

				arg_69_1.var_["1072ui_story" .. "Animator"] = var_72_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_["1072ui_story" .. "Animator"].applyRootMotion = true
				arg_69_1.var_["1072ui_story" .. "LipSync"] = var_72_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_3 = arg_69_1.actors_["1072ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1072ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_69_1.time_ - 0) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0, -0.71, -6)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			local var_72_5 = arg_69_1.actors_["1072ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1072ui_story == nil then
				arg_69_1.var_.characterEffect1072ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1072ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1072ui_story then
				arg_69_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_72_8 = arg_69_1.actors_["1076ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1076ui_story = var_72_8.localPosition
			end

			local var_72_9 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 then
				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_9)
				var_72_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_8.position).x, (manager.ui.mainCamera.transform.position - var_72_8.position).y, (manager.ui.mainCamera.transform.position - var_72_8.position).z)
				var_72_8.localEulerAngles.z = 0
				var_72_8.localEulerAngles.x = 0
				var_72_8.localEulerAngles = var_72_8.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(0, 100, 0)
				var_72_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_8.position).x, (manager.ui.mainCamera.transform.position - var_72_8.position).y, (manager.ui.mainCamera.transform.position - var_72_8.position).z)
				var_72_8.localEulerAngles.z = 0
				var_72_8.localEulerAngles.x = 0
				var_72_8.localEulerAngles = var_72_8.localEulerAngles
			end

			local var_72_10 = arg_69_1.actors_["1076ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_10) and arg_69_1.var_.characterEffect1076ui_story == nil then
				arg_69_1.var_.characterEffect1076ui_story = var_72_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_11 and not isNil(var_72_10) then
				if arg_69_1.var_.characterEffect1076ui_story and not isNil(var_72_10) then
					arg_69_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_11)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_11 and arg_69_1.time_ < 0 + var_72_11 + arg_72_0 and not isNil(var_72_10) and arg_69_1.var_.characterEffect1076ui_story then
				arg_69_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_72_12 = 0
			local var_72_13 = 0.75

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_14 = arg_69_1:GetWordFromCfg(221041016)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 30 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 30)

				if (30 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 30)) > 0 and var_72_13 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17

					if var_72_17 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041016", "story_v_out_221041.awb") ~= 0 then
					local var_72_18 = manager.audio:GetVoiceLength("story_v_out_221041", "221041016", "story_v_out_221041.awb") / 1000

					if var_72_18 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_12
					end

					if var_72_14.prefab_name ~= "" and arg_69_1.actors_[var_72_14.prefab_name] ~= nil then
						local var_72_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_14.prefab_name].transform, "story_v_out_221041", "221041016", "story_v_out_221041.awb")

						arg_69_1:RecordAudio("221041016", var_72_19)
						arg_69_1:RecordAudio("221041016", var_72_19)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_221041", "221041016", "story_v_out_221041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_221041", "221041016", "story_v_out_221041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_20 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_20 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_20

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_20 and arg_69_1.time_ < var_72_12 + var_72_20 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221041017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 221041017
		arg_73_1.duration_ = 8.67

		local var_73_0 = {
			ja = 8.666,
			ko = 6.133,
			zh = 6.133
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
				arg_73_0:Play221041018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1072ui_story = arg_73_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).z)
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles = arg_73_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_73_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).z)
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles = arg_73_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_76_1 = 0
			local var_76_2 = 0.7

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(221041017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 28 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 28)

				if (28 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 28)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041017", "story_v_out_221041.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_221041", "221041017", "story_v_out_221041.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_221041", "221041017", "story_v_out_221041.awb")

						arg_73_1:RecordAudio("221041017", var_76_8)
						arg_73_1:RecordAudio("221041017", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_221041", "221041017", "story_v_out_221041.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_221041", "221041017", "story_v_out_221041.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221041018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 221041018
		arg_77_1.duration_ = 12.53

		local var_77_0 = {
			ja = 12.533,
			ko = 12.333,
			zh = 12.333
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play221041019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.bgs_.ST40 == nil then
				local var_80_0 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST40")
				var_80_0.name = "ST40"
				var_80_0.transform.parent = arg_77_1.stage_.transform
				var_80_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_.ST40 = var_80_0
			end

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= 2 + arg_80_0 then
				local var_80_1 = arg_77_1.bgs_.ST40

				arg_77_1.bgs_.ST40.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_80_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_2 = var_80_1:GetComponent("SpriteRenderer")

				if var_80_2 and var_80_2.sprite then
					local var_80_3 = 2 * (var_80_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_80_1.transform.localScale = Vector3.New(var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "ST40" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_4 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_5 = 2

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_5 then
				local var_80_6 = Color.New(0, 0, 0)

				var_80_6.a = Mathf.Lerp(0, 1, (arg_77_1.time_ - var_80_4) / var_80_5)
				arg_77_1.mask_.color = var_80_6
			end

			if arg_77_1.time_ >= var_80_4 + var_80_5 and arg_77_1.time_ < var_80_4 + var_80_5 + arg_80_0 then
				local var_80_7 = Color.New(0, 0, 0)

				var_80_7.a = 1
				arg_77_1.mask_.color = var_80_7
			end

			local var_80_8 = 2

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_9 = 2

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 then
				local var_80_10 = Color.New(0, 0, 0)

				var_80_10.a = Mathf.Lerp(1, 0, (arg_77_1.time_ - var_80_8) / var_80_9)
				arg_77_1.mask_.color = var_80_10
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 then
				local var_80_11 = Color.New(0, 0, 0)

				arg_77_1.mask_.enabled = false
				var_80_11.a = 0
				arg_77_1.mask_.color = var_80_11
			end

			local var_80_12 = arg_77_1.actors_["1072ui_story"].transform

			if 4 < arg_77_1.time_ and arg_77_1.time_ <= 4 + arg_80_0 then
				arg_77_1.var_.moveOldPos1072ui_story = var_80_12.localPosition
			end

			local var_80_13 = 0.001

			if 4 <= arg_77_1.time_ and arg_77_1.time_ < 4 + var_80_13 then
				var_80_12.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_77_1.time_ - 4) / var_80_13)
				var_80_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_12.position).x, (manager.ui.mainCamera.transform.position - var_80_12.position).y, (manager.ui.mainCamera.transform.position - var_80_12.position).z)
				var_80_12.localEulerAngles.z = 0
				var_80_12.localEulerAngles.x = 0
				var_80_12.localEulerAngles = var_80_12.localEulerAngles
			end

			if arg_77_1.time_ >= 4 + var_80_13 and arg_77_1.time_ < 4 + var_80_13 + arg_80_0 then
				var_80_12.localPosition = Vector3.New(0, -0.71, -6)
				var_80_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_12.position).x, (manager.ui.mainCamera.transform.position - var_80_12.position).y, (manager.ui.mainCamera.transform.position - var_80_12.position).z)
				var_80_12.localEulerAngles.z = 0
				var_80_12.localEulerAngles.x = 0
				var_80_12.localEulerAngles = var_80_12.localEulerAngles
			end

			local var_80_14 = arg_77_1.actors_["1072ui_story"]

			if 4 < arg_77_1.time_ and arg_77_1.time_ <= 4 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect1072ui_story == nil then
				arg_77_1.var_.characterEffect1072ui_story = var_80_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_15 = 0.200000002980232

			if 4 <= arg_77_1.time_ and arg_77_1.time_ < 4 + var_80_15 and not isNil(var_80_14) then
				if arg_77_1.var_.characterEffect1072ui_story and not isNil(var_80_14) then
					arg_77_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 4 + var_80_15 and arg_77_1.time_ < 4 + var_80_15 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect1072ui_story then
				arg_77_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 4 < arg_77_1.time_ and arg_77_1.time_ <= 4 + arg_80_0 then
				arg_77_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 4 < arg_77_1.time_ and arg_77_1.time_ <= 4 + arg_80_0 then
				arg_77_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_17 = arg_77_1.actors_["1072ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1072ui_story = var_80_17.localPosition
			end

			local var_80_18 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_18 then
				var_80_17.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_18)
				var_80_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_17.position).x, (manager.ui.mainCamera.transform.position - var_80_17.position).y, (manager.ui.mainCamera.transform.position - var_80_17.position).z)
				var_80_17.localEulerAngles.z = 0
				var_80_17.localEulerAngles.x = 0
				var_80_17.localEulerAngles = var_80_17.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_18 and arg_77_1.time_ < 0 + var_80_18 + arg_80_0 then
				var_80_17.localPosition = Vector3.New(0, 100, 0)
				var_80_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_17.position).x, (manager.ui.mainCamera.transform.position - var_80_17.position).y, (manager.ui.mainCamera.transform.position - var_80_17.position).z)
				var_80_17.localEulerAngles.z = 0
				var_80_17.localEulerAngles.x = 0
				var_80_17.localEulerAngles = var_80_17.localEulerAngles
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_19 = 4
			local var_80_20 = 1.075

			if 4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_19 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_21 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_21:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_22 = arg_77_1:GetWordFromCfg(221041018)
				local var_80_23 = arg_77_1:FormatText(var_80_22.content)

				arg_77_1.text_.text = var_80_23

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_25 = 43 <= 0 and var_80_20 or var_80_20 * (utf8.len(var_80_23) / 43)

				if (43 <= 0 and var_80_20 or var_80_20 * (utf8.len(var_80_23) / 43)) > 0 and var_80_20 < var_80_25 then
					arg_77_1.talkMaxDuration = var_80_25
					var_80_19 = var_80_19 + 0.3

					if var_80_25 + var_80_19 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_25 + var_80_19
					end
				end

				arg_77_1.text_.text = var_80_23
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041018", "story_v_out_221041.awb") ~= 0 then
					local var_80_26 = manager.audio:GetVoiceLength("story_v_out_221041", "221041018", "story_v_out_221041.awb") / 1000

					if var_80_26 + var_80_19 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_26 + var_80_19
					end

					if var_80_22.prefab_name ~= "" and arg_77_1.actors_[var_80_22.prefab_name] ~= nil then
						local var_80_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_22.prefab_name].transform, "story_v_out_221041", "221041018", "story_v_out_221041.awb")

						arg_77_1:RecordAudio("221041018", var_80_27)
						arg_77_1:RecordAudio("221041018", var_80_27)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_221041", "221041018", "story_v_out_221041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_221041", "221041018", "story_v_out_221041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_28 = var_80_19 + 0.3
			local var_80_29 = math.max(var_80_20, arg_77_1.talkMaxDuration)

			if var_80_19 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_28 + var_80_29 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_28) / var_80_29

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_28 + var_80_29 and arg_77_1.time_ < var_80_28 + var_80_29 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221041019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 221041019
		arg_83_1.duration_ = 13.53

		local var_83_0 = {
			ja = 13.533,
			ko = 7.966,
			zh = 7.966
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
				arg_83_0:Play221041020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1072ui_story"]) and arg_83_1.var_.characterEffect1072ui_story == nil then
				arg_83_1.var_.characterEffect1072ui_story = arg_83_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1072ui_story"]) then
				if arg_83_1.var_.characterEffect1072ui_story and not isNil(arg_83_1.actors_["1072ui_story"]) then
					arg_83_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1072ui_story"]) and arg_83_1.var_.characterEffect1072ui_story then
				arg_83_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 1.075

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(221041019)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 43 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 43)

				if (43 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 43)) > 0 and var_86_2 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041019", "story_v_out_221041.awb") ~= 0 then
					local var_86_7 = manager.audio:GetVoiceLength("story_v_out_221041", "221041019", "story_v_out_221041.awb") / 1000

					if var_86_7 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_1
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_221041", "221041019", "story_v_out_221041.awb")

						arg_83_1:RecordAudio("221041019", var_86_8)
						arg_83_1:RecordAudio("221041019", var_86_8)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_221041", "221041019", "story_v_out_221041.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_221041", "221041019", "story_v_out_221041.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_9 and arg_83_1.time_ < var_86_1 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play221041020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 221041020
		arg_87_1.duration_ = 7.63

		local var_87_0 = {
			ja = 7.633,
			ko = 6.3,
			zh = 6.3
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
				arg_87_0:Play221041021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1072ui_story = arg_87_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).z)
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles = arg_87_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_87_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1072ui_story"].transform.position).z)
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1072ui_story"].transform.localEulerAngles = arg_87_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1072ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1072ui_story == nil then
				arg_87_1.var_.characterEffect1072ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1072ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1072ui_story then
				arg_87_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_90_4 = 0
			local var_90_5 = 0.675

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(221041020)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 27 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 27)

				if (27 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 27)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041020", "story_v_out_221041.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041020", "story_v_out_221041.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_221041", "221041020", "story_v_out_221041.awb")

						arg_87_1:RecordAudio("221041020", var_90_11)
						arg_87_1:RecordAudio("221041020", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_221041", "221041020", "story_v_out_221041.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_221041", "221041020", "story_v_out_221041.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play221041021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 221041021
		arg_91_1.duration_ = 8.73

		local var_91_0 = {
			ja = 8.733,
			ko = 7.366,
			zh = 7.366
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play221041022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1072ui_story"]) and arg_91_1.var_.characterEffect1072ui_story == nil then
				arg_91_1.var_.characterEffect1072ui_story = arg_91_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1072ui_story"]) then
				if arg_91_1.var_.characterEffect1072ui_story and not isNil(arg_91_1.actors_["1072ui_story"]) then
					arg_91_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1072ui_story"]) and arg_91_1.var_.characterEffect1072ui_story then
				arg_91_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_94_1 = 0
			local var_94_2 = 0.9

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(221041021)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_6 = 36 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_4) / 36)

				if (36 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_4) / 36)) > 0 and var_94_2 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041021", "story_v_out_221041.awb") ~= 0 then
					local var_94_7 = manager.audio:GetVoiceLength("story_v_out_221041", "221041021", "story_v_out_221041.awb") / 1000

					if var_94_7 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_1
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_221041", "221041021", "story_v_out_221041.awb")

						arg_91_1:RecordAudio("221041021", var_94_8)
						arg_91_1:RecordAudio("221041021", var_94_8)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_221041", "221041021", "story_v_out_221041.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_221041", "221041021", "story_v_out_221041.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_9 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_9 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_9

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_9 and arg_91_1.time_ < var_94_1 + var_94_9 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play221041022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 221041022
		arg_95_1.duration_ = 5.1

		local var_95_0 = {
			ja = 4.7,
			ko = 5.1,
			zh = 5.1
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play221041023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1072ui_story = arg_95_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).z)
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles = arg_95_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_95_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1072ui_story"].transform.position).z)
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1072ui_story"].transform.localEulerAngles = arg_95_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1072ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1072ui_story == nil then
				arg_95_1.var_.characterEffect1072ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1072ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1072ui_story then
				arg_95_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_98_4 = 0
			local var_98_5 = 0.525

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(221041022)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 21 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 21)

				if (21 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 21)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041022", "story_v_out_221041.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041022", "story_v_out_221041.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_221041", "221041022", "story_v_out_221041.awb")

						arg_95_1:RecordAudio("221041022", var_98_11)
						arg_95_1:RecordAudio("221041022", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_221041", "221041022", "story_v_out_221041.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_221041", "221041022", "story_v_out_221041.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play221041023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 221041023
		arg_99_1.duration_ = 1.5

		local var_99_0 = {
			ja = 1.5,
			ko = 1.1,
			zh = 1.1
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play221041024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1072ui_story"]) and arg_99_1.var_.characterEffect1072ui_story == nil then
				arg_99_1.var_.characterEffect1072ui_story = arg_99_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1072ui_story"]) then
				if arg_99_1.var_.characterEffect1072ui_story and not isNil(arg_99_1.actors_["1072ui_story"]) then
					arg_99_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1072ui_story"]) and arg_99_1.var_.characterEffect1072ui_story then
				arg_99_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_102_1 = 0
			local var_102_2 = 0.075

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(221041023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_6 = 3 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_4) / 3)

				if (3 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_4) / 3)) > 0 and var_102_2 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041023", "story_v_out_221041.awb") ~= 0 then
					local var_102_7 = manager.audio:GetVoiceLength("story_v_out_221041", "221041023", "story_v_out_221041.awb") / 1000

					if var_102_7 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_1
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_221041", "221041023", "story_v_out_221041.awb")

						arg_99_1:RecordAudio("221041023", var_102_8)
						arg_99_1:RecordAudio("221041023", var_102_8)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_221041", "221041023", "story_v_out_221041.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_221041", "221041023", "story_v_out_221041.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_9 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_9 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_9

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_9 and arg_99_1.time_ < var_102_1 + var_102_9 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play221041024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 221041024
		arg_103_1.duration_ = 1.17

		local var_103_0 = {
			ja = 1.166,
			ko = 0.999999999999,
			zh = 0.999999999999
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play221041025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1076ui_story = arg_103_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1076ui_story"].transform.position).z)
				arg_103_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1076ui_story"].transform.localEulerAngles = arg_103_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_103_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1076ui_story"].transform.position).z)
				arg_103_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1076ui_story"].transform.localEulerAngles = arg_103_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1076ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1076ui_story == nil then
				arg_103_1.var_.characterEffect1076ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1076ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1076ui_story then
				arg_103_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_4 = arg_103_1.actors_["1072ui_story"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1072ui_story = var_106_4.localPosition
			end

			local var_106_5 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_5 then
				var_106_4.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_103_1.time_ - 0) / var_106_5)
				var_106_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_4.position).x, (manager.ui.mainCamera.transform.position - var_106_4.position).y, (manager.ui.mainCamera.transform.position - var_106_4.position).z)
				var_106_4.localEulerAngles.z = 0
				var_106_4.localEulerAngles.x = 0
				var_106_4.localEulerAngles = var_106_4.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_5 and arg_103_1.time_ < 0 + var_106_5 + arg_106_0 then
				var_106_4.localPosition = Vector3.New(0, 100, 0)
				var_106_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_4.position).x, (manager.ui.mainCamera.transform.position - var_106_4.position).y, (manager.ui.mainCamera.transform.position - var_106_4.position).z)
				var_106_4.localEulerAngles.z = 0
				var_106_4.localEulerAngles.x = 0
				var_106_4.localEulerAngles = var_106_4.localEulerAngles
			end

			local var_106_6 = arg_103_1.actors_["1072ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect1072ui_story == nil then
				arg_103_1.var_.characterEffect1072ui_story = var_106_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_7 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 and not isNil(var_106_6) then
				if arg_103_1.var_.characterEffect1072ui_story and not isNil(var_106_6) then
					arg_103_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_7)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect1072ui_story then
				arg_103_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_106_8 = 0
			local var_106_9 = 0.05

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_10 = arg_103_1:GetWordFromCfg(221041024)
				local var_106_11 = arg_103_1:FormatText(var_106_10.content)

				arg_103_1.text_.text = var_106_11

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 2 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 2)

				if (2 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 2)) > 0 and var_106_9 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_8
					end
				end

				arg_103_1.text_.text = var_106_11
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041024", "story_v_out_221041.awb") ~= 0 then
					local var_106_14 = manager.audio:GetVoiceLength("story_v_out_221041", "221041024", "story_v_out_221041.awb") / 1000

					if var_106_14 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_8
					end

					if var_106_10.prefab_name ~= "" and arg_103_1.actors_[var_106_10.prefab_name] ~= nil then
						local var_106_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_10.prefab_name].transform, "story_v_out_221041", "221041024", "story_v_out_221041.awb")

						arg_103_1:RecordAudio("221041024", var_106_15)
						arg_103_1:RecordAudio("221041024", var_106_15)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_221041", "221041024", "story_v_out_221041.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_221041", "221041024", "story_v_out_221041.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_16 = math.max(var_106_9, arg_103_1.talkMaxDuration)

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_16 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_8) / var_106_16

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_8 + var_106_16 and arg_103_1.time_ < var_106_8 + var_106_16 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play221041025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 221041025
		arg_107_1.duration_ = 9.43

		local var_107_0 = {
			ja = 9.433,
			ko = 5.466,
			zh = 5.466
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play221041026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1072ui_story = arg_107_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1072ui_story"].transform.position).z)
				arg_107_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1072ui_story"].transform.localEulerAngles = arg_107_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_107_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1072ui_story"].transform.position).z)
				arg_107_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1072ui_story"].transform.localEulerAngles = arg_107_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["1072ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1072ui_story == nil then
				arg_107_1.var_.characterEffect1072ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1072ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1072ui_story then
				arg_107_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_110_4 = arg_107_1.actors_["1076ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1076ui_story == nil then
				arg_107_1.var_.characterEffect1076ui_story = var_110_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_5 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 and not isNil(var_110_4) then
				if arg_107_1.var_.characterEffect1076ui_story and not isNil(var_110_4) then
					arg_107_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_5)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1076ui_story then
				arg_107_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_110_6 = 0
			local var_110_7 = 0.65

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_8 = arg_107_1:GetWordFromCfg(221041025)
				local var_110_9 = arg_107_1:FormatText(var_110_8.content)

				arg_107_1.text_.text = var_110_9

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 26 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 26)

				if (26 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 26)) > 0 and var_110_7 < var_110_11 then
					arg_107_1.talkMaxDuration = var_110_11

					if var_110_11 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_9
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041025", "story_v_out_221041.awb") ~= 0 then
					local var_110_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041025", "story_v_out_221041.awb") / 1000

					if var_110_12 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_6
					end

					if var_110_8.prefab_name ~= "" and arg_107_1.actors_[var_110_8.prefab_name] ~= nil then
						local var_110_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_8.prefab_name].transform, "story_v_out_221041", "221041025", "story_v_out_221041.awb")

						arg_107_1:RecordAudio("221041025", var_110_13)
						arg_107_1:RecordAudio("221041025", var_110_13)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_221041", "221041025", "story_v_out_221041.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_221041", "221041025", "story_v_out_221041.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play221041026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 221041026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play221041027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1072ui_story"]) and arg_111_1.var_.characterEffect1072ui_story == nil then
				arg_111_1.var_.characterEffect1072ui_story = arg_111_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1072ui_story"]) then
				if arg_111_1.var_.characterEffect1072ui_story and not isNil(arg_111_1.actors_["1072ui_story"]) then
					arg_111_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1072ui_story"]) and arg_111_1.var_.characterEffect1072ui_story then
				arg_111_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.975

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(221041026).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 39 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 39)

				if (39 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 39)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play221041027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 221041027
		arg_115_1.duration_ = 4.4

		local var_115_0 = {
			ja = 4.4,
			ko = 2.3,
			zh = 2.3
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play221041028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1076ui_story = arg_115_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1076ui_story"].transform.position).z)
				arg_115_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1076ui_story"].transform.localEulerAngles = arg_115_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_115_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1076ui_story"].transform.position).z)
				arg_115_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1076ui_story"].transform.localEulerAngles = arg_115_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1076ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1076ui_story == nil then
				arg_115_1.var_.characterEffect1076ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1076ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1076ui_story then
				arg_115_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_118_4 = 0
			local var_118_5 = 0.275

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(221041027)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 11 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 11)

				if (11 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 11)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041027", "story_v_out_221041.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041027", "story_v_out_221041.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_221041", "221041027", "story_v_out_221041.awb")

						arg_115_1:RecordAudio("221041027", var_118_11)
						arg_115_1:RecordAudio("221041027", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_221041", "221041027", "story_v_out_221041.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_221041", "221041027", "story_v_out_221041.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play221041028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 221041028
		arg_119_1.duration_ = 3.07

		local var_119_0 = {
			ja = 3.066,
			ko = 2.066,
			zh = 2.066
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
				arg_119_0:Play221041029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1072ui_story = arg_119_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).z)
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles = arg_119_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_119_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1072ui_story"].transform.position).z)
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1072ui_story"].transform.localEulerAngles = arg_119_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1072ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1072ui_story == nil then
				arg_119_1.var_.characterEffect1072ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1072ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1072ui_story then
				arg_119_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_4 = arg_119_1.actors_["1076ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1076ui_story == nil then
				arg_119_1.var_.characterEffect1076ui_story = var_122_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_5 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_5 and not isNil(var_122_4) then
				if arg_119_1.var_.characterEffect1076ui_story and not isNil(var_122_4) then
					arg_119_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_5)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_5 and arg_119_1.time_ < 0 + var_122_5 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1076ui_story then
				arg_119_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_122_6 = 0
			local var_122_7 = 0.225

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_8 = arg_119_1:GetWordFromCfg(221041028)
				local var_122_9 = arg_119_1:FormatText(var_122_8.content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 9 <= 0 and var_122_7 or var_122_7 * (utf8.len(var_122_9) / 9)

				if (9 <= 0 and var_122_7 or var_122_7 * (utf8.len(var_122_9) / 9)) > 0 and var_122_7 < var_122_11 then
					arg_119_1.talkMaxDuration = var_122_11

					if var_122_11 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041028", "story_v_out_221041.awb") ~= 0 then
					local var_122_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041028", "story_v_out_221041.awb") / 1000

					if var_122_12 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_12 + var_122_6
					end

					if var_122_8.prefab_name ~= "" and arg_119_1.actors_[var_122_8.prefab_name] ~= nil then
						local var_122_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_8.prefab_name].transform, "story_v_out_221041", "221041028", "story_v_out_221041.awb")

						arg_119_1:RecordAudio("221041028", var_122_13)
						arg_119_1:RecordAudio("221041028", var_122_13)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_221041", "221041028", "story_v_out_221041.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_221041", "221041028", "story_v_out_221041.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play221041029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 221041029
		arg_123_1.duration_ = 4.7

		local var_123_0 = {
			ja = 4.7,
			ko = 3.533,
			zh = 3.533
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play221041030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1072ui_story = arg_123_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).z)
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles = arg_123_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_123_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).z)
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles = arg_123_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1072ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1072ui_story == nil then
				arg_123_1.var_.characterEffect1072ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1072ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1072ui_story then
				arg_123_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_4 = 0
			local var_126_5 = 0.475

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(221041029)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 19 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 19)

				if (19 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 19)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041029", "story_v_out_221041.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041029", "story_v_out_221041.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_221041", "221041029", "story_v_out_221041.awb")

						arg_123_1:RecordAudio("221041029", var_126_11)
						arg_123_1:RecordAudio("221041029", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_221041", "221041029", "story_v_out_221041.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_221041", "221041029", "story_v_out_221041.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play221041030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 221041030
		arg_127_1.duration_ = 3.8

		local var_127_0 = {
			ja = 3.8,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_127_0:Play221041031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1076ui_story = arg_127_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).z)
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles = arg_127_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_127_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1076ui_story"].transform.position).z)
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1076ui_story"].transform.localEulerAngles = arg_127_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1076ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1076ui_story == nil then
				arg_127_1.var_.characterEffect1076ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1076ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1076ui_story then
				arg_127_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_4 = arg_127_1.actors_["1072ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect1072ui_story == nil then
				arg_127_1.var_.characterEffect1072ui_story = var_130_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_5 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 and not isNil(var_130_4) then
				if arg_127_1.var_.characterEffect1072ui_story and not isNil(var_130_4) then
					arg_127_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_5)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect1072ui_story then
				arg_127_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_130_6 = 0
			local var_130_7 = 0.225

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(221041030)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 9 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 9)

				if (9 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 9)) > 0 and var_130_7 < var_130_11 then
					arg_127_1.talkMaxDuration = var_130_11

					if var_130_11 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041030", "story_v_out_221041.awb") ~= 0 then
					local var_130_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041030", "story_v_out_221041.awb") / 1000

					if var_130_12 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_6
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_out_221041", "221041030", "story_v_out_221041.awb")

						arg_127_1:RecordAudio("221041030", var_130_13)
						arg_127_1:RecordAudio("221041030", var_130_13)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_221041", "221041030", "story_v_out_221041.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_221041", "221041030", "story_v_out_221041.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play221041031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 221041031
		arg_131_1.duration_ = 3.73

		local var_131_0 = {
			ja = 3.533,
			ko = 3.733,
			zh = 3.733
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
				arg_131_0:Play221041032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1072ui_story = arg_131_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).z)
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles = arg_131_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_131_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1072ui_story"].transform.position).z)
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1072ui_story"].transform.localEulerAngles = arg_131_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1072ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1072ui_story == nil then
				arg_131_1.var_.characterEffect1072ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1072ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1072ui_story then
				arg_131_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_2")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_4 = arg_131_1.actors_["1076ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1076ui_story == nil then
				arg_131_1.var_.characterEffect1076ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_5 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 and not isNil(var_134_4) then
				if arg_131_1.var_.characterEffect1076ui_story and not isNil(var_134_4) then
					arg_131_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_5)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1076ui_story then
				arg_131_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_134_6 = 0
			local var_134_7 = 0.375

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(221041031)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 15 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 15)

				if (15 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 15)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041031", "story_v_out_221041.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041031", "story_v_out_221041.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_221041", "221041031", "story_v_out_221041.awb")

						arg_131_1:RecordAudio("221041031", var_134_13)
						arg_131_1:RecordAudio("221041031", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_221041", "221041031", "story_v_out_221041.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_221041", "221041031", "story_v_out_221041.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221041032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 221041032
		arg_135_1.duration_ = 4.6

		local var_135_0 = {
			ja = 4.6,
			ko = 3.766,
			zh = 3.766
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
				arg_135_0:Play221041033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1072ui_story = arg_135_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1072ui_story"].transform.position).z)
				arg_135_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1072ui_story"].transform.localEulerAngles = arg_135_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_135_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1072ui_story"].transform.position).z)
				arg_135_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1072ui_story"].transform.localEulerAngles = arg_135_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1072ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1072ui_story == nil then
				arg_135_1.var_.characterEffect1072ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1072ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1072ui_story then
				arg_135_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_4 = 0
			local var_138_5 = 0.35

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(221041032)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 14 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 14)

				if (14 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 14)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041032", "story_v_out_221041.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041032", "story_v_out_221041.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_221041", "221041032", "story_v_out_221041.awb")

						arg_135_1:RecordAudio("221041032", var_138_11)
						arg_135_1:RecordAudio("221041032", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_221041", "221041032", "story_v_out_221041.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_221041", "221041032", "story_v_out_221041.awb")
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
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play221041033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 221041033
		arg_139_1.duration_ = 4.57

		local var_139_0 = {
			ja = 4.566,
			ko = 2.466,
			zh = 2.466
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
				arg_139_0:Play221041034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1076ui_story = arg_139_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).z)
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles = arg_139_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_139_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1076ui_story"].transform.position).z)
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1076ui_story"].transform.localEulerAngles = arg_139_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1076ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1076ui_story == nil then
				arg_139_1.var_.characterEffect1076ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1076ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1076ui_story then
				arg_139_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_2")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_4 = arg_139_1.actors_["1072ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect1072ui_story == nil then
				arg_139_1.var_.characterEffect1072ui_story = var_142_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_5 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 and not isNil(var_142_4) then
				if arg_139_1.var_.characterEffect1072ui_story and not isNil(var_142_4) then
					arg_139_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_5)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect1072ui_story then
				arg_139_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_142_6 = 0
			local var_142_7 = 0.325

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(221041033)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 13 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 13)

				if (13 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 13)) > 0 and var_142_7 < var_142_11 then
					arg_139_1.talkMaxDuration = var_142_11

					if var_142_11 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041033", "story_v_out_221041.awb") ~= 0 then
					local var_142_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041033", "story_v_out_221041.awb") / 1000

					if var_142_12 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_6
					end

					if var_142_8.prefab_name ~= "" and arg_139_1.actors_[var_142_8.prefab_name] ~= nil then
						local var_142_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_8.prefab_name].transform, "story_v_out_221041", "221041033", "story_v_out_221041.awb")

						arg_139_1:RecordAudio("221041033", var_142_13)
						arg_139_1:RecordAudio("221041033", var_142_13)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_221041", "221041033", "story_v_out_221041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_221041", "221041033", "story_v_out_221041.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play221041034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 221041034
		arg_143_1.duration_ = 16.97

		local var_143_0 = {
			ja = 16.966,
			ko = 12.633,
			zh = 12.633
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
				arg_143_0:Play221041035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1072ui_story = arg_143_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).z)
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles = arg_143_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_143_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1072ui_story"].transform.position).z)
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1072ui_story"].transform.localEulerAngles = arg_143_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1072ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1072ui_story == nil then
				arg_143_1.var_.characterEffect1072ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1072ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1072ui_story then
				arg_143_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_146_4 = arg_143_1.actors_["1076ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect1076ui_story == nil then
				arg_143_1.var_.characterEffect1076ui_story = var_146_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_5 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 and not isNil(var_146_4) then
				if arg_143_1.var_.characterEffect1076ui_story and not isNil(var_146_4) then
					arg_143_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_5)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect1076ui_story then
				arg_143_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_146_6 = 0
			local var_146_7 = 1.325

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(221041034)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 53 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 53)

				if (53 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 53)) > 0 and var_146_7 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041034", "story_v_out_221041.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041034", "story_v_out_221041.awb") / 1000

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end

					if var_146_8.prefab_name ~= "" and arg_143_1.actors_[var_146_8.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_8.prefab_name].transform, "story_v_out_221041", "221041034", "story_v_out_221041.awb")

						arg_143_1:RecordAudio("221041034", var_146_13)
						arg_143_1:RecordAudio("221041034", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_221041", "221041034", "story_v_out_221041.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_221041", "221041034", "story_v_out_221041.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221041035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 221041035
		arg_147_1.duration_ = 7.87

		local var_147_0 = {
			ja = 6.933,
			ko = 7.866,
			zh = 7.866
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
				arg_147_0:Play221041036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1072ui_story = arg_147_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1072ui_story"].transform.position).z)
				arg_147_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1072ui_story"].transform.localEulerAngles = arg_147_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_147_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1072ui_story"].transform.position).z)
				arg_147_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1072ui_story"].transform.localEulerAngles = arg_147_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1072ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1072ui_story == nil then
				arg_147_1.var_.characterEffect1072ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1072ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1072ui_story then
				arg_147_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_4 = 0
			local var_150_5 = 0.825

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(221041035)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 34 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 34)

				if (34 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 34)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041035", "story_v_out_221041.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041035", "story_v_out_221041.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_221041", "221041035", "story_v_out_221041.awb")

						arg_147_1:RecordAudio("221041035", var_150_11)
						arg_147_1:RecordAudio("221041035", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_221041", "221041035", "story_v_out_221041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_221041", "221041035", "story_v_out_221041.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play221041036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 221041036
		arg_151_1.duration_ = 13.17

		local var_151_0 = {
			ja = 13.166,
			ko = 9.333,
			zh = 9.333
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
				arg_151_0:Play221041037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1076ui_story = arg_151_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1076ui_story"].transform.position).z)
				arg_151_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1076ui_story"].transform.localEulerAngles = arg_151_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_151_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1076ui_story"].transform.position).z)
				arg_151_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1076ui_story"].transform.localEulerAngles = arg_151_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1076ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1076ui_story == nil then
				arg_151_1.var_.characterEffect1076ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1076ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1076ui_story then
				arg_151_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_4 = arg_151_1.actors_["1072ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect1072ui_story == nil then
				arg_151_1.var_.characterEffect1072ui_story = var_154_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_5 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_5 and not isNil(var_154_4) then
				if arg_151_1.var_.characterEffect1072ui_story and not isNil(var_154_4) then
					arg_151_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_5)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_5 and arg_151_1.time_ < 0 + var_154_5 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect1072ui_story then
				arg_151_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_154_6 = 0
			local var_154_7 = 0.95

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:GetWordFromCfg(221041036)
				local var_154_9 = arg_151_1:FormatText(var_154_8.content)

				arg_151_1.text_.text = var_154_9

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 38 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_9) / 38)

				if (38 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_9) / 38)) > 0 and var_154_7 < var_154_11 then
					arg_151_1.talkMaxDuration = var_154_11

					if var_154_11 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_9
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041036", "story_v_out_221041.awb") ~= 0 then
					local var_154_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041036", "story_v_out_221041.awb") / 1000

					if var_154_12 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_6
					end

					if var_154_8.prefab_name ~= "" and arg_151_1.actors_[var_154_8.prefab_name] ~= nil then
						local var_154_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_8.prefab_name].transform, "story_v_out_221041", "221041036", "story_v_out_221041.awb")

						arg_151_1:RecordAudio("221041036", var_154_13)
						arg_151_1:RecordAudio("221041036", var_154_13)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_221041", "221041036", "story_v_out_221041.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_221041", "221041036", "story_v_out_221041.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play221041037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 221041037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play221041038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1076ui_story"]) and arg_155_1.var_.characterEffect1076ui_story == nil then
				arg_155_1.var_.characterEffect1076ui_story = arg_155_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1076ui_story"]) then
				if arg_155_1.var_.characterEffect1076ui_story and not isNil(arg_155_1.actors_["1076ui_story"]) then
					arg_155_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1076ui_story"]) and arg_155_1.var_.characterEffect1076ui_story then
				arg_155_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.875

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(221041037).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 35 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 35)

				if (35 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 35)) > 0 and var_158_2 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_6 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_6 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_6

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_6 and arg_155_1.time_ < var_158_1 + var_158_6 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play221041038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 221041038
		arg_159_1.duration_ = 8.57

		local var_159_0 = {
			ja = 8.566,
			ko = 7.4,
			zh = 7.4
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
				arg_159_0:Play221041039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1072ui_story = arg_159_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).z)
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles = arg_159_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_159_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1072ui_story"].transform.position).z)
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1072ui_story"].transform.localEulerAngles = arg_159_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1072ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1072ui_story == nil then
				arg_159_1.var_.characterEffect1072ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1072ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1072ui_story then
				arg_159_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_4 = 0
			local var_162_5 = 0.75

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(221041038)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 30 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 30)

				if (30 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 30)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041038", "story_v_out_221041.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041038", "story_v_out_221041.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_221041", "221041038", "story_v_out_221041.awb")

						arg_159_1:RecordAudio("221041038", var_162_11)
						arg_159_1:RecordAudio("221041038", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_221041", "221041038", "story_v_out_221041.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_221041", "221041038", "story_v_out_221041.awb")
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
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play221041039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 221041039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play221041040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1072ui_story"]) and arg_163_1.var_.characterEffect1072ui_story == nil then
				arg_163_1.var_.characterEffect1072ui_story = arg_163_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1072ui_story"]) then
				if arg_163_1.var_.characterEffect1072ui_story and not isNil(arg_163_1.actors_["1072ui_story"]) then
					arg_163_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1072ui_story"]) and arg_163_1.var_.characterEffect1072ui_story then
				arg_163_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_166_1 = arg_163_1.actors_["1072ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1072ui_story = var_166_1.localPosition
			end

			local var_166_2 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 then
				var_166_1.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_2)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 then
				var_166_1.localPosition = Vector3.New(0, 100, 0)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			local var_166_3 = arg_163_1.actors_["1076ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1076ui_story = var_166_3.localPosition
			end

			local var_166_4 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_3.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_4)
				var_166_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_3.position).x, (manager.ui.mainCamera.transform.position - var_166_3.position).y, (manager.ui.mainCamera.transform.position - var_166_3.position).z)
				var_166_3.localEulerAngles.z = 0
				var_166_3.localEulerAngles.x = 0
				var_166_3.localEulerAngles = var_166_3.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_3.localPosition = Vector3.New(0, 100, 0)
				var_166_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_3.position).x, (manager.ui.mainCamera.transform.position - var_166_3.position).y, (manager.ui.mainCamera.transform.position - var_166_3.position).z)
				var_166_3.localEulerAngles.z = 0
				var_166_3.localEulerAngles.x = 0
				var_166_3.localEulerAngles = var_166_3.localEulerAngles
			end

			local var_166_5 = 0
			local var_166_6 = 0.525

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(221041039).content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 21 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_7) / 21)

				if (21 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_7) / 21)) > 0 and var_166_6 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_6, arg_163_1.talkMaxDuration)

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_5) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_5 + var_166_10 and arg_163_1.time_ < var_166_5 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play221041040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 221041040
		arg_167_1.duration_ = 2.33

		local var_167_0 = {
			ja = 2.333,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_167_0:Play221041041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1076ui_story = arg_167_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1076ui_story"].transform.position).z)
				arg_167_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1076ui_story"].transform.localEulerAngles = arg_167_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_167_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1076ui_story"].transform.position).z)
				arg_167_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1076ui_story"].transform.localEulerAngles = arg_167_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1076ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1076ui_story == nil then
				arg_167_1.var_.characterEffect1076ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1076ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1076ui_story then
				arg_167_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_4 = arg_167_1.actors_["1072ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1072ui_story = var_170_4.localPosition
			end

			local var_170_5 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_5 then
				var_170_4.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_167_1.time_ - 0) / var_170_5)
				var_170_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_4.position).x, (manager.ui.mainCamera.transform.position - var_170_4.position).y, (manager.ui.mainCamera.transform.position - var_170_4.position).z)
				var_170_4.localEulerAngles.z = 0
				var_170_4.localEulerAngles.x = 0
				var_170_4.localEulerAngles = var_170_4.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_5 and arg_167_1.time_ < 0 + var_170_5 + arg_170_0 then
				var_170_4.localPosition = Vector3.New(0.7, -0.71, -6)
				var_170_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_4.position).x, (manager.ui.mainCamera.transform.position - var_170_4.position).y, (manager.ui.mainCamera.transform.position - var_170_4.position).z)
				var_170_4.localEulerAngles.z = 0
				var_170_4.localEulerAngles.x = 0
				var_170_4.localEulerAngles = var_170_4.localEulerAngles
			end

			local var_170_6 = 0
			local var_170_7 = 0.1

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_8 = arg_167_1:GetWordFromCfg(221041040)
				local var_170_9 = arg_167_1:FormatText(var_170_8.content)

				arg_167_1.text_.text = var_170_9

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 4 <= 0 and var_170_7 or var_170_7 * (utf8.len(var_170_9) / 4)

				if (4 <= 0 and var_170_7 or var_170_7 * (utf8.len(var_170_9) / 4)) > 0 and var_170_7 < var_170_11 then
					arg_167_1.talkMaxDuration = var_170_11

					if var_170_11 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_9
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041040", "story_v_out_221041.awb") ~= 0 then
					local var_170_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041040", "story_v_out_221041.awb") / 1000

					if var_170_12 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_6
					end

					if var_170_8.prefab_name ~= "" and arg_167_1.actors_[var_170_8.prefab_name] ~= nil then
						local var_170_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_8.prefab_name].transform, "story_v_out_221041", "221041040", "story_v_out_221041.awb")

						arg_167_1:RecordAudio("221041040", var_170_13)
						arg_167_1:RecordAudio("221041040", var_170_13)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_221041", "221041040", "story_v_out_221041.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_221041", "221041040", "story_v_out_221041.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play221041041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 221041041
		arg_171_1.duration_ = 4.87

		local var_171_0 = {
			ja = 4.866,
			ko = 4,
			zh = 4
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play221041042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1072ui_story = arg_171_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).z)
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles = arg_171_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_171_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1072ui_story"].transform.position).z)
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1072ui_story"].transform.localEulerAngles = arg_171_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1072ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1072ui_story == nil then
				arg_171_1.var_.characterEffect1072ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1072ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1072ui_story then
				arg_171_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_174_4 = arg_171_1.actors_["1076ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1076ui_story == nil then
				arg_171_1.var_.characterEffect1076ui_story = var_174_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_5 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_5 and not isNil(var_174_4) then
				if arg_171_1.var_.characterEffect1076ui_story and not isNil(var_174_4) then
					arg_171_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_5)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_5 and arg_171_1.time_ < 0 + var_174_5 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1076ui_story then
				arg_171_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_174_6 = 0
			local var_174_7 = 0.375

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_8 = arg_171_1:GetWordFromCfg(221041041)
				local var_174_9 = arg_171_1:FormatText(var_174_8.content)

				arg_171_1.text_.text = var_174_9

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_11 = 15 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_9) / 15)

				if (15 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_9) / 15)) > 0 and var_174_7 < var_174_11 then
					arg_171_1.talkMaxDuration = var_174_11

					if var_174_11 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_9
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041041", "story_v_out_221041.awb") ~= 0 then
					local var_174_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041041", "story_v_out_221041.awb") / 1000

					if var_174_12 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_6
					end

					if var_174_8.prefab_name ~= "" and arg_171_1.actors_[var_174_8.prefab_name] ~= nil then
						local var_174_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_8.prefab_name].transform, "story_v_out_221041", "221041041", "story_v_out_221041.awb")

						arg_171_1:RecordAudio("221041041", var_174_13)
						arg_171_1:RecordAudio("221041041", var_174_13)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_221041", "221041041", "story_v_out_221041.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_221041", "221041041", "story_v_out_221041.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_14 and arg_171_1.time_ < var_174_6 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play221041042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 221041042
		arg_175_1.duration_ = 2

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play221041043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1076ui_story = arg_175_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1076ui_story"].transform.position).z)
				arg_175_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1076ui_story"].transform.localEulerAngles = arg_175_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_175_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1076ui_story"].transform.position).z)
				arg_175_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1076ui_story"].transform.localEulerAngles = arg_175_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1076ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1076ui_story == nil then
				arg_175_1.var_.characterEffect1076ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1076ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1076ui_story then
				arg_175_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_2")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_4 = arg_175_1.actors_["1072ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect1072ui_story == nil then
				arg_175_1.var_.characterEffect1072ui_story = var_178_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_5 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_5 and not isNil(var_178_4) then
				if arg_175_1.var_.characterEffect1072ui_story and not isNil(var_178_4) then
					arg_175_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_5)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_5 and arg_175_1.time_ < 0 + var_178_5 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect1072ui_story then
				arg_175_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_178_6 = 0
			local var_178_7 = 0.25

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_8 = arg_175_1:GetWordFromCfg(221041042)
				local var_178_9 = arg_175_1:FormatText(var_178_8.content)

				arg_175_1.text_.text = var_178_9

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 10 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_9) / 10)

				if (10 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_9) / 10)) > 0 and var_178_7 < var_178_11 then
					arg_175_1.talkMaxDuration = var_178_11

					if var_178_11 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_9
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041042", "story_v_out_221041.awb") ~= 0 then
					local var_178_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041042", "story_v_out_221041.awb") / 1000

					if var_178_12 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_6
					end

					if var_178_8.prefab_name ~= "" and arg_175_1.actors_[var_178_8.prefab_name] ~= nil then
						local var_178_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_8.prefab_name].transform, "story_v_out_221041", "221041042", "story_v_out_221041.awb")

						arg_175_1:RecordAudio("221041042", var_178_13)
						arg_175_1:RecordAudio("221041042", var_178_13)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_221041", "221041042", "story_v_out_221041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_221041", "221041042", "story_v_out_221041.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play221041043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 221041043
		arg_179_1.duration_ = 6.7

		local var_179_0 = {
			ja = 6.7,
			ko = 4.933,
			zh = 4.933
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play221041044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1072ui_story = arg_179_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1072ui_story"].transform.position).z)
				arg_179_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1072ui_story"].transform.localEulerAngles = arg_179_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_179_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1072ui_story"].transform.position).z)
				arg_179_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1072ui_story"].transform.localEulerAngles = arg_179_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1072ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1072ui_story == nil then
				arg_179_1.var_.characterEffect1072ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1072ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1072ui_story then
				arg_179_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_4 = arg_179_1.actors_["1076ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect1076ui_story == nil then
				arg_179_1.var_.characterEffect1076ui_story = var_182_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_5 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_5 and not isNil(var_182_4) then
				if arg_179_1.var_.characterEffect1076ui_story and not isNil(var_182_4) then
					arg_179_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_5)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_5 and arg_179_1.time_ < 0 + var_182_5 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect1076ui_story then
				arg_179_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_182_6 = 0
			local var_182_7 = 0.575

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_8 = arg_179_1:GetWordFromCfg(221041043)
				local var_182_9 = arg_179_1:FormatText(var_182_8.content)

				arg_179_1.text_.text = var_182_9

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 23 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 23)

				if (23 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 23)) > 0 and var_182_7 < var_182_11 then
					arg_179_1.talkMaxDuration = var_182_11

					if var_182_11 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_9
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041043", "story_v_out_221041.awb") ~= 0 then
					local var_182_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041043", "story_v_out_221041.awb") / 1000

					if var_182_12 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_6
					end

					if var_182_8.prefab_name ~= "" and arg_179_1.actors_[var_182_8.prefab_name] ~= nil then
						local var_182_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_8.prefab_name].transform, "story_v_out_221041", "221041043", "story_v_out_221041.awb")

						arg_179_1:RecordAudio("221041043", var_182_13)
						arg_179_1:RecordAudio("221041043", var_182_13)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_221041", "221041043", "story_v_out_221041.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_221041", "221041043", "story_v_out_221041.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_14 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_14

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_14 and arg_179_1.time_ < var_182_6 + var_182_14 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play221041044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 221041044
		arg_183_1.duration_ = 2.9

		local var_183_0 = {
			ja = 2.9,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_183_0:Play221041045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1076ui_story = arg_183_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1076ui_story"].transform.position).z)
				arg_183_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1076ui_story"].transform.localEulerAngles = arg_183_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_183_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1076ui_story"].transform.position).z)
				arg_183_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1076ui_story"].transform.localEulerAngles = arg_183_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1076ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1076ui_story == nil then
				arg_183_1.var_.characterEffect1076ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1076ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1076ui_story then
				arg_183_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_186_4 = arg_183_1.actors_["1072ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect1072ui_story == nil then
				arg_183_1.var_.characterEffect1072ui_story = var_186_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_5 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_5 and not isNil(var_186_4) then
				if arg_183_1.var_.characterEffect1072ui_story and not isNil(var_186_4) then
					arg_183_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_5)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_5 and arg_183_1.time_ < 0 + var_186_5 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect1072ui_story then
				arg_183_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_2")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_186_6 = 0
			local var_186_7 = 0.05

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(221041044)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 2 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 2)

				if (2 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 2)) > 0 and var_186_7 < var_186_11 then
					arg_183_1.talkMaxDuration = var_186_11

					if var_186_11 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041044", "story_v_out_221041.awb") ~= 0 then
					local var_186_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041044", "story_v_out_221041.awb") / 1000

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end

					if var_186_8.prefab_name ~= "" and arg_183_1.actors_[var_186_8.prefab_name] ~= nil then
						local var_186_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_8.prefab_name].transform, "story_v_out_221041", "221041044", "story_v_out_221041.awb")

						arg_183_1:RecordAudio("221041044", var_186_13)
						arg_183_1:RecordAudio("221041044", var_186_13)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_221041", "221041044", "story_v_out_221041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_221041", "221041044", "story_v_out_221041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play221041045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 221041045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play221041046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1076ui_story"]) and arg_187_1.var_.characterEffect1076ui_story == nil then
				arg_187_1.var_.characterEffect1076ui_story = arg_187_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1076ui_story"]) then
				if arg_187_1.var_.characterEffect1076ui_story and not isNil(arg_187_1.actors_["1076ui_story"]) then
					arg_187_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1076ui_story"]) and arg_187_1.var_.characterEffect1076ui_story then
				arg_187_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 1.4

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(221041045).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 55 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 55)

				if (55 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 55)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play221041046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 221041046
		arg_191_1.duration_ = 9.93

		local var_191_0 = {
			ja = 9.933,
			ko = 6.333,
			zh = 6.333
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
				arg_191_0:Play221041047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1076ui_story = arg_191_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1076ui_story"].transform.position).z)
				arg_191_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1076ui_story"].transform.localEulerAngles = arg_191_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_191_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1076ui_story"].transform.position).z)
				arg_191_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1076ui_story"].transform.localEulerAngles = arg_191_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1076ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1076ui_story == nil then
				arg_191_1.var_.characterEffect1076ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1076ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1076ui_story then
				arg_191_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_4 = 0
			local var_194_5 = 0.675

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(221041046)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 27 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 27)

				if (27 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 27)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041046", "story_v_out_221041.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041046", "story_v_out_221041.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_221041", "221041046", "story_v_out_221041.awb")

						arg_191_1:RecordAudio("221041046", var_194_11)
						arg_191_1:RecordAudio("221041046", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_221041", "221041046", "story_v_out_221041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_221041", "221041046", "story_v_out_221041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_12 and arg_191_1.time_ < var_194_4 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play221041047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 221041047
		arg_195_1.duration_ = 4.8

		local var_195_0 = {
			ja = 4.8,
			ko = 3.566,
			zh = 3.566
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play221041048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1072ui_story = arg_195_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1072ui_story"].transform.position).z)
				arg_195_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1072ui_story"].transform.localEulerAngles = arg_195_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_195_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1072ui_story"].transform.position).z)
				arg_195_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1072ui_story"].transform.localEulerAngles = arg_195_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1072ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1072ui_story == nil then
				arg_195_1.var_.characterEffect1072ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1072ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1072ui_story then
				arg_195_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_4 = arg_195_1.actors_["1076ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1076ui_story == nil then
				arg_195_1.var_.characterEffect1076ui_story = var_198_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_5 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_5 and not isNil(var_198_4) then
				if arg_195_1.var_.characterEffect1076ui_story and not isNil(var_198_4) then
					arg_195_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_5)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_5 and arg_195_1.time_ < 0 + var_198_5 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1076ui_story then
				arg_195_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_198_6 = 0
			local var_198_7 = 0.375

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(221041047)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 15 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 15)

				if (15 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 15)) > 0 and var_198_7 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041047", "story_v_out_221041.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041047", "story_v_out_221041.awb") / 1000

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end

					if var_198_8.prefab_name ~= "" and arg_195_1.actors_[var_198_8.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_8.prefab_name].transform, "story_v_out_221041", "221041047", "story_v_out_221041.awb")

						arg_195_1:RecordAudio("221041047", var_198_13)
						arg_195_1:RecordAudio("221041047", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_221041", "221041047", "story_v_out_221041.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_221041", "221041047", "story_v_out_221041.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play221041048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 221041048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play221041049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1072ui_story"]) and arg_199_1.var_.characterEffect1072ui_story == nil then
				arg_199_1.var_.characterEffect1072ui_story = arg_199_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1072ui_story"]) then
				if arg_199_1.var_.characterEffect1072ui_story and not isNil(arg_199_1.actors_["1072ui_story"]) then
					arg_199_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1072ui_story"]) and arg_199_1.var_.characterEffect1072ui_story then
				arg_199_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.85

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(221041048).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 34 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 34)

				if (34 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 34)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play221041049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 221041049
		arg_203_1.duration_ = 10.03

		local var_203_0 = {
			ja = 9.2,
			ko = 10.033,
			zh = 10.033
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
				arg_203_0:Play221041050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1072ui_story = arg_203_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).z)
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles = arg_203_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_203_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1072ui_story"].transform.position).z)
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1072ui_story"].transform.localEulerAngles = arg_203_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1072ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1072ui_story == nil then
				arg_203_1.var_.characterEffect1072ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1072ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1072ui_story then
				arg_203_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action423")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_206_4 = 0
			local var_206_5 = 0.85

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(221041049)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 34 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 34)

				if (34 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 34)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041049", "story_v_out_221041.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041049", "story_v_out_221041.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_221041", "221041049", "story_v_out_221041.awb")

						arg_203_1:RecordAudio("221041049", var_206_11)
						arg_203_1:RecordAudio("221041049", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_221041", "221041049", "story_v_out_221041.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_221041", "221041049", "story_v_out_221041.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play221041050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 221041050
		arg_207_1.duration_ = 5.33

		local var_207_0 = {
			ja = 5.333,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play221041051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1076ui_story = arg_207_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1076ui_story"].transform.position).z)
				arg_207_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1076ui_story"].transform.localEulerAngles = arg_207_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_207_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1076ui_story"].transform.position).z)
				arg_207_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1076ui_story"].transform.localEulerAngles = arg_207_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1076ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1076ui_story == nil then
				arg_207_1.var_.characterEffect1076ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1076ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1076ui_story then
				arg_207_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_210_4 = arg_207_1.actors_["1072ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1072ui_story == nil then
				arg_207_1.var_.characterEffect1072ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_5 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_5 and not isNil(var_210_4) then
				if arg_207_1.var_.characterEffect1072ui_story and not isNil(var_210_4) then
					arg_207_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_5)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_5 and arg_207_1.time_ < 0 + var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1072ui_story then
				arg_207_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_210_6 = 0
			local var_210_7 = 0.225

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(221041050)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 9 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 9)

				if (9 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 9)) > 0 and var_210_7 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041050", "story_v_out_221041.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041050", "story_v_out_221041.awb") / 1000

					if var_210_12 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_6
					end

					if var_210_8.prefab_name ~= "" and arg_207_1.actors_[var_210_8.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_8.prefab_name].transform, "story_v_out_221041", "221041050", "story_v_out_221041.awb")

						arg_207_1:RecordAudio("221041050", var_210_13)
						arg_207_1:RecordAudio("221041050", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_221041", "221041050", "story_v_out_221041.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_221041", "221041050", "story_v_out_221041.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play221041051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 221041051
		arg_211_1.duration_ = 12.77

		local var_211_0 = {
			ja = 12.766,
			ko = 7.5,
			zh = 7.5
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
				arg_211_0:Play221041052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1072ui_story = arg_211_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1072ui_story"].transform.position).z)
				arg_211_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1072ui_story"].transform.localEulerAngles = arg_211_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_211_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1072ui_story"].transform.position).z)
				arg_211_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1072ui_story"].transform.localEulerAngles = arg_211_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1072ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1072ui_story == nil then
				arg_211_1.var_.characterEffect1072ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1072ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1072ui_story then
				arg_211_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action434")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_214_4 = arg_211_1.actors_["1076ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect1076ui_story == nil then
				arg_211_1.var_.characterEffect1076ui_story = var_214_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_5 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_5 and not isNil(var_214_4) then
				if arg_211_1.var_.characterEffect1076ui_story and not isNil(var_214_4) then
					arg_211_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_5)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_5 and arg_211_1.time_ < 0 + var_214_5 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect1076ui_story then
				arg_211_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_214_6 = 0
			local var_214_7 = 0.9

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:GetWordFromCfg(221041051)
				local var_214_9 = arg_211_1:FormatText(var_214_8.content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 36 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_9) / 36)

				if (36 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_9) / 36)) > 0 and var_214_7 < var_214_11 then
					arg_211_1.talkMaxDuration = var_214_11

					if var_214_11 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041051", "story_v_out_221041.awb") ~= 0 then
					local var_214_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041051", "story_v_out_221041.awb") / 1000

					if var_214_12 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_6
					end

					if var_214_8.prefab_name ~= "" and arg_211_1.actors_[var_214_8.prefab_name] ~= nil then
						local var_214_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_8.prefab_name].transform, "story_v_out_221041", "221041051", "story_v_out_221041.awb")

						arg_211_1:RecordAudio("221041051", var_214_13)
						arg_211_1:RecordAudio("221041051", var_214_13)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_221041", "221041051", "story_v_out_221041.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_221041", "221041051", "story_v_out_221041.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_14 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_14 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_14

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_14 and arg_211_1.time_ < var_214_6 + var_214_14 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221041052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 221041052
		arg_215_1.duration_ = 6.37

		local var_215_0 = {
			ja = 6.366,
			ko = 3.066,
			zh = 3.066
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
				arg_215_0:Play221041053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1072ui_story = arg_215_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1072ui_story"].transform.position).z)
				arg_215_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1072ui_story"].transform.localEulerAngles = arg_215_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_215_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1072ui_story"].transform.position).z)
				arg_215_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1072ui_story"].transform.localEulerAngles = arg_215_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1072ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1072ui_story == nil then
				arg_215_1.var_.characterEffect1072ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1072ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1072ui_story then
				arg_215_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_218_4 = 0
			local var_218_5 = 0.475

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(221041052)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 18 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 18)

				if (18 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 18)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041052", "story_v_out_221041.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041052", "story_v_out_221041.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_221041", "221041052", "story_v_out_221041.awb")

						arg_215_1:RecordAudio("221041052", var_218_11)
						arg_215_1:RecordAudio("221041052", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_221041", "221041052", "story_v_out_221041.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_221041", "221041052", "story_v_out_221041.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play221041053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 221041053
		arg_219_1.duration_ = 9.5

		local var_219_0 = {
			ja = 9.5,
			ko = 5.566,
			zh = 5.566
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
				arg_219_0:Play221041054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_2")
			end

			local var_222_0 = 0
			local var_222_1 = 0.825

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(221041053)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 33 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 33)

				if (33 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 33)) > 0 and var_222_1 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041053", "story_v_out_221041.awb") ~= 0 then
					local var_222_6 = manager.audio:GetVoiceLength("story_v_out_221041", "221041053", "story_v_out_221041.awb") / 1000

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end

					if var_222_2.prefab_name ~= "" and arg_219_1.actors_[var_222_2.prefab_name] ~= nil then
						local var_222_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_2.prefab_name].transform, "story_v_out_221041", "221041053", "story_v_out_221041.awb")

						arg_219_1:RecordAudio("221041053", var_222_7)
						arg_219_1:RecordAudio("221041053", var_222_7)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_221041", "221041053", "story_v_out_221041.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_221041", "221041053", "story_v_out_221041.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play221041054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 221041054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play221041055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1076ui_story = arg_223_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1076ui_story"].transform.position).z)
				arg_223_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1076ui_story"].transform.localEulerAngles = arg_223_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1076ui_story"].transform.position).z)
				arg_223_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1076ui_story"].transform.localEulerAngles = arg_223_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1076ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1076ui_story == nil then
				arg_223_1.var_.characterEffect1076ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1076ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_2)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1076ui_story then
				arg_223_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_226_3 = arg_223_1.actors_["1072ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1072ui_story = var_226_3.localPosition
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_3.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_4)
				var_226_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_3.position).x, (manager.ui.mainCamera.transform.position - var_226_3.position).y, (manager.ui.mainCamera.transform.position - var_226_3.position).z)
				var_226_3.localEulerAngles.z = 0
				var_226_3.localEulerAngles.x = 0
				var_226_3.localEulerAngles = var_226_3.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_3.localPosition = Vector3.New(0, 100, 0)
				var_226_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_3.position).x, (manager.ui.mainCamera.transform.position - var_226_3.position).y, (manager.ui.mainCamera.transform.position - var_226_3.position).z)
				var_226_3.localEulerAngles.z = 0
				var_226_3.localEulerAngles.x = 0
				var_226_3.localEulerAngles = var_226_3.localEulerAngles
			end

			local var_226_5 = arg_223_1.actors_["1072ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.characterEffect1072ui_story == nil then
				arg_223_1.var_.characterEffect1072ui_story = var_226_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_6 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_6 and not isNil(var_226_5) then
				if arg_223_1.var_.characterEffect1072ui_story and not isNil(var_226_5) then
					arg_223_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_6)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_6 and arg_223_1.time_ < 0 + var_226_6 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.characterEffect1072ui_story then
				arg_223_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_226_7 = 0
			local var_226_8 = 0.675

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_9 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(221041054).content)

				arg_223_1.text_.text = var_226_9

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 27 <= 0 and var_226_8 or var_226_8 * (utf8.len(var_226_9) / 27)

				if (27 <= 0 and var_226_8 or var_226_8 * (utf8.len(var_226_9) / 27)) > 0 and var_226_8 < var_226_11 then
					arg_223_1.talkMaxDuration = var_226_11

					if var_226_11 + var_226_7 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_7
					end
				end

				arg_223_1.text_.text = var_226_9
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_8, arg_223_1.talkMaxDuration)

			if var_226_7 <= arg_223_1.time_ and arg_223_1.time_ < var_226_7 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_7) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_7 + var_226_12 and arg_223_1.time_ < var_226_7 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play221041055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 221041055
		arg_227_1.duration_ = 7.67

		local var_227_0 = {
			ja = 7.666,
			ko = 6.966,
			zh = 6.966
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play221041056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if arg_227_1.bgs_.XH0402a == nil then
				local var_230_0 = Object.Instantiate(arg_227_1.paintGo_)

				var_230_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0402a")
				var_230_0.name = "XH0402a"
				var_230_0.transform.parent = arg_227_1.stage_.transform
				var_230_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.bgs_.XH0402a = var_230_0
			end

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= 2 + arg_230_0 then
				local var_230_1 = arg_227_1.bgs_.XH0402a

				arg_227_1.bgs_.XH0402a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_230_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_2 = var_230_1:GetComponent("SpriteRenderer")

				if var_230_2 and var_230_2.sprite then
					local var_230_3 = 2 * (var_230_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_230_1.transform.localScale = Vector3.New(var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "XH0402a" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_4 = 0

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_5 = 2

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_5 then
				local var_230_6 = Color.New(0, 0, 0)

				var_230_6.a = Mathf.Lerp(0, 1, (arg_227_1.time_ - var_230_4) / var_230_5)
				arg_227_1.mask_.color = var_230_6
			end

			if arg_227_1.time_ >= var_230_4 + var_230_5 and arg_227_1.time_ < var_230_4 + var_230_5 + arg_230_0 then
				local var_230_7 = Color.New(0, 0, 0)

				var_230_7.a = 1
				arg_227_1.mask_.color = var_230_7
			end

			local var_230_8 = 2

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_9 = 2

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_9 then
				local var_230_10 = Color.New(0, 0, 0)

				var_230_10.a = Mathf.Lerp(1, 0, (arg_227_1.time_ - var_230_8) / var_230_9)
				arg_227_1.mask_.color = var_230_10
			end

			if arg_227_1.time_ >= var_230_8 + var_230_9 and arg_227_1.time_ < var_230_8 + var_230_9 + arg_230_0 then
				local var_230_11 = Color.New(0, 0, 0)

				arg_227_1.mask_.enabled = false
				var_230_11.a = 0
				arg_227_1.mask_.color = var_230_11
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_12 = 4
			local var_230_13 = 0.425

			if 4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_12 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_14 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_14:setOnUpdate(LuaHelper.FloatAction(function(arg_231_0)
					arg_227_1.dialogCg_.alpha = arg_231_0
				end))
				var_230_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_15 = arg_227_1:GetWordFromCfg(221041055)
				local var_230_16 = arg_227_1:FormatText(var_230_15.content)

				arg_227_1.text_.text = var_230_16

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_18 = 17 <= 0 and var_230_13 or var_230_13 * (utf8.len(var_230_16) / 17)

				if (17 <= 0 and var_230_13 or var_230_13 * (utf8.len(var_230_16) / 17)) > 0 and var_230_13 < var_230_18 then
					arg_227_1.talkMaxDuration = var_230_18
					var_230_12 = var_230_12 + 0.3

					if var_230_18 + var_230_12 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_18 + var_230_12
					end
				end

				arg_227_1.text_.text = var_230_16
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041055", "story_v_out_221041.awb") ~= 0 then
					local var_230_19 = manager.audio:GetVoiceLength("story_v_out_221041", "221041055", "story_v_out_221041.awb") / 1000

					if var_230_19 + var_230_12 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_19 + var_230_12
					end

					if var_230_15.prefab_name ~= "" and arg_227_1.actors_[var_230_15.prefab_name] ~= nil then
						local var_230_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_15.prefab_name].transform, "story_v_out_221041", "221041055", "story_v_out_221041.awb")

						arg_227_1:RecordAudio("221041055", var_230_20)
						arg_227_1:RecordAudio("221041055", var_230_20)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_221041", "221041055", "story_v_out_221041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_221041", "221041055", "story_v_out_221041.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_21 = var_230_12 + 0.3
			local var_230_22 = math.max(var_230_13, arg_227_1.talkMaxDuration)

			if var_230_12 + 0.3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_21 + var_230_22 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_21) / var_230_22

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_21 + var_230_22 and arg_227_1.time_ < var_230_21 + var_230_22 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play221041056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 221041056
		arg_233_1.duration_ = 3.33

		local var_233_0 = {
			ja = 3.333,
			ko = 1.8,
			zh = 1.8
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
				arg_233_0:Play221041057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.25

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:GetWordFromCfg(221041056)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 10 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 10)

				if (10 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 10)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041056", "story_v_out_221041.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041056", "story_v_out_221041.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_221041", "221041056", "story_v_out_221041.awb")

						arg_233_1:RecordAudio("221041056", var_236_6)
						arg_233_1:RecordAudio("221041056", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_221041", "221041056", "story_v_out_221041.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_221041", "221041056", "story_v_out_221041.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play221041057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 221041057
		arg_237_1.duration_ = 9.23

		local var_237_0 = {
			ja = 5.266,
			ko = 9.233,
			zh = 9.233
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
				arg_237_0:Play221041058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.85

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:GetWordFromCfg(221041057)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 34 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 34)

				if (34 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 34)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041057", "story_v_out_221041.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041057", "story_v_out_221041.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_221041", "221041057", "story_v_out_221041.awb")

						arg_237_1:RecordAudio("221041057", var_240_6)
						arg_237_1:RecordAudio("221041057", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_221041", "221041057", "story_v_out_221041.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_221041", "221041057", "story_v_out_221041.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play221041058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 221041058
		arg_241_1.duration_ = 2.37

		local var_241_0 = {
			ja = 2.366,
			ko = 1.5,
			zh = 1.5
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play221041059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.15

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(221041058)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 6 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 6)

				if (6 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 6)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041058", "story_v_out_221041.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041058", "story_v_out_221041.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_221041", "221041058", "story_v_out_221041.awb")

						arg_241_1:RecordAudio("221041058", var_244_6)
						arg_241_1:RecordAudio("221041058", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_221041", "221041058", "story_v_out_221041.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_221041", "221041058", "story_v_out_221041.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play221041059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 221041059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play221041060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.575

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

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(221041059).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 23 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 23)

				if (23 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 23)) > 0 and var_248_0 < var_248_3 then
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
	Play221041060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 221041060
		arg_249_1.duration_ = 8.47

		local var_249_0 = {
			ja = 8.333,
			ko = 8.466,
			zh = 8.466
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
				arg_249_0:Play221041061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.775

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:GetWordFromCfg(221041060)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 31 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 31)

				if (31 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 31)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041060", "story_v_out_221041.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041060", "story_v_out_221041.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_221041", "221041060", "story_v_out_221041.awb")

						arg_249_1:RecordAudio("221041060", var_252_6)
						arg_249_1:RecordAudio("221041060", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_221041", "221041060", "story_v_out_221041.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_221041", "221041060", "story_v_out_221041.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play221041061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 221041061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play221041062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.575

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(221041061).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 63 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 63)

				if (63 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 63)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play221041062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 221041062
		arg_257_1.duration_ = 13.63

		local var_257_0 = {
			ja = 13.633,
			ko = 9.9,
			zh = 9.9
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play221041063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.05

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:GetWordFromCfg(221041062)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 42 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 42)

				if (42 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 42)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041062", "story_v_out_221041.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041062", "story_v_out_221041.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_221041", "221041062", "story_v_out_221041.awb")

						arg_257_1:RecordAudio("221041062", var_260_6)
						arg_257_1:RecordAudio("221041062", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_221041", "221041062", "story_v_out_221041.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_221041", "221041062", "story_v_out_221041.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play221041063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 221041063
		arg_261_1.duration_ = 1.97

		local var_261_0 = {
			ja = 1.766,
			ko = 1.966,
			zh = 1.966
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
				arg_261_0:Play221041064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.1

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:GetWordFromCfg(221041063)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 4 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 4)

				if (4 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 4)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041063", "story_v_out_221041.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041063", "story_v_out_221041.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_221041", "221041063", "story_v_out_221041.awb")

						arg_261_1:RecordAudio("221041063", var_264_6)
						arg_261_1:RecordAudio("221041063", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_221041", "221041063", "story_v_out_221041.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_221041", "221041063", "story_v_out_221041.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play221041064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 221041064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play221041065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.175

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(221041064).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 47 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 47)

				if (47 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 47)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play221041065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 221041065
		arg_269_1.duration_ = 6.47

		local var_269_0 = {
			ja = 6.466,
			ko = 4.6,
			zh = 4.6
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play221041066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.625

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:GetWordFromCfg(221041065)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 25 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 25)

				if (25 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 25)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041065", "story_v_out_221041.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041065", "story_v_out_221041.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_221041", "221041065", "story_v_out_221041.awb")

						arg_269_1:RecordAudio("221041065", var_272_6)
						arg_269_1:RecordAudio("221041065", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_221041", "221041065", "story_v_out_221041.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_221041", "221041065", "story_v_out_221041.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play221041066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 221041066
		arg_273_1.duration_ = 10.37

		local var_273_0 = {
			ja = 10.366,
			ko = 6.733,
			zh = 6.733
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play221041067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.775

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(221041066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 31 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 31)

				if (31 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 31)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041066", "story_v_out_221041.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041066", "story_v_out_221041.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_221041", "221041066", "story_v_out_221041.awb")

						arg_273_1:RecordAudio("221041066", var_276_6)
						arg_273_1:RecordAudio("221041066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_221041", "221041066", "story_v_out_221041.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_221041", "221041066", "story_v_out_221041.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play221041067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 221041067
		arg_277_1.duration_ = 6.7

		local var_277_0 = {
			ja = 6.7,
			ko = 3.6,
			zh = 3.6
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play221041068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.325

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:GetWordFromCfg(221041067)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 13 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 13)

				if (13 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 13)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041067", "story_v_out_221041.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041067", "story_v_out_221041.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_221041", "221041067", "story_v_out_221041.awb")

						arg_277_1:RecordAudio("221041067", var_280_6)
						arg_277_1:RecordAudio("221041067", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_221041", "221041067", "story_v_out_221041.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_221041", "221041067", "story_v_out_221041.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play221041068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 221041068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play221041069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.675

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(221041068).content)

				arg_281_1.text_.text = var_284_1

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_3 = 27 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 27)

				if (27 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 27)) > 0 and var_284_0 < var_284_3 then
					arg_281_1.talkMaxDuration = var_284_3

					if var_284_3 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_3 + 0
					end
				end

				arg_281_1.text_.text = var_284_1
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_4 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_4

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play221041069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 221041069
		arg_285_1.duration_ = 4.57

		local var_285_0 = {
			ja = 4.366,
			ko = 4.566,
			zh = 4.566
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play221041070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.375

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:GetWordFromCfg(221041069)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 15 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 15)

				if (15 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 15)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041069", "story_v_out_221041.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041069", "story_v_out_221041.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_221041", "221041069", "story_v_out_221041.awb")

						arg_285_1:RecordAudio("221041069", var_288_6)
						arg_285_1:RecordAudio("221041069", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_221041", "221041069", "story_v_out_221041.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_221041", "221041069", "story_v_out_221041.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play221041070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 221041070
		arg_289_1.duration_ = 6.97

		local var_289_0 = {
			ja = 6.966,
			ko = 5.1,
			zh = 5.1
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play221041071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.525

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:GetWordFromCfg(221041070)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 21 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 21)

				if (21 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 21)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041070", "story_v_out_221041.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041070", "story_v_out_221041.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_221041", "221041070", "story_v_out_221041.awb")

						arg_289_1:RecordAudio("221041070", var_292_6)
						arg_289_1:RecordAudio("221041070", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_221041", "221041070", "story_v_out_221041.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_221041", "221041070", "story_v_out_221041.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play221041071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 221041071
		arg_293_1.duration_ = 13.17

		local var_293_0 = {
			ja = 13.166,
			ko = 9.4,
			zh = 9.4
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
				arg_293_0:Play221041072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.025

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:GetWordFromCfg(221041071)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 41 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 41)

				if (41 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 41)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041071", "story_v_out_221041.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041071", "story_v_out_221041.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_221041", "221041071", "story_v_out_221041.awb")

						arg_293_1:RecordAudio("221041071", var_296_6)
						arg_293_1:RecordAudio("221041071", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_221041", "221041071", "story_v_out_221041.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_221041", "221041071", "story_v_out_221041.awb")
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
	Play221041072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 221041072
		arg_297_1.duration_ = 4.5

		local var_297_0 = {
			ja = 4.5,
			ko = 3.6,
			zh = 3.6
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
				arg_297_0:Play221041073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.3

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:GetWordFromCfg(221041072)
				local var_300_2 = arg_297_1:FormatText(var_300_1.content)

				arg_297_1.text_.text = var_300_2

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 12 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 12)

				if (12 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 12)) > 0 and var_300_0 < var_300_4 then
					arg_297_1.talkMaxDuration = var_300_4

					if var_300_4 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_4 + 0
					end
				end

				arg_297_1.text_.text = var_300_2
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041072", "story_v_out_221041.awb") ~= 0 then
					local var_300_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041072", "story_v_out_221041.awb") / 1000

					if var_300_5 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + 0
					end

					if var_300_1.prefab_name ~= "" and arg_297_1.actors_[var_300_1.prefab_name] ~= nil then
						local var_300_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_1.prefab_name].transform, "story_v_out_221041", "221041072", "story_v_out_221041.awb")

						arg_297_1:RecordAudio("221041072", var_300_6)
						arg_297_1:RecordAudio("221041072", var_300_6)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_221041", "221041072", "story_v_out_221041.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_221041", "221041072", "story_v_out_221041.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play221041073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 221041073
		arg_301_1.duration_ = 9.97

		local var_301_0 = {
			ja = 9.966,
			ko = 8.4,
			zh = 8.4
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
				arg_301_0:Play221041074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.975

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:GetWordFromCfg(221041073)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 39 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 39)

				if (39 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 39)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041073", "story_v_out_221041.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041073", "story_v_out_221041.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_221041", "221041073", "story_v_out_221041.awb")

						arg_301_1:RecordAudio("221041073", var_304_6)
						arg_301_1:RecordAudio("221041073", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_221041", "221041073", "story_v_out_221041.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_221041", "221041073", "story_v_out_221041.awb")
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
	Play221041074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 221041074
		arg_305_1.duration_ = 4.83

		local var_305_0 = {
			ja = 4.833,
			ko = 4.333,
			zh = 4.333
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play221041075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.425

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:GetWordFromCfg(221041074)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 17 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 17)

				if (17 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 17)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041074", "story_v_out_221041.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041074", "story_v_out_221041.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_221041", "221041074", "story_v_out_221041.awb")

						arg_305_1:RecordAudio("221041074", var_308_6)
						arg_305_1:RecordAudio("221041074", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_221041", "221041074", "story_v_out_221041.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_221041", "221041074", "story_v_out_221041.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play221041075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 221041075
		arg_309_1.duration_ = 1.23

		local var_309_0 = {
			ja = 1.233,
			ko = 0.999999999999,
			zh = 0.999999999999
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play221041076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.05

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:GetWordFromCfg(221041075)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 2 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 2)

				if (2 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 2)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041075", "story_v_out_221041.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041075", "story_v_out_221041.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_221041", "221041075", "story_v_out_221041.awb")

						arg_309_1:RecordAudio("221041075", var_312_6)
						arg_309_1:RecordAudio("221041075", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_221041", "221041075", "story_v_out_221041.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_221041", "221041075", "story_v_out_221041.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play221041076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 221041076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play221041077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 1.775

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(221041076).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 71 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 71)

				if (71 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 71)) > 0 and var_316_0 < var_316_3 then
					arg_313_1.talkMaxDuration = var_316_3

					if var_316_3 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_3 + 0
					end
				end

				arg_313_1.text_.text = var_316_1
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_4 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_4

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play221041077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 221041077
		arg_317_1.duration_ = 9.6

		local var_317_0 = {
			ja = 9.6,
			ko = 6.766,
			zh = 6.766
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
				arg_317_0:Play221041078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.875

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:GetWordFromCfg(221041077)
				local var_320_2 = arg_317_1:FormatText(var_320_1.content)

				arg_317_1.text_.text = var_320_2

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 33 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 33)

				if (33 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 33)) > 0 and var_320_0 < var_320_4 then
					arg_317_1.talkMaxDuration = var_320_4

					if var_320_4 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_4 + 0
					end
				end

				arg_317_1.text_.text = var_320_2
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041077", "story_v_out_221041.awb") ~= 0 then
					local var_320_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041077", "story_v_out_221041.awb") / 1000

					if var_320_5 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + 0
					end

					if var_320_1.prefab_name ~= "" and arg_317_1.actors_[var_320_1.prefab_name] ~= nil then
						local var_320_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_1.prefab_name].transform, "story_v_out_221041", "221041077", "story_v_out_221041.awb")

						arg_317_1:RecordAudio("221041077", var_320_6)
						arg_317_1:RecordAudio("221041077", var_320_6)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_221041", "221041077", "story_v_out_221041.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_221041", "221041077", "story_v_out_221041.awb")
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
	Play221041078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 221041078
		arg_321_1.duration_ = 4.6

		local var_321_0 = {
			ja = 4.6,
			ko = 3.4,
			zh = 3.4
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
				arg_321_0:Play221041079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.4

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(221041078)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 16 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 16)

				if (16 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 16)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041078", "story_v_out_221041.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041078", "story_v_out_221041.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_221041", "221041078", "story_v_out_221041.awb")

						arg_321_1:RecordAudio("221041078", var_324_6)
						arg_321_1:RecordAudio("221041078", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_221041", "221041078", "story_v_out_221041.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_221041", "221041078", "story_v_out_221041.awb")
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
	Play221041079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 221041079
		arg_325_1.duration_ = 4.73

		local var_325_0 = {
			ja = 4.733,
			ko = 2.9,
			zh = 2.9
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
				arg_325_0:Play221041080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.375

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:GetWordFromCfg(221041079)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 15 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 15)

				if (15 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 15)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041079", "story_v_out_221041.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041079", "story_v_out_221041.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_221041", "221041079", "story_v_out_221041.awb")

						arg_325_1:RecordAudio("221041079", var_328_6)
						arg_325_1:RecordAudio("221041079", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_221041", "221041079", "story_v_out_221041.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_221041", "221041079", "story_v_out_221041.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play221041080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 221041080
		arg_329_1.duration_ = 6.93

		local var_329_0 = {
			ja = 6.9,
			ko = 6.933,
			zh = 6.933
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play221041081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.775

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:GetWordFromCfg(221041080)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.text_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 31 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 31)

				if (31 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 31)) > 0 and var_332_0 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end

				arg_329_1.text_.text = var_332_2
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041080", "story_v_out_221041.awb") ~= 0 then
					local var_332_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041080", "story_v_out_221041.awb") / 1000

					if var_332_5 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + 0
					end

					if var_332_1.prefab_name ~= "" and arg_329_1.actors_[var_332_1.prefab_name] ~= nil then
						local var_332_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_1.prefab_name].transform, "story_v_out_221041", "221041080", "story_v_out_221041.awb")

						arg_329_1:RecordAudio("221041080", var_332_6)
						arg_329_1:RecordAudio("221041080", var_332_6)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_221041", "221041080", "story_v_out_221041.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_221041", "221041080", "story_v_out_221041.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play221041081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 221041081
		arg_333_1.duration_ = 4.67

		local var_333_0 = {
			ja = 4.666,
			ko = 4.2,
			zh = 4.2
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play221041082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.375

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:GetWordFromCfg(221041081)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 15 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 15)

				if (15 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 15)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041081", "story_v_out_221041.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041081", "story_v_out_221041.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_out_221041", "221041081", "story_v_out_221041.awb")

						arg_333_1:RecordAudio("221041081", var_336_6)
						arg_333_1:RecordAudio("221041081", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_221041", "221041081", "story_v_out_221041.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_221041", "221041081", "story_v_out_221041.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play221041082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 221041082
		arg_337_1.duration_ = 11.33

		local var_337_0 = {
			ja = 11.333,
			ko = 7.5,
			zh = 7.5
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play221041083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 1

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:GetWordFromCfg(221041082)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 40 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 40)

				if (40 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 40)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041082", "story_v_out_221041.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041082", "story_v_out_221041.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_221041", "221041082", "story_v_out_221041.awb")

						arg_337_1:RecordAudio("221041082", var_340_6)
						arg_337_1:RecordAudio("221041082", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_221041", "221041082", "story_v_out_221041.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_221041", "221041082", "story_v_out_221041.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play221041083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 221041083
		arg_341_1.duration_ = 2.97

		local var_341_0 = {
			ja = 1.6,
			ko = 2.966,
			zh = 2.966
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play221041084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.125

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:GetWordFromCfg(221041083)
				local var_344_2 = arg_341_1:FormatText(var_344_1.content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 5 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 5)

				if (5 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 5)) > 0 and var_344_0 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041083", "story_v_out_221041.awb") ~= 0 then
					local var_344_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041083", "story_v_out_221041.awb") / 1000

					if var_344_5 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + 0
					end

					if var_344_1.prefab_name ~= "" and arg_341_1.actors_[var_344_1.prefab_name] ~= nil then
						local var_344_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_1.prefab_name].transform, "story_v_out_221041", "221041083", "story_v_out_221041.awb")

						arg_341_1:RecordAudio("221041083", var_344_6)
						arg_341_1:RecordAudio("221041083", var_344_6)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_221041", "221041083", "story_v_out_221041.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_221041", "221041083", "story_v_out_221041.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play221041084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 221041084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play221041085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 1.45

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

				local var_348_1 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(221041084).content)

				arg_345_1.text_.text = var_348_1

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_3 = 58 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 58)

				if (58 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 58)) > 0 and var_348_0 < var_348_3 then
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
	Play221041085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 221041085
		arg_349_1.duration_ = 6.67

		local var_349_0 = {
			ja = 6.666,
			ko = 4.233,
			zh = 4.233
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play221041086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.45

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:GetWordFromCfg(221041085)
				local var_352_2 = arg_349_1:FormatText(var_352_1.content)

				arg_349_1.text_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 18 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 18)

				if (18 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 18)) > 0 and var_352_0 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + 0
					end
				end

				arg_349_1.text_.text = var_352_2
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041085", "story_v_out_221041.awb") ~= 0 then
					local var_352_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041085", "story_v_out_221041.awb") / 1000

					if var_352_5 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + 0
					end

					if var_352_1.prefab_name ~= "" and arg_349_1.actors_[var_352_1.prefab_name] ~= nil then
						local var_352_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_1.prefab_name].transform, "story_v_out_221041", "221041085", "story_v_out_221041.awb")

						arg_349_1:RecordAudio("221041085", var_352_6)
						arg_349_1:RecordAudio("221041085", var_352_6)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_221041", "221041085", "story_v_out_221041.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_221041", "221041085", "story_v_out_221041.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play221041086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 221041086
		arg_353_1.duration_ = 9.63

		local var_353_0 = {
			ja = 9.633,
			ko = 7.1,
			zh = 7.1
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
				arg_353_0:Play221041087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.8

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_1 = arg_353_1:GetWordFromCfg(221041086)
				local var_356_2 = arg_353_1:FormatText(var_356_1.content)

				arg_353_1.text_.text = var_356_2

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 32 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 32)

				if (32 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 32)) > 0 and var_356_0 < var_356_4 then
					arg_353_1.talkMaxDuration = var_356_4

					if var_356_4 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_4 + 0
					end
				end

				arg_353_1.text_.text = var_356_2
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041086", "story_v_out_221041.awb") ~= 0 then
					local var_356_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041086", "story_v_out_221041.awb") / 1000

					if var_356_5 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + 0
					end

					if var_356_1.prefab_name ~= "" and arg_353_1.actors_[var_356_1.prefab_name] ~= nil then
						local var_356_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_1.prefab_name].transform, "story_v_out_221041", "221041086", "story_v_out_221041.awb")

						arg_353_1:RecordAudio("221041086", var_356_6)
						arg_353_1:RecordAudio("221041086", var_356_6)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_221041", "221041086", "story_v_out_221041.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_221041", "221041086", "story_v_out_221041.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play221041087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 221041087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play221041088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 1.45

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(221041087).content)

				arg_357_1.text_.text = var_360_1

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_3 = 58 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 58)

				if (58 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 58)) > 0 and var_360_0 < var_360_3 then
					arg_357_1.talkMaxDuration = var_360_3

					if var_360_3 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_3 + 0
					end
				end

				arg_357_1.text_.text = var_360_1
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_4 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_4

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play221041088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 221041088
		arg_361_1.duration_ = 2.77

		local var_361_0 = {
			ja = 2.766,
			ko = 2.533,
			zh = 2.533
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
				arg_361_0:Play221041089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.075

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:GetWordFromCfg(221041088)
				local var_364_2 = arg_361_1:FormatText(var_364_1.content)

				arg_361_1.text_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 3 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 3)

				if (3 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 3)) > 0 and var_364_0 < var_364_4 then
					arg_361_1.talkMaxDuration = var_364_4

					if var_364_4 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_4 + 0
					end
				end

				arg_361_1.text_.text = var_364_2
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041088", "story_v_out_221041.awb") ~= 0 then
					local var_364_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041088", "story_v_out_221041.awb") / 1000

					if var_364_5 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + 0
					end

					if var_364_1.prefab_name ~= "" and arg_361_1.actors_[var_364_1.prefab_name] ~= nil then
						local var_364_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_1.prefab_name].transform, "story_v_out_221041", "221041088", "story_v_out_221041.awb")

						arg_361_1:RecordAudio("221041088", var_364_6)
						arg_361_1:RecordAudio("221041088", var_364_6)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_221041", "221041088", "story_v_out_221041.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_221041", "221041088", "story_v_out_221041.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play221041089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 221041089
		arg_365_1.duration_ = 3.63

		local var_365_0 = {
			ja = 3.633,
			ko = 2.133,
			zh = 2.133
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
				arg_365_0:Play221041090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.25

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(221041089)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 10 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 10)

				if (10 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 10)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041089", "story_v_out_221041.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041089", "story_v_out_221041.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_221041", "221041089", "story_v_out_221041.awb")

						arg_365_1:RecordAudio("221041089", var_368_6)
						arg_365_1:RecordAudio("221041089", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_221041", "221041089", "story_v_out_221041.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_221041", "221041089", "story_v_out_221041.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play221041090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 221041090
		arg_369_1.duration_ = 6.13

		local var_369_0 = {
			ja = 6.133,
			ko = 4.633,
			zh = 4.633
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
				arg_369_0:Play221041091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.425

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:GetWordFromCfg(221041090)
				local var_372_2 = arg_369_1:FormatText(var_372_1.content)

				arg_369_1.text_.text = var_372_2

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_4 = 13 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 13)

				if (13 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 13)) > 0 and var_372_0 < var_372_4 then
					arg_369_1.talkMaxDuration = var_372_4

					if var_372_4 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_4 + 0
					end
				end

				arg_369_1.text_.text = var_372_2
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041090", "story_v_out_221041.awb") ~= 0 then
					local var_372_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041090", "story_v_out_221041.awb") / 1000

					if var_372_5 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + 0
					end

					if var_372_1.prefab_name ~= "" and arg_369_1.actors_[var_372_1.prefab_name] ~= nil then
						local var_372_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_1.prefab_name].transform, "story_v_out_221041", "221041090", "story_v_out_221041.awb")

						arg_369_1:RecordAudio("221041090", var_372_6)
						arg_369_1:RecordAudio("221041090", var_372_6)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_221041", "221041090", "story_v_out_221041.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_221041", "221041090", "story_v_out_221041.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_7 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_7 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_7

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_7 and arg_369_1.time_ < 0 + var_372_7 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play221041091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 221041091
		arg_373_1.duration_ = 3.2

		local var_373_0 = {
			ja = 3.2,
			ko = 1.4,
			zh = 1.4
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
				arg_373_0:Play221041092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.2

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_1 = arg_373_1:GetWordFromCfg(221041091)
				local var_376_2 = arg_373_1:FormatText(var_376_1.content)

				arg_373_1.text_.text = var_376_2

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_4 = 8 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 8)

				if (8 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 8)) > 0 and var_376_0 < var_376_4 then
					arg_373_1.talkMaxDuration = var_376_4

					if var_376_4 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_4 + 0
					end
				end

				arg_373_1.text_.text = var_376_2
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041091", "story_v_out_221041.awb") ~= 0 then
					local var_376_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041091", "story_v_out_221041.awb") / 1000

					if var_376_5 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + 0
					end

					if var_376_1.prefab_name ~= "" and arg_373_1.actors_[var_376_1.prefab_name] ~= nil then
						local var_376_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_1.prefab_name].transform, "story_v_out_221041", "221041091", "story_v_out_221041.awb")

						arg_373_1:RecordAudio("221041091", var_376_6)
						arg_373_1:RecordAudio("221041091", var_376_6)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_221041", "221041091", "story_v_out_221041.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_221041", "221041091", "story_v_out_221041.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play221041092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 221041092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play221041093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 1.3

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(221041092).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 52 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 52)

				if (52 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 52)) > 0 and var_380_0 < var_380_3 then
					arg_377_1.talkMaxDuration = var_380_3

					if var_380_3 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_3 + 0
					end
				end

				arg_377_1.text_.text = var_380_1
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_4 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_4

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play221041093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 221041093
		arg_381_1.duration_ = 5.33

		local var_381_0 = {
			ja = 5.333,
			ko = 3.9,
			zh = 3.9
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play221041094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.325

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_1 = arg_381_1:GetWordFromCfg(221041093)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.text_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 13 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 13)

				if (13 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 13)) > 0 and var_384_0 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end

				arg_381_1.text_.text = var_384_2
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041093", "story_v_out_221041.awb") ~= 0 then
					local var_384_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041093", "story_v_out_221041.awb") / 1000

					if var_384_5 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + 0
					end

					if var_384_1.prefab_name ~= "" and arg_381_1.actors_[var_384_1.prefab_name] ~= nil then
						local var_384_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_1.prefab_name].transform, "story_v_out_221041", "221041093", "story_v_out_221041.awb")

						arg_381_1:RecordAudio("221041093", var_384_6)
						arg_381_1:RecordAudio("221041093", var_384_6)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_221041", "221041093", "story_v_out_221041.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_221041", "221041093", "story_v_out_221041.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play221041094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 221041094
		arg_385_1.duration_ = 3.6

		local var_385_0 = {
			ja = 1.633,
			ko = 3.6,
			zh = 3.6
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
				arg_385_0:Play221041095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.15

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(221041094)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 6 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 6)

				if (6 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 6)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041094", "story_v_out_221041.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041094", "story_v_out_221041.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_221041", "221041094", "story_v_out_221041.awb")

						arg_385_1:RecordAudio("221041094", var_388_6)
						arg_385_1:RecordAudio("221041094", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_221041", "221041094", "story_v_out_221041.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_221041", "221041094", "story_v_out_221041.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play221041095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 221041095
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play221041096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.75

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_1 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(221041095).content)

				arg_389_1.text_.text = var_392_1

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_3 = 30 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 30)

				if (30 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 30)) > 0 and var_392_0 < var_392_3 then
					arg_389_1.talkMaxDuration = var_392_3

					if var_392_3 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_3 + 0
					end
				end

				arg_389_1.text_.text = var_392_1
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_4 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_4

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play221041096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 221041096
		arg_393_1.duration_ = 10.33

		local var_393_0 = {
			ja = 10.333,
			ko = 6.3,
			zh = 6.3
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
				arg_393_0:Play221041097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0.625

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:GetWordFromCfg(221041096)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.text_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 25 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 25)

				if (25 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 25)) > 0 and var_396_0 < var_396_4 then
					arg_393_1.talkMaxDuration = var_396_4

					if var_396_4 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_4 + 0
					end
				end

				arg_393_1.text_.text = var_396_2
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041096", "story_v_out_221041.awb") ~= 0 then
					local var_396_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041096", "story_v_out_221041.awb") / 1000

					if var_396_5 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + 0
					end

					if var_396_1.prefab_name ~= "" and arg_393_1.actors_[var_396_1.prefab_name] ~= nil then
						local var_396_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_1.prefab_name].transform, "story_v_out_221041", "221041096", "story_v_out_221041.awb")

						arg_393_1:RecordAudio("221041096", var_396_6)
						arg_393_1:RecordAudio("221041096", var_396_6)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_221041", "221041096", "story_v_out_221041.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_221041", "221041096", "story_v_out_221041.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play221041097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 221041097
		arg_397_1.duration_ = 9.7

		local var_397_0 = {
			ja = 9.7,
			ko = 6.7,
			zh = 6.7
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
				arg_397_0:Play221041098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.675

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:GetWordFromCfg(221041097)
				local var_400_2 = arg_397_1:FormatText(var_400_1.content)

				arg_397_1.text_.text = var_400_2

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 27 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 27)

				if (27 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 27)) > 0 and var_400_0 < var_400_4 then
					arg_397_1.talkMaxDuration = var_400_4

					if var_400_4 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_4 + 0
					end
				end

				arg_397_1.text_.text = var_400_2
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041097", "story_v_out_221041.awb") ~= 0 then
					local var_400_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041097", "story_v_out_221041.awb") / 1000

					if var_400_5 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + 0
					end

					if var_400_1.prefab_name ~= "" and arg_397_1.actors_[var_400_1.prefab_name] ~= nil then
						local var_400_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_1.prefab_name].transform, "story_v_out_221041", "221041097", "story_v_out_221041.awb")

						arg_397_1:RecordAudio("221041097", var_400_6)
						arg_397_1:RecordAudio("221041097", var_400_6)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_221041", "221041097", "story_v_out_221041.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_221041", "221041097", "story_v_out_221041.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_7 and arg_397_1.time_ < 0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play221041098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 221041098
		arg_401_1.duration_ = 6.33

		local var_401_0 = {
			ja = 6.333,
			ko = 5.366,
			zh = 5.366
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play221041099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.575

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:GetWordFromCfg(221041098)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 23 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 23)

				if (23 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 23)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041098", "story_v_out_221041.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041098", "story_v_out_221041.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_221041", "221041098", "story_v_out_221041.awb")

						arg_401_1:RecordAudio("221041098", var_404_6)
						arg_401_1:RecordAudio("221041098", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_221041", "221041098", "story_v_out_221041.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_221041", "221041098", "story_v_out_221041.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play221041099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 221041099
		arg_405_1.duration_ = 5.9

		local var_405_0 = {
			ja = 5.9,
			ko = 3.866,
			zh = 3.866
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play221041100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.525

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:GetWordFromCfg(221041099)
				local var_408_2 = arg_405_1:FormatText(var_408_1.content)

				arg_405_1.text_.text = var_408_2

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 21 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 21)

				if (21 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 21)) > 0 and var_408_0 < var_408_4 then
					arg_405_1.talkMaxDuration = var_408_4

					if var_408_4 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_4 + 0
					end
				end

				arg_405_1.text_.text = var_408_2
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041099", "story_v_out_221041.awb") ~= 0 then
					local var_408_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041099", "story_v_out_221041.awb") / 1000

					if var_408_5 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + 0
					end

					if var_408_1.prefab_name ~= "" and arg_405_1.actors_[var_408_1.prefab_name] ~= nil then
						local var_408_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_1.prefab_name].transform, "story_v_out_221041", "221041099", "story_v_out_221041.awb")

						arg_405_1:RecordAudio("221041099", var_408_6)
						arg_405_1:RecordAudio("221041099", var_408_6)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_221041", "221041099", "story_v_out_221041.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_221041", "221041099", "story_v_out_221041.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play221041100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 221041100
		arg_409_1.duration_ = 12.1

		local var_409_0 = {
			ja = 12.1,
			ko = 9.166,
			zh = 9.166
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
				arg_409_0:Play221041101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.9

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_1 = arg_409_1:GetWordFromCfg(221041100)
				local var_412_2 = arg_409_1:FormatText(var_412_1.content)

				arg_409_1.text_.text = var_412_2

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_4 = 36 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 36)

				if (36 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 36)) > 0 and var_412_0 < var_412_4 then
					arg_409_1.talkMaxDuration = var_412_4

					if var_412_4 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_4 + 0
					end
				end

				arg_409_1.text_.text = var_412_2
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041100", "story_v_out_221041.awb") ~= 0 then
					local var_412_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041100", "story_v_out_221041.awb") / 1000

					if var_412_5 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + 0
					end

					if var_412_1.prefab_name ~= "" and arg_409_1.actors_[var_412_1.prefab_name] ~= nil then
						local var_412_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_1.prefab_name].transform, "story_v_out_221041", "221041100", "story_v_out_221041.awb")

						arg_409_1:RecordAudio("221041100", var_412_6)
						arg_409_1:RecordAudio("221041100", var_412_6)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_221041", "221041100", "story_v_out_221041.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_221041", "221041100", "story_v_out_221041.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_7 and arg_409_1.time_ < 0 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play221041101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 221041101
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play221041102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.75

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(221041101).content)

				arg_413_1.text_.text = var_416_1

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_3 = 30 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 30)

				if (30 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 30)) > 0 and var_416_0 < var_416_3 then
					arg_413_1.talkMaxDuration = var_416_3

					if var_416_3 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_3 + 0
					end
				end

				arg_413_1.text_.text = var_416_1
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_4 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_4

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play221041102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 221041102
		arg_417_1.duration_ = 4.67

		local var_417_0 = {
			ja = 4.666,
			ko = 1.8,
			zh = 1.8
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
				arg_417_0:Play221041103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.175

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_1 = arg_417_1:GetWordFromCfg(221041102)
				local var_420_2 = arg_417_1:FormatText(var_420_1.content)

				arg_417_1.text_.text = var_420_2

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_4 = 7 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_2) / 7)

				if (7 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_2) / 7)) > 0 and var_420_0 < var_420_4 then
					arg_417_1.talkMaxDuration = var_420_4

					if var_420_4 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_4 + 0
					end
				end

				arg_417_1.text_.text = var_420_2
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041102", "story_v_out_221041.awb") ~= 0 then
					local var_420_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041102", "story_v_out_221041.awb") / 1000

					if var_420_5 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + 0
					end

					if var_420_1.prefab_name ~= "" and arg_417_1.actors_[var_420_1.prefab_name] ~= nil then
						local var_420_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_1.prefab_name].transform, "story_v_out_221041", "221041102", "story_v_out_221041.awb")

						arg_417_1:RecordAudio("221041102", var_420_6)
						arg_417_1:RecordAudio("221041102", var_420_6)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_221041", "221041102", "story_v_out_221041.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_221041", "221041102", "story_v_out_221041.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_7 = math.max(var_420_0, arg_417_1.talkMaxDuration)

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_7 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - 0) / var_420_7

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= 0 + var_420_7 and arg_417_1.time_ < 0 + var_420_7 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play221041103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 221041103
		arg_421_1.duration_ = 6.6

		local var_421_0 = {
			ja = 6.6,
			ko = 4.866,
			zh = 4.866
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play221041104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.45

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_1 = arg_421_1:GetWordFromCfg(221041103)
				local var_424_2 = arg_421_1:FormatText(var_424_1.content)

				arg_421_1.text_.text = var_424_2

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 18 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 18)

				if (18 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 18)) > 0 and var_424_0 < var_424_4 then
					arg_421_1.talkMaxDuration = var_424_4

					if var_424_4 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_4 + 0
					end
				end

				arg_421_1.text_.text = var_424_2
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041103", "story_v_out_221041.awb") ~= 0 then
					local var_424_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041103", "story_v_out_221041.awb") / 1000

					if var_424_5 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + 0
					end

					if var_424_1.prefab_name ~= "" and arg_421_1.actors_[var_424_1.prefab_name] ~= nil then
						local var_424_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_1.prefab_name].transform, "story_v_out_221041", "221041103", "story_v_out_221041.awb")

						arg_421_1:RecordAudio("221041103", var_424_6)
						arg_421_1:RecordAudio("221041103", var_424_6)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_221041", "221041103", "story_v_out_221041.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_221041", "221041103", "story_v_out_221041.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_7 and arg_421_1.time_ < 0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play221041104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 221041104
		arg_425_1.duration_ = 1.23

		local var_425_0 = {
			ja = 1.233,
			ko = 0.999999999999,
			zh = 0.999999999999
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
				arg_425_0:Play221041105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.05

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_1 = arg_425_1:GetWordFromCfg(221041104)
				local var_428_2 = arg_425_1:FormatText(var_428_1.content)

				arg_425_1.text_.text = var_428_2

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_4 = 2 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 2)

				if (2 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 2)) > 0 and var_428_0 < var_428_4 then
					arg_425_1.talkMaxDuration = var_428_4

					if var_428_4 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_4 + 0
					end
				end

				arg_425_1.text_.text = var_428_2
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041104", "story_v_out_221041.awb") ~= 0 then
					local var_428_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041104", "story_v_out_221041.awb") / 1000

					if var_428_5 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + 0
					end

					if var_428_1.prefab_name ~= "" and arg_425_1.actors_[var_428_1.prefab_name] ~= nil then
						local var_428_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_1.prefab_name].transform, "story_v_out_221041", "221041104", "story_v_out_221041.awb")

						arg_425_1:RecordAudio("221041104", var_428_6)
						arg_425_1:RecordAudio("221041104", var_428_6)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_221041", "221041104", "story_v_out_221041.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_221041", "221041104", "story_v_out_221041.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_7 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_7 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_7

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_7 and arg_425_1.time_ < 0 + var_428_7 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play221041105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 221041105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play221041106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 1.2

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(221041105).content)

				arg_429_1.text_.text = var_432_1

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_3 = 48 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 48)

				if (48 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 48)) > 0 and var_432_0 < var_432_3 then
					arg_429_1.talkMaxDuration = var_432_3

					if var_432_3 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_3 + 0
					end
				end

				arg_429_1.text_.text = var_432_1
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_4 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_4

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play221041106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 221041106
		arg_433_1.duration_ = 6.1

		local var_433_0 = {
			ja = 6.1,
			ko = 3.633,
			zh = 3.633
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
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play221041107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.4

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_1 = arg_433_1:GetWordFromCfg(221041106)
				local var_436_2 = arg_433_1:FormatText(var_436_1.content)

				arg_433_1.text_.text = var_436_2

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_4 = 16 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_2) / 16)

				if (16 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_2) / 16)) > 0 and var_436_0 < var_436_4 then
					arg_433_1.talkMaxDuration = var_436_4

					if var_436_4 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_4 + 0
					end
				end

				arg_433_1.text_.text = var_436_2
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041106", "story_v_out_221041.awb") ~= 0 then
					local var_436_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041106", "story_v_out_221041.awb") / 1000

					if var_436_5 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + 0
					end

					if var_436_1.prefab_name ~= "" and arg_433_1.actors_[var_436_1.prefab_name] ~= nil then
						local var_436_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_1.prefab_name].transform, "story_v_out_221041", "221041106", "story_v_out_221041.awb")

						arg_433_1:RecordAudio("221041106", var_436_6)
						arg_433_1:RecordAudio("221041106", var_436_6)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_221041", "221041106", "story_v_out_221041.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_221041", "221041106", "story_v_out_221041.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_7 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_7 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_7

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_7 and arg_433_1.time_ < 0 + var_436_7 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play221041107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 221041107
		arg_437_1.duration_ = 2.37

		local var_437_0 = {
			ja = 2.3,
			ko = 2.366,
			zh = 2.366
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play221041108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.2

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_1 = arg_437_1:GetWordFromCfg(221041107)
				local var_440_2 = arg_437_1:FormatText(var_440_1.content)

				arg_437_1.text_.text = var_440_2

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_4 = 8 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 8)

				if (8 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 8)) > 0 and var_440_0 < var_440_4 then
					arg_437_1.talkMaxDuration = var_440_4

					if var_440_4 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_4 + 0
					end
				end

				arg_437_1.text_.text = var_440_2
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041107", "story_v_out_221041.awb") ~= 0 then
					local var_440_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041107", "story_v_out_221041.awb") / 1000

					if var_440_5 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + 0
					end

					if var_440_1.prefab_name ~= "" and arg_437_1.actors_[var_440_1.prefab_name] ~= nil then
						local var_440_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_1.prefab_name].transform, "story_v_out_221041", "221041107", "story_v_out_221041.awb")

						arg_437_1:RecordAudio("221041107", var_440_6)
						arg_437_1:RecordAudio("221041107", var_440_6)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_221041", "221041107", "story_v_out_221041.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_221041", "221041107", "story_v_out_221041.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_7 and arg_437_1.time_ < 0 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play221041108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 221041108
		arg_441_1.duration_ = 10.73

		local var_441_0 = {
			ja = 10.733,
			ko = 7.166,
			zh = 7.166
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play221041109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.85

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_1 = arg_441_1:GetWordFromCfg(221041108)
				local var_444_2 = arg_441_1:FormatText(var_444_1.content)

				arg_441_1.text_.text = var_444_2

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 34 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 34)

				if (34 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 34)) > 0 and var_444_0 < var_444_4 then
					arg_441_1.talkMaxDuration = var_444_4

					if var_444_4 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_4 + 0
					end
				end

				arg_441_1.text_.text = var_444_2
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041108", "story_v_out_221041.awb") ~= 0 then
					local var_444_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041108", "story_v_out_221041.awb") / 1000

					if var_444_5 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + 0
					end

					if var_444_1.prefab_name ~= "" and arg_441_1.actors_[var_444_1.prefab_name] ~= nil then
						local var_444_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_1.prefab_name].transform, "story_v_out_221041", "221041108", "story_v_out_221041.awb")

						arg_441_1:RecordAudio("221041108", var_444_6)
						arg_441_1:RecordAudio("221041108", var_444_6)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_221041", "221041108", "story_v_out_221041.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_221041", "221041108", "story_v_out_221041.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_7 and arg_441_1.time_ < 0 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play221041109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 221041109
		arg_445_1.duration_ = 4.1

		local var_445_0 = {
			ja = 4.1,
			ko = 2.933,
			zh = 2.933
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play221041110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0.35

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:GetWordFromCfg(221041109)
				local var_448_2 = arg_445_1:FormatText(var_448_1.content)

				arg_445_1.text_.text = var_448_2

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 14 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 14)

				if (14 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 14)) > 0 and var_448_0 < var_448_4 then
					arg_445_1.talkMaxDuration = var_448_4

					if var_448_4 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_4 + 0
					end
				end

				arg_445_1.text_.text = var_448_2
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041109", "story_v_out_221041.awb") ~= 0 then
					local var_448_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041109", "story_v_out_221041.awb") / 1000

					if var_448_5 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + 0
					end

					if var_448_1.prefab_name ~= "" and arg_445_1.actors_[var_448_1.prefab_name] ~= nil then
						local var_448_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_1.prefab_name].transform, "story_v_out_221041", "221041109", "story_v_out_221041.awb")

						arg_445_1:RecordAudio("221041109", var_448_6)
						arg_445_1:RecordAudio("221041109", var_448_6)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_221041", "221041109", "story_v_out_221041.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_221041", "221041109", "story_v_out_221041.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_7 and arg_445_1.time_ < 0 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play221041110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 221041110
		arg_449_1.duration_ = 3.67

		local var_449_0 = {
			ja = 2.733,
			ko = 3.666,
			zh = 3.666
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play221041111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.4

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:GetWordFromCfg(221041110)
				local var_452_2 = arg_449_1:FormatText(var_452_1.content)

				arg_449_1.text_.text = var_452_2

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_4 = 16 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 16)

				if (16 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 16)) > 0 and var_452_0 < var_452_4 then
					arg_449_1.talkMaxDuration = var_452_4

					if var_452_4 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_4 + 0
					end
				end

				arg_449_1.text_.text = var_452_2
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041110", "story_v_out_221041.awb") ~= 0 then
					local var_452_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041110", "story_v_out_221041.awb") / 1000

					if var_452_5 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + 0
					end

					if var_452_1.prefab_name ~= "" and arg_449_1.actors_[var_452_1.prefab_name] ~= nil then
						local var_452_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_1.prefab_name].transform, "story_v_out_221041", "221041110", "story_v_out_221041.awb")

						arg_449_1:RecordAudio("221041110", var_452_6)
						arg_449_1:RecordAudio("221041110", var_452_6)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_221041", "221041110", "story_v_out_221041.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_221041", "221041110", "story_v_out_221041.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_7 and arg_449_1.time_ < 0 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play221041111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 221041111
		arg_453_1.duration_ = 6.8

		local var_453_0 = {
			ja = 6.8,
			ko = 4.1,
			zh = 4.1
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play221041112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.5

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_1 = arg_453_1:GetWordFromCfg(221041111)
				local var_456_2 = arg_453_1:FormatText(var_456_1.content)

				arg_453_1.text_.text = var_456_2

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 21 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 21)

				if (21 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 21)) > 0 and var_456_0 < var_456_4 then
					arg_453_1.talkMaxDuration = var_456_4

					if var_456_4 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_4 + 0
					end
				end

				arg_453_1.text_.text = var_456_2
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041111", "story_v_out_221041.awb") ~= 0 then
					local var_456_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041111", "story_v_out_221041.awb") / 1000

					if var_456_5 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + 0
					end

					if var_456_1.prefab_name ~= "" and arg_453_1.actors_[var_456_1.prefab_name] ~= nil then
						local var_456_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_1.prefab_name].transform, "story_v_out_221041", "221041111", "story_v_out_221041.awb")

						arg_453_1:RecordAudio("221041111", var_456_6)
						arg_453_1:RecordAudio("221041111", var_456_6)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_221041", "221041111", "story_v_out_221041.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_221041", "221041111", "story_v_out_221041.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_7 and arg_453_1.time_ < 0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play221041112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 221041112
		arg_457_1.duration_ = 6.2

		local var_457_0 = {
			ja = 6.2,
			ko = 4.866,
			zh = 4.866
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play221041113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.575

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:GetWordFromCfg(221041112)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.text_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 23 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 23)

				if (23 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 23)) > 0 and var_460_0 < var_460_4 then
					arg_457_1.talkMaxDuration = var_460_4

					if var_460_4 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_4 + 0
					end
				end

				arg_457_1.text_.text = var_460_2
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041112", "story_v_out_221041.awb") ~= 0 then
					local var_460_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041112", "story_v_out_221041.awb") / 1000

					if var_460_5 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + 0
					end

					if var_460_1.prefab_name ~= "" and arg_457_1.actors_[var_460_1.prefab_name] ~= nil then
						local var_460_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_1.prefab_name].transform, "story_v_out_221041", "221041112", "story_v_out_221041.awb")

						arg_457_1:RecordAudio("221041112", var_460_6)
						arg_457_1:RecordAudio("221041112", var_460_6)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_221041", "221041112", "story_v_out_221041.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_221041", "221041112", "story_v_out_221041.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play221041113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 221041113
		arg_461_1.duration_ = 9

		local var_461_0 = {
			ja = 6.8,
			ko = 9,
			zh = 9
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play221041114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 1.025

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:GetWordFromCfg(221041113)
				local var_464_2 = arg_461_1:FormatText(var_464_1.content)

				arg_461_1.text_.text = var_464_2

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 43 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 43)

				if (43 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 43)) > 0 and var_464_0 < var_464_4 then
					arg_461_1.talkMaxDuration = var_464_4

					if var_464_4 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_4 + 0
					end
				end

				arg_461_1.text_.text = var_464_2
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041113", "story_v_out_221041.awb") ~= 0 then
					local var_464_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041113", "story_v_out_221041.awb") / 1000

					if var_464_5 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + 0
					end

					if var_464_1.prefab_name ~= "" and arg_461_1.actors_[var_464_1.prefab_name] ~= nil then
						local var_464_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_1.prefab_name].transform, "story_v_out_221041", "221041113", "story_v_out_221041.awb")

						arg_461_1:RecordAudio("221041113", var_464_6)
						arg_461_1:RecordAudio("221041113", var_464_6)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_221041", "221041113", "story_v_out_221041.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_221041", "221041113", "story_v_out_221041.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_7 and arg_461_1.time_ < 0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play221041114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 221041114
		arg_465_1.duration_ = 6.8

		local var_465_0 = {
			ja = 6.8,
			ko = 4.866,
			zh = 4.866
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play221041115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0.525

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_1 = arg_465_1:GetWordFromCfg(221041114)
				local var_468_2 = arg_465_1:FormatText(var_468_1.content)

				arg_465_1.text_.text = var_468_2

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 21 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 21)

				if (21 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 21)) > 0 and var_468_0 < var_468_4 then
					arg_465_1.talkMaxDuration = var_468_4

					if var_468_4 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_4 + 0
					end
				end

				arg_465_1.text_.text = var_468_2
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041114", "story_v_out_221041.awb") ~= 0 then
					local var_468_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041114", "story_v_out_221041.awb") / 1000

					if var_468_5 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + 0
					end

					if var_468_1.prefab_name ~= "" and arg_465_1.actors_[var_468_1.prefab_name] ~= nil then
						local var_468_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_1.prefab_name].transform, "story_v_out_221041", "221041114", "story_v_out_221041.awb")

						arg_465_1:RecordAudio("221041114", var_468_6)
						arg_465_1:RecordAudio("221041114", var_468_6)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_221041", "221041114", "story_v_out_221041.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_221041", "221041114", "story_v_out_221041.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_7 and arg_465_1.time_ < 0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play221041115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 221041115
		arg_469_1.duration_ = 5

		local var_469_0 = {
			ja = 5,
			ko = 3.933,
			zh = 3.933
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play221041116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.45

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_1 = arg_469_1:GetWordFromCfg(221041115)
				local var_472_2 = arg_469_1:FormatText(var_472_1.content)

				arg_469_1.text_.text = var_472_2

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 18 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 18)

				if (18 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 18)) > 0 and var_472_0 < var_472_4 then
					arg_469_1.talkMaxDuration = var_472_4

					if var_472_4 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_4 + 0
					end
				end

				arg_469_1.text_.text = var_472_2
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041115", "story_v_out_221041.awb") ~= 0 then
					local var_472_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041115", "story_v_out_221041.awb") / 1000

					if var_472_5 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + 0
					end

					if var_472_1.prefab_name ~= "" and arg_469_1.actors_[var_472_1.prefab_name] ~= nil then
						local var_472_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_1.prefab_name].transform, "story_v_out_221041", "221041115", "story_v_out_221041.awb")

						arg_469_1:RecordAudio("221041115", var_472_6)
						arg_469_1:RecordAudio("221041115", var_472_6)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_221041", "221041115", "story_v_out_221041.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_221041", "221041115", "story_v_out_221041.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_7 and arg_469_1.time_ < 0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play221041116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 221041116
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play221041117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.825

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(221041116).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 33 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 33)

				if (33 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 33)) > 0 and var_476_0 < var_476_3 then
					arg_473_1.talkMaxDuration = var_476_3

					if var_476_3 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_3 + 0
					end
				end

				arg_473_1.text_.text = var_476_1
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_4 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_4 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_4

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_4 and arg_473_1.time_ < 0 + var_476_4 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play221041117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 221041117
		arg_477_1.duration_ = 14.17

		local var_477_0 = {
			ja = 14.166,
			ko = 10.9,
			zh = 10.9
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play221041118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 1.2

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_1 = arg_477_1:GetWordFromCfg(221041117)
				local var_480_2 = arg_477_1:FormatText(var_480_1.content)

				arg_477_1.text_.text = var_480_2

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_4 = 47 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 47)

				if (47 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 47)) > 0 and var_480_0 < var_480_4 then
					arg_477_1.talkMaxDuration = var_480_4

					if var_480_4 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_4 + 0
					end
				end

				arg_477_1.text_.text = var_480_2
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041117", "story_v_out_221041.awb") ~= 0 then
					local var_480_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041117", "story_v_out_221041.awb") / 1000

					if var_480_5 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + 0
					end

					if var_480_1.prefab_name ~= "" and arg_477_1.actors_[var_480_1.prefab_name] ~= nil then
						local var_480_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_1.prefab_name].transform, "story_v_out_221041", "221041117", "story_v_out_221041.awb")

						arg_477_1:RecordAudio("221041117", var_480_6)
						arg_477_1:RecordAudio("221041117", var_480_6)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_221041", "221041117", "story_v_out_221041.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_221041", "221041117", "story_v_out_221041.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_7 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_7 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_7

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_7 and arg_477_1.time_ < 0 + var_480_7 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play221041118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 221041118
		arg_481_1.duration_ = 8.97

		local var_481_0 = {
			ja = 8.966,
			ko = 6.333,
			zh = 6.333
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play221041119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.625

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:GetWordFromCfg(221041118)
				local var_484_2 = arg_481_1:FormatText(var_484_1.content)

				arg_481_1.text_.text = var_484_2

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 25 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 25)

				if (25 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 25)) > 0 and var_484_0 < var_484_4 then
					arg_481_1.talkMaxDuration = var_484_4

					if var_484_4 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_4 + 0
					end
				end

				arg_481_1.text_.text = var_484_2
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041118", "story_v_out_221041.awb") ~= 0 then
					local var_484_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041118", "story_v_out_221041.awb") / 1000

					if var_484_5 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + 0
					end

					if var_484_1.prefab_name ~= "" and arg_481_1.actors_[var_484_1.prefab_name] ~= nil then
						local var_484_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_1.prefab_name].transform, "story_v_out_221041", "221041118", "story_v_out_221041.awb")

						arg_481_1:RecordAudio("221041118", var_484_6)
						arg_481_1:RecordAudio("221041118", var_484_6)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_221041", "221041118", "story_v_out_221041.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_221041", "221041118", "story_v_out_221041.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play221041119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 221041119
		arg_485_1.duration_ = 2.83

		local var_485_0 = {
			ja = 2.833,
			ko = 1.8,
			zh = 1.8
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play221041120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.225

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_1 = arg_485_1:GetWordFromCfg(221041119)
				local var_488_2 = arg_485_1:FormatText(var_488_1.content)

				arg_485_1.text_.text = var_488_2

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 9 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 9)

				if (9 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 9)) > 0 and var_488_0 < var_488_4 then
					arg_485_1.talkMaxDuration = var_488_4

					if var_488_4 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_4 + 0
					end
				end

				arg_485_1.text_.text = var_488_2
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041119", "story_v_out_221041.awb") ~= 0 then
					local var_488_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041119", "story_v_out_221041.awb") / 1000

					if var_488_5 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + 0
					end

					if var_488_1.prefab_name ~= "" and arg_485_1.actors_[var_488_1.prefab_name] ~= nil then
						local var_488_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_1.prefab_name].transform, "story_v_out_221041", "221041119", "story_v_out_221041.awb")

						arg_485_1:RecordAudio("221041119", var_488_6)
						arg_485_1:RecordAudio("221041119", var_488_6)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_221041", "221041119", "story_v_out_221041.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_221041", "221041119", "story_v_out_221041.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_7 and arg_485_1.time_ < 0 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play221041120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 221041120
		arg_489_1.duration_ = 11.97

		local var_489_0 = {
			ja = 11.966,
			ko = 7.133,
			zh = 7.133
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play221041121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.7

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_1 = arg_489_1:GetWordFromCfg(221041120)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 28 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 28)

				if (28 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 28)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041120", "story_v_out_221041.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041120", "story_v_out_221041.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_out_221041", "221041120", "story_v_out_221041.awb")

						arg_489_1:RecordAudio("221041120", var_492_6)
						arg_489_1:RecordAudio("221041120", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_221041", "221041120", "story_v_out_221041.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_221041", "221041120", "story_v_out_221041.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play221041121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 221041121
		arg_493_1.duration_ = 2

		local var_493_0 = {
			ja = 2,
			ko = 1.166,
			zh = 1.166
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play221041122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.1

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_1 = arg_493_1:GetWordFromCfg(221041121)
				local var_496_2 = arg_493_1:FormatText(var_496_1.content)

				arg_493_1.text_.text = var_496_2

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 4 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 4)

				if (4 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 4)) > 0 and var_496_0 < var_496_4 then
					arg_493_1.talkMaxDuration = var_496_4

					if var_496_4 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_4 + 0
					end
				end

				arg_493_1.text_.text = var_496_2
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041121", "story_v_out_221041.awb") ~= 0 then
					local var_496_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041121", "story_v_out_221041.awb") / 1000

					if var_496_5 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_5 + 0
					end

					if var_496_1.prefab_name ~= "" and arg_493_1.actors_[var_496_1.prefab_name] ~= nil then
						local var_496_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_1.prefab_name].transform, "story_v_out_221041", "221041121", "story_v_out_221041.awb")

						arg_493_1:RecordAudio("221041121", var_496_6)
						arg_493_1:RecordAudio("221041121", var_496_6)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_221041", "221041121", "story_v_out_221041.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_221041", "221041121", "story_v_out_221041.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_7 and arg_493_1.time_ < 0 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play221041122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 221041122
		arg_497_1.duration_ = 1

		local var_497_0 = {
			ja = 0.999999999999,
			ko = 1,
			zh = 1
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play221041123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0.05

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_1 = arg_497_1:GetWordFromCfg(221041122)
				local var_500_2 = arg_497_1:FormatText(var_500_1.content)

				arg_497_1.text_.text = var_500_2

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 2 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 2)

				if (2 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 2)) > 0 and var_500_0 < var_500_4 then
					arg_497_1.talkMaxDuration = var_500_4

					if var_500_4 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_4 + 0
					end
				end

				arg_497_1.text_.text = var_500_2
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041122", "story_v_out_221041.awb") ~= 0 then
					local var_500_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041122", "story_v_out_221041.awb") / 1000

					if var_500_5 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + 0
					end

					if var_500_1.prefab_name ~= "" and arg_497_1.actors_[var_500_1.prefab_name] ~= nil then
						local var_500_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_1.prefab_name].transform, "story_v_out_221041", "221041122", "story_v_out_221041.awb")

						arg_497_1:RecordAudio("221041122", var_500_6)
						arg_497_1:RecordAudio("221041122", var_500_6)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_221041", "221041122", "story_v_out_221041.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_221041", "221041122", "story_v_out_221041.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_0, arg_497_1.talkMaxDuration)

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - 0) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= 0 + var_500_7 and arg_497_1.time_ < 0 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play221041123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 221041123
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play221041124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0.55

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_1 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(221041123).content)

				arg_501_1.text_.text = var_504_1

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_3 = 22 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 22)

				if (22 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 22)) > 0 and var_504_0 < var_504_3 then
					arg_501_1.talkMaxDuration = var_504_3

					if var_504_3 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_3 + 0
					end
				end

				arg_501_1.text_.text = var_504_1
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_4 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_4

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play221041124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 221041124
		arg_505_1.duration_ = 14.3

		local var_505_0 = {
			ja = 14.3,
			ko = 9.5,
			zh = 9.5
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play221041125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 1.075

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_1 = arg_505_1:GetWordFromCfg(221041124)
				local var_508_2 = arg_505_1:FormatText(var_508_1.content)

				arg_505_1.text_.text = var_508_2

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 43 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 43)

				if (43 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 43)) > 0 and var_508_0 < var_508_4 then
					arg_505_1.talkMaxDuration = var_508_4

					if var_508_4 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_4 + 0
					end
				end

				arg_505_1.text_.text = var_508_2
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041124", "story_v_out_221041.awb") ~= 0 then
					local var_508_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041124", "story_v_out_221041.awb") / 1000

					if var_508_5 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + 0
					end

					if var_508_1.prefab_name ~= "" and arg_505_1.actors_[var_508_1.prefab_name] ~= nil then
						local var_508_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_1.prefab_name].transform, "story_v_out_221041", "221041124", "story_v_out_221041.awb")

						arg_505_1:RecordAudio("221041124", var_508_6)
						arg_505_1:RecordAudio("221041124", var_508_6)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_221041", "221041124", "story_v_out_221041.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_221041", "221041124", "story_v_out_221041.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_7 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_7 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_7

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_7 and arg_505_1.time_ < 0 + var_508_7 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play221041125 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 221041125
		arg_509_1.duration_ = 7.27

		local var_509_0 = {
			ja = 7.266,
			ko = 5.8,
			zh = 5.8
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
				arg_509_0:Play221041126(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0.7

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_1 = arg_509_1:GetWordFromCfg(221041125)
				local var_512_2 = arg_509_1:FormatText(var_512_1.content)

				arg_509_1.text_.text = var_512_2

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_4 = 28 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 28)

				if (28 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 28)) > 0 and var_512_0 < var_512_4 then
					arg_509_1.talkMaxDuration = var_512_4

					if var_512_4 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_4 + 0
					end
				end

				arg_509_1.text_.text = var_512_2
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041125", "story_v_out_221041.awb") ~= 0 then
					local var_512_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041125", "story_v_out_221041.awb") / 1000

					if var_512_5 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + 0
					end

					if var_512_1.prefab_name ~= "" and arg_509_1.actors_[var_512_1.prefab_name] ~= nil then
						local var_512_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_1.prefab_name].transform, "story_v_out_221041", "221041125", "story_v_out_221041.awb")

						arg_509_1:RecordAudio("221041125", var_512_6)
						arg_509_1:RecordAudio("221041125", var_512_6)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_221041", "221041125", "story_v_out_221041.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_221041", "221041125", "story_v_out_221041.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_7 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_7 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_7

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_7 and arg_509_1.time_ < 0 + var_512_7 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play221041126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 221041126
		arg_513_1.duration_ = 1.57

		local var_513_0 = {
			ja = 1.1,
			ko = 1.566,
			zh = 1.566
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play221041127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.05

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_1 = arg_513_1:GetWordFromCfg(221041126)
				local var_516_2 = arg_513_1:FormatText(var_516_1.content)

				arg_513_1.text_.text = var_516_2

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_4 = 2 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 2)

				if (2 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 2)) > 0 and var_516_0 < var_516_4 then
					arg_513_1.talkMaxDuration = var_516_4

					if var_516_4 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_4 + 0
					end
				end

				arg_513_1.text_.text = var_516_2
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041126", "story_v_out_221041.awb") ~= 0 then
					local var_516_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041126", "story_v_out_221041.awb") / 1000

					if var_516_5 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + 0
					end

					if var_516_1.prefab_name ~= "" and arg_513_1.actors_[var_516_1.prefab_name] ~= nil then
						local var_516_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_1.prefab_name].transform, "story_v_out_221041", "221041126", "story_v_out_221041.awb")

						arg_513_1:RecordAudio("221041126", var_516_6)
						arg_513_1:RecordAudio("221041126", var_516_6)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_221041", "221041126", "story_v_out_221041.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_221041", "221041126", "story_v_out_221041.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_7 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_7 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_7

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_7 and arg_513_1.time_ < 0 + var_516_7 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play221041127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 221041127
		arg_517_1.duration_ = 7.23

		local var_517_0 = {
			ja = 7.233,
			ko = 6.766,
			zh = 6.766
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
				arg_517_0:Play221041128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.7

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_1 = arg_517_1:GetWordFromCfg(221041127)
				local var_520_2 = arg_517_1:FormatText(var_520_1.content)

				arg_517_1.text_.text = var_520_2

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 28 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 28)

				if (28 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 28)) > 0 and var_520_0 < var_520_4 then
					arg_517_1.talkMaxDuration = var_520_4

					if var_520_4 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_4 + 0
					end
				end

				arg_517_1.text_.text = var_520_2
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041127", "story_v_out_221041.awb") ~= 0 then
					local var_520_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041127", "story_v_out_221041.awb") / 1000

					if var_520_5 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + 0
					end

					if var_520_1.prefab_name ~= "" and arg_517_1.actors_[var_520_1.prefab_name] ~= nil then
						local var_520_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_1.prefab_name].transform, "story_v_out_221041", "221041127", "story_v_out_221041.awb")

						arg_517_1:RecordAudio("221041127", var_520_6)
						arg_517_1:RecordAudio("221041127", var_520_6)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_221041", "221041127", "story_v_out_221041.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_221041", "221041127", "story_v_out_221041.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_7 and arg_517_1.time_ < 0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play221041128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 221041128
		arg_521_1.duration_ = 7.67

		local var_521_0 = {
			ja = 7.666,
			ko = 3.933,
			zh = 3.933
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
				arg_521_0:Play221041129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.45

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_1 = arg_521_1:GetWordFromCfg(221041128)
				local var_524_2 = arg_521_1:FormatText(var_524_1.content)

				arg_521_1.text_.text = var_524_2

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 18 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 18)

				if (18 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 18)) > 0 and var_524_0 < var_524_4 then
					arg_521_1.talkMaxDuration = var_524_4

					if var_524_4 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_4 + 0
					end
				end

				arg_521_1.text_.text = var_524_2
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041128", "story_v_out_221041.awb") ~= 0 then
					local var_524_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041128", "story_v_out_221041.awb") / 1000

					if var_524_5 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + 0
					end

					if var_524_1.prefab_name ~= "" and arg_521_1.actors_[var_524_1.prefab_name] ~= nil then
						local var_524_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_1.prefab_name].transform, "story_v_out_221041", "221041128", "story_v_out_221041.awb")

						arg_521_1:RecordAudio("221041128", var_524_6)
						arg_521_1:RecordAudio("221041128", var_524_6)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_221041", "221041128", "story_v_out_221041.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_221041", "221041128", "story_v_out_221041.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_7 and arg_521_1.time_ < 0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play221041129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 221041129
		arg_525_1.duration_ = 5.53

		local var_525_0 = {
			ja = 5.533,
			ko = 2.4,
			zh = 2.4
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play221041130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.225

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:GetWordFromCfg(221041129)
				local var_528_2 = arg_525_1:FormatText(var_528_1.content)

				arg_525_1.text_.text = var_528_2

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_4 = 9 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 9)

				if (9 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 9)) > 0 and var_528_0 < var_528_4 then
					arg_525_1.talkMaxDuration = var_528_4

					if var_528_4 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_4 + 0
					end
				end

				arg_525_1.text_.text = var_528_2
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041129", "story_v_out_221041.awb") ~= 0 then
					local var_528_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041129", "story_v_out_221041.awb") / 1000

					if var_528_5 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + 0
					end

					if var_528_1.prefab_name ~= "" and arg_525_1.actors_[var_528_1.prefab_name] ~= nil then
						local var_528_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_1.prefab_name].transform, "story_v_out_221041", "221041129", "story_v_out_221041.awb")

						arg_525_1:RecordAudio("221041129", var_528_6)
						arg_525_1:RecordAudio("221041129", var_528_6)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_221041", "221041129", "story_v_out_221041.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_221041", "221041129", "story_v_out_221041.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_7 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_7 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_7

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_7 and arg_525_1.time_ < 0 + var_528_7 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play221041130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 221041130
		arg_529_1.duration_ = 9.07

		local var_529_0 = {
			ja = 9.066,
			ko = 4.6,
			zh = 4.6
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
				arg_529_0:Play221041131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0.45

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_1 = arg_529_1:GetWordFromCfg(221041130)
				local var_532_2 = arg_529_1:FormatText(var_532_1.content)

				arg_529_1.text_.text = var_532_2

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_4 = 18 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 18)

				if (18 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 18)) > 0 and var_532_0 < var_532_4 then
					arg_529_1.talkMaxDuration = var_532_4

					if var_532_4 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_4 + 0
					end
				end

				arg_529_1.text_.text = var_532_2
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041130", "story_v_out_221041.awb") ~= 0 then
					local var_532_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041130", "story_v_out_221041.awb") / 1000

					if var_532_5 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + 0
					end

					if var_532_1.prefab_name ~= "" and arg_529_1.actors_[var_532_1.prefab_name] ~= nil then
						local var_532_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_1.prefab_name].transform, "story_v_out_221041", "221041130", "story_v_out_221041.awb")

						arg_529_1:RecordAudio("221041130", var_532_6)
						arg_529_1:RecordAudio("221041130", var_532_6)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_221041", "221041130", "story_v_out_221041.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_221041", "221041130", "story_v_out_221041.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_7 = math.max(var_532_0, arg_529_1.talkMaxDuration)

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_7 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - 0) / var_532_7

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= 0 + var_532_7 and arg_529_1.time_ < 0 + var_532_7 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play221041131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 221041131
		arg_533_1.duration_ = 15

		local var_533_0 = {
			ja = 15,
			ko = 13,
			zh = 13
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play221041132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 1.275

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_1 = arg_533_1:GetWordFromCfg(221041131)
				local var_536_2 = arg_533_1:FormatText(var_536_1.content)

				arg_533_1.text_.text = var_536_2

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_4 = 51 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 51)

				if (51 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 51)) > 0 and var_536_0 < var_536_4 then
					arg_533_1.talkMaxDuration = var_536_4

					if var_536_4 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_4 + 0
					end
				end

				arg_533_1.text_.text = var_536_2
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041131", "story_v_out_221041.awb") ~= 0 then
					local var_536_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041131", "story_v_out_221041.awb") / 1000

					if var_536_5 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + 0
					end

					if var_536_1.prefab_name ~= "" and arg_533_1.actors_[var_536_1.prefab_name] ~= nil then
						local var_536_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_1.prefab_name].transform, "story_v_out_221041", "221041131", "story_v_out_221041.awb")

						arg_533_1:RecordAudio("221041131", var_536_6)
						arg_533_1:RecordAudio("221041131", var_536_6)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_221041", "221041131", "story_v_out_221041.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_221041", "221041131", "story_v_out_221041.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_7 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_7 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_7

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_7 and arg_533_1.time_ < 0 + var_536_7 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play221041132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 221041132
		arg_537_1.duration_ = 10.2

		local var_537_0 = {
			ja = 10.2,
			ko = 6.533,
			zh = 6.533
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play221041133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.65

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_1 = arg_537_1:GetWordFromCfg(221041132)
				local var_540_2 = arg_537_1:FormatText(var_540_1.content)

				arg_537_1.text_.text = var_540_2

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_4 = 26 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_2) / 26)

				if (26 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_2) / 26)) > 0 and var_540_0 < var_540_4 then
					arg_537_1.talkMaxDuration = var_540_4

					if var_540_4 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_4 + 0
					end
				end

				arg_537_1.text_.text = var_540_2
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041132", "story_v_out_221041.awb") ~= 0 then
					local var_540_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041132", "story_v_out_221041.awb") / 1000

					if var_540_5 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_5 + 0
					end

					if var_540_1.prefab_name ~= "" and arg_537_1.actors_[var_540_1.prefab_name] ~= nil then
						local var_540_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_1.prefab_name].transform, "story_v_out_221041", "221041132", "story_v_out_221041.awb")

						arg_537_1:RecordAudio("221041132", var_540_6)
						arg_537_1:RecordAudio("221041132", var_540_6)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_221041", "221041132", "story_v_out_221041.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_221041", "221041132", "story_v_out_221041.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_7 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_7 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_7

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_7 and arg_537_1.time_ < 0 + var_540_7 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play221041133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 221041133
		arg_541_1.duration_ = 22.03

		local var_541_0 = {
			ja = 17.1,
			ko = 22.033,
			zh = 22.033
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
				arg_541_0:Play221041134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 2.075

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_1 = arg_541_1:GetWordFromCfg(221041133)
				local var_544_2 = arg_541_1:FormatText(var_544_1.content)

				arg_541_1.text_.text = var_544_2

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_4 = 83 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 83)

				if (83 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 83)) > 0 and var_544_0 < var_544_4 then
					arg_541_1.talkMaxDuration = var_544_4

					if var_544_4 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_4 + 0
					end
				end

				arg_541_1.text_.text = var_544_2
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041133", "story_v_out_221041.awb") ~= 0 then
					local var_544_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041133", "story_v_out_221041.awb") / 1000

					if var_544_5 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + 0
					end

					if var_544_1.prefab_name ~= "" and arg_541_1.actors_[var_544_1.prefab_name] ~= nil then
						local var_544_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_1.prefab_name].transform, "story_v_out_221041", "221041133", "story_v_out_221041.awb")

						arg_541_1:RecordAudio("221041133", var_544_6)
						arg_541_1:RecordAudio("221041133", var_544_6)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_221041", "221041133", "story_v_out_221041.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_221041", "221041133", "story_v_out_221041.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_7 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_7

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play221041134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 221041134
		arg_545_1.duration_ = 14.9

		local var_545_0 = {
			ja = 14.9,
			ko = 8.666,
			zh = 8.666
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play221041135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0.875

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_1 = arg_545_1:GetWordFromCfg(221041134)
				local var_548_2 = arg_545_1:FormatText(var_548_1.content)

				arg_545_1.text_.text = var_548_2

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_4 = 35 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_2) / 35)

				if (35 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_2) / 35)) > 0 and var_548_0 < var_548_4 then
					arg_545_1.talkMaxDuration = var_548_4

					if var_548_4 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_4 + 0
					end
				end

				arg_545_1.text_.text = var_548_2
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041134", "story_v_out_221041.awb") ~= 0 then
					local var_548_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041134", "story_v_out_221041.awb") / 1000

					if var_548_5 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_5 + 0
					end

					if var_548_1.prefab_name ~= "" and arg_545_1.actors_[var_548_1.prefab_name] ~= nil then
						local var_548_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_1.prefab_name].transform, "story_v_out_221041", "221041134", "story_v_out_221041.awb")

						arg_545_1:RecordAudio("221041134", var_548_6)
						arg_545_1:RecordAudio("221041134", var_548_6)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_221041", "221041134", "story_v_out_221041.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_221041", "221041134", "story_v_out_221041.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_7 = math.max(var_548_0, arg_545_1.talkMaxDuration)

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_7 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - 0) / var_548_7

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= 0 + var_548_7 and arg_545_1.time_ < 0 + var_548_7 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play221041135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 221041135
		arg_549_1.duration_ = 13.23

		local var_549_0 = {
			ja = 13.233,
			ko = 8.9,
			zh = 8.9
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play221041136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 1.125

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_1 = arg_549_1:GetWordFromCfg(221041135)
				local var_552_2 = arg_549_1:FormatText(var_552_1.content)

				arg_549_1.text_.text = var_552_2

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 45 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_2) / 45)

				if (45 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_2) / 45)) > 0 and var_552_0 < var_552_4 then
					arg_549_1.talkMaxDuration = var_552_4

					if var_552_4 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_4 + 0
					end
				end

				arg_549_1.text_.text = var_552_2
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041135", "story_v_out_221041.awb") ~= 0 then
					local var_552_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041135", "story_v_out_221041.awb") / 1000

					if var_552_5 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + 0
					end

					if var_552_1.prefab_name ~= "" and arg_549_1.actors_[var_552_1.prefab_name] ~= nil then
						local var_552_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_1.prefab_name].transform, "story_v_out_221041", "221041135", "story_v_out_221041.awb")

						arg_549_1:RecordAudio("221041135", var_552_6)
						arg_549_1:RecordAudio("221041135", var_552_6)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_221041", "221041135", "story_v_out_221041.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_221041", "221041135", "story_v_out_221041.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_7 = math.max(var_552_0, arg_549_1.talkMaxDuration)

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_7 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - 0) / var_552_7

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= 0 + var_552_7 and arg_549_1.time_ < 0 + var_552_7 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play221041136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 221041136
		arg_553_1.duration_ = 1

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play221041137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0.05

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_1 = arg_553_1:GetWordFromCfg(221041136)
				local var_556_2 = arg_553_1:FormatText(var_556_1.content)

				arg_553_1.text_.text = var_556_2

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_4 = 2 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_2) / 2)

				if (2 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_2) / 2)) > 0 and var_556_0 < var_556_4 then
					arg_553_1.talkMaxDuration = var_556_4

					if var_556_4 + 0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_4 + 0
					end
				end

				arg_553_1.text_.text = var_556_2
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041136", "story_v_out_221041.awb") ~= 0 then
					local var_556_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041136", "story_v_out_221041.awb") / 1000

					if var_556_5 + 0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_5 + 0
					end

					if var_556_1.prefab_name ~= "" and arg_553_1.actors_[var_556_1.prefab_name] ~= nil then
						local var_556_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_1.prefab_name].transform, "story_v_out_221041", "221041136", "story_v_out_221041.awb")

						arg_553_1:RecordAudio("221041136", var_556_6)
						arg_553_1:RecordAudio("221041136", var_556_6)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_221041", "221041136", "story_v_out_221041.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_221041", "221041136", "story_v_out_221041.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_7 = math.max(var_556_0, arg_553_1.talkMaxDuration)

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_7 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - 0) / var_556_7

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= 0 + var_556_7 and arg_553_1.time_ < 0 + var_556_7 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play221041137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 221041137
		arg_557_1.duration_ = 8.93

		local var_557_0 = {
			ja = 8.933,
			ko = 4.466,
			zh = 4.466
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play221041138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0.475

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_1 = arg_557_1:GetWordFromCfg(221041137)
				local var_560_2 = arg_557_1:FormatText(var_560_1.content)

				arg_557_1.text_.text = var_560_2

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_4 = 19 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 19)

				if (19 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 19)) > 0 and var_560_0 < var_560_4 then
					arg_557_1.talkMaxDuration = var_560_4

					if var_560_4 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_4 + 0
					end
				end

				arg_557_1.text_.text = var_560_2
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041137", "story_v_out_221041.awb") ~= 0 then
					local var_560_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041137", "story_v_out_221041.awb") / 1000

					if var_560_5 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + 0
					end

					if var_560_1.prefab_name ~= "" and arg_557_1.actors_[var_560_1.prefab_name] ~= nil then
						local var_560_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_1.prefab_name].transform, "story_v_out_221041", "221041137", "story_v_out_221041.awb")

						arg_557_1:RecordAudio("221041137", var_560_6)
						arg_557_1:RecordAudio("221041137", var_560_6)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_221041", "221041137", "story_v_out_221041.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_221041", "221041137", "story_v_out_221041.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_7 = math.max(var_560_0, arg_557_1.talkMaxDuration)

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_7 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - 0) / var_560_7

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= 0 + var_560_7 and arg_557_1.time_ < 0 + var_560_7 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play221041138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 221041138
		arg_561_1.duration_ = 8.53

		local var_561_0 = {
			ja = 8.533,
			ko = 6.233,
			zh = 6.233
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play221041139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.725

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_1 = arg_561_1:GetWordFromCfg(221041138)
				local var_564_2 = arg_561_1:FormatText(var_564_1.content)

				arg_561_1.text_.text = var_564_2

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_4 = 29 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_2) / 29)

				if (29 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_2) / 29)) > 0 and var_564_0 < var_564_4 then
					arg_561_1.talkMaxDuration = var_564_4

					if var_564_4 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_4 + 0
					end
				end

				arg_561_1.text_.text = var_564_2
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041138", "story_v_out_221041.awb") ~= 0 then
					local var_564_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041138", "story_v_out_221041.awb") / 1000

					if var_564_5 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_5 + 0
					end

					if var_564_1.prefab_name ~= "" and arg_561_1.actors_[var_564_1.prefab_name] ~= nil then
						local var_564_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_1.prefab_name].transform, "story_v_out_221041", "221041138", "story_v_out_221041.awb")

						arg_561_1:RecordAudio("221041138", var_564_6)
						arg_561_1:RecordAudio("221041138", var_564_6)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_221041", "221041138", "story_v_out_221041.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_221041", "221041138", "story_v_out_221041.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_7 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_7 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_7

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_7 and arg_561_1.time_ < 0 + var_564_7 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play221041139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 221041139
		arg_565_1.duration_ = 5.8

		local var_565_0 = {
			ja = 5.8,
			ko = 2.1,
			zh = 2.1
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play221041140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0.2

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_1 = arg_565_1:GetWordFromCfg(221041139)
				local var_568_2 = arg_565_1:FormatText(var_568_1.content)

				arg_565_1.text_.text = var_568_2

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_4 = 8 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_2) / 8)

				if (8 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_2) / 8)) > 0 and var_568_0 < var_568_4 then
					arg_565_1.talkMaxDuration = var_568_4

					if var_568_4 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_4 + 0
					end
				end

				arg_565_1.text_.text = var_568_2
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041139", "story_v_out_221041.awb") ~= 0 then
					local var_568_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041139", "story_v_out_221041.awb") / 1000

					if var_568_5 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_5 + 0
					end

					if var_568_1.prefab_name ~= "" and arg_565_1.actors_[var_568_1.prefab_name] ~= nil then
						local var_568_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_1.prefab_name].transform, "story_v_out_221041", "221041139", "story_v_out_221041.awb")

						arg_565_1:RecordAudio("221041139", var_568_6)
						arg_565_1:RecordAudio("221041139", var_568_6)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_221041", "221041139", "story_v_out_221041.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_221041", "221041139", "story_v_out_221041.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_7 = math.max(var_568_0, arg_565_1.talkMaxDuration)

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_7 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - 0) / var_568_7

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= 0 + var_568_7 and arg_565_1.time_ < 0 + var_568_7 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play221041140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 221041140
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play221041141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0.95

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_1 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(221041140).content)

				arg_569_1.text_.text = var_572_1

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_3 = 38 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_1) / 38)

				if (38 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_1) / 38)) > 0 and var_572_0 < var_572_3 then
					arg_569_1.talkMaxDuration = var_572_3

					if var_572_3 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_3 + 0
					end
				end

				arg_569_1.text_.text = var_572_1
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_4 = math.max(var_572_0, arg_569_1.talkMaxDuration)

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_4 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - 0) / var_572_4

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= 0 + var_572_4 and arg_569_1.time_ < 0 + var_572_4 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play221041141 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 221041141
		arg_573_1.duration_ = 17.13

		local var_573_0 = {
			ja = 17.133,
			ko = 11.633,
			zh = 11.633
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play221041142(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 1.1

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_1 = arg_573_1:GetWordFromCfg(221041141)
				local var_576_2 = arg_573_1:FormatText(var_576_1.content)

				arg_573_1.text_.text = var_576_2

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_4 = 44 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_2) / 44)

				if (44 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_2) / 44)) > 0 and var_576_0 < var_576_4 then
					arg_573_1.talkMaxDuration = var_576_4

					if var_576_4 + 0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_4 + 0
					end
				end

				arg_573_1.text_.text = var_576_2
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041141", "story_v_out_221041.awb") ~= 0 then
					local var_576_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041141", "story_v_out_221041.awb") / 1000

					if var_576_5 + 0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_5 + 0
					end

					if var_576_1.prefab_name ~= "" and arg_573_1.actors_[var_576_1.prefab_name] ~= nil then
						local var_576_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_1.prefab_name].transform, "story_v_out_221041", "221041141", "story_v_out_221041.awb")

						arg_573_1:RecordAudio("221041141", var_576_6)
						arg_573_1:RecordAudio("221041141", var_576_6)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_out_221041", "221041141", "story_v_out_221041.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_out_221041", "221041141", "story_v_out_221041.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_7 = math.max(var_576_0, arg_573_1.talkMaxDuration)

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_7 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - 0) / var_576_7

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= 0 + var_576_7 and arg_573_1.time_ < 0 + var_576_7 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play221041142 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 221041142
		arg_577_1.duration_ = 9.7

		local var_577_0 = {
			ja = 9.7,
			ko = 5.2,
			zh = 5.2
		}
		local var_577_1 = manager.audio:GetLocalizationFlag()

		if var_577_0[var_577_1] ~= nil then
			arg_577_1.duration_ = var_577_0[var_577_1]
		end

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play221041143(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = 0.6

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_1 = arg_577_1:GetWordFromCfg(221041142)
				local var_580_2 = arg_577_1:FormatText(var_580_1.content)

				arg_577_1.text_.text = var_580_2

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_4 = 24 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_2) / 24)

				if (24 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_2) / 24)) > 0 and var_580_0 < var_580_4 then
					arg_577_1.talkMaxDuration = var_580_4

					if var_580_4 + 0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_4 + 0
					end
				end

				arg_577_1.text_.text = var_580_2
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041142", "story_v_out_221041.awb") ~= 0 then
					local var_580_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041142", "story_v_out_221041.awb") / 1000

					if var_580_5 + 0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_5 + 0
					end

					if var_580_1.prefab_name ~= "" and arg_577_1.actors_[var_580_1.prefab_name] ~= nil then
						local var_580_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_1.prefab_name].transform, "story_v_out_221041", "221041142", "story_v_out_221041.awb")

						arg_577_1:RecordAudio("221041142", var_580_6)
						arg_577_1:RecordAudio("221041142", var_580_6)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_out_221041", "221041142", "story_v_out_221041.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_out_221041", "221041142", "story_v_out_221041.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_7 = math.max(var_580_0, arg_577_1.talkMaxDuration)

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_7 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - 0) / var_580_7

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= 0 + var_580_7 and arg_577_1.time_ < 0 + var_580_7 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play221041143 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 221041143
		arg_581_1.duration_ = 7.4

		local var_581_0 = {
			ja = 7.4,
			ko = 5.033,
			zh = 5.033
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play221041144(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0.475

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_1 = arg_581_1:GetWordFromCfg(221041143)
				local var_584_2 = arg_581_1:FormatText(var_584_1.content)

				arg_581_1.text_.text = var_584_2

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_4 = 19 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_2) / 19)

				if (19 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_2) / 19)) > 0 and var_584_0 < var_584_4 then
					arg_581_1.talkMaxDuration = var_584_4

					if var_584_4 + 0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_4 + 0
					end
				end

				arg_581_1.text_.text = var_584_2
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041143", "story_v_out_221041.awb") ~= 0 then
					local var_584_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041143", "story_v_out_221041.awb") / 1000

					if var_584_5 + 0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_5 + 0
					end

					if var_584_1.prefab_name ~= "" and arg_581_1.actors_[var_584_1.prefab_name] ~= nil then
						local var_584_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_1.prefab_name].transform, "story_v_out_221041", "221041143", "story_v_out_221041.awb")

						arg_581_1:RecordAudio("221041143", var_584_6)
						arg_581_1:RecordAudio("221041143", var_584_6)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_221041", "221041143", "story_v_out_221041.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_221041", "221041143", "story_v_out_221041.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_7 = math.max(var_584_0, arg_581_1.talkMaxDuration)

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_7 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - 0) / var_584_7

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= 0 + var_584_7 and arg_581_1.time_ < 0 + var_584_7 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play221041144 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 221041144
		arg_585_1.duration_ = 5.77

		local var_585_0 = {
			ja = 5.766,
			ko = 4.333,
			zh = 4.333
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play221041145(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0.475

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_1 = arg_585_1:GetWordFromCfg(221041144)
				local var_588_2 = arg_585_1:FormatText(var_588_1.content)

				arg_585_1.text_.text = var_588_2

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_4 = 19 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_2) / 19)

				if (19 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_2) / 19)) > 0 and var_588_0 < var_588_4 then
					arg_585_1.talkMaxDuration = var_588_4

					if var_588_4 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_4 + 0
					end
				end

				arg_585_1.text_.text = var_588_2
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041144", "story_v_out_221041.awb") ~= 0 then
					local var_588_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041144", "story_v_out_221041.awb") / 1000

					if var_588_5 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_5 + 0
					end

					if var_588_1.prefab_name ~= "" and arg_585_1.actors_[var_588_1.prefab_name] ~= nil then
						local var_588_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_1.prefab_name].transform, "story_v_out_221041", "221041144", "story_v_out_221041.awb")

						arg_585_1:RecordAudio("221041144", var_588_6)
						arg_585_1:RecordAudio("221041144", var_588_6)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_221041", "221041144", "story_v_out_221041.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_221041", "221041144", "story_v_out_221041.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_7 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_7 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_7

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_7 and arg_585_1.time_ < 0 + var_588_7 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play221041145 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 221041145
		arg_589_1.duration_ = 7.5

		local var_589_0 = {
			ja = 7.5,
			ko = 4.1,
			zh = 4.1
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play221041146(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0.525

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_1 = arg_589_1:GetWordFromCfg(221041145)
				local var_592_2 = arg_589_1:FormatText(var_592_1.content)

				arg_589_1.text_.text = var_592_2

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_4 = 21 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_2) / 21)

				if (21 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_2) / 21)) > 0 and var_592_0 < var_592_4 then
					arg_589_1.talkMaxDuration = var_592_4

					if var_592_4 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_4 + 0
					end
				end

				arg_589_1.text_.text = var_592_2
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041145", "story_v_out_221041.awb") ~= 0 then
					local var_592_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041145", "story_v_out_221041.awb") / 1000

					if var_592_5 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_5 + 0
					end

					if var_592_1.prefab_name ~= "" and arg_589_1.actors_[var_592_1.prefab_name] ~= nil then
						local var_592_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_1.prefab_name].transform, "story_v_out_221041", "221041145", "story_v_out_221041.awb")

						arg_589_1:RecordAudio("221041145", var_592_6)
						arg_589_1:RecordAudio("221041145", var_592_6)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_221041", "221041145", "story_v_out_221041.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_221041", "221041145", "story_v_out_221041.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_7 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_7 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_7

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_7 and arg_589_1.time_ < 0 + var_592_7 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play221041146 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 221041146
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play221041147(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0.75

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, false)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_1 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(221041146).content)

				arg_593_1.text_.text = var_596_1

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_3 = 30 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 30)

				if (30 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 30)) > 0 and var_596_0 < var_596_3 then
					arg_593_1.talkMaxDuration = var_596_3

					if var_596_3 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_3 + 0
					end
				end

				arg_593_1.text_.text = var_596_1
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_4 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_4 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_4

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_4 and arg_593_1.time_ < 0 + var_596_4 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play221041147 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 221041147
		arg_597_1.duration_ = 11.37

		local var_597_0 = {
			ja = 11.366,
			ko = 5.833,
			zh = 5.833
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play221041148(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0.775

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_1 = arg_597_1:GetWordFromCfg(221041147)
				local var_600_2 = arg_597_1:FormatText(var_600_1.content)

				arg_597_1.text_.text = var_600_2

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_4 = 31 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_2) / 31)

				if (31 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_2) / 31)) > 0 and var_600_0 < var_600_4 then
					arg_597_1.talkMaxDuration = var_600_4

					if var_600_4 + 0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_4 + 0
					end
				end

				arg_597_1.text_.text = var_600_2
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041147", "story_v_out_221041.awb") ~= 0 then
					local var_600_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041147", "story_v_out_221041.awb") / 1000

					if var_600_5 + 0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_5 + 0
					end

					if var_600_1.prefab_name ~= "" and arg_597_1.actors_[var_600_1.prefab_name] ~= nil then
						local var_600_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_1.prefab_name].transform, "story_v_out_221041", "221041147", "story_v_out_221041.awb")

						arg_597_1:RecordAudio("221041147", var_600_6)
						arg_597_1:RecordAudio("221041147", var_600_6)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_221041", "221041147", "story_v_out_221041.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_221041", "221041147", "story_v_out_221041.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_7 = math.max(var_600_0, arg_597_1.talkMaxDuration)

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_7 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - 0) / var_600_7

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= 0 + var_600_7 and arg_597_1.time_ < 0 + var_600_7 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play221041148 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 221041148
		arg_601_1.duration_ = 4.8

		local var_601_0 = {
			ja = 4.266,
			ko = 4.8,
			zh = 4.8
		}
		local var_601_1 = manager.audio:GetLocalizationFlag()

		if var_601_0[var_601_1] ~= nil then
			arg_601_1.duration_ = var_601_0[var_601_1]
		end

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play221041149(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0.375

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_1 = arg_601_1:GetWordFromCfg(221041148)
				local var_604_2 = arg_601_1:FormatText(var_604_1.content)

				arg_601_1.text_.text = var_604_2

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_4 = 15 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_2) / 15)

				if (15 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_2) / 15)) > 0 and var_604_0 < var_604_4 then
					arg_601_1.talkMaxDuration = var_604_4

					if var_604_4 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_4 + 0
					end
				end

				arg_601_1.text_.text = var_604_2
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041148", "story_v_out_221041.awb") ~= 0 then
					local var_604_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041148", "story_v_out_221041.awb") / 1000

					if var_604_5 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_5 + 0
					end

					if var_604_1.prefab_name ~= "" and arg_601_1.actors_[var_604_1.prefab_name] ~= nil then
						local var_604_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_1.prefab_name].transform, "story_v_out_221041", "221041148", "story_v_out_221041.awb")

						arg_601_1:RecordAudio("221041148", var_604_6)
						arg_601_1:RecordAudio("221041148", var_604_6)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_out_221041", "221041148", "story_v_out_221041.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_out_221041", "221041148", "story_v_out_221041.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_7 = math.max(var_604_0, arg_601_1.talkMaxDuration)

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_7 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - 0) / var_604_7

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= 0 + var_604_7 and arg_601_1.time_ < 0 + var_604_7 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play221041149 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 221041149
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play221041150(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0.5

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, false)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_1 = arg_605_1:FormatText(arg_605_1:GetWordFromCfg(221041149).content)

				arg_605_1.text_.text = var_608_1

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_3 = 20 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 20)

				if (20 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 20)) > 0 and var_608_0 < var_608_3 then
					arg_605_1.talkMaxDuration = var_608_3

					if var_608_3 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_3 + 0
					end
				end

				arg_605_1.text_.text = var_608_1
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_4 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_4 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_4

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_4 and arg_605_1.time_ < 0 + var_608_4 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play221041150 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 221041150
		arg_609_1.duration_ = 9.97

		local var_609_0 = {
			ja = 9.966,
			ko = 7.166,
			zh = 7.166
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play221041151(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 2 < arg_609_1.time_ and arg_609_1.time_ <= 2 + arg_612_0 then
				local var_612_0 = arg_609_1.bgs_.ST40

				arg_609_1.bgs_.ST40.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_612_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_612_1 = var_612_0:GetComponent("SpriteRenderer")

				if var_612_1 and var_612_1.sprite then
					local var_612_2 = 2 * (var_612_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_612_0.transform.localScale = Vector3.New(var_612_2 / var_612_1.sprite.bounds.size.y < var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x and var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x or var_612_2 / var_612_1.sprite.bounds.size.y, var_612_2 / var_612_1.sprite.bounds.size.y < var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x and var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x or var_612_2 / var_612_1.sprite.bounds.size.y, 0)
				end

				for iter_612_0, iter_612_1 in pairs(arg_609_1.bgs_) do
					if iter_612_0 ~= "ST40" then
						iter_612_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_612_3 = 0

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_3 + arg_612_0 then
				arg_609_1.mask_.enabled = true
				arg_609_1.mask_.raycastTarget = true

				arg_609_1:SetGaussion(false)
			end

			local var_612_4 = 2

			if var_612_3 <= arg_609_1.time_ and arg_609_1.time_ < var_612_3 + var_612_4 then
				local var_612_5 = Color.New(0, 0, 0)

				var_612_5.a = Mathf.Lerp(0, 1, (arg_609_1.time_ - var_612_3) / var_612_4)
				arg_609_1.mask_.color = var_612_5
			end

			if arg_609_1.time_ >= var_612_3 + var_612_4 and arg_609_1.time_ < var_612_3 + var_612_4 + arg_612_0 then
				local var_612_6 = Color.New(0, 0, 0)

				var_612_6.a = 1
				arg_609_1.mask_.color = var_612_6
			end

			local var_612_7 = 2

			if 2 < arg_609_1.time_ and arg_609_1.time_ <= var_612_7 + arg_612_0 then
				arg_609_1.mask_.enabled = true
				arg_609_1.mask_.raycastTarget = true

				arg_609_1:SetGaussion(false)
			end

			local var_612_8 = 2

			if var_612_7 <= arg_609_1.time_ and arg_609_1.time_ < var_612_7 + var_612_8 then
				local var_612_9 = Color.New(0, 0, 0)

				var_612_9.a = Mathf.Lerp(1, 0, (arg_609_1.time_ - var_612_7) / var_612_8)
				arg_609_1.mask_.color = var_612_9
			end

			if arg_609_1.time_ >= var_612_7 + var_612_8 and arg_609_1.time_ < var_612_7 + var_612_8 + arg_612_0 then
				local var_612_10 = Color.New(0, 0, 0)

				arg_609_1.mask_.enabled = false
				var_612_10.a = 0
				arg_609_1.mask_.color = var_612_10
			end

			local var_612_11 = arg_609_1.actors_["1076ui_story"].transform

			if 4 < arg_609_1.time_ and arg_609_1.time_ <= 4 + arg_612_0 then
				arg_609_1.var_.moveOldPos1076ui_story = var_612_11.localPosition
			end

			local var_612_12 = 0.001

			if 4 <= arg_609_1.time_ and arg_609_1.time_ < 4 + var_612_12 then
				var_612_11.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_609_1.time_ - 4) / var_612_12)
				var_612_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_612_11.position).x, (manager.ui.mainCamera.transform.position - var_612_11.position).y, (manager.ui.mainCamera.transform.position - var_612_11.position).z)
				var_612_11.localEulerAngles.z = 0
				var_612_11.localEulerAngles.x = 0
				var_612_11.localEulerAngles = var_612_11.localEulerAngles
			end

			if arg_609_1.time_ >= 4 + var_612_12 and arg_609_1.time_ < 4 + var_612_12 + arg_612_0 then
				var_612_11.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_612_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_612_11.position).x, (manager.ui.mainCamera.transform.position - var_612_11.position).y, (manager.ui.mainCamera.transform.position - var_612_11.position).z)
				var_612_11.localEulerAngles.z = 0
				var_612_11.localEulerAngles.x = 0
				var_612_11.localEulerAngles = var_612_11.localEulerAngles
			end

			if 4 < arg_609_1.time_ and arg_609_1.time_ <= 4 + arg_612_0 then
				arg_609_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_612_13 = arg_609_1.actors_["1076ui_story"]

			if 4 < arg_609_1.time_ and arg_609_1.time_ <= 4 + arg_612_0 and not isNil(var_612_13) and arg_609_1.var_.characterEffect1076ui_story == nil then
				arg_609_1.var_.characterEffect1076ui_story = var_612_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_14 = 0.2

			if 4 <= arg_609_1.time_ and arg_609_1.time_ < 4 + var_612_14 and not isNil(var_612_13) then
				if arg_609_1.var_.characterEffect1076ui_story and not isNil(var_612_13) then
					arg_609_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_609_1.time_ >= 4 + var_612_14 and arg_609_1.time_ < 4 + var_612_14 + arg_612_0 and not isNil(var_612_13) and arg_609_1.var_.characterEffect1076ui_story then
				arg_609_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 4 < arg_609_1.time_ and arg_609_1.time_ <= 4 + arg_612_0 then
				arg_609_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_609_1.frameCnt_ <= 1 then
				arg_609_1.dialog_:SetActive(false)
			end

			local var_612_16 = 4
			local var_612_17 = 0.375

			if 4 < arg_609_1.time_ and arg_609_1.time_ <= var_612_16 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0

				arg_609_1.dialog_:SetActive(true)

				arg_609_1.dialogCg_.alpha = 0

				local var_612_18 = LeanTween.value(arg_609_1.dialog_, 0, 1, 0.3)

				var_612_18:setOnUpdate(LuaHelper.FloatAction(function(arg_613_0)
					arg_609_1.dialogCg_.alpha = arg_613_0
				end))
				var_612_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_609_1.dialog_)
					var_612_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_609_1.duration_ = arg_609_1.duration_ + 0.3

				SetActive(arg_609_1.leftNameGo_, true)

				arg_609_1.leftNameTxt_.text = arg_609_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_19 = arg_609_1:GetWordFromCfg(221041150)
				local var_612_20 = arg_609_1:FormatText(var_612_19.content)

				arg_609_1.text_.text = var_612_20

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_22 = 15 <= 0 and var_612_17 or var_612_17 * (utf8.len(var_612_20) / 15)

				if (15 <= 0 and var_612_17 or var_612_17 * (utf8.len(var_612_20) / 15)) > 0 and var_612_17 < var_612_22 then
					arg_609_1.talkMaxDuration = var_612_22
					var_612_16 = var_612_16 + 0.3

					if var_612_22 + var_612_16 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_22 + var_612_16
					end
				end

				arg_609_1.text_.text = var_612_20
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041150", "story_v_out_221041.awb") ~= 0 then
					local var_612_23 = manager.audio:GetVoiceLength("story_v_out_221041", "221041150", "story_v_out_221041.awb") / 1000

					if var_612_23 + var_612_16 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_23 + var_612_16
					end

					if var_612_19.prefab_name ~= "" and arg_609_1.actors_[var_612_19.prefab_name] ~= nil then
						local var_612_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_19.prefab_name].transform, "story_v_out_221041", "221041150", "story_v_out_221041.awb")

						arg_609_1:RecordAudio("221041150", var_612_24)
						arg_609_1:RecordAudio("221041150", var_612_24)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_out_221041", "221041150", "story_v_out_221041.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_out_221041", "221041150", "story_v_out_221041.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_25 = var_612_16 + 0.3
			local var_612_26 = math.max(var_612_17, arg_609_1.talkMaxDuration)

			if var_612_16 + 0.3 <= arg_609_1.time_ and arg_609_1.time_ < var_612_25 + var_612_26 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_25) / var_612_26

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_25 + var_612_26 and arg_609_1.time_ < var_612_25 + var_612_26 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_609_1:InitPlayNodeList()
	end,
	Play221041151 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 221041151
		arg_615_1.duration_ = 7.17

		local var_615_0 = {
			ja = 6.066,
			ko = 7.166,
			zh = 7.166
		}
		local var_615_1 = manager.audio:GetLocalizationFlag()

		if var_615_0[var_615_1] ~= nil then
			arg_615_1.duration_ = var_615_0[var_615_1]
		end

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play221041152(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 and not isNil(arg_615_1.actors_["1076ui_story"]) and arg_615_1.var_.characterEffect1076ui_story == nil then
				arg_615_1.var_.characterEffect1076ui_story = arg_615_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_0 = 0.2

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_0 and not isNil(arg_615_1.actors_["1076ui_story"]) then
				if arg_615_1.var_.characterEffect1076ui_story and not isNil(arg_615_1.actors_["1076ui_story"]) then
					arg_615_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_615_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_615_1.time_ - 0) / var_618_0)
				end
			end

			if arg_615_1.time_ >= 0 + var_618_0 and arg_615_1.time_ < 0 + var_618_0 + arg_618_0 and not isNil(arg_615_1.actors_["1076ui_story"]) and arg_615_1.var_.characterEffect1076ui_story then
				arg_615_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_615_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_618_1 = arg_615_1.actors_["1072ui_story"].transform

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.var_.moveOldPos1072ui_story = var_618_1.localPosition
			end

			local var_618_2 = 0.001

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_2 then
				var_618_1.localPosition = Vector3.Lerp(arg_615_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_615_1.time_ - 0) / var_618_2)
				var_618_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_618_1.position).x, (manager.ui.mainCamera.transform.position - var_618_1.position).y, (manager.ui.mainCamera.transform.position - var_618_1.position).z)
				var_618_1.localEulerAngles.z = 0
				var_618_1.localEulerAngles.x = 0
				var_618_1.localEulerAngles = var_618_1.localEulerAngles
			end

			if arg_615_1.time_ >= 0 + var_618_2 and arg_615_1.time_ < 0 + var_618_2 + arg_618_0 then
				var_618_1.localPosition = Vector3.New(0.7, -0.71, -6)
				var_618_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_618_1.position).x, (manager.ui.mainCamera.transform.position - var_618_1.position).y, (manager.ui.mainCamera.transform.position - var_618_1.position).z)
				var_618_1.localEulerAngles.z = 0
				var_618_1.localEulerAngles.x = 0
				var_618_1.localEulerAngles = var_618_1.localEulerAngles
			end

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			local var_618_3 = arg_615_1.actors_["1072ui_story"]

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 and not isNil(var_618_3) and arg_615_1.var_.characterEffect1072ui_story == nil then
				arg_615_1.var_.characterEffect1072ui_story = var_618_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_4 = 0.2

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_4 and not isNil(var_618_3) then
				if arg_615_1.var_.characterEffect1072ui_story and not isNil(var_618_3) then
					arg_615_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_615_1.time_ >= 0 + var_618_4 and arg_615_1.time_ < 0 + var_618_4 + arg_618_0 and not isNil(var_618_3) and arg_615_1.var_.characterEffect1072ui_story then
				arg_615_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_618_6 = 0
			local var_618_7 = 0.575

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_6 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_8 = arg_615_1:GetWordFromCfg(221041151)
				local var_618_9 = arg_615_1:FormatText(var_618_8.content)

				arg_615_1.text_.text = var_618_9

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_11 = 23 <= 0 and var_618_7 or var_618_7 * (utf8.len(var_618_9) / 23)

				if (23 <= 0 and var_618_7 or var_618_7 * (utf8.len(var_618_9) / 23)) > 0 and var_618_7 < var_618_11 then
					arg_615_1.talkMaxDuration = var_618_11

					if var_618_11 + var_618_6 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_11 + var_618_6
					end
				end

				arg_615_1.text_.text = var_618_9
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041151", "story_v_out_221041.awb") ~= 0 then
					local var_618_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041151", "story_v_out_221041.awb") / 1000

					if var_618_12 + var_618_6 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_12 + var_618_6
					end

					if var_618_8.prefab_name ~= "" and arg_615_1.actors_[var_618_8.prefab_name] ~= nil then
						local var_618_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_8.prefab_name].transform, "story_v_out_221041", "221041151", "story_v_out_221041.awb")

						arg_615_1:RecordAudio("221041151", var_618_13)
						arg_615_1:RecordAudio("221041151", var_618_13)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_out_221041", "221041151", "story_v_out_221041.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_out_221041", "221041151", "story_v_out_221041.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_14 = math.max(var_618_7, arg_615_1.talkMaxDuration)

			if var_618_6 <= arg_615_1.time_ and arg_615_1.time_ < var_618_6 + var_618_14 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_6) / var_618_14

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_6 + var_618_14 and arg_615_1.time_ < var_618_6 + var_618_14 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_615_1:InitPlayNodeList()
	end,
	Play221041152 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 221041152
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play221041153(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.var_.moveOldPos1076ui_story = arg_619_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_622_0 = 0.001

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_0 then
				arg_619_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_619_1.time_ - 0) / var_622_0)
				arg_619_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1076ui_story"].transform.position).z)
				arg_619_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["1076ui_story"].transform.localEulerAngles = arg_619_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_619_1.time_ >= 0 + var_622_0 and arg_619_1.time_ < 0 + var_622_0 + arg_622_0 then
				arg_619_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_619_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1076ui_story"].transform.position).z)
				arg_619_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["1076ui_story"].transform.localEulerAngles = arg_619_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_622_1 = arg_619_1.actors_["1072ui_story"].transform

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.var_.moveOldPos1072ui_story = var_622_1.localPosition
			end

			local var_622_2 = 0.001

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_2 then
				var_622_1.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_619_1.time_ - 0) / var_622_2)
				var_622_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_622_1.position).x, (manager.ui.mainCamera.transform.position - var_622_1.position).y, (manager.ui.mainCamera.transform.position - var_622_1.position).z)
				var_622_1.localEulerAngles.z = 0
				var_622_1.localEulerAngles.x = 0
				var_622_1.localEulerAngles = var_622_1.localEulerAngles
			end

			if arg_619_1.time_ >= 0 + var_622_2 and arg_619_1.time_ < 0 + var_622_2 + arg_622_0 then
				var_622_1.localPosition = Vector3.New(0, 100, 0)
				var_622_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_622_1.position).x, (manager.ui.mainCamera.transform.position - var_622_1.position).y, (manager.ui.mainCamera.transform.position - var_622_1.position).z)
				var_622_1.localEulerAngles.z = 0
				var_622_1.localEulerAngles.x = 0
				var_622_1.localEulerAngles = var_622_1.localEulerAngles
			end

			local var_622_3 = 0
			local var_622_4 = 0.6

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_3 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_5 = arg_619_1:FormatText(arg_619_1:GetWordFromCfg(221041152).content)

				arg_619_1.text_.text = var_622_5

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_7 = 24 <= 0 and var_622_4 or var_622_4 * (utf8.len(var_622_5) / 24)

				if (24 <= 0 and var_622_4 or var_622_4 * (utf8.len(var_622_5) / 24)) > 0 and var_622_4 < var_622_7 then
					arg_619_1.talkMaxDuration = var_622_7

					if var_622_7 + var_622_3 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_7 + var_622_3
					end
				end

				arg_619_1.text_.text = var_622_5
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_8 = math.max(var_622_4, arg_619_1.talkMaxDuration)

			if var_622_3 <= arg_619_1.time_ and arg_619_1.time_ < var_622_3 + var_622_8 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_3) / var_622_8

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_3 + var_622_8 and arg_619_1.time_ < var_622_3 + var_622_8 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play221041153 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 221041153
		arg_623_1.duration_ = 4.17

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play221041154(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.var_.moveOldPos1072ui_story = arg_623_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_626_0 = 0.001

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 then
				arg_623_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_623_1.time_ - 0) / var_626_0)
				arg_623_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_623_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1072ui_story"].transform.position).z)
				arg_623_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_623_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_623_1.actors_["1072ui_story"].transform.localEulerAngles = arg_623_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 then
				arg_623_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_623_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_623_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1072ui_story"].transform.position).z)
				arg_623_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_623_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_623_1.actors_["1072ui_story"].transform.localEulerAngles = arg_623_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			local var_626_1 = arg_623_1.actors_["1072ui_story"]

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(var_626_1) and arg_623_1.var_.characterEffect1072ui_story == nil then
				arg_623_1.var_.characterEffect1072ui_story = var_626_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_2 = 0.2

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_2 and not isNil(var_626_1) then
				if arg_623_1.var_.characterEffect1072ui_story and not isNil(var_626_1) then
					arg_623_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= 0 + var_626_2 and arg_623_1.time_ < 0 + var_626_2 + arg_626_0 and not isNil(var_626_1) and arg_623_1.var_.characterEffect1072ui_story then
				arg_623_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_626_4 = 0
			local var_626_5 = 0.475

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_4 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_6 = arg_623_1:GetWordFromCfg(221041153)
				local var_626_7 = arg_623_1:FormatText(var_626_6.content)

				arg_623_1.text_.text = var_626_7

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_9 = 19 <= 0 and var_626_5 or var_626_5 * (utf8.len(var_626_7) / 19)

				if (19 <= 0 and var_626_5 or var_626_5 * (utf8.len(var_626_7) / 19)) > 0 and var_626_5 < var_626_9 then
					arg_623_1.talkMaxDuration = var_626_9

					if var_626_9 + var_626_4 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_9 + var_626_4
					end
				end

				arg_623_1.text_.text = var_626_7
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041153", "story_v_out_221041.awb") ~= 0 then
					local var_626_10 = manager.audio:GetVoiceLength("story_v_out_221041", "221041153", "story_v_out_221041.awb") / 1000

					if var_626_10 + var_626_4 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_10 + var_626_4
					end

					if var_626_6.prefab_name ~= "" and arg_623_1.actors_[var_626_6.prefab_name] ~= nil then
						local var_626_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_6.prefab_name].transform, "story_v_out_221041", "221041153", "story_v_out_221041.awb")

						arg_623_1:RecordAudio("221041153", var_626_11)
						arg_623_1:RecordAudio("221041153", var_626_11)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_out_221041", "221041153", "story_v_out_221041.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_out_221041", "221041153", "story_v_out_221041.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_12 = math.max(var_626_5, arg_623_1.talkMaxDuration)

			if var_626_4 <= arg_623_1.time_ and arg_623_1.time_ < var_626_4 + var_626_12 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_4) / var_626_12

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_4 + var_626_12 and arg_623_1.time_ < var_626_4 + var_626_12 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_623_1:InitPlayNodeList()
	end,
	Play221041154 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 221041154
		arg_627_1.duration_ = 2.23

		local var_627_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_627_1 = manager.audio:GetLocalizationFlag()

		if var_627_0[var_627_1] ~= nil then
			arg_627_1.duration_ = var_627_0[var_627_1]
		end

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play221041155(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["1072ui_story"]) and arg_627_1.var_.characterEffect1072ui_story == nil then
				arg_627_1.var_.characterEffect1072ui_story = arg_627_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_0 = 0.2

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["1072ui_story"]) then
				if arg_627_1.var_.characterEffect1072ui_story and not isNil(arg_627_1.actors_["1072ui_story"]) then
					arg_627_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_627_1.time_ - 0) / var_630_0)
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["1072ui_story"]) and arg_627_1.var_.characterEffect1072ui_story then
				arg_627_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_630_1 = arg_627_1.actors_["1076ui_story"].transform

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.var_.moveOldPos1076ui_story = var_630_1.localPosition
			end

			local var_630_2 = 0.001

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_2 then
				var_630_1.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_627_1.time_ - 0) / var_630_2)
				var_630_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_630_1.position).x, (manager.ui.mainCamera.transform.position - var_630_1.position).y, (manager.ui.mainCamera.transform.position - var_630_1.position).z)
				var_630_1.localEulerAngles.z = 0
				var_630_1.localEulerAngles.x = 0
				var_630_1.localEulerAngles = var_630_1.localEulerAngles
			end

			if arg_627_1.time_ >= 0 + var_630_2 and arg_627_1.time_ < 0 + var_630_2 + arg_630_0 then
				var_630_1.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_630_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_630_1.position).x, (manager.ui.mainCamera.transform.position - var_630_1.position).y, (manager.ui.mainCamera.transform.position - var_630_1.position).z)
				var_630_1.localEulerAngles.z = 0
				var_630_1.localEulerAngles.x = 0
				var_630_1.localEulerAngles = var_630_1.localEulerAngles
			end

			local var_630_3 = arg_627_1.actors_["1076ui_story"]

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(var_630_3) and arg_627_1.var_.characterEffect1076ui_story == nil then
				arg_627_1.var_.characterEffect1076ui_story = var_630_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_4 = 0.2

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_4 and not isNil(var_630_3) then
				if arg_627_1.var_.characterEffect1076ui_story and not isNil(var_630_3) then
					arg_627_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_627_1.time_ >= 0 + var_630_4 and arg_627_1.time_ < 0 + var_630_4 + arg_630_0 and not isNil(var_630_3) and arg_627_1.var_.characterEffect1076ui_story then
				arg_627_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_630_6 = 0
			local var_630_7 = 0.1

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_6 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_8 = arg_627_1:GetWordFromCfg(221041154)
				local var_630_9 = arg_627_1:FormatText(var_630_8.content)

				arg_627_1.text_.text = var_630_9

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_11 = 4 <= 0 and var_630_7 or var_630_7 * (utf8.len(var_630_9) / 4)

				if (4 <= 0 and var_630_7 or var_630_7 * (utf8.len(var_630_9) / 4)) > 0 and var_630_7 < var_630_11 then
					arg_627_1.talkMaxDuration = var_630_11

					if var_630_11 + var_630_6 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_11 + var_630_6
					end
				end

				arg_627_1.text_.text = var_630_9
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041154", "story_v_out_221041.awb") ~= 0 then
					local var_630_12 = manager.audio:GetVoiceLength("story_v_out_221041", "221041154", "story_v_out_221041.awb") / 1000

					if var_630_12 + var_630_6 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_12 + var_630_6
					end

					if var_630_8.prefab_name ~= "" and arg_627_1.actors_[var_630_8.prefab_name] ~= nil then
						local var_630_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_8.prefab_name].transform, "story_v_out_221041", "221041154", "story_v_out_221041.awb")

						arg_627_1:RecordAudio("221041154", var_630_13)
						arg_627_1:RecordAudio("221041154", var_630_13)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_out_221041", "221041154", "story_v_out_221041.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_out_221041", "221041154", "story_v_out_221041.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_14 = math.max(var_630_7, arg_627_1.talkMaxDuration)

			if var_630_6 <= arg_627_1.time_ and arg_627_1.time_ < var_630_6 + var_630_14 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_6) / var_630_14

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_6 + var_630_14 and arg_627_1.time_ < var_630_6 + var_630_14 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_627_1:InitPlayNodeList()
	end,
	Play221041155 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 221041155
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play221041156(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.var_.moveOldPos1076ui_story = arg_631_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_634_0 = 0.001

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 then
				arg_631_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_631_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_631_1.time_ - 0) / var_634_0)
				arg_631_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_631_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_631_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_631_1.actors_["1076ui_story"].transform.position).z)
				arg_631_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_631_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_631_1.actors_["1076ui_story"].transform.localEulerAngles = arg_631_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 then
				arg_631_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_631_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_631_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_631_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_631_1.actors_["1076ui_story"].transform.position).z)
				arg_631_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_631_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_631_1.actors_["1076ui_story"].transform.localEulerAngles = arg_631_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_634_1 = arg_631_1.actors_["1072ui_story"].transform

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.var_.moveOldPos1072ui_story = var_634_1.localPosition
			end

			local var_634_2 = 0.001

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_2 then
				var_634_1.localPosition = Vector3.Lerp(arg_631_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_631_1.time_ - 0) / var_634_2)
				var_634_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_634_1.position).x, (manager.ui.mainCamera.transform.position - var_634_1.position).y, (manager.ui.mainCamera.transform.position - var_634_1.position).z)
				var_634_1.localEulerAngles.z = 0
				var_634_1.localEulerAngles.x = 0
				var_634_1.localEulerAngles = var_634_1.localEulerAngles
			end

			if arg_631_1.time_ >= 0 + var_634_2 and arg_631_1.time_ < 0 + var_634_2 + arg_634_0 then
				var_634_1.localPosition = Vector3.New(0, 100, 0)
				var_634_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_634_1.position).x, (manager.ui.mainCamera.transform.position - var_634_1.position).y, (manager.ui.mainCamera.transform.position - var_634_1.position).z)
				var_634_1.localEulerAngles.z = 0
				var_634_1.localEulerAngles.x = 0
				var_634_1.localEulerAngles = var_634_1.localEulerAngles
			end

			local var_634_3 = 0
			local var_634_4 = 0.875

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_3 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, false)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_5 = arg_631_1:FormatText(arg_631_1:GetWordFromCfg(221041155).content)

				arg_631_1.text_.text = var_634_5

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_7 = 35 <= 0 and var_634_4 or var_634_4 * (utf8.len(var_634_5) / 35)

				if (35 <= 0 and var_634_4 or var_634_4 * (utf8.len(var_634_5) / 35)) > 0 and var_634_4 < var_634_7 then
					arg_631_1.talkMaxDuration = var_634_7

					if var_634_7 + var_634_3 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_7 + var_634_3
					end
				end

				arg_631_1.text_.text = var_634_5
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_8 = math.max(var_634_4, arg_631_1.talkMaxDuration)

			if var_634_3 <= arg_631_1.time_ and arg_631_1.time_ < var_634_3 + var_634_8 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_3) / var_634_8

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_3 + var_634_8 and arg_631_1.time_ < var_634_3 + var_634_8 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_631_1:InitPlayNodeList()
	end,
	Play221041156 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 221041156
		arg_635_1.duration_ = 9.63

		local var_635_0 = {
			ja = 7.6,
			ko = 9.633,
			zh = 9.633
		}
		local var_635_1 = manager.audio:GetLocalizationFlag()

		if var_635_0[var_635_1] ~= nil then
			arg_635_1.duration_ = var_635_0[var_635_1]
		end

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play221041157(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.var_.moveOldPos1076ui_story = arg_635_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_638_0 = 0.001

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 then
				arg_635_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_635_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_635_1.time_ - 0) / var_638_0)
				arg_635_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_635_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1076ui_story"].transform.position).z)
				arg_635_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_635_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_635_1.actors_["1076ui_story"].transform.localEulerAngles = arg_635_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 then
				arg_635_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_635_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_635_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1076ui_story"].transform.position).z)
				arg_635_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_635_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_635_1.actors_["1076ui_story"].transform.localEulerAngles = arg_635_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_638_1 = arg_635_1.actors_["1072ui_story"].transform

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.var_.moveOldPos1072ui_story = var_638_1.localPosition
			end

			local var_638_2 = 0.001

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_2 then
				var_638_1.localPosition = Vector3.Lerp(arg_635_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_635_1.time_ - 0) / var_638_2)
				var_638_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_638_1.position).x, (manager.ui.mainCamera.transform.position - var_638_1.position).y, (manager.ui.mainCamera.transform.position - var_638_1.position).z)
				var_638_1.localEulerAngles.z = 0
				var_638_1.localEulerAngles.x = 0
				var_638_1.localEulerAngles = var_638_1.localEulerAngles
			end

			if arg_635_1.time_ >= 0 + var_638_2 and arg_635_1.time_ < 0 + var_638_2 + arg_638_0 then
				var_638_1.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_638_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_638_1.position).x, (manager.ui.mainCamera.transform.position - var_638_1.position).y, (manager.ui.mainCamera.transform.position - var_638_1.position).z)
				var_638_1.localEulerAngles.z = 0
				var_638_1.localEulerAngles.x = 0
				var_638_1.localEulerAngles = var_638_1.localEulerAngles
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_638_3 = arg_635_1.actors_["1072ui_story"]

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(var_638_3) and arg_635_1.var_.characterEffect1072ui_story == nil then
				arg_635_1.var_.characterEffect1072ui_story = var_638_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_4 = 0.2

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_4 and not isNil(var_638_3) then
				if arg_635_1.var_.characterEffect1072ui_story and not isNil(var_638_3) then
					arg_635_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_635_1.time_ >= 0 + var_638_4 and arg_635_1.time_ < 0 + var_638_4 + arg_638_0 and not isNil(var_638_3) and arg_635_1.var_.characterEffect1072ui_story then
				arg_635_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_638_6 = arg_635_1.actors_["1076ui_story"]

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(var_638_6) and arg_635_1.var_.characterEffect1076ui_story == nil then
				arg_635_1.var_.characterEffect1076ui_story = var_638_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_7 = 0.0166666666666667

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_7 and not isNil(var_638_6) then
				if arg_635_1.var_.characterEffect1076ui_story and not isNil(var_638_6) then
					arg_635_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_635_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_635_1.time_ - 0) / var_638_7)
				end
			end

			if arg_635_1.time_ >= 0 + var_638_7 and arg_635_1.time_ < 0 + var_638_7 + arg_638_0 and not isNil(var_638_6) and arg_635_1.var_.characterEffect1076ui_story then
				arg_635_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_635_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_638_8 = 0
			local var_638_9 = 1.075

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_8 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_10 = arg_635_1:GetWordFromCfg(221041156)
				local var_638_11 = arg_635_1:FormatText(var_638_10.content)

				arg_635_1.text_.text = var_638_11

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_13 = 43 <= 0 and var_638_9 or var_638_9 * (utf8.len(var_638_11) / 43)

				if (43 <= 0 and var_638_9 or var_638_9 * (utf8.len(var_638_11) / 43)) > 0 and var_638_9 < var_638_13 then
					arg_635_1.talkMaxDuration = var_638_13

					if var_638_13 + var_638_8 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_13 + var_638_8
					end
				end

				arg_635_1.text_.text = var_638_11
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041156", "story_v_out_221041.awb") ~= 0 then
					local var_638_14 = manager.audio:GetVoiceLength("story_v_out_221041", "221041156", "story_v_out_221041.awb") / 1000

					if var_638_14 + var_638_8 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_14 + var_638_8
					end

					if var_638_10.prefab_name ~= "" and arg_635_1.actors_[var_638_10.prefab_name] ~= nil then
						local var_638_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_10.prefab_name].transform, "story_v_out_221041", "221041156", "story_v_out_221041.awb")

						arg_635_1:RecordAudio("221041156", var_638_15)
						arg_635_1:RecordAudio("221041156", var_638_15)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_out_221041", "221041156", "story_v_out_221041.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_out_221041", "221041156", "story_v_out_221041.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_16 = math.max(var_638_9, arg_635_1.talkMaxDuration)

			if var_638_8 <= arg_635_1.time_ and arg_635_1.time_ < var_638_8 + var_638_16 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_8) / var_638_16

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_8 + var_638_16 and arg_635_1.time_ < var_638_8 + var_638_16 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_635_1:InitPlayNodeList()
	end,
	Play221041157 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 221041157
		arg_639_1.duration_ = 10.03

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play221041158(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_642_0 = 0
			local var_642_1 = 1.1

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_2 = arg_639_1:GetWordFromCfg(221041157)
				local var_642_3 = arg_639_1:FormatText(var_642_2.content)

				arg_639_1.text_.text = var_642_3

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_5 = 45 <= 0 and var_642_1 or var_642_1 * (utf8.len(var_642_3) / 45)

				if (45 <= 0 and var_642_1 or var_642_1 * (utf8.len(var_642_3) / 45)) > 0 and var_642_1 < var_642_5 then
					arg_639_1.talkMaxDuration = var_642_5

					if var_642_5 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_5 + var_642_0
					end
				end

				arg_639_1.text_.text = var_642_3
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041157", "story_v_out_221041.awb") ~= 0 then
					local var_642_6 = manager.audio:GetVoiceLength("story_v_out_221041", "221041157", "story_v_out_221041.awb") / 1000

					if var_642_6 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_6 + var_642_0
					end

					if var_642_2.prefab_name ~= "" and arg_639_1.actors_[var_642_2.prefab_name] ~= nil then
						local var_642_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_2.prefab_name].transform, "story_v_out_221041", "221041157", "story_v_out_221041.awb")

						arg_639_1:RecordAudio("221041157", var_642_7)
						arg_639_1:RecordAudio("221041157", var_642_7)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_out_221041", "221041157", "story_v_out_221041.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_out_221041", "221041157", "story_v_out_221041.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_8 = math.max(var_642_1, arg_639_1.talkMaxDuration)

			if var_642_0 <= arg_639_1.time_ and arg_639_1.time_ < var_642_0 + var_642_8 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_0) / var_642_8

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_0 + var_642_8 and arg_639_1.time_ < var_642_0 + var_642_8 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play221041158 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 221041158
		arg_643_1.duration_ = 11.97

		local var_643_0 = {
			ja = 11.966,
			ko = 6.2,
			zh = 6.2
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play221041159(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_646_0 = 0
			local var_646_1 = 0.7

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_2 = arg_643_1:GetWordFromCfg(221041158)
				local var_646_3 = arg_643_1:FormatText(var_646_2.content)

				arg_643_1.text_.text = var_646_3

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_5 = 28 <= 0 and var_646_1 or var_646_1 * (utf8.len(var_646_3) / 28)

				if (28 <= 0 and var_646_1 or var_646_1 * (utf8.len(var_646_3) / 28)) > 0 and var_646_1 < var_646_5 then
					arg_643_1.talkMaxDuration = var_646_5

					if var_646_5 + var_646_0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_5 + var_646_0
					end
				end

				arg_643_1.text_.text = var_646_3
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041158", "story_v_out_221041.awb") ~= 0 then
					local var_646_6 = manager.audio:GetVoiceLength("story_v_out_221041", "221041158", "story_v_out_221041.awb") / 1000

					if var_646_6 + var_646_0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_6 + var_646_0
					end

					if var_646_2.prefab_name ~= "" and arg_643_1.actors_[var_646_2.prefab_name] ~= nil then
						local var_646_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_2.prefab_name].transform, "story_v_out_221041", "221041158", "story_v_out_221041.awb")

						arg_643_1:RecordAudio("221041158", var_646_7)
						arg_643_1:RecordAudio("221041158", var_646_7)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_out_221041", "221041158", "story_v_out_221041.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_out_221041", "221041158", "story_v_out_221041.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_8 = math.max(var_646_1, arg_643_1.talkMaxDuration)

			if var_646_0 <= arg_643_1.time_ and arg_643_1.time_ < var_646_0 + var_646_8 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_0) / var_646_8

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_0 + var_646_8 and arg_643_1.time_ < var_646_0 + var_646_8 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play221041159 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 221041159
		arg_647_1.duration_ = 5.23

		local var_647_0 = {
			ja = 5.233,
			ko = 3.966,
			zh = 3.966
		}
		local var_647_1 = manager.audio:GetLocalizationFlag()

		if var_647_0[var_647_1] ~= nil then
			arg_647_1.duration_ = var_647_0[var_647_1]
		end

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play221041160(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_650_0 = 0
			local var_650_1 = 0.35

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_2 = arg_647_1:GetWordFromCfg(221041159)
				local var_650_3 = arg_647_1:FormatText(var_650_2.content)

				arg_647_1.text_.text = var_650_3

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_5 = 14 <= 0 and var_650_1 or var_650_1 * (utf8.len(var_650_3) / 14)

				if (14 <= 0 and var_650_1 or var_650_1 * (utf8.len(var_650_3) / 14)) > 0 and var_650_1 < var_650_5 then
					arg_647_1.talkMaxDuration = var_650_5

					if var_650_5 + var_650_0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_5 + var_650_0
					end
				end

				arg_647_1.text_.text = var_650_3
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041159", "story_v_out_221041.awb") ~= 0 then
					local var_650_6 = manager.audio:GetVoiceLength("story_v_out_221041", "221041159", "story_v_out_221041.awb") / 1000

					if var_650_6 + var_650_0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_6 + var_650_0
					end

					if var_650_2.prefab_name ~= "" and arg_647_1.actors_[var_650_2.prefab_name] ~= nil then
						local var_650_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_2.prefab_name].transform, "story_v_out_221041", "221041159", "story_v_out_221041.awb")

						arg_647_1:RecordAudio("221041159", var_650_7)
						arg_647_1:RecordAudio("221041159", var_650_7)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_out_221041", "221041159", "story_v_out_221041.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_out_221041", "221041159", "story_v_out_221041.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_8 = math.max(var_650_1, arg_647_1.talkMaxDuration)

			if var_650_0 <= arg_647_1.time_ and arg_647_1.time_ < var_650_0 + var_650_8 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_0) / var_650_8

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_0 + var_650_8 and arg_647_1.time_ < var_650_0 + var_650_8 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play221041160 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 221041160
		arg_651_1.duration_ = 9.1

		local var_651_0 = {
			ja = 9.1,
			ko = 4.6,
			zh = 4.6
		}
		local var_651_1 = manager.audio:GetLocalizationFlag()

		if var_651_0[var_651_1] ~= nil then
			arg_651_1.duration_ = var_651_0[var_651_1]
		end

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
			arg_651_1.auto_ = false
		end

		function arg_651_1.playNext_(arg_653_0)
			arg_651_1.onStoryFinished_()
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 0.625

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_1 = arg_651_1:GetWordFromCfg(221041160)
				local var_654_2 = arg_651_1:FormatText(var_654_1.content)

				arg_651_1.text_.text = var_654_2

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_4 = 22 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_2) / 22)

				if (22 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_2) / 22)) > 0 and var_654_0 < var_654_4 then
					arg_651_1.talkMaxDuration = var_654_4

					if var_654_4 + 0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_4 + 0
					end
				end

				arg_651_1.text_.text = var_654_2
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_221041", "221041160", "story_v_out_221041.awb") ~= 0 then
					local var_654_5 = manager.audio:GetVoiceLength("story_v_out_221041", "221041160", "story_v_out_221041.awb") / 1000

					if var_654_5 + 0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_5 + 0
					end

					if var_654_1.prefab_name ~= "" and arg_651_1.actors_[var_654_1.prefab_name] ~= nil then
						local var_654_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_1.prefab_name].transform, "story_v_out_221041", "221041160", "story_v_out_221041.awb")

						arg_651_1:RecordAudio("221041160", var_654_6)
						arg_651_1:RecordAudio("221041160", var_654_6)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_out_221041", "221041160", "story_v_out_221041.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_out_221041", "221041160", "story_v_out_221041.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_7 = math.max(var_654_0, arg_651_1.talkMaxDuration)

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_7 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - 0) / var_654_7

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= 0 + var_654_7 and arg_651_1.time_ < 0 + var_654_7 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST45",
		"TextureConfig/Background/ST40",
		"TextureConfig/Background/XH0402a"
	},
	voices = {
		"story_v_out_221041.awb"
	}
}
