return {
	Play319951001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319951001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319951002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11i")
				var_4_0.name = "I11i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11i

				arg_1_1.bgs_.I11i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11i" then
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

			if 0.233333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.233333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

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

			local var_4_14 = 1.999999999999
			local var_4_15 = 0.875

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319951001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 35 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 35)

				if (35 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 35)) > 0 and var_4_15 < var_4_19 then
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
	Play319951002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319951002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319951003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.275

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(319951002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 51 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 51)

				if (51 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 51)) > 0 and var_12_0 < var_12_3 then
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
	Play319951003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319951003
		arg_13_1.duration_ = 3.3

		local var_13_0 = {
			zh = 2.333,
			ja = 3.3
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
				arg_13_0:Play319951004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "4040ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["4040ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["4040ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["4040ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["4040ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["4040ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos4040ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["4040ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect4040ui_story == nil then
				arg_13_1.var_.characterEffect4040ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect4040ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect4040ui_story then
				arg_13_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.15

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(319951003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 6 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 6)

				if (6 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 6)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951003", "story_v_out_319951.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_319951", "319951003", "story_v_out_319951.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_319951", "319951003", "story_v_out_319951.awb")

						arg_13_1:RecordAudio("319951003", var_16_15)
						arg_13_1:RecordAudio("319951003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319951", "319951003", "story_v_out_319951.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319951", "319951003", "story_v_out_319951.awb")
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
				actorName = "4040ui_story",
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
	Play319951004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319951004
		arg_17_1.duration_ = 4.57

		local var_17_0 = {
			zh = 1.733,
			ja = 4.566
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
				arg_17_0:Play319951005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1095ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1095ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1095ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1095ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1095ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1095ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1095ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1095ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_8 = arg_17_1.actors_["4040ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos4040ui_story = var_20_8.localPosition
			end

			local var_20_9 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_17_1.time_ - 0) / var_20_9)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			local var_20_10 = arg_17_1.actors_["4040ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect4040ui_story == nil then
				arg_17_1.var_.characterEffect4040ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_11 and not isNil(var_20_10) then
				if arg_17_1.var_.characterEffect4040ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_17_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_11)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_11 and arg_17_1.time_ < 0 + var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect4040ui_story then
				arg_17_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_17_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_20_12 = 0
			local var_20_13 = 0.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(319951004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 9 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 9)

				if (9 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 9)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951004", "story_v_out_319951.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_319951", "319951004", "story_v_out_319951.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_319951", "319951004", "story_v_out_319951.awb")

						arg_17_1:RecordAudio("319951004", var_20_19)
						arg_17_1:RecordAudio("319951004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319951", "319951004", "story_v_out_319951.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319951", "319951004", "story_v_out_319951.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_20 and arg_17_1.time_ < var_20_12 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319951005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319951005
		arg_21_1.duration_ = 4.53

		local var_21_0 = {
			zh = 4.533,
			ja = 2.9
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
				arg_21_0:Play319951006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = arg_21_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) then
				if arg_21_1.var_.characterEffect1095ui_story and not isNil(arg_21_1.actors_["1095ui_story"]) then
					arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) and arg_21_1.var_.characterEffect1095ui_story then
				arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_24_1 = arg_21_1.actors_["4040ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect4040ui_story == nil then
				arg_21_1.var_.characterEffect4040ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect4040ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect4040ui_story then
				arg_21_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 0.525

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(319951005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 21 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 21)

				if (21 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 21)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951005", "story_v_out_319951.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_319951", "319951005", "story_v_out_319951.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_319951", "319951005", "story_v_out_319951.awb")

						arg_21_1:RecordAudio("319951005", var_24_11)
						arg_21_1:RecordAudio("319951005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319951", "319951005", "story_v_out_319951.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319951", "319951005", "story_v_out_319951.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319951006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319951006
		arg_25_1.duration_ = 4

		local var_25_0 = {
			zh = 2.4,
			ja = 4
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
				arg_25_0:Play319951007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.325

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(319951006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 13 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 13)

				if (13 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 13)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951006", "story_v_out_319951.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_319951", "319951006", "story_v_out_319951.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_319951", "319951006", "story_v_out_319951.awb")

						arg_25_1:RecordAudio("319951006", var_28_6)
						arg_25_1:RecordAudio("319951006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319951", "319951006", "story_v_out_319951.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319951", "319951006", "story_v_out_319951.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319951007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319951007
		arg_29_1.duration_ = 2.13

		local var_29_0 = {
			zh = 1.999999999999,
			ja = 2.133
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
				arg_29_0:Play319951008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "10079ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["10079ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["10079ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["10079ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["10079ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["10079ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10079ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["10079ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10079ui_story == nil then
				arg_29_1.var_.characterEffect10079ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect10079ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10079ui_story then
				arg_29_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_8 = arg_29_1.actors_["1095ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1095ui_story = var_32_8.localPosition
			end

			local var_32_9 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 then
				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_9)
				var_32_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_8.position).x, (manager.ui.mainCamera.transform.position - var_32_8.position).y, (manager.ui.mainCamera.transform.position - var_32_8.position).z)
				var_32_8.localEulerAngles.z = 0
				var_32_8.localEulerAngles.x = 0
				var_32_8.localEulerAngles = var_32_8.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(0, 100, 0)
				var_32_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_8.position).x, (manager.ui.mainCamera.transform.position - var_32_8.position).y, (manager.ui.mainCamera.transform.position - var_32_8.position).z)
				var_32_8.localEulerAngles.z = 0
				var_32_8.localEulerAngles.x = 0
				var_32_8.localEulerAngles = var_32_8.localEulerAngles
			end

			local var_32_10 = arg_29_1.actors_["1095ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect1095ui_story == nil then
				arg_29_1.var_.characterEffect1095ui_story = var_32_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_11 and not isNil(var_32_10) then
				if arg_29_1.var_.characterEffect1095ui_story and not isNil(var_32_10) then
					arg_29_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_11)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_11 and arg_29_1.time_ < 0 + var_32_11 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect1095ui_story then
				arg_29_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_32_12 = arg_29_1.actors_["4040ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos4040ui_story = var_32_12.localPosition
			end

			local var_32_13 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_13 then
				var_32_12.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_13)
				var_32_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_12.position).x, (manager.ui.mainCamera.transform.position - var_32_12.position).y, (manager.ui.mainCamera.transform.position - var_32_12.position).z)
				var_32_12.localEulerAngles.z = 0
				var_32_12.localEulerAngles.x = 0
				var_32_12.localEulerAngles = var_32_12.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_13 and arg_29_1.time_ < 0 + var_32_13 + arg_32_0 then
				var_32_12.localPosition = Vector3.New(0, 100, 0)
				var_32_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_12.position).x, (manager.ui.mainCamera.transform.position - var_32_12.position).y, (manager.ui.mainCamera.transform.position - var_32_12.position).z)
				var_32_12.localEulerAngles.z = 0
				var_32_12.localEulerAngles.x = 0
				var_32_12.localEulerAngles = var_32_12.localEulerAngles
			end

			local var_32_14 = arg_29_1.actors_["4040ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect4040ui_story == nil then
				arg_29_1.var_.characterEffect4040ui_story = var_32_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_15 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_15 and not isNil(var_32_14) then
				if arg_29_1.var_.characterEffect4040ui_story and not isNil(var_32_14) then
					arg_29_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_29_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_15)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_15 and arg_29_1.time_ < 0 + var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect4040ui_story then
				arg_29_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_29_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_32_16 = 0
			local var_32_17 = 0.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(319951007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 7 <= 0 and var_32_17 or var_32_17 * (utf8.len(var_32_19) / 7)

				if (7 <= 0 and var_32_17 or var_32_17 * (utf8.len(var_32_19) / 7)) > 0 and var_32_17 < var_32_21 then
					arg_29_1.talkMaxDuration = var_32_21

					if var_32_21 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_21 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951007", "story_v_out_319951.awb") ~= 0 then
					local var_32_22 = manager.audio:GetVoiceLength("story_v_out_319951", "319951007", "story_v_out_319951.awb") / 1000

					if var_32_22 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_16
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_319951", "319951007", "story_v_out_319951.awb")

						arg_29_1:RecordAudio("319951007", var_32_23)
						arg_29_1:RecordAudio("319951007", var_32_23)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319951", "319951007", "story_v_out_319951.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319951", "319951007", "story_v_out_319951.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_24 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_24 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_24

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_24 and arg_29_1.time_ < var_32_16 + var_32_24 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319951008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319951008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319951009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10079ui_story"]) and arg_33_1.var_.characterEffect10079ui_story == nil then
				arg_33_1.var_.characterEffect10079ui_story = arg_33_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10079ui_story"]) then
				if arg_33_1.var_.characterEffect10079ui_story and not isNil(arg_33_1.actors_["10079ui_story"]) then
					arg_33_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10079ui_story"]) and arg_33_1.var_.characterEffect10079ui_story then
				arg_33_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.875

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(319951008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 35 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 35)

				if (35 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 35)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319951009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319951009
		arg_37_1.duration_ = 5.5

		local var_37_0 = {
			zh = 3.866,
			ja = 5.5
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play319951010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos4040ui_story = arg_37_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).z)
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles = arg_37_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_37_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["4040ui_story"].transform.position).z)
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["4040ui_story"].transform.localEulerAngles = arg_37_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["4040ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect4040ui_story == nil then
				arg_37_1.var_.characterEffect4040ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect4040ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect4040ui_story then
				arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_4 = arg_37_1.actors_["10079ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10079ui_story = var_40_4.localPosition
			end

			local var_40_5 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 then
				var_40_4.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_5)
				var_40_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_4.position).x, (manager.ui.mainCamera.transform.position - var_40_4.position).y, (manager.ui.mainCamera.transform.position - var_40_4.position).z)
				var_40_4.localEulerAngles.z = 0
				var_40_4.localEulerAngles.x = 0
				var_40_4.localEulerAngles = var_40_4.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 then
				var_40_4.localPosition = Vector3.New(0, 100, 0)
				var_40_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_4.position).x, (manager.ui.mainCamera.transform.position - var_40_4.position).y, (manager.ui.mainCamera.transform.position - var_40_4.position).z)
				var_40_4.localEulerAngles.z = 0
				var_40_4.localEulerAngles.x = 0
				var_40_4.localEulerAngles = var_40_4.localEulerAngles
			end

			local var_40_6 = arg_37_1.actors_["10079ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect10079ui_story == nil then
				arg_37_1.var_.characterEffect10079ui_story = var_40_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_7 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 and not isNil(var_40_6) then
				if arg_37_1.var_.characterEffect10079ui_story and not isNil(var_40_6) then
					arg_37_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_7)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect10079ui_story then
				arg_37_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_40_8 = 0
			local var_40_9 = 0.275

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(319951009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 11 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 11)

				if (11 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 11)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951009", "story_v_out_319951.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_319951", "319951009", "story_v_out_319951.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_319951", "319951009", "story_v_out_319951.awb")

						arg_37_1:RecordAudio("319951009", var_40_15)
						arg_37_1:RecordAudio("319951009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319951", "319951009", "story_v_out_319951.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319951", "319951009", "story_v_out_319951.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319951010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319951010
		arg_41_1.duration_ = 6.43

		local var_41_0 = {
			zh = 4.633,
			ja = 6.433
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
				arg_41_0:Play319951011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1095ui_story = arg_41_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).z)
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles = arg_41_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_41_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1095ui_story"].transform.position).z)
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1095ui_story"].transform.localEulerAngles = arg_41_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1095ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1095ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = arg_41_1.actors_["4040ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos4040ui_story = var_44_4.localPosition
			end

			local var_44_5 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 then
				var_44_4.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_41_1.time_ - 0) / var_44_5)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 then
				var_44_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			local var_44_6 = arg_41_1.actors_["4040ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect4040ui_story == nil then
				arg_41_1.var_.characterEffect4040ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_7 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 and not isNil(var_44_6) then
				if arg_41_1.var_.characterEffect4040ui_story and not isNil(var_44_6) then
					arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_41_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_7)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect4040ui_story then
				arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_41_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_44_8 = 0
			local var_44_9 = 0.625

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(319951010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 25 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 25)

				if (25 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 25)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951010", "story_v_out_319951.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_319951", "319951010", "story_v_out_319951.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_319951", "319951010", "story_v_out_319951.awb")

						arg_41_1:RecordAudio("319951010", var_44_15)
						arg_41_1:RecordAudio("319951010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319951", "319951010", "story_v_out_319951.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319951", "319951010", "story_v_out_319951.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319951011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319951011
		arg_45_1.duration_ = 4.9

		local var_45_0 = {
			zh = 4.9,
			ja = 3.9
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play319951012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1095ui_story"]) and arg_45_1.var_.characterEffect1095ui_story == nil then
				arg_45_1.var_.characterEffect1095ui_story = arg_45_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1095ui_story"]) then
				if arg_45_1.var_.characterEffect1095ui_story and not isNil(arg_45_1.actors_["1095ui_story"]) then
					arg_45_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1095ui_story"]) and arg_45_1.var_.characterEffect1095ui_story then
				arg_45_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_48_1 = arg_45_1.actors_["4040ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect4040ui_story == nil then
				arg_45_1.var_.characterEffect4040ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect4040ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect4040ui_story then
				arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_48_4 = 0
			local var_48_5 = 0.45

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(319951011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 18 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 18)

				if (18 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 18)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951011", "story_v_out_319951.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_319951", "319951011", "story_v_out_319951.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_319951", "319951011", "story_v_out_319951.awb")

						arg_45_1:RecordAudio("319951011", var_48_11)
						arg_45_1:RecordAudio("319951011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319951", "319951011", "story_v_out_319951.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319951", "319951011", "story_v_out_319951.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319951012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319951012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play319951013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1095ui_story = arg_49_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1095ui_story"].transform.position).z)
				arg_49_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1095ui_story"].transform.localEulerAngles = arg_49_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1095ui_story"].transform.position).z)
				arg_49_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1095ui_story"].transform.localEulerAngles = arg_49_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1095ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1095ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_2)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1095ui_story then
				arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_52_3 = arg_49_1.actors_["4040ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos4040ui_story = var_52_3.localPosition
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_4)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(0, 100, 0)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			local var_52_5 = arg_49_1.actors_["4040ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect4040ui_story == nil then
				arg_49_1.var_.characterEffect4040ui_story = var_52_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.characterEffect4040ui_story and not isNil(var_52_5) then
					arg_49_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_49_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_6)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect4040ui_story then
				arg_49_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_49_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_52_7 = 0
			local var_52_8 = 1.175

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(319951012).content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 47 <= 0 and var_52_8 or var_52_8 * (utf8.len(var_52_9) / 47)

				if (47 <= 0 and var_52_8 or var_52_8 * (utf8.len(var_52_9) / 47)) > 0 and var_52_8 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_7
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_8, arg_49_1.talkMaxDuration)

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_7) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_7 + var_52_12 and arg_49_1.time_ < var_52_7 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play319951013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319951013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play319951014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.25

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(319951013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 50 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 50)

				if (50 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 50)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319951014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319951014
		arg_57_1.duration_ = 4.8

		local var_57_0 = {
			zh = 2.366,
			ja = 4.8
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
				arg_57_0:Play319951015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10079ui_story = arg_57_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).z)
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles = arg_57_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_57_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10079ui_story"].transform.position).z)
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10079ui_story"].transform.localEulerAngles = arg_57_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["10079ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10079ui_story == nil then
				arg_57_1.var_.characterEffect10079ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect10079ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10079ui_story then
				arg_57_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.275

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(319951014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 11 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 11)

				if (11 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 11)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951014", "story_v_out_319951.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_319951", "319951014", "story_v_out_319951.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_319951", "319951014", "story_v_out_319951.awb")

						arg_57_1:RecordAudio("319951014", var_60_11)
						arg_57_1:RecordAudio("319951014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319951", "319951014", "story_v_out_319951.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319951", "319951014", "story_v_out_319951.awb")
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
				actorName = "10079ui_story",
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
	Play319951015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319951015
		arg_61_1.duration_ = 12.4

		local var_61_0 = {
			zh = 7.966,
			ja = 12.4
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
				arg_61_0:Play319951016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10079ui_story"]) and arg_61_1.var_.characterEffect10079ui_story == nil then
				arg_61_1.var_.characterEffect10079ui_story = arg_61_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10079ui_story"]) then
				if arg_61_1.var_.characterEffect10079ui_story and not isNil(arg_61_1.actors_["10079ui_story"]) then
					arg_61_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10079ui_story"]) and arg_61_1.var_.characterEffect10079ui_story then
				arg_61_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.725

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[699].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(319951015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 29 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 29)

				if (29 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 29)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951015", "story_v_out_319951.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_319951", "319951015", "story_v_out_319951.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_319951", "319951015", "story_v_out_319951.awb")

						arg_61_1:RecordAudio("319951015", var_64_8)
						arg_61_1:RecordAudio("319951015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319951", "319951015", "story_v_out_319951.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319951", "319951015", "story_v_out_319951.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play319951016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319951016
		arg_65_1.duration_ = 8.8

		local var_65_0 = {
			zh = 4.266,
			ja = 8.8
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
				arg_65_0:Play319951017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10079ui_story"]) and arg_65_1.var_.characterEffect10079ui_story == nil then
				arg_65_1.var_.characterEffect10079ui_story = arg_65_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10079ui_story"]) then
				if arg_65_1.var_.characterEffect10079ui_story and not isNil(arg_65_1.actors_["10079ui_story"]) then
					arg_65_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10079ui_story"]) and arg_65_1.var_.characterEffect10079ui_story then
				arg_65_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_68_2 = 0
			local var_68_3 = 0.375

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(319951016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 15 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 15)

				if (15 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 15)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951016", "story_v_out_319951.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_319951", "319951016", "story_v_out_319951.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_319951", "319951016", "story_v_out_319951.awb")

						arg_65_1:RecordAudio("319951016", var_68_9)
						arg_65_1:RecordAudio("319951016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319951", "319951016", "story_v_out_319951.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319951", "319951016", "story_v_out_319951.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319951017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319951017
		arg_69_1.duration_ = 19.37

		local var_69_0 = {
			zh = 5.466,
			ja = 19.366
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
				arg_69_0:Play319951018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10079ui_story"]) and arg_69_1.var_.characterEffect10079ui_story == nil then
				arg_69_1.var_.characterEffect10079ui_story = arg_69_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10079ui_story"]) then
				if arg_69_1.var_.characterEffect10079ui_story and not isNil(arg_69_1.actors_["10079ui_story"]) then
					arg_69_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10079ui_story"]) and arg_69_1.var_.characterEffect10079ui_story then
				arg_69_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.6

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[699].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(319951017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 24 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 24)

				if (24 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 24)) > 0 and var_72_2 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951017", "story_v_out_319951.awb") ~= 0 then
					local var_72_7 = manager.audio:GetVoiceLength("story_v_out_319951", "319951017", "story_v_out_319951.awb") / 1000

					if var_72_7 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_1
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_319951", "319951017", "story_v_out_319951.awb")

						arg_69_1:RecordAudio("319951017", var_72_8)
						arg_69_1:RecordAudio("319951017", var_72_8)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319951", "319951017", "story_v_out_319951.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319951", "319951017", "story_v_out_319951.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_9 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_9

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_9 and arg_69_1.time_ < var_72_1 + var_72_9 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319951018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319951018
		arg_73_1.duration_ = 15

		local var_73_0 = {
			zh = 8.8,
			ja = 15
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
				arg_73_0:Play319951019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.975

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[699].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(319951018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 39 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 39)

				if (39 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 39)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951018", "story_v_out_319951.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_319951", "319951018", "story_v_out_319951.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_319951", "319951018", "story_v_out_319951.awb")

						arg_73_1:RecordAudio("319951018", var_76_6)
						arg_73_1:RecordAudio("319951018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319951", "319951018", "story_v_out_319951.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319951", "319951018", "story_v_out_319951.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319951019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319951019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play319951020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_80_0 = 0
			local var_80_1 = 1.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(319951019).content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 44 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_2) / 44)

				if (44 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_2) / 44)) > 0 and var_80_1 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_5 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_5 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_5

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_5 and arg_77_1.time_ < var_80_0 + var_80_5 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319951020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319951020
		arg_81_1.duration_ = 10.5

		local var_81_0 = {
			zh = 6.566,
			ja = 10.5
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
				arg_81_0:Play319951021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10079ui_story = arg_81_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10079ui_story"].transform.position).z)
				arg_81_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10079ui_story"].transform.localEulerAngles = arg_81_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_81_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10079ui_story"].transform.position).z)
				arg_81_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10079ui_story"].transform.localEulerAngles = arg_81_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["10079ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10079ui_story == nil then
				arg_81_1.var_.characterEffect10079ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect10079ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10079ui_story then
				arg_81_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_4 = 0
			local var_84_5 = 0.85

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(319951020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 34 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 34)

				if (34 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 34)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951020", "story_v_out_319951.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_319951", "319951020", "story_v_out_319951.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_319951", "319951020", "story_v_out_319951.awb")

						arg_81_1:RecordAudio("319951020", var_84_11)
						arg_81_1:RecordAudio("319951020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319951", "319951020", "story_v_out_319951.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319951", "319951020", "story_v_out_319951.awb")
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
				actorName = "10079ui_story",
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
	Play319951021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319951021
		arg_85_1.duration_ = 6.6

		local var_85_0 = {
			zh = 5.066,
			ja = 6.6
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play319951022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10079ui_story"]) and arg_85_1.var_.characterEffect10079ui_story == nil then
				arg_85_1.var_.characterEffect10079ui_story = arg_85_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10079ui_story"]) then
				if arg_85_1.var_.characterEffect10079ui_story and not isNil(arg_85_1.actors_["10079ui_story"]) then
					arg_85_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10079ui_story"]) and arg_85_1.var_.characterEffect10079ui_story then
				arg_85_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.325

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[699].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(319951021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 13 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 13)

				if (13 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 13)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951021", "story_v_out_319951.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_319951", "319951021", "story_v_out_319951.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_319951", "319951021", "story_v_out_319951.awb")

						arg_85_1:RecordAudio("319951021", var_88_8)
						arg_85_1:RecordAudio("319951021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319951", "319951021", "story_v_out_319951.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319951", "319951021", "story_v_out_319951.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play319951022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319951022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319951023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10079ui_story = arg_89_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).z)
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles = arg_89_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10079ui_story"].transform.position).z)
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10079ui_story"].transform.localEulerAngles = arg_89_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_92_1 = 0
			local var_92_2 = 0.675

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

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(319951022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 27 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 27)

				if (27 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 27)) > 0 and var_92_2 < var_92_5 then
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play319951023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319951023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319951024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.1

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(319951023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 44 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 44)

				if (44 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 44)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319951024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319951024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319951025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.1

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

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(319951024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 44 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 44)

				if (44 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 44)) > 0 and var_100_0 < var_100_3 then
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
	Play319951025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319951025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play319951026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.55

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(319951025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 22 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 22)

				if (22 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 22)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play319951026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319951026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play319951027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.2

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(319951026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 48 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 48)

				if (48 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 48)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play319951027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319951027
		arg_109_1.duration_ = 4.73

		local var_109_0 = {
			zh = 2.2,
			ja = 4.733
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
				arg_109_0:Play319951028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10079ui_story = arg_109_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).z)
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles = arg_109_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_109_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).z)
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles = arg_109_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["10079ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10079ui_story == nil then
				arg_109_1.var_.characterEffect10079ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect10079ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10079ui_story then
				arg_109_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(319951027)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 14 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 14)

				if (14 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 14)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951027", "story_v_out_319951.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_319951", "319951027", "story_v_out_319951.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_319951", "319951027", "story_v_out_319951.awb")

						arg_109_1:RecordAudio("319951027", var_112_11)
						arg_109_1:RecordAudio("319951027", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319951", "319951027", "story_v_out_319951.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319951", "319951027", "story_v_out_319951.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319951028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319951028
		arg_113_1.duration_ = 7.6

		local var_113_0 = {
			zh = 7.6,
			ja = 3.366
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
				arg_113_0:Play319951029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1095ui_story = arg_113_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1095ui_story"].transform.position).z)
				arg_113_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1095ui_story"].transform.localEulerAngles = arg_113_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_113_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1095ui_story"].transform.position).z)
				arg_113_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1095ui_story"].transform.localEulerAngles = arg_113_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1095ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1095ui_story == nil then
				arg_113_1.var_.characterEffect1095ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1095ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1095ui_story then
				arg_113_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_4 = arg_113_1.actors_["10079ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10079ui_story = var_116_4.localPosition
			end

			local var_116_5 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 then
				var_116_4.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_113_1.time_ - 0) / var_116_5)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 then
				var_116_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			local var_116_6 = arg_113_1.actors_["10079ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect10079ui_story == nil then
				arg_113_1.var_.characterEffect10079ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_7 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 and not isNil(var_116_6) then
				if arg_113_1.var_.characterEffect10079ui_story and not isNil(var_116_6) then
					arg_113_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_7)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect10079ui_story then
				arg_113_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_116_8 = 0
			local var_116_9 = 0.775

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(319951028)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 31 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 31)

				if (31 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 31)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951028", "story_v_out_319951.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_319951", "319951028", "story_v_out_319951.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_319951", "319951028", "story_v_out_319951.awb")

						arg_113_1:RecordAudio("319951028", var_116_15)
						arg_113_1:RecordAudio("319951028", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319951", "319951028", "story_v_out_319951.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319951", "319951028", "story_v_out_319951.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319951029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319951029
		arg_117_1.duration_ = 2

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play319951030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10079ui_story = arg_117_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10079ui_story"].transform.position).z)
				arg_117_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10079ui_story"].transform.localEulerAngles = arg_117_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_117_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10079ui_story"].transform.position).z)
				arg_117_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10079ui_story"].transform.localEulerAngles = arg_117_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["10079ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10079ui_story == nil then
				arg_117_1.var_.characterEffect10079ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect10079ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10079ui_story then
				arg_117_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_4 = arg_117_1.actors_["1095ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1095ui_story == nil then
				arg_117_1.var_.characterEffect1095ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_5 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 and not isNil(var_120_4) then
				if arg_117_1.var_.characterEffect1095ui_story and not isNil(var_120_4) then
					arg_117_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_5)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1095ui_story then
				arg_117_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_120_6 = 0
			local var_120_7 = 0.1

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(319951029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 4 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 4)

				if (4 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 4)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951029", "story_v_out_319951.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_319951", "319951029", "story_v_out_319951.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_319951", "319951029", "story_v_out_319951.awb")

						arg_117_1:RecordAudio("319951029", var_120_13)
						arg_117_1:RecordAudio("319951029", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319951", "319951029", "story_v_out_319951.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319951", "319951029", "story_v_out_319951.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play319951030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319951030
		arg_121_1.duration_ = 3.27

		local var_121_0 = {
			zh = 2.5,
			ja = 3.266
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play319951031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10079ui_story"]) and arg_121_1.var_.characterEffect10079ui_story == nil then
				arg_121_1.var_.characterEffect10079ui_story = arg_121_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10079ui_story"]) then
				if arg_121_1.var_.characterEffect10079ui_story and not isNil(arg_121_1.actors_["10079ui_story"]) then
					arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10079ui_story"]) and arg_121_1.var_.characterEffect10079ui_story then
				arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_124_1 = arg_121_1.actors_["1095ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1095ui_story == nil then
				arg_121_1.var_.characterEffect1095ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1095ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1095ui_story then
				arg_121_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_124_4 = 0
			local var_124_5 = 0.25

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(319951030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 10 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 10)

				if (10 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 10)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951030", "story_v_out_319951.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_319951", "319951030", "story_v_out_319951.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_319951", "319951030", "story_v_out_319951.awb")

						arg_121_1:RecordAudio("319951030", var_124_11)
						arg_121_1:RecordAudio("319951030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319951", "319951030", "story_v_out_319951.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319951", "319951030", "story_v_out_319951.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play319951031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319951031
		arg_125_1.duration_ = 9.5

		local var_125_0 = {
			zh = 8.066,
			ja = 9.5
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
				arg_125_0:Play319951032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_128_0 = 0
			local var_128_1 = 0.95

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(319951031)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 38 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 38)

				if (38 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 38)) > 0 and var_128_1 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951031", "story_v_out_319951.awb") ~= 0 then
					local var_128_6 = manager.audio:GetVoiceLength("story_v_out_319951", "319951031", "story_v_out_319951.awb") / 1000

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end

					if var_128_2.prefab_name ~= "" and arg_125_1.actors_[var_128_2.prefab_name] ~= nil then
						local var_128_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_2.prefab_name].transform, "story_v_out_319951", "319951031", "story_v_out_319951.awb")

						arg_125_1:RecordAudio("319951031", var_128_7)
						arg_125_1:RecordAudio("319951031", var_128_7)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319951", "319951031", "story_v_out_319951.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319951", "319951031", "story_v_out_319951.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play319951032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319951032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319951033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1095ui_story = arg_129_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).z)
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles = arg_129_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1095ui_story"].transform.position).z)
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1095ui_story"].transform.localEulerAngles = arg_129_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["10079ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10079ui_story = var_132_1.localPosition
			end

			local var_132_2 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 then
				var_132_1.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_2)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 then
				var_132_1.localPosition = Vector3.New(0, 100, 0)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_132_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_5 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_5

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_5
						arg_129_1.bgmTxt2_.text = var_132_5
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_132_6 = 0
			local var_132_7 = 1.175

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(319951032).content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 47 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 47)

				if (47 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 47)) > 0 and var_132_7 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_11 and arg_129_1.time_ < var_132_6 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319951033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 319951033
		arg_134_1.duration_ = 1.17

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play319951034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if arg_134_1.bgs_.STblack == nil then
				local var_137_0 = Object.Instantiate(arg_134_1.paintGo_)

				var_137_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_137_0.name = "STblack"
				var_137_0.transform.parent = arg_134_1.stage_.transform
				var_137_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_134_1.bgs_.STblack = var_137_0
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				local var_137_1 = arg_134_1.bgs_.STblack

				arg_134_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_137_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_137_2 = var_137_1:GetComponent("SpriteRenderer")

				if var_137_2 and var_137_2.sprite then
					local var_137_3 = 2 * (var_137_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_137_1.transform.localScale = Vector3.New(var_137_3 / var_137_2.sprite.bounds.size.y < var_137_3 * manager.ui.mainCameraCom_.aspect / var_137_2.sprite.bounds.size.x and var_137_3 * manager.ui.mainCameraCom_.aspect / var_137_2.sprite.bounds.size.x or var_137_3 / var_137_2.sprite.bounds.size.y, var_137_3 / var_137_2.sprite.bounds.size.y < var_137_3 * manager.ui.mainCameraCom_.aspect / var_137_2.sprite.bounds.size.x and var_137_3 * manager.ui.mainCameraCom_.aspect / var_137_2.sprite.bounds.size.x or var_137_3 / var_137_2.sprite.bounds.size.y, 0)
				end

				for iter_137_0, iter_137_1 in pairs(arg_134_1.bgs_) do
					if iter_137_0 ~= "STblack" then
						iter_137_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.fswbg_:SetActive(true)
				arg_134_1.dialog_:SetActive(false)

				arg_134_1.fswtw_.percent = 0
				arg_134_1.fswt_.text = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(319951033).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.fswt_)

				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_134_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_134_1.fswtw_:SetDirty()

				arg_134_1.typewritterCharCountI18N = 0

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_4 = 0.0166666666666667

			if 0.0166666666666667 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.var_.oldValueTypewriter = arg_134_1.fswtw_.percent

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_5 = 2
			local var_137_6 = 0.133333333333333
			local var_137_7, var_137_8 = arg_134_1:GetPercentByPara(arg_134_1:FormatText(arg_134_1:GetWordFromCfg(319951033).content), 1)

			if var_137_4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0

				local var_137_9 = var_137_5 <= 0 and var_137_6 or var_137_6 * ((var_137_8 - arg_134_1.typewritterCharCountI18N) / var_137_5)

				if (var_137_5 <= 0 and var_137_6 or var_137_6 * ((var_137_8 - arg_134_1.typewritterCharCountI18N) / var_137_5)) > 0 and var_137_6 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end
			end

			local var_137_10 = math.max(0.133333333333333, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_10 then
				arg_134_1.fswtw_.percent = Mathf.Lerp(arg_134_1.var_.oldValueTypewriter, var_137_7, (arg_134_1.time_ - var_137_4) / var_137_10)
				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_134_1.fswtw_:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_10 and arg_134_1.time_ < var_137_4 + var_137_10 + arg_137_0 then
				arg_134_1.fswtw_.percent = var_137_7

				arg_134_1.fswtw_:SetDirty()
				arg_134_1:ShowNextGo(true)

				arg_134_1.typewritterCharCountI18N = var_137_8
			end

			local var_137_11 = 0.1

			if 0.1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_11 + arg_137_0 then
				arg_134_1.var_.oldValueTypewriter = arg_134_1.fswtw_.percent

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_12 = 0
			local var_137_13 = 0
			local var_137_14, var_137_15 = arg_134_1:GetPercentByPara(arg_134_1:FormatText(arg_134_1:GetWordFromCfg(319951033).content), 1)

			if var_137_11 < arg_134_1.time_ and arg_134_1.time_ <= var_137_11 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0

				local var_137_16 = var_137_12 <= 0 and var_137_13 or var_137_13 * ((var_137_15 - arg_134_1.typewritterCharCountI18N) / var_137_12)

				if (var_137_12 <= 0 and var_137_13 or var_137_13 * ((var_137_15 - arg_134_1.typewritterCharCountI18N) / var_137_12)) > 0 and var_137_13 < var_137_16 then
					arg_134_1.talkMaxDuration = var_137_16

					if var_137_16 + var_137_11 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_16 + var_137_11
					end
				end
			end

			local var_137_17 = math.max(0, arg_134_1.talkMaxDuration)

			if var_137_11 <= arg_134_1.time_ and arg_134_1.time_ < var_137_11 + var_137_17 then
				arg_134_1.fswtw_.percent = Mathf.Lerp(arg_134_1.var_.oldValueTypewriter, var_137_14, (arg_134_1.time_ - var_137_11) / var_137_17)
				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_134_1.fswtw_:SetDirty()
			end

			if arg_134_1.time_ >= var_137_11 + var_137_17 and arg_134_1.time_ < var_137_11 + var_137_17 + arg_137_0 then
				arg_134_1.fswtw_.percent = var_137_14

				arg_134_1.fswtw_:SetDirty()
				arg_134_1:ShowNextGo(true)

				arg_134_1.typewritterCharCountI18N = var_137_15
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.cswbg_:SetActive(true)

				local var_137_18 = arg_134_1.cswt_:GetComponent("RectTransform")

				arg_134_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_137_18.offsetMin = Vector2.New(410, 330)
				var_137_18.offsetMax = Vector2.New(-400, -180)
				arg_134_1.cswt_.text = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(419082).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.cswt_)

				arg_134_1.cswt_.fontSize = 172
				arg_134_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_134_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_134_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				local var_137_19 = arg_134_1.fswbg_.transform:Find("textbox/adapt/content") or arg_134_1.fswbg_.transform:Find("textbox/content")
				local var_137_20 = arg_134_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_137_21 = var_137_19:GetComponent("RectTransform")

				var_137_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_137_21.offsetMin = Vector2.New(0, 0)
				var_137_21.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play319951034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 319951034
		arg_138_1.duration_ = 1

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play319951035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.cswbg_:SetActive(true)

				local var_141_0 = arg_138_1.cswt_:GetComponent("RectTransform")

				arg_138_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_141_0.offsetMin = Vector2.New(410, 330)
				var_141_0.offsetMax = Vector2.New(-400, -175)
				arg_138_1.cswt_.text = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(419083).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.cswt_)

				arg_138_1.cswt_.fontSize = 180
				arg_138_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_138_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_138_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play319951035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 319951035
		arg_142_1.duration_ = 1

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play319951036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.cswbg_:SetActive(true)

				local var_145_0 = arg_142_1.cswt_:GetComponent("RectTransform")

				arg_142_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_145_0.offsetMin = Vector2.New(410, 330)
				var_145_0.offsetMax = Vector2.New(-400, -175)
				arg_142_1.cswt_.text = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(419084).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.cswt_)

				arg_142_1.cswt_.fontSize = 185
				arg_142_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_142_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_142_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play319951036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 319951036
		arg_146_1.duration_ = 1

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play319951037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.cswbg_:SetActive(true)

				local var_149_0 = arg_146_1.cswt_:GetComponent("RectTransform")

				arg_146_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_149_0.offsetMin = Vector2.New(410, 330)
				var_149_0.offsetMax = Vector2.New(-400, -175)
				arg_146_1.cswt_.text = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(419085).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.cswt_)

				arg_146_1.cswt_.fontSize = 188
				arg_146_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_146_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_146_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play319951037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 319951037
		arg_150_1.duration_ = 6.4

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play319951038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				local var_153_0 = arg_150_1.bgs_.I11i

				arg_150_1.bgs_.I11i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_153_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_153_1 = var_153_0:GetComponent("SpriteRenderer")

				if var_153_1 and var_153_1.sprite then
					local var_153_2 = 2 * (var_153_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_153_0.transform.localScale = Vector3.New(var_153_2 / var_153_1.sprite.bounds.size.y < var_153_2 * manager.ui.mainCameraCom_.aspect / var_153_1.sprite.bounds.size.x and var_153_2 * manager.ui.mainCameraCom_.aspect / var_153_1.sprite.bounds.size.x or var_153_2 / var_153_1.sprite.bounds.size.y, var_153_2 / var_153_1.sprite.bounds.size.y < var_153_2 * manager.ui.mainCameraCom_.aspect / var_153_1.sprite.bounds.size.x and var_153_2 * manager.ui.mainCameraCom_.aspect / var_153_1.sprite.bounds.size.x or var_153_2 / var_153_1.sprite.bounds.size.y, 0)
				end

				for iter_153_0, iter_153_1 in pairs(arg_150_1.bgs_) do
					if iter_153_0 ~= "I11i" then
						iter_153_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_153_3 = 0

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_3 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_4 = 2

			if var_153_3 <= arg_150_1.time_ and arg_150_1.time_ < var_153_3 + var_153_4 then
				local var_153_5 = Color.New(0, 0, 0)

				var_153_5.a = Mathf.Lerp(1, 0, (arg_150_1.time_ - var_153_3) / var_153_4)
				arg_150_1.mask_.color = var_153_5
			end

			if arg_150_1.time_ >= var_153_3 + var_153_4 and arg_150_1.time_ < var_153_3 + var_153_4 + arg_153_0 then
				local var_153_6 = Color.New(0, 0, 0)

				arg_150_1.mask_.enabled = false
				var_153_6.a = 0
				arg_150_1.mask_.color = var_153_6
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.fswbg_:SetActive(false)
				arg_150_1.dialog_:SetActive(false)
				SetActive(arg_150_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_150_1:ShowNextGo(false)
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.cswbg_:SetActive(false)
			end

			if arg_150_1.frameCnt_ <= 1 then
				arg_150_1.dialog_:SetActive(false)
			end

			local var_153_7 = 1.4
			local var_153_8 = 0.95

			if 1.4 < arg_150_1.time_ and arg_150_1.time_ <= var_153_7 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0

				arg_150_1.dialog_:SetActive(true)

				arg_150_1.dialogCg_.alpha = 0

				local var_153_9 = LeanTween.value(arg_150_1.dialog_, 0, 1, 0.3)

				var_153_9:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_150_1.dialogCg_.alpha = arg_154_0
				end))
				var_153_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_150_1.dialog_)
					var_153_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_150_1.duration_ = arg_150_1.duration_ + 0.3

				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_10 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(319951037).content)

				arg_150_1.text_.text = var_153_10

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_12 = 38 <= 0 and var_153_8 or var_153_8 * (utf8.len(var_153_10) / 38)

				if (38 <= 0 and var_153_8 or var_153_8 * (utf8.len(var_153_10) / 38)) > 0 and var_153_8 < var_153_12 then
					arg_150_1.talkMaxDuration = var_153_12
					var_153_7 = var_153_7 + 0.3

					if var_153_12 + var_153_7 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_12 + var_153_7
					end
				end

				arg_150_1.text_.text = var_153_10
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_13 = var_153_7 + 0.3
			local var_153_14 = math.max(var_153_8, arg_150_1.talkMaxDuration)

			if var_153_7 + 0.3 <= arg_150_1.time_ and arg_150_1.time_ < var_153_13 + var_153_14 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_13) / var_153_14

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_13 + var_153_14 and arg_150_1.time_ < var_153_13 + var_153_14 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play319951038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319951038
		arg_156_1.duration_ = 10.87

		local var_156_0 = {
			zh = 7.666,
			ja = 10.866
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
				arg_156_0:Play319951039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.7

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[696].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_1 = arg_156_1:GetWordFromCfg(319951038)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 28 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 28)

				if (28 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 28)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951038", "story_v_out_319951.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_319951", "319951038", "story_v_out_319951.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_319951", "319951038", "story_v_out_319951.awb")

						arg_156_1:RecordAudio("319951038", var_159_6)
						arg_156_1:RecordAudio("319951038", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319951", "319951038", "story_v_out_319951.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319951", "319951038", "story_v_out_319951.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play319951039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319951039
		arg_160_1.duration_ = 3.67

		local var_160_0 = {
			zh = 1.999999999999,
			ja = 3.666
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play319951040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1095ui_story = arg_160_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_163_0 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 then
				arg_160_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_160_1.time_ - 0) / var_163_0)
				arg_160_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).z)
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles = arg_160_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 then
				arg_160_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_160_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).z)
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles = arg_160_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_163_1 = arg_160_1.actors_["1095ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_1) and arg_160_1.var_.characterEffect1095ui_story == nil then
				arg_160_1.var_.characterEffect1095ui_story = var_163_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_2 and not isNil(var_163_1) then
				if arg_160_1.var_.characterEffect1095ui_story and not isNil(var_163_1) then
					arg_160_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_2 and arg_160_1.time_ < 0 + var_163_2 + arg_163_0 and not isNil(var_163_1) and arg_160_1.var_.characterEffect1095ui_story then
				arg_160_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_163_4 = 0
			local var_163_5 = 0.25

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_6 = arg_160_1:GetWordFromCfg(319951039)
				local var_163_7 = arg_160_1:FormatText(var_163_6.content)

				arg_160_1.text_.text = var_163_7

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_9 = 10 <= 0 and var_163_5 or var_163_5 * (utf8.len(var_163_7) / 10)

				if (10 <= 0 and var_163_5 or var_163_5 * (utf8.len(var_163_7) / 10)) > 0 and var_163_5 < var_163_9 then
					arg_160_1.talkMaxDuration = var_163_9

					if var_163_9 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_4
					end
				end

				arg_160_1.text_.text = var_163_7
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951039", "story_v_out_319951.awb") ~= 0 then
					local var_163_10 = manager.audio:GetVoiceLength("story_v_out_319951", "319951039", "story_v_out_319951.awb") / 1000

					if var_163_10 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_4
					end

					if var_163_6.prefab_name ~= "" and arg_160_1.actors_[var_163_6.prefab_name] ~= nil then
						local var_163_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_6.prefab_name].transform, "story_v_out_319951", "319951039", "story_v_out_319951.awb")

						arg_160_1:RecordAudio("319951039", var_163_11)
						arg_160_1:RecordAudio("319951039", var_163_11)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319951", "319951039", "story_v_out_319951.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319951", "319951039", "story_v_out_319951.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_12 = math.max(var_163_5, arg_160_1.talkMaxDuration)

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_12 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_4) / var_163_12

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_4 + var_163_12 and arg_160_1.time_ < var_163_4 + var_163_12 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play319951040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319951040
		arg_164_1.duration_ = 5.6

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play319951041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_9000

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1095ui_story"]) and arg_164_1.var_.characterEffect1095ui_story == nil then
				arg_164_1.var_.characterEffect1095ui_story = arg_164_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1095ui_story"]) then
				if arg_164_1.var_.characterEffect1095ui_story and not isNil(arg_164_1.actors_["1095ui_story"]) then
					arg_164_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1095ui_story"]) and arg_164_1.var_.characterEffect1095ui_story then
				arg_164_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:AudioAction("play", "effect", "se_story_130", "se_story_130_shot2", "")
			end

			local var_167_2 = arg_164_1.actors_["1095ui_story"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1095ui_story = var_167_2.localPosition
			end

			local var_167_3 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_3 then
				var_167_2.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 0) / var_167_3)
				var_167_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_2.position).x, (manager.ui.mainCamera.transform.position - var_167_2.position).y, (manager.ui.mainCamera.transform.position - var_167_2.position).z)
				var_167_2.localEulerAngles.z = 0
				var_167_2.localEulerAngles.x = 0
				var_167_2.localEulerAngles = var_167_2.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_3 and arg_164_1.time_ < 0 + var_167_3 + arg_167_0 then
				var_167_2.localPosition = Vector3.New(0, 100, 0)
				var_167_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_2.position).x, (manager.ui.mainCamera.transform.position - var_167_2.position).y, (manager.ui.mainCamera.transform.position - var_167_2.position).z)
				var_167_2.localEulerAngles.z = 0
				var_167_2.localEulerAngles.x = 0
				var_167_2.localEulerAngles = var_167_2.localEulerAngles
			end

			local var_167_4 = 0

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_5 = 0.5

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_5 then
				local var_167_6 = Color.New(1, 1, 1)

				var_167_6.a = Mathf.Lerp(1, 0, (arg_164_1.time_ - var_167_4) / var_167_5)
				arg_164_1.mask_.color = var_167_6
			end

			if arg_164_1.time_ >= var_167_4 + var_167_5 and arg_164_1.time_ < var_167_4 + var_167_5 + arg_167_0 then
				local var_167_7 = Color.New(1, 1, 1)

				arg_164_1.mask_.enabled = false
				var_167_7.a = 0
				arg_164_1.mask_.color = var_167_7
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				local var_167_8 = arg_164_1.var_.effectqiege1

				if not arg_164_1.var_.effectqiege1 then
					var_167_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), manager.ui.mainCamera.transform)
					var_167_8.name = "qiege1"
					arg_164_1.var_.effectqiege1 = var_167_8
				else
					var_167_8.transform:SetParent(var_167_9000)
				end

				var_167_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_167_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.5 < arg_164_1.time_ and arg_164_1.time_ <= 0.5 + arg_167_0 then
				if arg_164_1.var_.effectqiege1 then
					Object.Destroy(arg_164_1.var_.effectqiege1)

					arg_164_1.var_.effectqiege1 = nil
				end
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_11 = 0.6
			local var_167_12 = 1.5

			if 0.6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_11 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_13 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_13:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_14 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(319951040).content)

				arg_164_1.text_.text = var_167_14

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_16 = 60 <= 0 and var_167_12 or var_167_12 * (utf8.len(var_167_14) / 60)

				if (60 <= 0 and var_167_12 or var_167_12 * (utf8.len(var_167_14) / 60)) > 0 and var_167_12 < var_167_16 then
					arg_164_1.talkMaxDuration = var_167_16
					var_167_11 = var_167_11 + 0.3

					if var_167_16 + var_167_11 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_16 + var_167_11
					end
				end

				arg_164_1.text_.text = var_167_14
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_17 = var_167_11 + 0.3
			local var_167_18 = math.max(var_167_12, arg_164_1.talkMaxDuration)

			if var_167_11 + 0.3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_17 + var_167_18 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_17) / var_167_18

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_17 + var_167_18 and arg_164_1.time_ < var_167_17 + var_167_18 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play319951041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 319951041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play319951042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.825

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(319951041).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 33 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 33)

				if (33 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 33)) > 0 and var_173_0 < var_173_3 then
					arg_170_1.talkMaxDuration = var_173_3

					if var_173_3 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_3 + 0
					end
				end

				arg_170_1.text_.text = var_173_1
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_4 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_4

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play319951042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 319951042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play319951043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 1.6

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_1 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(319951042).content)

				arg_174_1.text_.text = var_177_1

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_3 = 64 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 64)

				if (64 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 64)) > 0 and var_177_0 < var_177_3 then
					arg_174_1.talkMaxDuration = var_177_3

					if var_177_3 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_3 + 0
					end
				end

				arg_174_1.text_.text = var_177_1
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_4 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_4

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play319951043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 319951043
		arg_178_1.duration_ = 2.23

		local var_178_0 = {
			zh = 1.366,
			ja = 2.233
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
				arg_178_0:Play319951044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1095ui_story = arg_178_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).z)
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles = arg_178_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_178_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1095ui_story"].transform.position).z)
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1095ui_story"].transform.localEulerAngles = arg_178_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["1095ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1095ui_story == nil then
				arg_178_1.var_.characterEffect1095ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1095ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1095ui_story then
				arg_178_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_4 = 0
			local var_181_5 = 0.15

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:GetWordFromCfg(319951043)
				local var_181_7 = arg_178_1:FormatText(var_181_6.content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 6 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 6)

				if (6 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 6)) > 0 and var_181_5 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951043", "story_v_out_319951.awb") ~= 0 then
					local var_181_10 = manager.audio:GetVoiceLength("story_v_out_319951", "319951043", "story_v_out_319951.awb") / 1000

					if var_181_10 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_4
					end

					if var_181_6.prefab_name ~= "" and arg_178_1.actors_[var_181_6.prefab_name] ~= nil then
						local var_181_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_6.prefab_name].transform, "story_v_out_319951", "319951043", "story_v_out_319951.awb")

						arg_178_1:RecordAudio("319951043", var_181_11)
						arg_178_1:RecordAudio("319951043", var_181_11)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_319951", "319951043", "story_v_out_319951.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_319951", "319951043", "story_v_out_319951.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_12 and arg_178_1.time_ < var_181_4 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play319951044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 319951044
		arg_182_1.duration_ = 2.4

		local var_182_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
			arg_182_1.auto_ = false
		end

		function arg_182_1.playNext_(arg_184_0)
			arg_182_1.onStoryFinished_()
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10079ui_story = arg_182_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).z)
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles = arg_182_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_182_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).z)
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles = arg_182_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["10079ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect10079ui_story == nil then
				arg_182_1.var_.characterEffect10079ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect10079ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect10079ui_story then
				arg_182_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_185_4 = arg_182_1.actors_["1095ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1095ui_story = var_185_4.localPosition
			end

			local var_185_5 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_5 then
				var_185_4.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_182_1.time_ - 0) / var_185_5)
				var_185_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_4.position).x, (manager.ui.mainCamera.transform.position - var_185_4.position).y, (manager.ui.mainCamera.transform.position - var_185_4.position).z)
				var_185_4.localEulerAngles.z = 0
				var_185_4.localEulerAngles.x = 0
				var_185_4.localEulerAngles = var_185_4.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_5 and arg_182_1.time_ < 0 + var_185_5 + arg_185_0 then
				var_185_4.localPosition = Vector3.New(0, 100, 0)
				var_185_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_4.position).x, (manager.ui.mainCamera.transform.position - var_185_4.position).y, (manager.ui.mainCamera.transform.position - var_185_4.position).z)
				var_185_4.localEulerAngles.z = 0
				var_185_4.localEulerAngles.x = 0
				var_185_4.localEulerAngles = var_185_4.localEulerAngles
			end

			local var_185_6 = arg_182_1.actors_["1095ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1095ui_story == nil then
				arg_182_1.var_.characterEffect1095ui_story = var_185_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_7 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 and not isNil(var_185_6) then
				if arg_182_1.var_.characterEffect1095ui_story and not isNil(var_185_6) then
					arg_182_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_7)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1095ui_story then
				arg_182_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_185_8 = 0
			local var_185_9 = 0.175

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_8 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_10 = arg_182_1:GetWordFromCfg(319951044)
				local var_185_11 = arg_182_1:FormatText(var_185_10.content)

				arg_182_1.text_.text = var_185_11

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_13 = 7 <= 0 and var_185_9 or var_185_9 * (utf8.len(var_185_11) / 7)

				if (7 <= 0 and var_185_9 or var_185_9 * (utf8.len(var_185_11) / 7)) > 0 and var_185_9 < var_185_13 then
					arg_182_1.talkMaxDuration = var_185_13

					if var_185_13 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_13 + var_185_8
					end
				end

				arg_182_1.text_.text = var_185_11
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319951", "319951044", "story_v_out_319951.awb") ~= 0 then
					local var_185_14 = manager.audio:GetVoiceLength("story_v_out_319951", "319951044", "story_v_out_319951.awb") / 1000

					if var_185_14 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_8
					end

					if var_185_10.prefab_name ~= "" and arg_182_1.actors_[var_185_10.prefab_name] ~= nil then
						local var_185_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_10.prefab_name].transform, "story_v_out_319951", "319951044", "story_v_out_319951.awb")

						arg_182_1:RecordAudio("319951044", var_185_15)
						arg_182_1:RecordAudio("319951044", var_185_15)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_319951", "319951044", "story_v_out_319951.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_319951", "319951044", "story_v_out_319951.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_16 = math.max(var_185_9, arg_182_1.talkMaxDuration)

			if var_185_8 <= arg_182_1.time_ and arg_182_1.time_ < var_185_8 + var_185_16 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_8) / var_185_16

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_8 + var_185_16 and arg_182_1.time_ < var_185_8 + var_185_16 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319951.awb"
	}
}
