return {
	Play933011287 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 933011287
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play933011288(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11r == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11r")
				var_4_0.name = "I11r"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11r = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11r

				arg_1_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11r" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 1.999999999999
			local var_4_17 = 1.475

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(933011287).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 59 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 59)

				if (59 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 59)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play933011288 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 933011288
		arg_9_1.duration_ = 8.63

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play933011289(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10102ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10102ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10102ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10102ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10102ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10102ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10102ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10102ui_story == nil then
				arg_9_1.var_.characterEffect10102ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10102ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10102ui_story then
				arg_9_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_12_8 = 0
			local var_12_9 = 1.25

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(933011288)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 50 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 50)

				if (50 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 50)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011288", "story_v_side_old_933011.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011288", "story_v_side_old_933011.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_side_old_933011", "933011288", "story_v_side_old_933011.awb")

						arg_9_1:RecordAudio("933011288", var_12_15)
						arg_9_1:RecordAudio("933011288", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011288", "story_v_side_old_933011.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011288", "story_v_side_old_933011.awb")
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
				actorName = "10102ui_story",
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
	Play933011289 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 933011289
		arg_13_1.duration_ = 6.13

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play933011290(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.85

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(933011289)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 34)

				if (34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 34)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011289", "story_v_side_old_933011.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011289", "story_v_side_old_933011.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_side_old_933011", "933011289", "story_v_side_old_933011.awb")

						arg_13_1:RecordAudio("933011289", var_16_6)
						arg_13_1:RecordAudio("933011289", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011289", "story_v_side_old_933011.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011289", "story_v_side_old_933011.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play933011290 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 933011290
		arg_17_1.duration_ = 6.5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play933011291(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10102ui_story = arg_17_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).z)
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles = arg_17_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_17_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10102ui_story"].transform.position).z)
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10102ui_story"].transform.localEulerAngles = arg_17_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_20_1 = 0
			local var_20_2 = 0.825

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(933011290)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 33 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 33)

				if (33 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 33)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011290", "story_v_side_old_933011.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011290", "story_v_side_old_933011.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_side_old_933011", "933011290", "story_v_side_old_933011.awb")

						arg_17_1:RecordAudio("933011290", var_20_8)
						arg_17_1:RecordAudio("933011290", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011290", "story_v_side_old_933011.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011290", "story_v_side_old_933011.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_9 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_9 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_9

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_9 and arg_17_1.time_ < var_20_1 + var_20_9 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play933011291 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 933011291
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play933011292(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10102ui_story"]) and arg_21_1.var_.characterEffect10102ui_story == nil then
				arg_21_1.var_.characterEffect10102ui_story = arg_21_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10102ui_story"]) then
				if arg_21_1.var_.characterEffect10102ui_story and not isNil(arg_21_1.actors_["10102ui_story"]) then
					arg_21_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10102ui_story"]) and arg_21_1.var_.characterEffect10102ui_story then
				arg_21_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.775

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(933011291).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 31 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 31)

				if (31 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 31)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play933011292 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 933011292
		arg_25_1.duration_ = 2

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play933011293(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10102ui_story = arg_25_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).z)
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles = arg_25_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_25_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10102ui_story"].transform.position).z)
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10102ui_story"].transform.localEulerAngles = arg_25_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["10102ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10102ui_story == nil then
				arg_25_1.var_.characterEffect10102ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect10102ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10102ui_story then
				arg_25_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_28_4 = 0
			local var_28_5 = 0.075

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(933011292)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 3 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 3)

				if (3 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 3)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011292", "story_v_side_old_933011.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011292", "story_v_side_old_933011.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_side_old_933011", "933011292", "story_v_side_old_933011.awb")

						arg_25_1:RecordAudio("933011292", var_28_11)
						arg_25_1:RecordAudio("933011292", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011292", "story_v_side_old_933011.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011292", "story_v_side_old_933011.awb")
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
				actorName = "10102ui_story",
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
	Play933011293 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 933011293
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play933011294(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10102ui_story = arg_29_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).z)
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles = arg_29_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10102ui_story"].transform.position).z)
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10102ui_story"].transform.localEulerAngles = arg_29_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["10102ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10102ui_story == nil then
				arg_29_1.var_.characterEffect10102ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect10102ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_2)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10102ui_story then
				arg_29_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_32_3 = 0
			local var_32_4 = 0.875

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_5 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(933011293).content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 35 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 35)

				if (35 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 35)) > 0 and var_32_4 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_8 and arg_29_1.time_ < var_32_3 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play933011294 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 933011294
		arg_33_1.duration_ = 2.8

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play933011295(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10102ui_story = arg_33_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).z)
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles = arg_33_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_33_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10102ui_story"].transform.position).z)
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10102ui_story"].transform.localEulerAngles = arg_33_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["10102ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect10102ui_story == nil then
				arg_33_1.var_.characterEffect10102ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect10102ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect10102ui_story then
				arg_33_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_4 = 0
			local var_36_5 = 0.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(933011294)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 10 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 10)

				if (10 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 10)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011294", "story_v_side_old_933011.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011294", "story_v_side_old_933011.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_side_old_933011", "933011294", "story_v_side_old_933011.awb")

						arg_33_1:RecordAudio("933011294", var_36_11)
						arg_33_1:RecordAudio("933011294", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011294", "story_v_side_old_933011.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011294", "story_v_side_old_933011.awb")
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
				actorName = "10102ui_story",
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
	Play933011295 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 933011295
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play933011296(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10102ui_story"]) and arg_37_1.var_.characterEffect10102ui_story == nil then
				arg_37_1.var_.characterEffect10102ui_story = arg_37_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10102ui_story"]) then
				if arg_37_1.var_.characterEffect10102ui_story and not isNil(arg_37_1.actors_["10102ui_story"]) then
					arg_37_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10102ui_story"]) and arg_37_1.var_.characterEffect10102ui_story then
				arg_37_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.65

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
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

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(933011295).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 26 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 26)

				if (26 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 26)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play933011296 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 933011296
		arg_41_1.duration_ = 3.7

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play933011297(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10102ui_story = arg_41_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).z)
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles = arg_41_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_41_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10102ui_story"].transform.position).z)
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10102ui_story"].transform.localEulerAngles = arg_41_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["10102ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10102ui_story == nil then
				arg_41_1.var_.characterEffect10102ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect10102ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10102ui_story then
				arg_41_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_44_4 = 0
			local var_44_5 = 0.375

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(933011296)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 15 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 15)

				if (15 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 15)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011296", "story_v_side_old_933011.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011296", "story_v_side_old_933011.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_side_old_933011", "933011296", "story_v_side_old_933011.awb")

						arg_41_1:RecordAudio("933011296", var_44_11)
						arg_41_1:RecordAudio("933011296", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011296", "story_v_side_old_933011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011296", "story_v_side_old_933011.awb")
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
				actorName = "10102ui_story",
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
	Play933011297 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 933011297
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play933011298(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10102ui_story"]) and arg_45_1.var_.characterEffect10102ui_story == nil then
				arg_45_1.var_.characterEffect10102ui_story = arg_45_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10102ui_story"]) then
				if arg_45_1.var_.characterEffect10102ui_story and not isNil(arg_45_1.actors_["10102ui_story"]) then
					arg_45_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10102ui_story"]) and arg_45_1.var_.characterEffect10102ui_story then
				arg_45_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.9

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
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

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(933011297).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 36 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 36)

				if (36 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 36)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play933011298 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 933011298
		arg_49_1.duration_ = 3.6

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play933011299(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10102ui_story = arg_49_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).z)
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles = arg_49_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_49_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10102ui_story"].transform.position).z)
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10102ui_story"].transform.localEulerAngles = arg_49_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10102ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10102ui_story == nil then
				arg_49_1.var_.characterEffect10102ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10102ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10102ui_story then
				arg_49_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action465")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_52_4 = 0
			local var_52_5 = 0.4

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(933011298)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 16 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 16)

				if (16 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 16)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011298", "story_v_side_old_933011.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011298", "story_v_side_old_933011.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_side_old_933011", "933011298", "story_v_side_old_933011.awb")

						arg_49_1:RecordAudio("933011298", var_52_11)
						arg_49_1:RecordAudio("933011298", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011298", "story_v_side_old_933011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011298", "story_v_side_old_933011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play933011299 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 933011299
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play933011300(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10102ui_story"]) and arg_53_1.var_.characterEffect10102ui_story == nil then
				arg_53_1.var_.characterEffect10102ui_story = arg_53_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10102ui_story"]) then
				if arg_53_1.var_.characterEffect10102ui_story and not isNil(arg_53_1.actors_["10102ui_story"]) then
					arg_53_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10102ui_story"]) and arg_53_1.var_.characterEffect10102ui_story then
				arg_53_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 1.025

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(933011299).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 41 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 41)

				if (41 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 41)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play933011300 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 933011300
		arg_57_1.duration_ = 5.1

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play933011301(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10102ui_story = arg_57_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).z)
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles = arg_57_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_57_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10102ui_story"].transform.position).z)
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10102ui_story"].transform.localEulerAngles = arg_57_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["10102ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10102ui_story == nil then
				arg_57_1.var_.characterEffect10102ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect10102ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10102ui_story then
				arg_57_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action454")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_60_4 = 0
			local var_60_5 = 0.575

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

				local var_60_6 = arg_57_1:GetWordFromCfg(933011300)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 23 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 23)

				if (23 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 23)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011300", "story_v_side_old_933011.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011300", "story_v_side_old_933011.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_side_old_933011", "933011300", "story_v_side_old_933011.awb")

						arg_57_1:RecordAudio("933011300", var_60_11)
						arg_57_1:RecordAudio("933011300", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011300", "story_v_side_old_933011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011300", "story_v_side_old_933011.awb")
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
				actorName = "10102ui_story",
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
	Play933011301 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 933011301
		arg_61_1.duration_ = 4.7

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play933011302(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10102ui_story = arg_61_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).z)
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles = arg_61_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_61_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).z)
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles = arg_61_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action442")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_64_1 = 0
			local var_64_2 = 0.55

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(933011301)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 22 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 22)

				if (22 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 22)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011301", "story_v_side_old_933011.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011301", "story_v_side_old_933011.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_side_old_933011", "933011301", "story_v_side_old_933011.awb")

						arg_61_1:RecordAudio("933011301", var_64_8)
						arg_61_1:RecordAudio("933011301", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011301", "story_v_side_old_933011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011301", "story_v_side_old_933011.awb")
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

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play933011302 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 933011302
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play933011303(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10102ui_story"]) and arg_65_1.var_.characterEffect10102ui_story == nil then
				arg_65_1.var_.characterEffect10102ui_story = arg_65_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10102ui_story"]) then
				if arg_65_1.var_.characterEffect10102ui_story and not isNil(arg_65_1.actors_["10102ui_story"]) then
					arg_65_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10102ui_story"]) and arg_65_1.var_.characterEffect10102ui_story then
				arg_65_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.5

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(933011302).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 20 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 20)

				if (20 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 20)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play933011303 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 933011303
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play933011304(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10102ui_story = arg_69_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10102ui_story"].transform.position).z)
				arg_69_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10102ui_story"].transform.localEulerAngles = arg_69_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_69_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10102ui_story"].transform.position).z)
				arg_69_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10102ui_story"].transform.localEulerAngles = arg_69_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["10102ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10102ui_story == nil then
				arg_69_1.var_.characterEffect10102ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect10102ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10102ui_story then
				arg_69_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			local var_72_4 = 0
			local var_72_5 = 0.1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(933011303)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 4 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 4)

				if (4 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 4)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011303", "story_v_side_old_933011.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011303", "story_v_side_old_933011.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_side_old_933011", "933011303", "story_v_side_old_933011.awb")

						arg_69_1:RecordAudio("933011303", var_72_11)
						arg_69_1:RecordAudio("933011303", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011303", "story_v_side_old_933011.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011303", "story_v_side_old_933011.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play933011304 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 933011304
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play933011305(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10102ui_story"]) and arg_73_1.var_.characterEffect10102ui_story == nil then
				arg_73_1.var_.characterEffect10102ui_story = arg_73_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10102ui_story"]) then
				if arg_73_1.var_.characterEffect10102ui_story and not isNil(arg_73_1.actors_["10102ui_story"]) then
					arg_73_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10102ui_story"]) and arg_73_1.var_.characterEffect10102ui_story then
				arg_73_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.675

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(933011304).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 27 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 27)

				if (27 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 27)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play933011305 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 933011305
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play933011306(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.775

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
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

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(933011305).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 31 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 31)

				if (31 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 31)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play933011306 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 933011306
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play933011307(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.525

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(933011306).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 21 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 21)

				if (21 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 21)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play933011307 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 933011307
		arg_85_1.duration_ = 2.9

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play933011308(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10102ui_story = arg_85_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10102ui_story"].transform.position).z)
				arg_85_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10102ui_story"].transform.localEulerAngles = arg_85_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_85_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10102ui_story"].transform.position).z)
				arg_85_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10102ui_story"].transform.localEulerAngles = arg_85_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["10102ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10102ui_story == nil then
				arg_85_1.var_.characterEffect10102ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect10102ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10102ui_story then
				arg_85_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_88_4 = 0
			local var_88_5 = 0.3

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(933011307)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 12 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 12)

				if (12 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 12)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011307", "story_v_side_old_933011.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011307", "story_v_side_old_933011.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_side_old_933011", "933011307", "story_v_side_old_933011.awb")

						arg_85_1:RecordAudio("933011307", var_88_11)
						arg_85_1:RecordAudio("933011307", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011307", "story_v_side_old_933011.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011307", "story_v_side_old_933011.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play933011308 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 933011308
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play933011309(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10102ui_story"]) and arg_89_1.var_.characterEffect10102ui_story == nil then
				arg_89_1.var_.characterEffect10102ui_story = arg_89_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10102ui_story"]) then
				if arg_89_1.var_.characterEffect10102ui_story and not isNil(arg_89_1.actors_["10102ui_story"]) then
					arg_89_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10102ui_story"]) and arg_89_1.var_.characterEffect10102ui_story then
				arg_89_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.925

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(933011308).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 37 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 37)

				if (37 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 37)) > 0 and var_92_2 < var_92_5 then
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

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play933011309 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 933011309
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play933011310(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10102ui_story = arg_93_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).z)
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles = arg_93_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10102ui_story"].transform.position).z)
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10102ui_story"].transform.localEulerAngles = arg_93_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if 0.034000001847744 < arg_93_1.time_ and arg_93_1.time_ <= 0.034000001847744 + arg_96_0 then
				arg_93_1:AudioAction("play", "effect", "se_story_146", "se_story_146_car", "")
			end

			local var_96_2 = 0
			local var_96_3 = 0.85

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(933011309).content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 34 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_4) / 34)

				if (34 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_4) / 34)) > 0 and var_96_3 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_7 and arg_93_1.time_ < var_96_2 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play933011310 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 933011310
		arg_97_1.duration_ = 2.6

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play933011311(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10102ui_story = arg_97_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10102ui_story"].transform.position).z)
				arg_97_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10102ui_story"].transform.localEulerAngles = arg_97_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_97_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10102ui_story"].transform.position).z)
				arg_97_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10102ui_story"].transform.localEulerAngles = arg_97_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10102ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10102ui_story == nil then
				arg_97_1.var_.characterEffect10102ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10102ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10102ui_story then
				arg_97_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			local var_100_4 = 0
			local var_100_5 = 0.225

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(933011310)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 9 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 9)

				if (9 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 9)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011310", "story_v_side_old_933011.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011310", "story_v_side_old_933011.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_side_old_933011", "933011310", "story_v_side_old_933011.awb")

						arg_97_1:RecordAudio("933011310", var_100_11)
						arg_97_1:RecordAudio("933011310", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011310", "story_v_side_old_933011.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011310", "story_v_side_old_933011.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play933011311 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 933011311
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play933011312(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10102ui_story"]) and arg_101_1.var_.characterEffect10102ui_story == nil then
				arg_101_1.var_.characterEffect10102ui_story = arg_101_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10102ui_story"]) then
				if arg_101_1.var_.characterEffect10102ui_story and not isNil(arg_101_1.actors_["10102ui_story"]) then
					arg_101_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10102ui_story"]) and arg_101_1.var_.characterEffect10102ui_story then
				arg_101_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.25

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(933011311).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 10 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 10)

				if (10 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 10)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play933011312 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 933011312
		arg_105_1.duration_ = 2

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play933011313(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10102ui_story"]) and arg_105_1.var_.characterEffect10102ui_story == nil then
				arg_105_1.var_.characterEffect10102ui_story = arg_105_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10102ui_story"]) then
				if arg_105_1.var_.characterEffect10102ui_story and not isNil(arg_105_1.actors_["10102ui_story"]) then
					arg_105_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10102ui_story"]) and arg_105_1.var_.characterEffect10102ui_story then
				arg_105_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_108_2 = 0
			local var_108_3 = 0.1

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(933011312)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 4 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 4)

				if (4 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 4)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011312", "story_v_side_old_933011.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011312", "story_v_side_old_933011.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_side_old_933011", "933011312", "story_v_side_old_933011.awb")

						arg_105_1:RecordAudio("933011312", var_108_9)
						arg_105_1:RecordAudio("933011312", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011312", "story_v_side_old_933011.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011312", "story_v_side_old_933011.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play933011313 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 933011313
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play933011314(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10102ui_story"]) and arg_109_1.var_.characterEffect10102ui_story == nil then
				arg_109_1.var_.characterEffect10102ui_story = arg_109_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10102ui_story"]) then
				if arg_109_1.var_.characterEffect10102ui_story and not isNil(arg_109_1.actors_["10102ui_story"]) then
					arg_109_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10102ui_story"]) and arg_109_1.var_.characterEffect10102ui_story then
				arg_109_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.9

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

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(933011313).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 36 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 36)

				if (36 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 36)) > 0 and var_112_2 < var_112_5 then
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

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play933011314 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 933011314
		arg_113_1.duration_ = 9

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play933011315(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if arg_113_1.bgs_.ST15 == nil then
				local var_116_0 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15")
				var_116_0.name = "ST15"
				var_116_0.transform.parent = arg_113_1.stage_.transform
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_.ST15 = var_116_0
			end

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				local var_116_1 = arg_113_1.bgs_.ST15

				arg_113_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_2 = var_116_1:GetComponent("SpriteRenderer")

				if var_116_2 and var_116_2.sprite then
					local var_116_3 = 2 * (var_116_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_1.transform.localScale = Vector3.New(var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "ST15" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_4 = 3.999999999999

			if 3.999999999999 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_4 + 0.3 and arg_113_1.time_ < var_116_4 + 0.3 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			local var_116_5 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_6 = 2

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_6 then
				local var_116_7 = Color.New(0, 0, 0)

				var_116_7.a = Mathf.Lerp(0, 1, (arg_113_1.time_ - var_116_5) / var_116_6)
				arg_113_1.mask_.color = var_116_7
			end

			if arg_113_1.time_ >= var_116_5 + var_116_6 and arg_113_1.time_ < var_116_5 + var_116_6 + arg_116_0 then
				local var_116_8 = Color.New(0, 0, 0)

				var_116_8.a = 1
				arg_113_1.mask_.color = var_116_8
			end

			local var_116_9 = 2

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_10 = 2

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 then
				local var_116_11 = Color.New(0, 0, 0)

				var_116_11.a = Mathf.Lerp(1, 0, (arg_113_1.time_ - var_116_9) / var_116_10)
				arg_113_1.mask_.color = var_116_11
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 then
				local var_116_12 = Color.New(0, 0, 0)

				arg_113_1.mask_.enabled = false
				var_116_12.a = 0
				arg_113_1.mask_.color = var_116_12
			end

			local var_116_13 = arg_113_1.actors_["10102ui_story"].transform

			if 1.96599999815226 < arg_113_1.time_ and arg_113_1.time_ <= 1.96599999815226 + arg_116_0 then
				arg_113_1.var_.moveOldPos10102ui_story = var_116_13.localPosition
			end

			local var_116_14 = 0.001

			if 1.96599999815226 <= arg_113_1.time_ and arg_113_1.time_ < 1.96599999815226 + var_116_14 then
				var_116_13.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 1.96599999815226) / var_116_14)
				var_116_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_13.position).x, (manager.ui.mainCamera.transform.position - var_116_13.position).y, (manager.ui.mainCamera.transform.position - var_116_13.position).z)
				var_116_13.localEulerAngles.z = 0
				var_116_13.localEulerAngles.x = 0
				var_116_13.localEulerAngles = var_116_13.localEulerAngles
			end

			if arg_113_1.time_ >= 1.96599999815226 + var_116_14 and arg_113_1.time_ < 1.96599999815226 + var_116_14 + arg_116_0 then
				var_116_13.localPosition = Vector3.New(0, 100, 0)
				var_116_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_13.position).x, (manager.ui.mainCamera.transform.position - var_116_13.position).y, (manager.ui.mainCamera.transform.position - var_116_13.position).z)
				var_116_13.localEulerAngles.z = 0
				var_116_13.localEulerAngles.x = 0
				var_116_13.localEulerAngles = var_116_13.localEulerAngles
			end

			if 0.166666666666667 < arg_113_1.time_ and arg_113_1.time_ <= 0.166666666666667 + arg_116_0 then
				arg_113_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_116_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_113_1.bgmTxt_.text ~= var_116_17 and arg_113_1.bgmTxt_.text ~= "" then
						if arg_113_1.bgmTxt2_.text ~= "" then
							arg_113_1.bgmTxt_.text = arg_113_1.bgmTxt2_.text
						end

						arg_113_1.bgmTxt2_.text = var_116_17

						arg_113_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_113_1.bgmTxt_.text = var_116_17
						arg_113_1.bgmTxt2_.text = var_116_17
					end

					if arg_113_1.bgmTimer then
						arg_113_1.bgmTimer:Stop()

						arg_113_1.bgmTimer = nil
					end

					if arg_113_1.settingData.show_music_name == 1 then
						arg_113_1.musicController:SetSelectedState("show")
						arg_113_1.musicAnimator_:Play("open", 0, 0)

						if arg_113_1.settingData.music_time ~= 0 then
							arg_113_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_113_1.settingData.music_time), function()
								if arg_113_1 == nil or isNil(arg_113_1.bgmTxt_) then
									return
								end

								arg_113_1.musicController:SetSelectedState("hide")
								arg_113_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.6 < arg_113_1.time_ and arg_113_1.time_ <= 1.6 + arg_116_0 then
				arg_113_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_beach", "bgm_activity_1_2_summer1_story_beach", "bgm_activity_1_2_summer1_story_beach.awb")

				local var_116_20 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_beach", "bgm_activity_1_2_summer1_story_beach")

				if "" ~= "" then
					if arg_113_1.bgmTxt_.text ~= var_116_20 and arg_113_1.bgmTxt_.text ~= "" then
						if arg_113_1.bgmTxt2_.text ~= "" then
							arg_113_1.bgmTxt_.text = arg_113_1.bgmTxt2_.text
						end

						arg_113_1.bgmTxt2_.text = var_116_20

						arg_113_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_113_1.bgmTxt_.text = var_116_20
						arg_113_1.bgmTxt2_.text = var_116_20
					end

					if arg_113_1.bgmTimer then
						arg_113_1.bgmTimer:Stop()

						arg_113_1.bgmTimer = nil
					end

					if arg_113_1.settingData.show_music_name == 1 then
						arg_113_1.musicController:SetSelectedState("show")
						arg_113_1.musicAnimator_:Play("open", 0, 0)

						if arg_113_1.settingData.music_time ~= 0 then
							arg_113_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_113_1.settingData.music_time), function()
								if arg_113_1 == nil or isNil(arg_113_1.bgmTxt_) then
									return
								end

								arg_113_1.musicController:SetSelectedState("hide")
								arg_113_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_113_1.time_ and arg_113_1.time_ <= 0.166666666666667 + arg_116_0 then
				arg_113_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 1.6 < arg_113_1.time_ and arg_113_1.time_ <= 1.6 + arg_116_0 then
				arg_113_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_23 = 4
			local var_116_24 = 0.825

			if 4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_25 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_25:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_113_1.dialogCg_.alpha = arg_119_0
				end))
				var_116_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_26 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(933011314).content)

				arg_113_1.text_.text = var_116_26

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_28 = 33 <= 0 and var_116_24 or var_116_24 * (utf8.len(var_116_26) / 33)

				if (33 <= 0 and var_116_24 or var_116_24 * (utf8.len(var_116_26) / 33)) > 0 and var_116_24 < var_116_28 then
					arg_113_1.talkMaxDuration = var_116_28
					var_116_23 = var_116_23 + 0.3

					if var_116_28 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_28 + var_116_23
					end
				end

				arg_113_1.text_.text = var_116_26
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_29 = var_116_23 + 0.3
			local var_116_30 = math.max(var_116_24, arg_113_1.talkMaxDuration)

			if var_116_23 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_29 + var_116_30 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_29) / var_116_30

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_29 + var_116_30 and arg_113_1.time_ < var_116_29 + var_116_30 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play933011315 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 933011315
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play933011316(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.075

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(933011315).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 43 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 43)

				if (43 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 43)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play933011316 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 933011316
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play933011317(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0.175 < arg_125_1.time_ and arg_125_1.time_ <= 0.175 + arg_128_0 then
				arg_125_1:AudioAction("play", "effect", "se_story_143", "se_story_143_footstep_sand", "")
			end

			local var_128_1 = 0
			local var_128_2 = 1.175

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(933011316).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 47 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 47)

				if (47 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 47)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play933011317 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 933011317
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play933011318(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1.5

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(933011317).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 60 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 60)

				if (60 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 60)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play933011318 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 933011318
		arg_133_1.duration_ = 12.4

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play933011319(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_9001
			local var_136_9000

			if arg_133_1.bgs_.SP93301 == nil then
				local var_136_0 = Object.Instantiate(arg_133_1.paintGo_)

				var_136_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SP93301")
				var_136_0.name = "SP93301"
				var_136_0.transform.parent = arg_133_1.stage_.transform
				var_136_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.bgs_.SP93301 = var_136_0
			end

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= 2 + arg_136_0 then
				local var_136_1 = arg_133_1.bgs_.SP93301

				arg_133_1.bgs_.SP93301.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_136_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_2 = var_136_1:GetComponent("SpriteRenderer")

				if var_136_2 and var_136_2.sprite then
					local var_136_3 = 2 * (var_136_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_136_1.transform.localScale = Vector3.New(var_136_3 / var_136_2.sprite.bounds.size.y < var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x and var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x or var_136_3 / var_136_2.sprite.bounds.size.y, var_136_3 / var_136_2.sprite.bounds.size.y < var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x and var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x or var_136_3 / var_136_2.sprite.bounds.size.y, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "SP93301" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_4 = 4

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			if arg_133_1.time_ >= var_136_4 + 0.3 and arg_133_1.time_ < var_136_4 + 0.3 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end

			local var_136_5 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_6 = 2

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 then
				local var_136_7 = Color.New(0, 0, 0)

				var_136_7.a = Mathf.Lerp(0, 1, (arg_133_1.time_ - var_136_5) / var_136_6)
				arg_133_1.mask_.color = var_136_7
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 then
				local var_136_8 = Color.New(0, 0, 0)

				var_136_8.a = 1
				arg_133_1.mask_.color = var_136_8
			end

			local var_136_9 = 2

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_10 = 2

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_10 then
				local var_136_11 = Color.New(0, 0, 0)

				var_136_11.a = Mathf.Lerp(1, 0, (arg_133_1.time_ - var_136_9) / var_136_10)
				arg_133_1.mask_.color = var_136_11
			end

			if arg_133_1.time_ >= var_136_9 + var_136_10 and arg_133_1.time_ < var_136_9 + var_136_10 + arg_136_0 then
				local var_136_12 = Color.New(0, 0, 0)

				arg_133_1.mask_.enabled = false
				var_136_12.a = 0
				arg_133_1.mask_.color = var_136_12
			end

			local var_136_13 = arg_133_1.bgs_.SP93301.transform

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= 2 + arg_136_0 then
				arg_133_1.var_.moveOldPosSP93301 = var_136_13.localPosition
			end

			local var_136_14 = 1.8

			if 2 <= arg_133_1.time_ and arg_133_1.time_ < 2 + var_136_14 then
				var_136_13.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosSP93301, Vector3.New(-2.38, 1.74, 4.15), (arg_133_1.time_ - 2) / var_136_14)
			end

			if arg_133_1.time_ >= 2 + var_136_14 and arg_133_1.time_ < 2 + var_136_14 + arg_136_0 then
				var_136_13.localPosition = Vector3.New(-2.38, 1.74, 4.15)
			end

			local var_136_15 = arg_133_1.bgs_.SP93301.transform

			if 3.8 < arg_133_1.time_ and arg_133_1.time_ <= 3.8 + arg_136_0 then
				arg_133_1.var_.moveOldPosSP93301 = var_136_15.localPosition
			end

			local var_136_16 = 1.8

			if 3.8 <= arg_133_1.time_ and arg_133_1.time_ < 3.8 + var_136_16 then
				var_136_15.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosSP93301, Vector3.New(-1, -0.13, 2.01), (arg_133_1.time_ - 3.8) / var_136_16)
			end

			if arg_133_1.time_ >= 3.8 + var_136_16 and arg_133_1.time_ < 3.8 + var_136_16 + arg_136_0 then
				var_136_15.localPosition = Vector3.New(-1, -0.13, 2.01)
			end

			local var_136_17 = arg_133_1.bgs_.SP93301.transform

			if 5.6 < arg_133_1.time_ and arg_133_1.time_ <= 5.6 + arg_136_0 then
				arg_133_1.var_.moveOldPosSP93301 = var_136_17.localPosition
			end

			local var_136_18 = 1.8

			if 5.6 <= arg_133_1.time_ and arg_133_1.time_ < 5.6 + var_136_18 then
				var_136_17.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosSP93301, Vector3.New(0, 1, 9), (arg_133_1.time_ - 5.6) / var_136_18)
			end

			if arg_133_1.time_ >= 5.6 + var_136_18 and arg_133_1.time_ < 5.6 + var_136_18 + arg_136_0 then
				var_136_17.localPosition = Vector3.New(0, 1, 9)
			end

			local var_136_19 = arg_133_1.bgs_.SP93301.transform

			if 7.4 < arg_133_1.time_ and arg_133_1.time_ <= 7.4 + arg_136_0 then
				arg_133_1.var_.moveOldPosSP93301 = var_136_19.localPosition
			end

			local var_136_20 = 4.7

			if 7.4 <= arg_133_1.time_ and arg_133_1.time_ < 7.4 + var_136_20 then
				var_136_19.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosSP93301, Vector3.New(0, 1, 9.5), (arg_133_1.time_ - 7.4) / var_136_20)
			end

			if arg_133_1.time_ >= 7.4 + var_136_20 and arg_133_1.time_ < 7.4 + var_136_20 + arg_136_0 then
				var_136_19.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 5 < arg_133_1.time_ and arg_133_1.time_ <= 5 + arg_136_0 then
				local var_136_21 = arg_133_1.var_.effectweiershatan

				if not arg_133_1.var_.effectweiershatan then
					var_136_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_136_21.name = "weiershatan"
					arg_133_1.var_.effectweiershatan = var_136_21
				else
					var_136_21.transform:SetParent(var_136_9001)
				end

				var_136_21.transform.localPosition = Vector3.New(0, 0, -1)
				var_136_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_136_21.transform.localScale = Vector3.New(var_136_21.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_136_21.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_136_21.transform.localScale.z)
			end

			if 6.33333333333333 < arg_133_1.time_ and arg_133_1.time_ <= 6.33333333333333 + arg_136_0 then
				if arg_133_1.var_.effectweiershatan then
					Object.Destroy(arg_133_1.var_.effectweiershatan)

					arg_133_1.var_.effectweiershatan = nil
				end
			end

			if 6.33333333333333 < arg_133_1.time_ and arg_133_1.time_ <= 6.33333333333333 + arg_136_0 then
				local var_136_24 = arg_133_1.var_.effectweiershatan1

				if not arg_133_1.var_.effectweiershatan1 then
					var_136_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_136_24.name = "weiershatan1"
					arg_133_1.var_.effectweiershatan1 = var_136_24
				else
					var_136_24.transform:SetParent(var_136_9000)
				end

				var_136_24.transform.localPosition = Vector3.New(0, 0, -1)
				var_136_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_136_24.transform.localScale = Vector3.New(var_136_24.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_136_24.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_136_24.transform.localScale.z)
			end

			if 7.66666666666667 < arg_133_1.time_ and arg_133_1.time_ <= 7.66666666666667 + arg_136_0 then
				if arg_133_1.var_.effectweiershatan1 then
					Object.Destroy(arg_133_1.var_.effectweiershatan1)

					arg_133_1.var_.effectweiershatan1 = nil
				end
			end

			local var_136_27 = 4

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_27 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			if arg_133_1.time_ >= var_136_27 + 7.06666666666667 and arg_133_1.time_ < var_136_27 + 7.06666666666667 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_28 = 7.4
			local var_136_29 = 1.125

			if 7.4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_28 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_30 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_30:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_31 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(933011318).content)

				arg_133_1.text_.text = var_136_31

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_33 = 45 <= 0 and var_136_29 or var_136_29 * (utf8.len(var_136_31) / 45)

				if (45 <= 0 and var_136_29 or var_136_29 * (utf8.len(var_136_31) / 45)) > 0 and var_136_29 < var_136_33 then
					arg_133_1.talkMaxDuration = var_136_33
					var_136_28 = var_136_28 + 0.3

					if var_136_33 + var_136_28 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_33 + var_136_28
					end
				end

				arg_133_1.text_.text = var_136_31
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_34 = var_136_28 + 0.3
			local var_136_35 = math.max(var_136_29, arg_133_1.talkMaxDuration)

			if var_136_28 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_34 + var_136_35 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_34) / var_136_35

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_34 + var_136_35 and arg_133_1.time_ < var_136_34 + var_136_35 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93301",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.8,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(2.88, 0.7, 4.15),
					endPos = Vector3.New(-2.38, 1.74, 4.15),
					easeType = LeanTweenType.easeInOutCubic
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93301",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.8,
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-2.38, 1.74, 4.15),
					endPos = Vector3.New(-1, -0.13, 2.01),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93301",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.8,
				startTime = 5.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-1, -0.13, 2.01),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93301",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 4.7,
				startTime = 7.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play933011319 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 933011319
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play933011320(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.2

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
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

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(933011319).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 8 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 8)

				if (8 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 8)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play933011320 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 933011320
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play933011321(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0.1 < arg_143_1.time_ and arg_143_1.time_ <= 0.1 + arg_146_0 then
				arg_143_1:AudioAction("play", "effect", "se_story_148", "se_story_148_soda_can_open", "")
			end

			local var_146_1 = 0
			local var_146_2 = 1.375

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(933011320).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 55 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 55)

				if (55 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 55)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play933011321 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 933011321
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play933011322(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.325

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(933011321).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 13 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 13)

				if (13 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 13)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play933011322 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 933011322
		arg_151_1.duration_ = 2

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play933011323(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.225

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(933011322)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 9 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 9)

				if (9 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 9)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011322", "story_v_side_old_933011.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011322", "story_v_side_old_933011.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_side_old_933011", "933011322", "story_v_side_old_933011.awb")

						arg_151_1:RecordAudio("933011322", var_154_6)
						arg_151_1:RecordAudio("933011322", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011322", "story_v_side_old_933011.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011322", "story_v_side_old_933011.awb")
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
	Play933011323 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 933011323
		arg_155_1.duration_ = 7.13

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play933011324(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.8

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(933011323)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 32 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 32)

				if (32 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 32)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011323", "story_v_side_old_933011.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011323", "story_v_side_old_933011.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_side_old_933011", "933011323", "story_v_side_old_933011.awb")

						arg_155_1:RecordAudio("933011323", var_158_6)
						arg_155_1:RecordAudio("933011323", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011323", "story_v_side_old_933011.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011323", "story_v_side_old_933011.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play933011324 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 933011324
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play933011325(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.45

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(933011324).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 18 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 18)

				if (18 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 18)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play933011325 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 933011325
		arg_163_1.duration_ = 2.73

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play933011326(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.275

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:GetWordFromCfg(933011325)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 11 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 11)

				if (11 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 11)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011325", "story_v_side_old_933011.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011325", "story_v_side_old_933011.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_side_old_933011", "933011325", "story_v_side_old_933011.awb")

						arg_163_1:RecordAudio("933011325", var_166_6)
						arg_163_1:RecordAudio("933011325", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011325", "story_v_side_old_933011.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011325", "story_v_side_old_933011.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play933011326 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 933011326
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play933011327(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.575

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

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(933011326).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 23 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 23)

				if (23 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 23)) > 0 and var_170_0 < var_170_3 then
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
	Play933011327 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 933011327
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play933011328(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.95

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(933011327).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 38 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 38)

				if (38 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 38)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play933011328 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 933011328
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play933011329(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.475

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
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

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(933011328).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 19 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 19)

				if (19 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 19)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play933011329 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 933011329
		arg_179_1.duration_ = 8.9

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play933011330(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.75

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(933011329)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 30 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 30)

				if (30 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 30)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011329", "story_v_side_old_933011.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011329", "story_v_side_old_933011.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_side_old_933011", "933011329", "story_v_side_old_933011.awb")

						arg_179_1:RecordAudio("933011329", var_182_6)
						arg_179_1:RecordAudio("933011329", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011329", "story_v_side_old_933011.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011329", "story_v_side_old_933011.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play933011330 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 933011330
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play933011331(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.125

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(933011330).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 5 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 5)

				if (5 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 5)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play933011331 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 933011331
		arg_187_1.duration_ = 2.67

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play933011332(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.25

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(933011331)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 10 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 10)

				if (10 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 10)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011331", "story_v_side_old_933011.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011331", "story_v_side_old_933011.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_side_old_933011", "933011331", "story_v_side_old_933011.awb")

						arg_187_1:RecordAudio("933011331", var_190_6)
						arg_187_1:RecordAudio("933011331", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011331", "story_v_side_old_933011.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011331", "story_v_side_old_933011.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play933011332 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 933011332
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play933011333(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0.1 < arg_191_1.time_ and arg_191_1.time_ <= 0.1 + arg_194_0 then
				arg_191_1:AudioAction("play", "effect", "se_story_148", "se_story_148_soda_can_shake", "")
			end

			local var_194_1 = 0
			local var_194_2 = 0.925

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(933011332).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 37 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 37)

				if (37 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 37)) > 0 and var_194_2 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_6 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_6 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_6

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_6 and arg_191_1.time_ < var_194_1 + var_194_6 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play933011333 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 933011333
		arg_195_1.duration_ = 10.53

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play933011334(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if arg_195_1.bgs_.SP93301a == nil then
				local var_198_0 = Object.Instantiate(arg_195_1.paintGo_)

				var_198_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SP93301a")
				var_198_0.name = "SP93301a"
				var_198_0.transform.parent = arg_195_1.stage_.transform
				var_198_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.bgs_.SP93301a = var_198_0
			end

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= 2 + arg_198_0 then
				local var_198_1 = arg_195_1.bgs_.SP93301a

				arg_195_1.bgs_.SP93301a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_198_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_198_2 = var_198_1:GetComponent("SpriteRenderer")

				if var_198_2 and var_198_2.sprite then
					local var_198_3 = 2 * (var_198_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_198_1.transform.localScale = Vector3.New(var_198_3 / var_198_2.sprite.bounds.size.y < var_198_3 * manager.ui.mainCameraCom_.aspect / var_198_2.sprite.bounds.size.x and var_198_3 * manager.ui.mainCameraCom_.aspect / var_198_2.sprite.bounds.size.x or var_198_3 / var_198_2.sprite.bounds.size.y, var_198_3 / var_198_2.sprite.bounds.size.y < var_198_3 * manager.ui.mainCameraCom_.aspect / var_198_2.sprite.bounds.size.x and var_198_3 * manager.ui.mainCameraCom_.aspect / var_198_2.sprite.bounds.size.x or var_198_3 / var_198_2.sprite.bounds.size.y, 0)
				end

				for iter_198_0, iter_198_1 in pairs(arg_195_1.bgs_) do
					if iter_198_0 ~= "SP93301a" then
						iter_198_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_198_4 = 4

			if 4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.allBtn_.enabled = false
			end

			if arg_195_1.time_ >= var_198_4 + 0.3 and arg_195_1.time_ < var_198_4 + 0.3 + arg_198_0 then
				arg_195_1.allBtn_.enabled = true
			end

			local var_198_5 = 0

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_6 = 2

			if var_198_5 <= arg_195_1.time_ and arg_195_1.time_ < var_198_5 + var_198_6 then
				local var_198_7 = Color.New(0, 0, 0)

				var_198_7.a = Mathf.Lerp(0, 1, (arg_195_1.time_ - var_198_5) / var_198_6)
				arg_195_1.mask_.color = var_198_7
			end

			if arg_195_1.time_ >= var_198_5 + var_198_6 and arg_195_1.time_ < var_198_5 + var_198_6 + arg_198_0 then
				local var_198_8 = Color.New(0, 0, 0)

				var_198_8.a = 1
				arg_195_1.mask_.color = var_198_8
			end

			local var_198_9 = 2

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_10 = 2

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_10 then
				local var_198_11 = Color.New(0, 0, 0)

				var_198_11.a = Mathf.Lerp(1, 0, (arg_195_1.time_ - var_198_9) / var_198_10)
				arg_195_1.mask_.color = var_198_11
			end

			if arg_195_1.time_ >= var_198_9 + var_198_10 and arg_195_1.time_ < var_198_9 + var_198_10 + arg_198_0 then
				local var_198_12 = Color.New(0, 0, 0)

				arg_195_1.mask_.enabled = false
				var_198_12.a = 0
				arg_195_1.mask_.color = var_198_12
			end

			local var_198_13 = arg_195_1.bgs_.SP93301a.transform

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= 2 + arg_198_0 then
				arg_195_1.var_.moveOldPosSP93301a = var_198_13.localPosition
			end

			local var_198_14 = 5

			if 2 <= arg_195_1.time_ and arg_195_1.time_ < 2 + var_198_14 then
				var_198_13.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPosSP93301a, Vector3.New(-2, 0, 0.5), (arg_195_1.time_ - 2) / var_198_14)
			end

			if arg_195_1.time_ >= 2 + var_198_14 and arg_195_1.time_ < 2 + var_198_14 + arg_198_0 then
				var_198_13.localPosition = Vector3.New(-2, 0, 0.5)
			end

			local var_198_15 = 4

			if 4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.allBtn_.enabled = false
			end

			if arg_195_1.time_ >= var_198_15 + 3 and arg_195_1.time_ < var_198_15 + 3 + arg_198_0 then
				arg_195_1.allBtn_.enabled = true
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_16 = 4
			local var_198_17 = 0.775

			if 4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_18 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_18:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_19 = arg_195_1:GetWordFromCfg(933011333)
				local var_198_20 = arg_195_1:FormatText(var_198_19.content)

				arg_195_1.text_.text = var_198_20

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_22 = 31 <= 0 and var_198_17 or var_198_17 * (utf8.len(var_198_20) / 31)

				if (31 <= 0 and var_198_17 or var_198_17 * (utf8.len(var_198_20) / 31)) > 0 and var_198_17 < var_198_22 then
					arg_195_1.talkMaxDuration = var_198_22
					var_198_16 = var_198_16 + 0.3

					if var_198_22 + var_198_16 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_16
					end
				end

				arg_195_1.text_.text = var_198_20
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011333", "story_v_side_old_933011.awb") ~= 0 then
					local var_198_23 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011333", "story_v_side_old_933011.awb") / 1000

					if var_198_23 + var_198_16 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_16
					end

					if var_198_19.prefab_name ~= "" and arg_195_1.actors_[var_198_19.prefab_name] ~= nil then
						local var_198_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_19.prefab_name].transform, "story_v_side_old_933011", "933011333", "story_v_side_old_933011.awb")

						arg_195_1:RecordAudio("933011333", var_198_24)
						arg_195_1:RecordAudio("933011333", var_198_24)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011333", "story_v_side_old_933011.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011333", "story_v_side_old_933011.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_25 = var_198_16 + 0.3
			local var_198_26 = math.max(var_198_17, arg_195_1.talkMaxDuration)

			if var_198_16 + 0.3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_25 + var_198_26 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_25) / var_198_26

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_25 + var_198_26 and arg_195_1.time_ < var_198_25 + var_198_26 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93301a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 5,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-2, 0, 0),
					endPos = Vector3.New(-2, 0, 0.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play933011334 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 933011334
		arg_201_1.duration_ = 11.23

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play933011335(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.175

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(933011334)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 47 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 47)

				if (47 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 47)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011334", "story_v_side_old_933011.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011334", "story_v_side_old_933011.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_side_old_933011", "933011334", "story_v_side_old_933011.awb")

						arg_201_1:RecordAudio("933011334", var_204_6)
						arg_201_1:RecordAudio("933011334", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011334", "story_v_side_old_933011.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011334", "story_v_side_old_933011.awb")
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
	Play933011335 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 933011335
		arg_205_1.duration_ = 7.2

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play933011336(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.9

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(933011335)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 36 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 36)

				if (36 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 36)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011335", "story_v_side_old_933011.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011335", "story_v_side_old_933011.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_side_old_933011", "933011335", "story_v_side_old_933011.awb")

						arg_205_1:RecordAudio("933011335", var_208_6)
						arg_205_1:RecordAudio("933011335", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011335", "story_v_side_old_933011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011335", "story_v_side_old_933011.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play933011336 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 933011336
		arg_209_1.duration_ = 11.23

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play933011337(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.25

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:GetWordFromCfg(933011336)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 50 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 50)

				if (50 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 50)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011336", "story_v_side_old_933011.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011336", "story_v_side_old_933011.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_side_old_933011", "933011336", "story_v_side_old_933011.awb")

						arg_209_1:RecordAudio("933011336", var_212_6)
						arg_209_1:RecordAudio("933011336", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011336", "story_v_side_old_933011.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011336", "story_v_side_old_933011.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play933011337 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 933011337
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play933011338(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.775

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(933011337).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 31 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 31)

				if (31 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 31)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play933011338 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 933011338
		arg_217_1.duration_ = 7.4

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play933011339(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.725

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(933011338)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 29 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 29)

				if (29 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 29)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011338", "story_v_side_old_933011.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011338", "story_v_side_old_933011.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_side_old_933011", "933011338", "story_v_side_old_933011.awb")

						arg_217_1:RecordAudio("933011338", var_220_6)
						arg_217_1:RecordAudio("933011338", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011338", "story_v_side_old_933011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011338", "story_v_side_old_933011.awb")
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
	Play933011339 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 933011339
		arg_221_1.duration_ = 14.5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play933011340(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1.625

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(933011339)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 65 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 65)

				if (65 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 65)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011339", "story_v_side_old_933011.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011339", "story_v_side_old_933011.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_side_old_933011", "933011339", "story_v_side_old_933011.awb")

						arg_221_1:RecordAudio("933011339", var_224_6)
						arg_221_1:RecordAudio("933011339", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011339", "story_v_side_old_933011.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011339", "story_v_side_old_933011.awb")
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
	Play933011340 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 933011340
		arg_225_1.duration_ = 10.6

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play933011341(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.125

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:GetWordFromCfg(933011340)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 45 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 45)

				if (45 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 45)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011340", "story_v_side_old_933011.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011340", "story_v_side_old_933011.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_side_old_933011", "933011340", "story_v_side_old_933011.awb")

						arg_225_1:RecordAudio("933011340", var_228_6)
						arg_225_1:RecordAudio("933011340", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011340", "story_v_side_old_933011.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011340", "story_v_side_old_933011.awb")
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
	Play933011341 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 933011341
		arg_229_1.duration_ = 7.9

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play933011342(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.575

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(933011341)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 23 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 23)

				if (23 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 23)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011341", "story_v_side_old_933011.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011341", "story_v_side_old_933011.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_side_old_933011", "933011341", "story_v_side_old_933011.awb")

						arg_229_1:RecordAudio("933011341", var_232_6)
						arg_229_1:RecordAudio("933011341", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011341", "story_v_side_old_933011.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011341", "story_v_side_old_933011.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play933011342 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 933011342
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play933011343(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.375

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(933011342).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 15 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 15)

				if (15 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 15)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play933011343 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 933011343
		arg_237_1.duration_ = 1.03

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play933011344(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.1

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:GetWordFromCfg(933011343)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 4 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 4)

				if (4 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 4)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011343", "story_v_side_old_933011.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011343", "story_v_side_old_933011.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_side_old_933011", "933011343", "story_v_side_old_933011.awb")

						arg_237_1:RecordAudio("933011343", var_240_6)
						arg_237_1:RecordAudio("933011343", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011343", "story_v_side_old_933011.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011343", "story_v_side_old_933011.awb")
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
	Play933011344 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 933011344
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play933011345(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.65

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(933011344).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 26 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 26)

				if (26 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 26)) > 0 and var_244_0 < var_244_3 then
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
	Play933011345 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 933011345
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play933011346(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.925

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(933011345).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 37 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 37)

				if (37 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 37)) > 0 and var_248_0 < var_248_3 then
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
	Play933011346 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 933011346
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play933011347(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 1.3

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
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

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(933011346).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 52 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 52)

				if (52 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 52)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play933011347 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 933011347
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play933011348(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.25

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(933011347).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 50 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 50)

				if (50 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 50)) > 0 and var_256_0 < var_256_3 then
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
	Play933011348 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 933011348
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play933011349(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.825

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
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

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(933011348).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 33 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 33)

				if (33 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 33)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play933011349 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 933011349
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play933011350(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.875

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(933011349).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 35 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 35)

				if (35 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 35)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play933011350 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 933011350
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play933011351(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.05

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
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

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(933011350).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 42 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 42)

				if (42 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 42)) > 0 and var_268_0 < var_268_3 then
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
	Play933011351 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 933011351
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play933011352(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0.866666666666667 < arg_269_1.time_ and arg_269_1.time_ <= 0.866666666666667 + arg_272_0 then
				arg_269_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_272_1 = 0
			local var_272_2 = 1.525

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(933011351).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 61 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 61)

				if (61 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 61)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_6 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_6 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_6

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_6 and arg_269_1.time_ < var_272_1 + var_272_6 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play933011352 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 933011352
		arg_273_1.duration_ = 8.97

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play933011353(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if arg_273_1.bgs_.SP93301b == nil then
				local var_276_0 = Object.Instantiate(arg_273_1.paintGo_)

				var_276_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SP93301b")
				var_276_0.name = "SP93301b"
				var_276_0.transform.parent = arg_273_1.stage_.transform
				var_276_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.bgs_.SP93301b = var_276_0
			end

			if 2 < arg_273_1.time_ and arg_273_1.time_ <= 2 + arg_276_0 then
				local var_276_1 = arg_273_1.bgs_.SP93301b

				arg_273_1.bgs_.SP93301b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_276_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_2 = var_276_1:GetComponent("SpriteRenderer")

				if var_276_2 and var_276_2.sprite then
					local var_276_3 = 2 * (var_276_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_276_1.transform.localScale = Vector3.New(var_276_3 / var_276_2.sprite.bounds.size.y < var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x and var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x or var_276_3 / var_276_2.sprite.bounds.size.y, var_276_3 / var_276_2.sprite.bounds.size.y < var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x and var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x or var_276_3 / var_276_2.sprite.bounds.size.y, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "SP93301b" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_276_4 = 4

			if 4 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.allBtn_.enabled = false
			end

			if arg_273_1.time_ >= var_276_4 + 0.3 and arg_273_1.time_ < var_276_4 + 0.3 + arg_276_0 then
				arg_273_1.allBtn_.enabled = true
			end

			local var_276_5 = 0

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_6 = 2

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_6 then
				local var_276_7 = Color.New(0, 0, 0)

				var_276_7.a = Mathf.Lerp(0, 1, (arg_273_1.time_ - var_276_5) / var_276_6)
				arg_273_1.mask_.color = var_276_7
			end

			if arg_273_1.time_ >= var_276_5 + var_276_6 and arg_273_1.time_ < var_276_5 + var_276_6 + arg_276_0 then
				local var_276_8 = Color.New(0, 0, 0)

				var_276_8.a = 1
				arg_273_1.mask_.color = var_276_8
			end

			local var_276_9 = 2

			if 2 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_10 = 2

			if var_276_9 <= arg_273_1.time_ and arg_273_1.time_ < var_276_9 + var_276_10 then
				local var_276_11 = Color.New(0, 0, 0)

				var_276_11.a = Mathf.Lerp(1, 0, (arg_273_1.time_ - var_276_9) / var_276_10)
				arg_273_1.mask_.color = var_276_11
			end

			if arg_273_1.time_ >= var_276_9 + var_276_10 and arg_273_1.time_ < var_276_9 + var_276_10 + arg_276_0 then
				local var_276_12 = Color.New(0, 0, 0)

				arg_273_1.mask_.enabled = false
				var_276_12.a = 0
				arg_273_1.mask_.color = var_276_12
			end

			local var_276_13 = arg_273_1.bgs_.SP93301b.transform

			if 2 < arg_273_1.time_ and arg_273_1.time_ <= 2 + arg_276_0 then
				arg_273_1.var_.moveOldPosSP93301b = var_276_13.localPosition
			end

			local var_276_14 = 3.53333333333333

			if 2 <= arg_273_1.time_ and arg_273_1.time_ < 2 + var_276_14 then
				var_276_13.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPosSP93301b, Vector3.New(0, 1, 10), (arg_273_1.time_ - 2) / var_276_14)
			end

			if arg_273_1.time_ >= 2 + var_276_14 and arg_273_1.time_ < 2 + var_276_14 + arg_276_0 then
				var_276_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_276_15 = 4

			if 4 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.allBtn_.enabled = false
			end

			if arg_273_1.time_ >= var_276_15 + 1.53333333333333 and arg_273_1.time_ < var_276_15 + 1.53333333333333 + arg_276_0 then
				arg_273_1.allBtn_.enabled = true
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_16 = 4
			local var_276_17 = 0.475

			if 4 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_18 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_18:setOnUpdate(LuaHelper.FloatAction(function(arg_277_0)
					arg_273_1.dialogCg_.alpha = arg_277_0
				end))
				var_276_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_19 = arg_273_1:GetWordFromCfg(933011352)
				local var_276_20 = arg_273_1:FormatText(var_276_19.content)

				arg_273_1.text_.text = var_276_20

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_22 = 19 <= 0 and var_276_17 or var_276_17 * (utf8.len(var_276_20) / 19)

				if (19 <= 0 and var_276_17 or var_276_17 * (utf8.len(var_276_20) / 19)) > 0 and var_276_17 < var_276_22 then
					arg_273_1.talkMaxDuration = var_276_22
					var_276_16 = var_276_16 + 0.3

					if var_276_22 + var_276_16 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_22 + var_276_16
					end
				end

				arg_273_1.text_.text = var_276_20
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011352", "story_v_side_old_933011.awb") ~= 0 then
					local var_276_23 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011352", "story_v_side_old_933011.awb") / 1000

					if var_276_23 + var_276_16 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_23 + var_276_16
					end

					if var_276_19.prefab_name ~= "" and arg_273_1.actors_[var_276_19.prefab_name] ~= nil then
						local var_276_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_19.prefab_name].transform, "story_v_side_old_933011", "933011352", "story_v_side_old_933011.awb")

						arg_273_1:RecordAudio("933011352", var_276_24)
						arg_273_1:RecordAudio("933011352", var_276_24)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011352", "story_v_side_old_933011.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011352", "story_v_side_old_933011.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_25 = var_276_16 + 0.3
			local var_276_26 = math.max(var_276_17, arg_273_1.talkMaxDuration)

			if var_276_16 + 0.3 <= arg_273_1.time_ and arg_273_1.time_ < var_276_25 + var_276_26 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_25) / var_276_26

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_25 + var_276_26 and arg_273_1.time_ < var_276_25 + var_276_26 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93301b",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.53333333333333,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play933011353 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 933011353
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play933011354(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.925

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(933011353).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 37 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 37)

				if (37 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 37)) > 0 and var_282_0 < var_282_3 then
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
	Play933011354 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 933011354
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play933011355(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.225

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(933011354).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 9 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 9)

				if (9 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 9)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play933011355 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 933011355
		arg_287_1.duration_ = 3.07

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play933011356(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.275

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(933011355)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 11 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 11)

				if (11 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 11)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011355", "story_v_side_old_933011.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011355", "story_v_side_old_933011.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_side_old_933011", "933011355", "story_v_side_old_933011.awb")

						arg_287_1:RecordAudio("933011355", var_290_6)
						arg_287_1:RecordAudio("933011355", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011355", "story_v_side_old_933011.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011355", "story_v_side_old_933011.awb")
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
	Play933011356 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 933011356
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play933011357(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.975

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(933011356).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 39 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 39)

				if (39 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 39)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play933011357 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 933011357
		arg_295_1.duration_ = 9

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play933011358(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if arg_295_1.bgs_.ST15a == nil then
				local var_298_0 = Object.Instantiate(arg_295_1.paintGo_)

				var_298_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15a")
				var_298_0.name = "ST15a"
				var_298_0.transform.parent = arg_295_1.stage_.transform
				var_298_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_295_1.bgs_.ST15a = var_298_0
			end

			if 2 < arg_295_1.time_ and arg_295_1.time_ <= 2 + arg_298_0 then
				local var_298_1 = arg_295_1.bgs_.ST15a

				arg_295_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_298_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_298_2 = var_298_1:GetComponent("SpriteRenderer")

				if var_298_2 and var_298_2.sprite then
					local var_298_3 = 2 * (var_298_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_298_1.transform.localScale = Vector3.New(var_298_3 / var_298_2.sprite.bounds.size.y < var_298_3 * manager.ui.mainCameraCom_.aspect / var_298_2.sprite.bounds.size.x and var_298_3 * manager.ui.mainCameraCom_.aspect / var_298_2.sprite.bounds.size.x or var_298_3 / var_298_2.sprite.bounds.size.y, var_298_3 / var_298_2.sprite.bounds.size.y < var_298_3 * manager.ui.mainCameraCom_.aspect / var_298_2.sprite.bounds.size.x and var_298_3 * manager.ui.mainCameraCom_.aspect / var_298_2.sprite.bounds.size.x or var_298_3 / var_298_2.sprite.bounds.size.y, 0)
				end

				for iter_298_0, iter_298_1 in pairs(arg_295_1.bgs_) do
					if iter_298_0 ~= "ST15a" then
						iter_298_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_298_4 = 3.999999999999

			if 3.999999999999 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.allBtn_.enabled = false
			end

			if arg_295_1.time_ >= var_298_4 + 0.3 and arg_295_1.time_ < var_298_4 + 0.3 + arg_298_0 then
				arg_295_1.allBtn_.enabled = true
			end

			local var_298_5 = 0

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_5 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_6 = 2

			if var_298_5 <= arg_295_1.time_ and arg_295_1.time_ < var_298_5 + var_298_6 then
				local var_298_7 = Color.New(0, 0, 0)

				var_298_7.a = Mathf.Lerp(0, 1, (arg_295_1.time_ - var_298_5) / var_298_6)
				arg_295_1.mask_.color = var_298_7
			end

			if arg_295_1.time_ >= var_298_5 + var_298_6 and arg_295_1.time_ < var_298_5 + var_298_6 + arg_298_0 then
				local var_298_8 = Color.New(0, 0, 0)

				var_298_8.a = 1
				arg_295_1.mask_.color = var_298_8
			end

			local var_298_9 = 2

			if 2 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_10 = 2

			if var_298_9 <= arg_295_1.time_ and arg_295_1.time_ < var_298_9 + var_298_10 then
				local var_298_11 = Color.New(0, 0, 0)

				var_298_11.a = Mathf.Lerp(1, 0, (arg_295_1.time_ - var_298_9) / var_298_10)
				arg_295_1.mask_.color = var_298_11
			end

			if arg_295_1.time_ >= var_298_9 + var_298_10 and arg_295_1.time_ < var_298_9 + var_298_10 + arg_298_0 then
				local var_298_12 = Color.New(0, 0, 0)

				arg_295_1.mask_.enabled = false
				var_298_12.a = 0
				arg_295_1.mask_.color = var_298_12
			end

			if 0.166666666666667 < arg_295_1.time_ and arg_295_1.time_ <= 0.166666666666667 + arg_298_0 then
				arg_295_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 1.66666666666667 < arg_295_1.time_ and arg_295_1.time_ <= 1.66666666666667 + arg_298_0 then
				arg_295_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachnightloop", "")
			end

			if arg_295_1.frameCnt_ <= 1 then
				arg_295_1.dialog_:SetActive(false)
			end

			local var_298_15 = 3.999999999999
			local var_298_16 = 0.675

			if 3.999999999999 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0

				arg_295_1.dialog_:SetActive(true)

				arg_295_1.dialogCg_.alpha = 0

				local var_298_17 = LeanTween.value(arg_295_1.dialog_, 0, 1, 0.3)

				var_298_17:setOnUpdate(LuaHelper.FloatAction(function(arg_299_0)
					arg_295_1.dialogCg_.alpha = arg_299_0
				end))
				var_298_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_295_1.dialog_)
					var_298_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_295_1.duration_ = arg_295_1.duration_ + 0.3

				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_18 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(933011357).content)

				arg_295_1.text_.text = var_298_18

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_20 = 27 <= 0 and var_298_16 or var_298_16 * (utf8.len(var_298_18) / 27)

				if (27 <= 0 and var_298_16 or var_298_16 * (utf8.len(var_298_18) / 27)) > 0 and var_298_16 < var_298_20 then
					arg_295_1.talkMaxDuration = var_298_20
					var_298_15 = var_298_15 + 0.3

					if var_298_20 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_20 + var_298_15
					end
				end

				arg_295_1.text_.text = var_298_18
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_21 = var_298_15 + 0.3
			local var_298_22 = math.max(var_298_16, arg_295_1.talkMaxDuration)

			if var_298_15 + 0.3 <= arg_295_1.time_ and arg_295_1.time_ < var_298_21 + var_298_22 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_21) / var_298_22

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_21 + var_298_22 and arg_295_1.time_ < var_298_21 + var_298_22 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play933011358 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 933011358
		arg_301_1.duration_ = 4.5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play933011359(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10102ui_story = arg_301_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10102ui_story"].transform.position).z)
				arg_301_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["10102ui_story"].transform.localEulerAngles = arg_301_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_301_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10102ui_story"].transform.position).z)
				arg_301_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["10102ui_story"].transform.localEulerAngles = arg_301_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["10102ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect10102ui_story == nil then
				arg_301_1.var_.characterEffect10102ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect10102ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect10102ui_story then
				arg_301_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_304_4 = 0
			local var_304_5 = 0.475

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(933011358)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 19 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 19)

				if (19 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 19)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011358", "story_v_side_old_933011.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011358", "story_v_side_old_933011.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_side_old_933011", "933011358", "story_v_side_old_933011.awb")

						arg_301_1:RecordAudio("933011358", var_304_11)
						arg_301_1:RecordAudio("933011358", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011358", "story_v_side_old_933011.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011358", "story_v_side_old_933011.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play933011359 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 933011359
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play933011360(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos10102ui_story = arg_305_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).z)
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles = arg_305_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["10102ui_story"].transform.position).z)
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["10102ui_story"].transform.localEulerAngles = arg_305_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["10102ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect10102ui_story == nil then
				arg_305_1.var_.characterEffect10102ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect10102ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_305_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_2)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect10102ui_story then
				arg_305_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_305_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_308_3 = 0
			local var_308_4 = 0.7

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_3 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_5 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(933011359).content)

				arg_305_1.text_.text = var_308_5

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_7 = 28 <= 0 and var_308_4 or var_308_4 * (utf8.len(var_308_5) / 28)

				if (28 <= 0 and var_308_4 or var_308_4 * (utf8.len(var_308_5) / 28)) > 0 and var_308_4 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_3 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_3
					end
				end

				arg_305_1.text_.text = var_308_5
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_4, arg_305_1.talkMaxDuration)

			if var_308_3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_3 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_3) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_3 + var_308_8 and arg_305_1.time_ < var_308_3 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play933011360 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 933011360
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play933011361(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.55

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(933011360).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 22 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 22)

				if (22 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 22)) > 0 and var_312_0 < var_312_3 then
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
	Play933011361 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 933011361
		arg_313_1.duration_ = 3

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play933011362(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10102ui_story = arg_313_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).z)
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles = arg_313_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_313_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10102ui_story"].transform.position).z)
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["10102ui_story"].transform.localEulerAngles = arg_313_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["10102ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect10102ui_story == nil then
				arg_313_1.var_.characterEffect10102ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect10102ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect10102ui_story then
				arg_313_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_316_4 = 0
			local var_316_5 = 0.225

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(933011361)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 9 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 9)

				if (9 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 9)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011361", "story_v_side_old_933011.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011361", "story_v_side_old_933011.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_side_old_933011", "933011361", "story_v_side_old_933011.awb")

						arg_313_1:RecordAudio("933011361", var_316_11)
						arg_313_1:RecordAudio("933011361", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011361", "story_v_side_old_933011.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011361", "story_v_side_old_933011.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play933011362 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 933011362
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play933011363(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["10102ui_story"]) and arg_317_1.var_.characterEffect10102ui_story == nil then
				arg_317_1.var_.characterEffect10102ui_story = arg_317_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["10102ui_story"]) then
				if arg_317_1.var_.characterEffect10102ui_story and not isNil(arg_317_1.actors_["10102ui_story"]) then
					arg_317_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_317_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["10102ui_story"]) and arg_317_1.var_.characterEffect10102ui_story then
				arg_317_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_317_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 0.6

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(933011362).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 24 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 24)

				if (24 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 24)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play933011363 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 933011363
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play933011364(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10102ui_story = arg_321_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).z)
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles = arg_321_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).z)
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles = arg_321_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_324_1 = 0
			local var_324_2 = 0.725

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(933011363).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 29 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 29)

				if (29 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 29)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_6 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_6 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_6

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_6 and arg_321_1.time_ < var_324_1 + var_324_6 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play933011364 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 933011364
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play933011365(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_328_0 = 0
			local var_328_1 = 0.275

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_2 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(933011364).content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 11 <= 0 and var_328_1 or var_328_1 * (utf8.len(var_328_2) / 11)

				if (11 <= 0 and var_328_1 or var_328_1 * (utf8.len(var_328_2) / 11)) > 0 and var_328_1 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_5 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_5 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_5

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_5 and arg_325_1.time_ < var_328_0 + var_328_5 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play933011365 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 933011365
		arg_329_1.duration_ = 4.2

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play933011366(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos10102ui_story = arg_329_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).z)
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles = arg_329_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_329_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).z)
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles = arg_329_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["10102ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect10102ui_story == nil then
				arg_329_1.var_.characterEffect10102ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect10102ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect10102ui_story then
				arg_329_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			local var_332_4 = 0
			local var_332_5 = 0.25

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(933011365)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 10 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 10)

				if (10 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 10)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011365", "story_v_side_old_933011.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011365", "story_v_side_old_933011.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_side_old_933011", "933011365", "story_v_side_old_933011.awb")

						arg_329_1:RecordAudio("933011365", var_332_11)
						arg_329_1:RecordAudio("933011365", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011365", "story_v_side_old_933011.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011365", "story_v_side_old_933011.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_12 and arg_329_1.time_ < var_332_4 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play933011366 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 933011366
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play933011367(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos10102ui_story = arg_333_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10102ui_story"].transform.position).z)
				arg_333_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["10102ui_story"].transform.localEulerAngles = arg_333_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_333_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10102ui_story"].transform.position).z)
				arg_333_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["10102ui_story"].transform.localEulerAngles = arg_333_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["10102ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect10102ui_story == nil then
				arg_333_1.var_.characterEffect10102ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect10102ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_333_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_2)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect10102ui_story then
				arg_333_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_333_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_336_3 = 0
			local var_336_4 = 1.075

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_3 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_5 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(933011366).content)

				arg_333_1.text_.text = var_336_5

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_7 = 43 <= 0 and var_336_4 or var_336_4 * (utf8.len(var_336_5) / 43)

				if (43 <= 0 and var_336_4 or var_336_4 * (utf8.len(var_336_5) / 43)) > 0 and var_336_4 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_3 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_3
					end
				end

				arg_333_1.text_.text = var_336_5
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_8 = math.max(var_336_4, arg_333_1.talkMaxDuration)

			if var_336_3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_3 + var_336_8 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_3) / var_336_8

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_3 + var_336_8 and arg_333_1.time_ < var_336_3 + var_336_8 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play933011367 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 933011367
		arg_337_1.duration_ = 10.97

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play933011368(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10102ui_story = arg_337_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).z)
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles = arg_337_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_337_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10102ui_story"].transform.position).z)
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["10102ui_story"].transform.localEulerAngles = arg_337_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["10102ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect10102ui_story == nil then
				arg_337_1.var_.characterEffect10102ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.characterEffect10102ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect10102ui_story then
				arg_337_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action449")
			end

			local var_340_4 = 0
			local var_340_5 = 0.55

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:GetWordFromCfg(933011367)
				local var_340_7 = arg_337_1:FormatText(var_340_6.content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 22 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 22)

				if (22 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 22)) > 0 and var_340_5 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011367", "story_v_side_old_933011.awb") ~= 0 then
					local var_340_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011367", "story_v_side_old_933011.awb") / 1000

					if var_340_10 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_4
					end

					if var_340_6.prefab_name ~= "" and arg_337_1.actors_[var_340_6.prefab_name] ~= nil then
						local var_340_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_6.prefab_name].transform, "story_v_side_old_933011", "933011367", "story_v_side_old_933011.awb")

						arg_337_1:RecordAudio("933011367", var_340_11)
						arg_337_1:RecordAudio("933011367", var_340_11)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011367", "story_v_side_old_933011.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011367", "story_v_side_old_933011.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_12 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_12 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_12

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_12 and arg_337_1.time_ < var_340_4 + var_340_12 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play933011368 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 933011368
		arg_341_1.duration_ = 1

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"

			SetActive(arg_341_1.choicesGo_, true)

			for iter_342_0, iter_342_1 in ipairs(arg_341_1.choices_) do
				SetActive(iter_342_1.go, iter_342_0 <= 2)
			end

			arg_341_1.choices_[1].txt.text = arg_341_1:FormatText(StoryChoiceCfg[1582].name)
			arg_341_1.choices_[2].txt.text = arg_341_1:FormatText(StoryChoiceCfg[1583].name)
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play933011369(arg_341_1)
			end

			if arg_343_0 == 2 then
				arg_341_0:Play933011369(arg_341_1)
			end

			arg_341_1:RecordChoiceLog(933011368, 1582, 1583)
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos10102ui_story = arg_341_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["10102ui_story"].transform.position).z)
				arg_341_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["10102ui_story"].transform.localEulerAngles = arg_341_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_341_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["10102ui_story"].transform.position).z)
				arg_341_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["10102ui_story"].transform.localEulerAngles = arg_341_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["10102ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect10102ui_story == nil then
				arg_341_1.var_.characterEffect10102ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect10102ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_341_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_2)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect10102ui_story then
				arg_341_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_341_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_344_3 = 0

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 then
				arg_341_1.allBtn_.enabled = false
			end

			if arg_341_1.time_ >= var_344_3 + 0.5 and arg_341_1.time_ < var_344_3 + 0.5 + arg_344_0 then
				arg_341_1.allBtn_.enabled = true
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play933011369 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 933011369
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play933011370(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.2

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_1 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(933011369).content)

				arg_345_1.text_.text = var_348_1

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_3 = 8 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 8)

				if (8 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 8)) > 0 and var_348_0 < var_348_3 then
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
	Play933011370 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 933011370
		arg_349_1.duration_ = 9

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play933011371(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 1.96599999815226 < arg_349_1.time_ and arg_349_1.time_ <= 1.96599999815226 + arg_352_0 then
				arg_349_1.var_.moveOldPos10102ui_story = arg_349_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 1.96599999815226 <= arg_349_1.time_ and arg_349_1.time_ < 1.96599999815226 + var_352_0 then
				arg_349_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 1.96599999815226) / var_352_0)
				arg_349_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).z)
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles = arg_349_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 1.96599999815226 + var_352_0 and arg_349_1.time_ < 1.96599999815226 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).z)
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles = arg_349_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_352_1 = 0

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.mask_.enabled = true
				arg_349_1.mask_.raycastTarget = true

				arg_349_1:SetGaussion(false)
			end

			local var_352_2 = 2

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = Color.New(0, 0, 0)

				var_352_3.a = Mathf.Lerp(0, 1, (arg_349_1.time_ - var_352_1) / var_352_2)
				arg_349_1.mask_.color = var_352_3
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 then
				local var_352_4 = Color.New(0, 0, 0)

				var_352_4.a = 1
				arg_349_1.mask_.color = var_352_4
			end

			local var_352_5 = 2

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1.mask_.enabled = true
				arg_349_1.mask_.raycastTarget = true

				arg_349_1:SetGaussion(false)
			end

			local var_352_6 = 2

			if var_352_5 <= arg_349_1.time_ and arg_349_1.time_ < var_352_5 + var_352_6 then
				local var_352_7 = Color.New(0, 0, 0)

				var_352_7.a = Mathf.Lerp(1, 0, (arg_349_1.time_ - var_352_5) / var_352_6)
				arg_349_1.mask_.color = var_352_7
			end

			if arg_349_1.time_ >= var_352_5 + var_352_6 and arg_349_1.time_ < var_352_5 + var_352_6 + arg_352_0 then
				local var_352_8 = Color.New(0, 0, 0)

				arg_349_1.mask_.enabled = false
				var_352_8.a = 0
				arg_349_1.mask_.color = var_352_8
			end

			local var_352_9 = "STblack"

			if arg_349_1.bgs_.STblack == nil then
				local var_352_10 = Object.Instantiate(arg_349_1.paintGo_)

				var_352_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_352_9)
				var_352_10.name = var_352_9
				var_352_10.transform.parent = arg_349_1.stage_.transform
				var_352_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.bgs_[var_352_9] = var_352_10
			end

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= 2 + arg_352_0 then
				local var_352_11 = arg_349_1.bgs_.STblack

				arg_349_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_352_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_352_12 = var_352_11:GetComponent("SpriteRenderer")

				if var_352_12 and var_352_12.sprite then
					local var_352_13 = 2 * (var_352_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_352_11.transform.localScale = Vector3.New(var_352_13 / var_352_12.sprite.bounds.size.y < var_352_13 * manager.ui.mainCameraCom_.aspect / var_352_12.sprite.bounds.size.x and var_352_13 * manager.ui.mainCameraCom_.aspect / var_352_12.sprite.bounds.size.x or var_352_13 / var_352_12.sprite.bounds.size.y, var_352_13 / var_352_12.sprite.bounds.size.y < var_352_13 * manager.ui.mainCameraCom_.aspect / var_352_12.sprite.bounds.size.x and var_352_13 * manager.ui.mainCameraCom_.aspect / var_352_12.sprite.bounds.size.x or var_352_13 / var_352_12.sprite.bounds.size.y, 0)
				end

				for iter_352_0, iter_352_1 in pairs(arg_349_1.bgs_) do
					if iter_352_0 ~= "STblack" then
						iter_352_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.2 < arg_349_1.time_ and arg_349_1.time_ <= 0.2 + arg_352_0 then
				arg_349_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_352_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_349_1.bgmTxt_.text ~= var_352_16 and arg_349_1.bgmTxt_.text ~= "" then
						if arg_349_1.bgmTxt2_.text ~= "" then
							arg_349_1.bgmTxt_.text = arg_349_1.bgmTxt2_.text
						end

						arg_349_1.bgmTxt2_.text = var_352_16

						arg_349_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_349_1.bgmTxt_.text = var_352_16
						arg_349_1.bgmTxt2_.text = var_352_16
					end

					if arg_349_1.bgmTimer then
						arg_349_1.bgmTimer:Stop()

						arg_349_1.bgmTimer = nil
					end

					if arg_349_1.settingData.show_music_name == 1 then
						arg_349_1.musicController:SetSelectedState("show")
						arg_349_1.musicAnimator_:Play("open", 0, 0)

						if arg_349_1.settingData.music_time ~= 0 then
							arg_349_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_349_1.settingData.music_time), function()
								if arg_349_1 == nil or isNil(arg_349_1.bgmTxt_) then
									return
								end

								arg_349_1.musicController:SetSelectedState("hide")
								arg_349_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_352_17 = 4
			local var_352_18 = 0.675

			if 4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_17 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_19 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(933011370).content)

				arg_349_1.text_.text = var_352_19

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_21 = 27 <= 0 and var_352_18 or var_352_18 * (utf8.len(var_352_19) / 27)

				if (27 <= 0 and var_352_18 or var_352_18 * (utf8.len(var_352_19) / 27)) > 0 and var_352_18 < var_352_21 then
					arg_349_1.talkMaxDuration = var_352_21

					if var_352_21 + var_352_17 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_21 + var_352_17
					end
				end

				arg_349_1.text_.text = var_352_19
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_22 = math.max(var_352_18, arg_349_1.talkMaxDuration)

			if var_352_17 <= arg_349_1.time_ and arg_349_1.time_ < var_352_17 + var_352_22 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_17) / var_352_22

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_17 + var_352_22 and arg_349_1.time_ < var_352_17 + var_352_22 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play933011371 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 933011371
		arg_354_1.duration_ = 9

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play933011372(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if arg_354_1.bgs_.D02a == nil then
				local var_357_0 = Object.Instantiate(arg_354_1.paintGo_)

				var_357_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D02a")
				var_357_0.name = "D02a"
				var_357_0.transform.parent = arg_354_1.stage_.transform
				var_357_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_354_1.bgs_.D02a = var_357_0
			end

			if 2 < arg_354_1.time_ and arg_354_1.time_ <= 2 + arg_357_0 then
				local var_357_1 = arg_354_1.bgs_.D02a

				arg_354_1.bgs_.D02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_357_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_2 = var_357_1:GetComponent("SpriteRenderer")

				if var_357_2 and var_357_2.sprite then
					local var_357_3 = 2 * (var_357_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_357_1.transform.localScale = Vector3.New(var_357_3 / var_357_2.sprite.bounds.size.y < var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x and var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x or var_357_3 / var_357_2.sprite.bounds.size.y, var_357_3 / var_357_2.sprite.bounds.size.y < var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x and var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x or var_357_3 / var_357_2.sprite.bounds.size.y, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "D02a" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_357_4 = 4

			if 4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.allBtn_.enabled = false
			end

			if arg_354_1.time_ >= var_357_4 + 0.3 and arg_354_1.time_ < var_357_4 + 0.3 + arg_357_0 then
				arg_354_1.allBtn_.enabled = true
			end

			local var_357_5 = 0

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_6 = 2

			if var_357_5 <= arg_354_1.time_ and arg_354_1.time_ < var_357_5 + var_357_6 then
				local var_357_7 = Color.New(0, 0, 0)

				var_357_7.a = Mathf.Lerp(0, 1, (arg_354_1.time_ - var_357_5) / var_357_6)
				arg_354_1.mask_.color = var_357_7
			end

			if arg_354_1.time_ >= var_357_5 + var_357_6 and arg_354_1.time_ < var_357_5 + var_357_6 + arg_357_0 then
				local var_357_8 = Color.New(0, 0, 0)

				var_357_8.a = 1
				arg_354_1.mask_.color = var_357_8
			end

			local var_357_9 = 2

			if 2 < arg_354_1.time_ and arg_354_1.time_ <= var_357_9 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_10 = 2

			if var_357_9 <= arg_354_1.time_ and arg_354_1.time_ < var_357_9 + var_357_10 then
				local var_357_11 = Color.New(0, 0, 0)

				var_357_11.a = Mathf.Lerp(1, 0, (arg_354_1.time_ - var_357_9) / var_357_10)
				arg_354_1.mask_.color = var_357_11
			end

			if arg_354_1.time_ >= var_357_9 + var_357_10 and arg_354_1.time_ < var_357_9 + var_357_10 + arg_357_0 then
				local var_357_12 = Color.New(0, 0, 0)

				arg_354_1.mask_.enabled = false
				var_357_12.a = 0
				arg_354_1.mask_.color = var_357_12
			end

			if 0.166666666666667 < arg_354_1.time_ and arg_354_1.time_ <= 0.166666666666667 + arg_357_0 then
				arg_354_1:AudioAction("stop", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachnightloop", "")
			end

			if 1.6 < arg_354_1.time_ and arg_354_1.time_ <= 1.6 + arg_357_0 then
				arg_354_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 0.166666666666667 < arg_354_1.time_ and arg_354_1.time_ <= 0.166666666666667 + arg_357_0 then
				arg_354_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_357_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_354_1.bgmTxt_.text ~= var_357_17 and arg_354_1.bgmTxt_.text ~= "" then
						if arg_354_1.bgmTxt2_.text ~= "" then
							arg_354_1.bgmTxt_.text = arg_354_1.bgmTxt2_.text
						end

						arg_354_1.bgmTxt2_.text = var_357_17

						arg_354_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_354_1.bgmTxt_.text = var_357_17
						arg_354_1.bgmTxt2_.text = var_357_17
					end

					if arg_354_1.bgmTimer then
						arg_354_1.bgmTimer:Stop()

						arg_354_1.bgmTimer = nil
					end

					if arg_354_1.settingData.show_music_name == 1 then
						arg_354_1.musicController:SetSelectedState("show")
						arg_354_1.musicAnimator_:Play("open", 0, 0)

						if arg_354_1.settingData.music_time ~= 0 then
							arg_354_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_354_1.settingData.music_time), function()
								if arg_354_1 == nil or isNil(arg_354_1.bgmTxt_) then
									return
								end

								arg_354_1.musicController:SetSelectedState("hide")
								arg_354_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.6 < arg_354_1.time_ and arg_354_1.time_ <= 1.6 + arg_357_0 then
				arg_354_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_357_20 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_354_1.bgmTxt_.text ~= var_357_20 and arg_354_1.bgmTxt_.text ~= "" then
						if arg_354_1.bgmTxt2_.text ~= "" then
							arg_354_1.bgmTxt_.text = arg_354_1.bgmTxt2_.text
						end

						arg_354_1.bgmTxt2_.text = var_357_20

						arg_354_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_354_1.bgmTxt_.text = var_357_20
						arg_354_1.bgmTxt2_.text = var_357_20
					end

					if arg_354_1.bgmTimer then
						arg_354_1.bgmTimer:Stop()

						arg_354_1.bgmTimer = nil
					end

					if arg_354_1.settingData.show_music_name == 1 then
						arg_354_1.musicController:SetSelectedState("show")
						arg_354_1.musicAnimator_:Play("open", 0, 0)

						if arg_354_1.settingData.music_time ~= 0 then
							arg_354_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_354_1.settingData.music_time), function()
								if arg_354_1 == nil or isNil(arg_354_1.bgmTxt_) then
									return
								end

								arg_354_1.musicController:SetSelectedState("hide")
								arg_354_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_354_1.frameCnt_ <= 1 then
				arg_354_1.dialog_:SetActive(false)
			end

			local var_357_21 = 4
			local var_357_22 = 1.05

			if 4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_21 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				arg_354_1.dialog_:SetActive(true)

				arg_354_1.dialogCg_.alpha = 0

				local var_357_23 = LeanTween.value(arg_354_1.dialog_, 0, 1, 0.3)

				var_357_23:setOnUpdate(LuaHelper.FloatAction(function(arg_360_0)
					arg_354_1.dialogCg_.alpha = arg_360_0
				end))
				var_357_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_354_1.dialog_)
					var_357_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_354_1.duration_ = arg_354_1.duration_ + 0.3

				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_24 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(933011371).content)

				arg_354_1.text_.text = var_357_24

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_26 = 42 <= 0 and var_357_22 or var_357_22 * (utf8.len(var_357_24) / 42)

				if (42 <= 0 and var_357_22 or var_357_22 * (utf8.len(var_357_24) / 42)) > 0 and var_357_22 < var_357_26 then
					arg_354_1.talkMaxDuration = var_357_26
					var_357_21 = var_357_21 + 0.3

					if var_357_26 + var_357_21 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_26 + var_357_21
					end
				end

				arg_354_1.text_.text = var_357_24
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_27 = var_357_21 + 0.3
			local var_357_28 = math.max(var_357_22, arg_354_1.talkMaxDuration)

			if var_357_21 + 0.3 <= arg_354_1.time_ and arg_354_1.time_ < var_357_27 + var_357_28 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_27) / var_357_28

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_27 + var_357_28 and arg_354_1.time_ < var_357_27 + var_357_28 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play933011372 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 933011372
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play933011373(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.8

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, false)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_1 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(933011372).content)

				arg_362_1.text_.text = var_365_1

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_3 = 32 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_1) / 32)

				if (32 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_1) / 32)) > 0 and var_365_0 < var_365_3 then
					arg_362_1.talkMaxDuration = var_365_3

					if var_365_3 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_3 + 0
					end
				end

				arg_362_1.text_.text = var_365_1
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_4 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_4 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_4

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_4 and arg_362_1.time_ < 0 + var_365_4 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play933011373 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 933011373
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play933011374(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 1.45

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_1 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(933011373).content)

				arg_366_1.text_.text = var_369_1

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_3 = 58 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 58)

				if (58 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 58)) > 0 and var_369_0 < var_369_3 then
					arg_366_1.talkMaxDuration = var_369_3

					if var_369_3 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_3 + 0
					end
				end

				arg_366_1.text_.text = var_369_1
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_4 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_4 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_4

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_4 and arg_366_1.time_ < 0 + var_369_4 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play933011374 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 933011374
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play933011375(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.275

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_1 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(933011374).content)

				arg_370_1.text_.text = var_373_1

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_3 = 11 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 11)

				if (11 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 11)) > 0 and var_373_0 < var_373_3 then
					arg_370_1.talkMaxDuration = var_373_3

					if var_373_3 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_3 + 0
					end
				end

				arg_370_1.text_.text = var_373_1
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_4 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_4 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_4

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_4 and arg_370_1.time_ < 0 + var_373_4 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play933011375 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 933011375
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play933011376(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if arg_374_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_377_0 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_374_1.stage_.transform)

				var_377_0.name = "1033ui_story"
				var_377_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_374_1.actors_["1033ui_story"] = var_377_0

				local var_377_1 = var_377_0:GetComponentInChildren(typeof(CharacterEffect))

				var_377_1.enabled = true

				local var_377_2 = GameObjectTools.GetOrAddComponent(var_377_0, typeof(DynamicBoneHelper))

				if var_377_2 then
					var_377_2:EnableDynamicBone(false)
				end

				arg_374_1:ShowWeapon(var_377_1.transform, false)

				arg_374_1.var_["1033ui_story" .. "Animator"] = var_377_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_374_1.var_["1033ui_story" .. "Animator"].applyRootMotion = true
				arg_374_1.var_["1033ui_story" .. "LipSync"] = var_377_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_377_3 = arg_374_1.actors_["1033ui_story"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1033ui_story = var_377_3.localPosition
			end

			local var_377_4 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 then
				var_377_3.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_374_1.time_ - 0) / var_377_4)
				var_377_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_377_3.position).x, (manager.ui.mainCamera.transform.position - var_377_3.position).y, (manager.ui.mainCamera.transform.position - var_377_3.position).z)
				var_377_3.localEulerAngles.z = 0
				var_377_3.localEulerAngles.x = 0
				var_377_3.localEulerAngles = var_377_3.localEulerAngles
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 then
				var_377_3.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				var_377_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_377_3.position).x, (manager.ui.mainCamera.transform.position - var_377_3.position).y, (manager.ui.mainCamera.transform.position - var_377_3.position).z)
				var_377_3.localEulerAngles.z = 0
				var_377_3.localEulerAngles.x = 0
				var_377_3.localEulerAngles = var_377_3.localEulerAngles
			end

			local var_377_5 = arg_374_1.actors_["1033ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_5) and arg_374_1.var_.characterEffect1033ui_story == nil then
				arg_374_1.var_.characterEffect1033ui_story = var_377_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_6 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_6 and not isNil(var_377_5) then
				if arg_374_1.var_.characterEffect1033ui_story and not isNil(var_377_5) then
					arg_374_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_6 and arg_374_1.time_ < 0 + var_377_6 + arg_377_0 and not isNil(var_377_5) and arg_374_1.var_.characterEffect1033ui_story then
				arg_374_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_377_8 = 0
			local var_377_9 = 0.7

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_8 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_10 = arg_374_1:GetWordFromCfg(933011375)
				local var_377_11 = arg_374_1:FormatText(var_377_10.content)

				arg_374_1.text_.text = var_377_11

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_13 = 28 <= 0 and var_377_9 or var_377_9 * (utf8.len(var_377_11) / 28)

				if (28 <= 0 and var_377_9 or var_377_9 * (utf8.len(var_377_11) / 28)) > 0 and var_377_9 < var_377_13 then
					arg_374_1.talkMaxDuration = var_377_13

					if var_377_13 + var_377_8 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_13 + var_377_8
					end
				end

				arg_374_1.text_.text = var_377_11
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011375", "story_v_side_old_933011.awb") ~= 0 then
					local var_377_14 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011375", "story_v_side_old_933011.awb") / 1000

					if var_377_14 + var_377_8 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_14 + var_377_8
					end

					if var_377_10.prefab_name ~= "" and arg_374_1.actors_[var_377_10.prefab_name] ~= nil then
						local var_377_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_10.prefab_name].transform, "story_v_side_old_933011", "933011375", "story_v_side_old_933011.awb")

						arg_374_1:RecordAudio("933011375", var_377_15)
						arg_374_1:RecordAudio("933011375", var_377_15)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011375", "story_v_side_old_933011.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011375", "story_v_side_old_933011.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_16 = math.max(var_377_9, arg_374_1.talkMaxDuration)

			if var_377_8 <= arg_374_1.time_ and arg_374_1.time_ < var_377_8 + var_377_16 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_8) / var_377_16

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_8 + var_377_16 and arg_374_1.time_ < var_377_8 + var_377_16 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play933011376 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 933011376
		arg_378_1.duration_ = 4.8

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play933011377(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if arg_378_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_381_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_378_1.stage_.transform)

				var_381_0.name = "1066ui_story"
				var_381_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_378_1.actors_["1066ui_story"] = var_381_0

				local var_381_1 = var_381_0:GetComponentInChildren(typeof(CharacterEffect))

				var_381_1.enabled = true

				local var_381_2 = GameObjectTools.GetOrAddComponent(var_381_0, typeof(DynamicBoneHelper))

				if var_381_2 then
					var_381_2:EnableDynamicBone(false)
				end

				arg_378_1:ShowWeapon(var_381_1.transform, false)

				arg_378_1.var_["1066ui_story" .. "Animator"] = var_381_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_378_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_378_1.var_["1066ui_story" .. "LipSync"] = var_381_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_381_3 = arg_378_1.actors_["1066ui_story"].transform

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos1066ui_story = var_381_3.localPosition
			end

			local var_381_4 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_4 then
				var_381_3.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_378_1.time_ - 0) / var_381_4)
				var_381_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_381_3.position).x, (manager.ui.mainCamera.transform.position - var_381_3.position).y, (manager.ui.mainCamera.transform.position - var_381_3.position).z)
				var_381_3.localEulerAngles.z = 0
				var_381_3.localEulerAngles.x = 0
				var_381_3.localEulerAngles = var_381_3.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_4 and arg_378_1.time_ < 0 + var_381_4 + arg_381_0 then
				var_381_3.localPosition = Vector3.New(0.7, -0.77, -6.1)
				var_381_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_381_3.position).x, (manager.ui.mainCamera.transform.position - var_381_3.position).y, (manager.ui.mainCamera.transform.position - var_381_3.position).z)
				var_381_3.localEulerAngles.z = 0
				var_381_3.localEulerAngles.x = 0
				var_381_3.localEulerAngles = var_381_3.localEulerAngles
			end

			local var_381_5 = arg_378_1.actors_["1066ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_5) and arg_378_1.var_.characterEffect1066ui_story == nil then
				arg_378_1.var_.characterEffect1066ui_story = var_381_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_6 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_6 and not isNil(var_381_5) then
				if arg_378_1.var_.characterEffect1066ui_story and not isNil(var_381_5) then
					arg_378_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_6 and arg_378_1.time_ < 0 + var_381_6 + arg_381_0 and not isNil(var_381_5) and arg_378_1.var_.characterEffect1066ui_story then
				arg_378_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_381_8 = arg_378_1.actors_["1033ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_8) and arg_378_1.var_.characterEffect1033ui_story == nil then
				arg_378_1.var_.characterEffect1033ui_story = var_381_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_9 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_9 and not isNil(var_381_8) then
				if arg_378_1.var_.characterEffect1033ui_story and not isNil(var_381_8) then
					arg_378_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_9)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_9 and arg_378_1.time_ < 0 + var_381_9 + arg_381_0 and not isNil(var_381_8) and arg_378_1.var_.characterEffect1033ui_story then
				arg_378_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_381_10 = 0
			local var_381_11 = 0.525

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_10 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_12 = arg_378_1:GetWordFromCfg(933011376)
				local var_381_13 = arg_378_1:FormatText(var_381_12.content)

				arg_378_1.text_.text = var_381_13

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_15 = 21 <= 0 and var_381_11 or var_381_11 * (utf8.len(var_381_13) / 21)

				if (21 <= 0 and var_381_11 or var_381_11 * (utf8.len(var_381_13) / 21)) > 0 and var_381_11 < var_381_15 then
					arg_378_1.talkMaxDuration = var_381_15

					if var_381_15 + var_381_10 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_15 + var_381_10
					end
				end

				arg_378_1.text_.text = var_381_13
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011376", "story_v_side_old_933011.awb") ~= 0 then
					local var_381_16 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011376", "story_v_side_old_933011.awb") / 1000

					if var_381_16 + var_381_10 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_16 + var_381_10
					end

					if var_381_12.prefab_name ~= "" and arg_378_1.actors_[var_381_12.prefab_name] ~= nil then
						local var_381_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_12.prefab_name].transform, "story_v_side_old_933011", "933011376", "story_v_side_old_933011.awb")

						arg_378_1:RecordAudio("933011376", var_381_17)
						arg_378_1:RecordAudio("933011376", var_381_17)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011376", "story_v_side_old_933011.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011376", "story_v_side_old_933011.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_18 = math.max(var_381_11, arg_378_1.talkMaxDuration)

			if var_381_10 <= arg_378_1.time_ and arg_378_1.time_ < var_381_10 + var_381_18 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_10) / var_381_18

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_10 + var_381_18 and arg_378_1.time_ < var_381_10 + var_381_18 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play933011377 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 933011377
		arg_382_1.duration_ = 4.3

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play933011378(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1033ui_story = arg_382_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_385_0 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 then
				arg_382_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_382_1.time_ - 0) / var_385_0)
				arg_382_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1033ui_story"].transform.position).z)
				arg_382_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1033ui_story"].transform.localEulerAngles = arg_382_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 then
				arg_382_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_382_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1033ui_story"].transform.position).z)
				arg_382_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1033ui_story"].transform.localEulerAngles = arg_382_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_385_1 = arg_382_1.actors_["1033ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect1033ui_story == nil then
				arg_382_1.var_.characterEffect1033ui_story = var_385_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_2 and not isNil(var_385_1) then
				if arg_382_1.var_.characterEffect1033ui_story and not isNil(var_385_1) then
					arg_382_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= 0 + var_385_2 and arg_382_1.time_ < 0 + var_385_2 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect1033ui_story then
				arg_382_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_385_4 = arg_382_1.actors_["1066ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_4) and arg_382_1.var_.characterEffect1066ui_story == nil then
				arg_382_1.var_.characterEffect1066ui_story = var_385_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_5 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_5 and not isNil(var_385_4) then
				if arg_382_1.var_.characterEffect1066ui_story and not isNil(var_385_4) then
					arg_382_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_5)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_5 and arg_382_1.time_ < 0 + var_385_5 + arg_385_0 and not isNil(var_385_4) and arg_382_1.var_.characterEffect1066ui_story then
				arg_382_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action432")
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_385_6 = 0
			local var_385_7 = 0.5

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_6 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_8 = arg_382_1:GetWordFromCfg(933011377)
				local var_385_9 = arg_382_1:FormatText(var_385_8.content)

				arg_382_1.text_.text = var_385_9

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_11 = 20 <= 0 and var_385_7 or var_385_7 * (utf8.len(var_385_9) / 20)

				if (20 <= 0 and var_385_7 or var_385_7 * (utf8.len(var_385_9) / 20)) > 0 and var_385_7 < var_385_11 then
					arg_382_1.talkMaxDuration = var_385_11

					if var_385_11 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_11 + var_385_6
					end
				end

				arg_382_1.text_.text = var_385_9
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011377", "story_v_side_old_933011.awb") ~= 0 then
					local var_385_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011377", "story_v_side_old_933011.awb") / 1000

					if var_385_12 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_12 + var_385_6
					end

					if var_385_8.prefab_name ~= "" and arg_382_1.actors_[var_385_8.prefab_name] ~= nil then
						local var_385_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_8.prefab_name].transform, "story_v_side_old_933011", "933011377", "story_v_side_old_933011.awb")

						arg_382_1:RecordAudio("933011377", var_385_13)
						arg_382_1:RecordAudio("933011377", var_385_13)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011377", "story_v_side_old_933011.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011377", "story_v_side_old_933011.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_14 = math.max(var_385_7, arg_382_1.talkMaxDuration)

			if var_385_6 <= arg_382_1.time_ and arg_382_1.time_ < var_385_6 + var_385_14 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_6) / var_385_14

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_6 + var_385_14 and arg_382_1.time_ < var_385_6 + var_385_14 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play933011378 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 933011378
		arg_386_1.duration_ = 4.9

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play933011379(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos1066ui_story = arg_386_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_389_0 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 then
				arg_386_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_386_1.time_ - 0) / var_389_0)
				arg_386_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1066ui_story"].transform.position).z)
				arg_386_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["1066ui_story"].transform.localEulerAngles = arg_386_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 then
				arg_386_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0.7, -0.77, -6.1)
				arg_386_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1066ui_story"].transform.position).z)
				arg_386_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["1066ui_story"].transform.localEulerAngles = arg_386_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_389_1 = arg_386_1.actors_["1066ui_story"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect1066ui_story == nil then
				arg_386_1.var_.characterEffect1066ui_story = var_389_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_2 and not isNil(var_389_1) then
				if arg_386_1.var_.characterEffect1066ui_story and not isNil(var_389_1) then
					arg_386_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_2 and arg_386_1.time_ < 0 + var_389_2 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect1066ui_story then
				arg_386_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_389_4 = arg_386_1.actors_["1033ui_story"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_4) and arg_386_1.var_.characterEffect1033ui_story == nil then
				arg_386_1.var_.characterEffect1033ui_story = var_389_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_5 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_5 and not isNil(var_389_4) then
				if arg_386_1.var_.characterEffect1033ui_story and not isNil(var_389_4) then
					arg_386_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_386_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 0) / var_389_5)
				end
			end

			if arg_386_1.time_ >= 0 + var_389_5 and arg_386_1.time_ < 0 + var_389_5 + arg_389_0 and not isNil(var_389_4) and arg_386_1.var_.characterEffect1033ui_story then
				arg_386_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_386_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_389_6 = 0
			local var_389_7 = 0.7

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_6 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_8 = arg_386_1:GetWordFromCfg(933011378)
				local var_389_9 = arg_386_1:FormatText(var_389_8.content)

				arg_386_1.text_.text = var_389_9

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_11 = 28 <= 0 and var_389_7 or var_389_7 * (utf8.len(var_389_9) / 28)

				if (28 <= 0 and var_389_7 or var_389_7 * (utf8.len(var_389_9) / 28)) > 0 and var_389_7 < var_389_11 then
					arg_386_1.talkMaxDuration = var_389_11

					if var_389_11 + var_389_6 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_11 + var_389_6
					end
				end

				arg_386_1.text_.text = var_389_9
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011378", "story_v_side_old_933011.awb") ~= 0 then
					local var_389_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011378", "story_v_side_old_933011.awb") / 1000

					if var_389_12 + var_389_6 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_12 + var_389_6
					end

					if var_389_8.prefab_name ~= "" and arg_386_1.actors_[var_389_8.prefab_name] ~= nil then
						local var_389_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_8.prefab_name].transform, "story_v_side_old_933011", "933011378", "story_v_side_old_933011.awb")

						arg_386_1:RecordAudio("933011378", var_389_13)
						arg_386_1:RecordAudio("933011378", var_389_13)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011378", "story_v_side_old_933011.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011378", "story_v_side_old_933011.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_14 = math.max(var_389_7, arg_386_1.talkMaxDuration)

			if var_389_6 <= arg_386_1.time_ and arg_386_1.time_ < var_389_6 + var_389_14 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_6) / var_389_14

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_6 + var_389_14 and arg_386_1.time_ < var_389_6 + var_389_14 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play933011379 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 933011379
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play933011380(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1066ui_story = arg_390_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_393_0 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 then
				arg_390_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_390_1.time_ - 0) / var_393_0)
				arg_390_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).z)
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles = arg_390_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 then
				arg_390_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_390_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1066ui_story"].transform.position).z)
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1066ui_story"].transform.localEulerAngles = arg_390_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_393_1 = arg_390_1.actors_["1033ui_story"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1033ui_story = var_393_1.localPosition
			end

			local var_393_2 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_2 then
				var_393_1.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_390_1.time_ - 0) / var_393_2)
				var_393_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_1.position).x, (manager.ui.mainCamera.transform.position - var_393_1.position).y, (manager.ui.mainCamera.transform.position - var_393_1.position).z)
				var_393_1.localEulerAngles.z = 0
				var_393_1.localEulerAngles.x = 0
				var_393_1.localEulerAngles = var_393_1.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_2 and arg_390_1.time_ < 0 + var_393_2 + arg_393_0 then
				var_393_1.localPosition = Vector3.New(0, 100, 0)
				var_393_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_1.position).x, (manager.ui.mainCamera.transform.position - var_393_1.position).y, (manager.ui.mainCamera.transform.position - var_393_1.position).z)
				var_393_1.localEulerAngles.z = 0
				var_393_1.localEulerAngles.x = 0
				var_393_1.localEulerAngles = var_393_1.localEulerAngles
			end

			local var_393_3 = arg_390_1.actors_["1066ui_story"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_3) and arg_390_1.var_.characterEffect1066ui_story == nil then
				arg_390_1.var_.characterEffect1066ui_story = var_393_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_4 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 and not isNil(var_393_3) then
				if arg_390_1.var_.characterEffect1066ui_story and not isNil(var_393_3) then
					arg_390_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_390_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_390_1.time_ - 0) / var_393_4)
				end
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 and not isNil(var_393_3) and arg_390_1.var_.characterEffect1066ui_story then
				arg_390_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_390_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_393_5 = 0
			local var_393_6 = 0.45

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_5 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_7 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(933011379).content)

				arg_390_1.text_.text = var_393_7

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_9 = 18 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_7) / 18)

				if (18 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_7) / 18)) > 0 and var_393_6 < var_393_9 then
					arg_390_1.talkMaxDuration = var_393_9

					if var_393_9 + var_393_5 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_9 + var_393_5
					end
				end

				arg_390_1.text_.text = var_393_7
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_6, arg_390_1.talkMaxDuration)

			if var_393_5 <= arg_390_1.time_ and arg_390_1.time_ < var_393_5 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_5) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_5 + var_393_10 and arg_390_1.time_ < var_393_5 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play933011380 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 933011380
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play933011381(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 1.375

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(933011380).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 55 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 55)

				if (55 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 55)) > 0 and var_397_0 < var_397_3 then
					arg_394_1.talkMaxDuration = var_397_3

					if var_397_3 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_3 + 0
					end
				end

				arg_394_1.text_.text = var_397_1
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_4 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_4

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play933011381 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 933011381
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play933011382(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 1.15

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(933011381).content)

				arg_398_1.text_.text = var_401_1

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_3 = 46 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 46)

				if (46 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 46)) > 0 and var_401_0 < var_401_3 then
					arg_398_1.talkMaxDuration = var_401_3

					if var_401_3 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_3 + 0
					end
				end

				arg_398_1.text_.text = var_401_1
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_4 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_4 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_4

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_4 and arg_398_1.time_ < 0 + var_401_4 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play933011382 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 933011382
		arg_402_1.duration_ = 2.27

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play933011383(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.var_.moveOldPos1033ui_story = arg_402_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_405_0 = 0.001

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 then
				arg_402_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_402_1.time_ - 0) / var_405_0)
				arg_402_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_402_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1033ui_story"].transform.position).z)
				arg_402_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_402_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_402_1.actors_["1033ui_story"].transform.localEulerAngles = arg_402_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 then
				arg_402_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_402_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_402_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["1033ui_story"].transform.position).z)
				arg_402_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_402_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_402_1.actors_["1033ui_story"].transform.localEulerAngles = arg_402_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_405_1 = arg_402_1.actors_["1033ui_story"]

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(var_405_1) and arg_402_1.var_.characterEffect1033ui_story == nil then
				arg_402_1.var_.characterEffect1033ui_story = var_405_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_2 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_2 and not isNil(var_405_1) then
				if arg_402_1.var_.characterEffect1033ui_story and not isNil(var_405_1) then
					arg_402_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= 0 + var_405_2 and arg_402_1.time_ < 0 + var_405_2 + arg_405_0 and not isNil(var_405_1) and arg_402_1.var_.characterEffect1033ui_story then
				arg_402_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_405_4 = 0
			local var_405_5 = 0.275

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_4 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_6 = arg_402_1:GetWordFromCfg(933011382)
				local var_405_7 = arg_402_1:FormatText(var_405_6.content)

				arg_402_1.text_.text = var_405_7

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_9 = 11 <= 0 and var_405_5 or var_405_5 * (utf8.len(var_405_7) / 11)

				if (11 <= 0 and var_405_5 or var_405_5 * (utf8.len(var_405_7) / 11)) > 0 and var_405_5 < var_405_9 then
					arg_402_1.talkMaxDuration = var_405_9

					if var_405_9 + var_405_4 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_9 + var_405_4
					end
				end

				arg_402_1.text_.text = var_405_7
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011382", "story_v_side_old_933011.awb") ~= 0 then
					local var_405_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011382", "story_v_side_old_933011.awb") / 1000

					if var_405_10 + var_405_4 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_10 + var_405_4
					end

					if var_405_6.prefab_name ~= "" and arg_402_1.actors_[var_405_6.prefab_name] ~= nil then
						local var_405_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_6.prefab_name].transform, "story_v_side_old_933011", "933011382", "story_v_side_old_933011.awb")

						arg_402_1:RecordAudio("933011382", var_405_11)
						arg_402_1:RecordAudio("933011382", var_405_11)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011382", "story_v_side_old_933011.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011382", "story_v_side_old_933011.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_12 = math.max(var_405_5, arg_402_1.talkMaxDuration)

			if var_405_4 <= arg_402_1.time_ and arg_402_1.time_ < var_405_4 + var_405_12 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_4) / var_405_12

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_4 + var_405_12 and arg_402_1.time_ < var_405_4 + var_405_12 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play933011383 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 933011383
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play933011384(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1033ui_story"]) and arg_406_1.var_.characterEffect1033ui_story == nil then
				arg_406_1.var_.characterEffect1033ui_story = arg_406_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1033ui_story"]) then
				if arg_406_1.var_.characterEffect1033ui_story and not isNil(arg_406_1.actors_["1033ui_story"]) then
					arg_406_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_0)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1033ui_story"]) and arg_406_1.var_.characterEffect1033ui_story then
				arg_406_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_409_1 = 0
			local var_409_2 = 0.1

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_3 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(933011383).content)

				arg_406_1.text_.text = var_409_3

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 4 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_3) / 4)

				if (4 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_3) / 4)) > 0 and var_409_2 < var_409_5 then
					arg_406_1.talkMaxDuration = var_409_5

					if var_409_5 + var_409_1 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + var_409_1
					end
				end

				arg_406_1.text_.text = var_409_3
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_6 = math.max(var_409_2, arg_406_1.talkMaxDuration)

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_6 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_1) / var_409_6

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_1 + var_409_6 and arg_406_1.time_ < var_409_1 + var_409_6 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play933011384 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 933011384
		arg_410_1.duration_ = 4.2

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play933011385(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1033ui_story = arg_410_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_413_0 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 then
				arg_410_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_410_1.time_ - 0) / var_413_0)
				arg_410_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1033ui_story"].transform.position).z)
				arg_410_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["1033ui_story"].transform.localEulerAngles = arg_410_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 then
				arg_410_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_410_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["1033ui_story"].transform.position).z)
				arg_410_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["1033ui_story"].transform.localEulerAngles = arg_410_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_413_1 = arg_410_1.actors_["1033ui_story"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_1) and arg_410_1.var_.characterEffect1033ui_story == nil then
				arg_410_1.var_.characterEffect1033ui_story = var_413_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_2 = 0.200000002980232

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_2 and not isNil(var_413_1) then
				if arg_410_1.var_.characterEffect1033ui_story and not isNil(var_413_1) then
					arg_410_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= 0 + var_413_2 and arg_410_1.time_ < 0 + var_413_2 + arg_413_0 and not isNil(var_413_1) and arg_410_1.var_.characterEffect1033ui_story then
				arg_410_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_1")
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_413_4 = 0
			local var_413_5 = 0.425

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_4 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_6 = arg_410_1:GetWordFromCfg(933011384)
				local var_413_7 = arg_410_1:FormatText(var_413_6.content)

				arg_410_1.text_.text = var_413_7

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_9 = 17 <= 0 and var_413_5 or var_413_5 * (utf8.len(var_413_7) / 17)

				if (17 <= 0 and var_413_5 or var_413_5 * (utf8.len(var_413_7) / 17)) > 0 and var_413_5 < var_413_9 then
					arg_410_1.talkMaxDuration = var_413_9

					if var_413_9 + var_413_4 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_9 + var_413_4
					end
				end

				arg_410_1.text_.text = var_413_7
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011384", "story_v_side_old_933011.awb") ~= 0 then
					local var_413_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011384", "story_v_side_old_933011.awb") / 1000

					if var_413_10 + var_413_4 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_10 + var_413_4
					end

					if var_413_6.prefab_name ~= "" and arg_410_1.actors_[var_413_6.prefab_name] ~= nil then
						local var_413_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_6.prefab_name].transform, "story_v_side_old_933011", "933011384", "story_v_side_old_933011.awb")

						arg_410_1:RecordAudio("933011384", var_413_11)
						arg_410_1:RecordAudio("933011384", var_413_11)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011384", "story_v_side_old_933011.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011384", "story_v_side_old_933011.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_12 = math.max(var_413_5, arg_410_1.talkMaxDuration)

			if var_413_4 <= arg_410_1.time_ and arg_410_1.time_ < var_413_4 + var_413_12 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_4) / var_413_12

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_4 + var_413_12 and arg_410_1.time_ < var_413_4 + var_413_12 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play933011385 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 933011385
		arg_414_1.duration_ = 10.17

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play933011386(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1066ui_story = arg_414_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_417_0 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 then
				arg_414_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_414_1.time_ - 0) / var_417_0)
				arg_414_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1066ui_story"].transform.position).z)
				arg_414_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1066ui_story"].transform.localEulerAngles = arg_414_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 then
				arg_414_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0.7, -0.77, -6.1)
				arg_414_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1066ui_story"].transform.position).z)
				arg_414_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1066ui_story"].transform.localEulerAngles = arg_414_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_417_1 = arg_414_1.actors_["1033ui_story"].transform

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1033ui_story = var_417_1.localPosition
			end

			local var_417_2 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_2 then
				var_417_1.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_414_1.time_ - 0) / var_417_2)
				var_417_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_1.position).x, (manager.ui.mainCamera.transform.position - var_417_1.position).y, (manager.ui.mainCamera.transform.position - var_417_1.position).z)
				var_417_1.localEulerAngles.z = 0
				var_417_1.localEulerAngles.x = 0
				var_417_1.localEulerAngles = var_417_1.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_2 and arg_414_1.time_ < 0 + var_417_2 + arg_417_0 then
				var_417_1.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				var_417_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_1.position).x, (manager.ui.mainCamera.transform.position - var_417_1.position).y, (manager.ui.mainCamera.transform.position - var_417_1.position).z)
				var_417_1.localEulerAngles.z = 0
				var_417_1.localEulerAngles.x = 0
				var_417_1.localEulerAngles = var_417_1.localEulerAngles
			end

			local var_417_3 = arg_414_1.actors_["1066ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_3) and arg_414_1.var_.characterEffect1066ui_story == nil then
				arg_414_1.var_.characterEffect1066ui_story = var_417_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_4 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 and not isNil(var_417_3) then
				if arg_414_1.var_.characterEffect1066ui_story and not isNil(var_417_3) then
					arg_414_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 and not isNil(var_417_3) and arg_414_1.var_.characterEffect1066ui_story then
				arg_414_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_417_6 = arg_414_1.actors_["1033ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_6) and arg_414_1.var_.characterEffect1033ui_story == nil then
				arg_414_1.var_.characterEffect1033ui_story = var_417_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_7 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 and not isNil(var_417_6) then
				if arg_414_1.var_.characterEffect1033ui_story and not isNil(var_417_6) then
					arg_414_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_414_1.time_ - 0) / var_417_7)
				end
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 and not isNil(var_417_6) and arg_414_1.var_.characterEffect1033ui_story then
				arg_414_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_417_8 = 0
			local var_417_9 = 1.125

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_8 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_10 = arg_414_1:GetWordFromCfg(933011385)
				local var_417_11 = arg_414_1:FormatText(var_417_10.content)

				arg_414_1.text_.text = var_417_11

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_13 = 45 <= 0 and var_417_9 or var_417_9 * (utf8.len(var_417_11) / 45)

				if (45 <= 0 and var_417_9 or var_417_9 * (utf8.len(var_417_11) / 45)) > 0 and var_417_9 < var_417_13 then
					arg_414_1.talkMaxDuration = var_417_13

					if var_417_13 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_13 + var_417_8
					end
				end

				arg_414_1.text_.text = var_417_11
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011385", "story_v_side_old_933011.awb") ~= 0 then
					local var_417_14 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011385", "story_v_side_old_933011.awb") / 1000

					if var_417_14 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_14 + var_417_8
					end

					if var_417_10.prefab_name ~= "" and arg_414_1.actors_[var_417_10.prefab_name] ~= nil then
						local var_417_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_10.prefab_name].transform, "story_v_side_old_933011", "933011385", "story_v_side_old_933011.awb")

						arg_414_1:RecordAudio("933011385", var_417_15)
						arg_414_1:RecordAudio("933011385", var_417_15)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011385", "story_v_side_old_933011.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011385", "story_v_side_old_933011.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_16 = math.max(var_417_9, arg_414_1.talkMaxDuration)

			if var_417_8 <= arg_414_1.time_ and arg_414_1.time_ < var_417_8 + var_417_16 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_8) / var_417_16

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_8 + var_417_16 and arg_414_1.time_ < var_417_8 + var_417_16 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play933011386 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 933011386
		arg_418_1.duration_ = 2.97

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play933011387(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.var_.moveOldPos1033ui_story = arg_418_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_421_0 = 0.001

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 then
				arg_418_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_418_1.time_ - 0) / var_421_0)
				arg_418_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_418_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1033ui_story"].transform.position).z)
				arg_418_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_418_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_418_1.actors_["1033ui_story"].transform.localEulerAngles = arg_418_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 then
				arg_418_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_418_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_418_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1033ui_story"].transform.position).z)
				arg_418_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_418_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_418_1.actors_["1033ui_story"].transform.localEulerAngles = arg_418_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_421_1 = arg_418_1.actors_["1033ui_story"]

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(var_421_1) and arg_418_1.var_.characterEffect1033ui_story == nil then
				arg_418_1.var_.characterEffect1033ui_story = var_421_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_2 and not isNil(var_421_1) then
				if arg_418_1.var_.characterEffect1033ui_story and not isNil(var_421_1) then
					arg_418_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_2 and arg_418_1.time_ < 0 + var_421_2 + arg_421_0 and not isNil(var_421_1) and arg_418_1.var_.characterEffect1033ui_story then
				arg_418_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_421_4 = arg_418_1.actors_["1066ui_story"]

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(var_421_4) and arg_418_1.var_.characterEffect1066ui_story == nil then
				arg_418_1.var_.characterEffect1066ui_story = var_421_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_5 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_5 and not isNil(var_421_4) then
				if arg_418_1.var_.characterEffect1066ui_story and not isNil(var_421_4) then
					arg_418_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_418_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_418_1.time_ - 0) / var_421_5)
				end
			end

			if arg_418_1.time_ >= 0 + var_421_5 and arg_418_1.time_ < 0 + var_421_5 + arg_421_0 and not isNil(var_421_4) and arg_418_1.var_.characterEffect1066ui_story then
				arg_418_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_418_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action483")
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_421_6 = 0
			local var_421_7 = 0.35

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_6 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_8 = arg_418_1:GetWordFromCfg(933011386)
				local var_421_9 = arg_418_1:FormatText(var_421_8.content)

				arg_418_1.text_.text = var_421_9

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_11 = 14 <= 0 and var_421_7 or var_421_7 * (utf8.len(var_421_9) / 14)

				if (14 <= 0 and var_421_7 or var_421_7 * (utf8.len(var_421_9) / 14)) > 0 and var_421_7 < var_421_11 then
					arg_418_1.talkMaxDuration = var_421_11

					if var_421_11 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_11 + var_421_6
					end
				end

				arg_418_1.text_.text = var_421_9
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011386", "story_v_side_old_933011.awb") ~= 0 then
					local var_421_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011386", "story_v_side_old_933011.awb") / 1000

					if var_421_12 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_12 + var_421_6
					end

					if var_421_8.prefab_name ~= "" and arg_418_1.actors_[var_421_8.prefab_name] ~= nil then
						local var_421_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_8.prefab_name].transform, "story_v_side_old_933011", "933011386", "story_v_side_old_933011.awb")

						arg_418_1:RecordAudio("933011386", var_421_13)
						arg_418_1:RecordAudio("933011386", var_421_13)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011386", "story_v_side_old_933011.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011386", "story_v_side_old_933011.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_14 = math.max(var_421_7, arg_418_1.talkMaxDuration)

			if var_421_6 <= arg_418_1.time_ and arg_418_1.time_ < var_421_6 + var_421_14 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_6) / var_421_14

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_6 + var_421_14 and arg_418_1.time_ < var_421_6 + var_421_14 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play933011387 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 933011387
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play933011388(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.var_.moveOldPos1066ui_story = arg_422_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_425_0 = 0.001

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 then
				arg_422_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_422_1.time_ - 0) / var_425_0)
				arg_422_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1066ui_story"].transform.position).z)
				arg_422_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1066ui_story"].transform.localEulerAngles = arg_422_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 then
				arg_422_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_422_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1066ui_story"].transform.position).z)
				arg_422_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1066ui_story"].transform.localEulerAngles = arg_422_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_425_1 = arg_422_1.actors_["1033ui_story"].transform

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.var_.moveOldPos1033ui_story = var_425_1.localPosition
			end

			local var_425_2 = 0.001

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_2 then
				var_425_1.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_422_1.time_ - 0) / var_425_2)
				var_425_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_425_1.position).x, (manager.ui.mainCamera.transform.position - var_425_1.position).y, (manager.ui.mainCamera.transform.position - var_425_1.position).z)
				var_425_1.localEulerAngles.z = 0
				var_425_1.localEulerAngles.x = 0
				var_425_1.localEulerAngles = var_425_1.localEulerAngles
			end

			if arg_422_1.time_ >= 0 + var_425_2 and arg_422_1.time_ < 0 + var_425_2 + arg_425_0 then
				var_425_1.localPosition = Vector3.New(0, 100, 0)
				var_425_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_425_1.position).x, (manager.ui.mainCamera.transform.position - var_425_1.position).y, (manager.ui.mainCamera.transform.position - var_425_1.position).z)
				var_425_1.localEulerAngles.z = 0
				var_425_1.localEulerAngles.x = 0
				var_425_1.localEulerAngles = var_425_1.localEulerAngles
			end

			local var_425_3 = arg_422_1.actors_["1033ui_story"]

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(var_425_3) and arg_422_1.var_.characterEffect1033ui_story == nil then
				arg_422_1.var_.characterEffect1033ui_story = var_425_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_4 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 and not isNil(var_425_3) then
				if arg_422_1.var_.characterEffect1033ui_story and not isNil(var_425_3) then
					arg_422_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_422_1.time_ - 0) / var_425_4)
				end
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 and not isNil(var_425_3) and arg_422_1.var_.characterEffect1033ui_story then
				arg_422_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_425_5 = 0
			local var_425_6 = 0.875

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_5 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_7 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(933011387).content)

				arg_422_1.text_.text = var_425_7

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_9 = 35 <= 0 and var_425_6 or var_425_6 * (utf8.len(var_425_7) / 35)

				if (35 <= 0 and var_425_6 or var_425_6 * (utf8.len(var_425_7) / 35)) > 0 and var_425_6 < var_425_9 then
					arg_422_1.talkMaxDuration = var_425_9

					if var_425_9 + var_425_5 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_9 + var_425_5
					end
				end

				arg_422_1.text_.text = var_425_7
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_10 = math.max(var_425_6, arg_422_1.talkMaxDuration)

			if var_425_5 <= arg_422_1.time_ and arg_422_1.time_ < var_425_5 + var_425_10 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_5) / var_425_10

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_5 + var_425_10 and arg_422_1.time_ < var_425_5 + var_425_10 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play933011388 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 933011388
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play933011389(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.975

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_1 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(933011388).content)

				arg_426_1.text_.text = var_429_1

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_3 = 39 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 39)

				if (39 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 39)) > 0 and var_429_0 < var_429_3 then
					arg_426_1.talkMaxDuration = var_429_3

					if var_429_3 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_3 + 0
					end
				end

				arg_426_1.text_.text = var_429_1
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_4 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_4 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_4

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_4 and arg_426_1.time_ < 0 + var_429_4 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play933011389 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 933011389
		arg_430_1.duration_ = 2.9

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play933011390(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1066ui_story = arg_430_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_433_0 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 then
				arg_430_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_430_1.time_ - 0) / var_433_0)
				arg_430_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1066ui_story"].transform.position).z)
				arg_430_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1066ui_story"].transform.localEulerAngles = arg_430_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 then
				arg_430_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_430_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1066ui_story"].transform.position).z)
				arg_430_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1066ui_story"].transform.localEulerAngles = arg_430_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_433_1 = arg_430_1.actors_["1066ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect1066ui_story == nil then
				arg_430_1.var_.characterEffect1066ui_story = var_433_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_2 and not isNil(var_433_1) then
				if arg_430_1.var_.characterEffect1066ui_story and not isNil(var_433_1) then
					arg_430_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_2 and arg_430_1.time_ < 0 + var_433_2 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect1066ui_story then
				arg_430_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_1")
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_433_4 = 0
			local var_433_5 = 0.35

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_6 = arg_430_1:GetWordFromCfg(933011389)
				local var_433_7 = arg_430_1:FormatText(var_433_6.content)

				arg_430_1.text_.text = var_433_7

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_9 = 14 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 14)

				if (14 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 14)) > 0 and var_433_5 < var_433_9 then
					arg_430_1.talkMaxDuration = var_433_9

					if var_433_9 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_9 + var_433_4
					end
				end

				arg_430_1.text_.text = var_433_7
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011389", "story_v_side_old_933011.awb") ~= 0 then
					local var_433_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011389", "story_v_side_old_933011.awb") / 1000

					if var_433_10 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_10 + var_433_4
					end

					if var_433_6.prefab_name ~= "" and arg_430_1.actors_[var_433_6.prefab_name] ~= nil then
						local var_433_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_6.prefab_name].transform, "story_v_side_old_933011", "933011389", "story_v_side_old_933011.awb")

						arg_430_1:RecordAudio("933011389", var_433_11)
						arg_430_1:RecordAudio("933011389", var_433_11)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011389", "story_v_side_old_933011.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011389", "story_v_side_old_933011.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_12 = math.max(var_433_5, arg_430_1.talkMaxDuration)

			if var_433_4 <= arg_430_1.time_ and arg_430_1.time_ < var_433_4 + var_433_12 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_4) / var_433_12

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_4 + var_433_12 and arg_430_1.time_ < var_433_4 + var_433_12 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play933011390 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 933011390
		arg_434_1.duration_ = 2

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play933011391(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1033ui_story = arg_434_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_437_0 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 then
				arg_434_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_434_1.time_ - 0) / var_437_0)
				arg_434_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1033ui_story"].transform.position).z)
				arg_434_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["1033ui_story"].transform.localEulerAngles = arg_434_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 then
				arg_434_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_434_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1033ui_story"].transform.position).z)
				arg_434_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["1033ui_story"].transform.localEulerAngles = arg_434_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_437_1 = arg_434_1.actors_["1033ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_1) and arg_434_1.var_.characterEffect1033ui_story == nil then
				arg_434_1.var_.characterEffect1033ui_story = var_437_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_2 and not isNil(var_437_1) then
				if arg_434_1.var_.characterEffect1033ui_story and not isNil(var_437_1) then
					arg_434_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= 0 + var_437_2 and arg_434_1.time_ < 0 + var_437_2 + arg_437_0 and not isNil(var_437_1) and arg_434_1.var_.characterEffect1033ui_story then
				arg_434_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_437_4 = arg_434_1.actors_["1066ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_4) and arg_434_1.var_.characterEffect1066ui_story == nil then
				arg_434_1.var_.characterEffect1066ui_story = var_437_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_5 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_5 and not isNil(var_437_4) then
				if arg_434_1.var_.characterEffect1066ui_story and not isNil(var_437_4) then
					arg_434_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_5)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_5 and arg_434_1.time_ < 0 + var_437_5 + arg_437_0 and not isNil(var_437_4) and arg_434_1.var_.characterEffect1066ui_story then
				arg_434_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_437_6 = 0
			local var_437_7 = 0.25

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_6 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_8 = arg_434_1:GetWordFromCfg(933011390)
				local var_437_9 = arg_434_1:FormatText(var_437_8.content)

				arg_434_1.text_.text = var_437_9

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_11 = 10 <= 0 and var_437_7 or var_437_7 * (utf8.len(var_437_9) / 10)

				if (10 <= 0 and var_437_7 or var_437_7 * (utf8.len(var_437_9) / 10)) > 0 and var_437_7 < var_437_11 then
					arg_434_1.talkMaxDuration = var_437_11

					if var_437_11 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_11 + var_437_6
					end
				end

				arg_434_1.text_.text = var_437_9
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011390", "story_v_side_old_933011.awb") ~= 0 then
					local var_437_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011390", "story_v_side_old_933011.awb") / 1000

					if var_437_12 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_12 + var_437_6
					end

					if var_437_8.prefab_name ~= "" and arg_434_1.actors_[var_437_8.prefab_name] ~= nil then
						local var_437_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_8.prefab_name].transform, "story_v_side_old_933011", "933011390", "story_v_side_old_933011.awb")

						arg_434_1:RecordAudio("933011390", var_437_13)
						arg_434_1:RecordAudio("933011390", var_437_13)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011390", "story_v_side_old_933011.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011390", "story_v_side_old_933011.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_14 = math.max(var_437_7, arg_434_1.talkMaxDuration)

			if var_437_6 <= arg_434_1.time_ and arg_434_1.time_ < var_437_6 + var_437_14 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_6) / var_437_14

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_6 + var_437_14 and arg_434_1.time_ < var_437_6 + var_437_14 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play933011391 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 933011391
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play933011392(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos1066ui_story = arg_438_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_441_0 = 0.001

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 then
				arg_438_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_438_1.time_ - 0) / var_441_0)
				arg_438_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_438_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1066ui_story"].transform.position).z)
				arg_438_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_438_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_438_1.actors_["1066ui_story"].transform.localEulerAngles = arg_438_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 then
				arg_438_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_438_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_438_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1066ui_story"].transform.position).z)
				arg_438_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_438_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_438_1.actors_["1066ui_story"].transform.localEulerAngles = arg_438_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_441_1 = arg_438_1.actors_["1033ui_story"].transform

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos1033ui_story = var_441_1.localPosition
			end

			local var_441_2 = 0.001

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_2 then
				var_441_1.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_438_1.time_ - 0) / var_441_2)
				var_441_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_441_1.position).x, (manager.ui.mainCamera.transform.position - var_441_1.position).y, (manager.ui.mainCamera.transform.position - var_441_1.position).z)
				var_441_1.localEulerAngles.z = 0
				var_441_1.localEulerAngles.x = 0
				var_441_1.localEulerAngles = var_441_1.localEulerAngles
			end

			if arg_438_1.time_ >= 0 + var_441_2 and arg_438_1.time_ < 0 + var_441_2 + arg_441_0 then
				var_441_1.localPosition = Vector3.New(0, 100, 0)
				var_441_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_441_1.position).x, (manager.ui.mainCamera.transform.position - var_441_1.position).y, (manager.ui.mainCamera.transform.position - var_441_1.position).z)
				var_441_1.localEulerAngles.z = 0
				var_441_1.localEulerAngles.x = 0
				var_441_1.localEulerAngles = var_441_1.localEulerAngles
			end

			local var_441_3 = arg_438_1.actors_["1033ui_story"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_3) and arg_438_1.var_.characterEffect1033ui_story == nil then
				arg_438_1.var_.characterEffect1033ui_story = var_441_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_4 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_4 and not isNil(var_441_3) then
				if arg_438_1.var_.characterEffect1033ui_story and not isNil(var_441_3) then
					arg_438_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_438_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_438_1.time_ - 0) / var_441_4)
				end
			end

			if arg_438_1.time_ >= 0 + var_441_4 and arg_438_1.time_ < 0 + var_441_4 + arg_441_0 and not isNil(var_441_3) and arg_438_1.var_.characterEffect1033ui_story then
				arg_438_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_438_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_441_5 = 0
			local var_441_6 = 0.675

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_5 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_7 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(933011391).content)

				arg_438_1.text_.text = var_441_7

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_9 = 27 <= 0 and var_441_6 or var_441_6 * (utf8.len(var_441_7) / 27)

				if (27 <= 0 and var_441_6 or var_441_6 * (utf8.len(var_441_7) / 27)) > 0 and var_441_6 < var_441_9 then
					arg_438_1.talkMaxDuration = var_441_9

					if var_441_9 + var_441_5 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_9 + var_441_5
					end
				end

				arg_438_1.text_.text = var_441_7
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_10 = math.max(var_441_6, arg_438_1.talkMaxDuration)

			if var_441_5 <= arg_438_1.time_ and arg_438_1.time_ < var_441_5 + var_441_10 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_5) / var_441_10

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_5 + var_441_10 and arg_438_1.time_ < var_441_5 + var_441_10 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play933011392 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 933011392
		arg_442_1.duration_ = 4.93

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play933011393(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos1033ui_story = arg_442_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_445_0 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 then
				arg_442_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_442_1.time_ - 0) / var_445_0)
				arg_442_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1033ui_story"].transform.position).z)
				arg_442_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["1033ui_story"].transform.localEulerAngles = arg_442_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 then
				arg_442_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_442_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1033ui_story"].transform.position).z)
				arg_442_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["1033ui_story"].transform.localEulerAngles = arg_442_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_445_1 = arg_442_1.actors_["1033ui_story"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect1033ui_story == nil then
				arg_442_1.var_.characterEffect1033ui_story = var_445_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_2 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_2 and not isNil(var_445_1) then
				if arg_442_1.var_.characterEffect1033ui_story and not isNil(var_445_1) then
					arg_442_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= 0 + var_445_2 and arg_442_1.time_ < 0 + var_445_2 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect1033ui_story then
				arg_442_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_445_4 = 0
			local var_445_5 = 0.525

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_4 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_6 = arg_442_1:GetWordFromCfg(933011392)
				local var_445_7 = arg_442_1:FormatText(var_445_6.content)

				arg_442_1.text_.text = var_445_7

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_9 = 21 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_7) / 21)

				if (21 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_7) / 21)) > 0 and var_445_5 < var_445_9 then
					arg_442_1.talkMaxDuration = var_445_9

					if var_445_9 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_9 + var_445_4
					end
				end

				arg_442_1.text_.text = var_445_7
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011392", "story_v_side_old_933011.awb") ~= 0 then
					local var_445_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011392", "story_v_side_old_933011.awb") / 1000

					if var_445_10 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_10 + var_445_4
					end

					if var_445_6.prefab_name ~= "" and arg_442_1.actors_[var_445_6.prefab_name] ~= nil then
						local var_445_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_6.prefab_name].transform, "story_v_side_old_933011", "933011392", "story_v_side_old_933011.awb")

						arg_442_1:RecordAudio("933011392", var_445_11)
						arg_442_1:RecordAudio("933011392", var_445_11)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011392", "story_v_side_old_933011.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011392", "story_v_side_old_933011.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_12 = math.max(var_445_5, arg_442_1.talkMaxDuration)

			if var_445_4 <= arg_442_1.time_ and arg_442_1.time_ < var_445_4 + var_445_12 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_4) / var_445_12

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_4 + var_445_12 and arg_442_1.time_ < var_445_4 + var_445_12 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play933011393 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 933011393
		arg_446_1.duration_ = 3.5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play933011394(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.var_.moveOldPos10102ui_story = arg_446_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_449_0 = 0.001

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 then
				arg_446_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_446_1.time_ - 0) / var_449_0)
				arg_446_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_446_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["10102ui_story"].transform.position).z)
				arg_446_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_446_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_446_1.actors_["10102ui_story"].transform.localEulerAngles = arg_446_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 then
				arg_446_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_446_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_446_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_446_1.actors_["10102ui_story"].transform.position).z)
				arg_446_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_446_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_446_1.actors_["10102ui_story"].transform.localEulerAngles = arg_446_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_449_1 = arg_446_1.actors_["10102ui_story"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_1) and arg_446_1.var_.characterEffect10102ui_story == nil then
				arg_446_1.var_.characterEffect10102ui_story = var_449_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_2 and not isNil(var_449_1) then
				if arg_446_1.var_.characterEffect10102ui_story and not isNil(var_449_1) then
					arg_446_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= 0 + var_449_2 and arg_446_1.time_ < 0 + var_449_2 + arg_449_0 and not isNil(var_449_1) and arg_446_1.var_.characterEffect10102ui_story then
				arg_446_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_449_4 = arg_446_1.actors_["1033ui_story"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_4) and arg_446_1.var_.characterEffect1033ui_story == nil then
				arg_446_1.var_.characterEffect1033ui_story = var_449_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_5 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_5 and not isNil(var_449_4) then
				if arg_446_1.var_.characterEffect1033ui_story and not isNil(var_449_4) then
					arg_446_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 0) / var_449_5)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_5 and arg_446_1.time_ < 0 + var_449_5 + arg_449_0 and not isNil(var_449_4) and arg_446_1.var_.characterEffect1033ui_story then
				arg_446_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_449_6 = 0
			local var_449_7 = 0.275

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_6 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_8 = arg_446_1:GetWordFromCfg(933011393)
				local var_449_9 = arg_446_1:FormatText(var_449_8.content)

				arg_446_1.text_.text = var_449_9

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_11 = 11 <= 0 and var_449_7 or var_449_7 * (utf8.len(var_449_9) / 11)

				if (11 <= 0 and var_449_7 or var_449_7 * (utf8.len(var_449_9) / 11)) > 0 and var_449_7 < var_449_11 then
					arg_446_1.talkMaxDuration = var_449_11

					if var_449_11 + var_449_6 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_11 + var_449_6
					end
				end

				arg_446_1.text_.text = var_449_9
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011393", "story_v_side_old_933011.awb") ~= 0 then
					local var_449_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011393", "story_v_side_old_933011.awb") / 1000

					if var_449_12 + var_449_6 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_12 + var_449_6
					end

					if var_449_8.prefab_name ~= "" and arg_446_1.actors_[var_449_8.prefab_name] ~= nil then
						local var_449_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_8.prefab_name].transform, "story_v_side_old_933011", "933011393", "story_v_side_old_933011.awb")

						arg_446_1:RecordAudio("933011393", var_449_13)
						arg_446_1:RecordAudio("933011393", var_449_13)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011393", "story_v_side_old_933011.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011393", "story_v_side_old_933011.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_14 = math.max(var_449_7, arg_446_1.talkMaxDuration)

			if var_449_6 <= arg_446_1.time_ and arg_446_1.time_ < var_449_6 + var_449_14 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_6) / var_449_14

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_6 + var_449_14 and arg_446_1.time_ < var_449_6 + var_449_14 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play933011394 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 933011394
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play933011395(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["10102ui_story"]) and arg_450_1.var_.characterEffect10102ui_story == nil then
				arg_450_1.var_.characterEffect10102ui_story = arg_450_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_0 = 0.200000002980232

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["10102ui_story"]) then
				if arg_450_1.var_.characterEffect10102ui_story and not isNil(arg_450_1.actors_["10102ui_story"]) then
					arg_450_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_450_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_450_1.time_ - 0) / var_453_0)
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["10102ui_story"]) and arg_450_1.var_.characterEffect10102ui_story then
				arg_450_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_450_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_453_1 = 0
			local var_453_2 = 0.2

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(933011394).content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 8 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 8)

				if (8 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 8)) > 0 and var_453_2 < var_453_5 then
					arg_450_1.talkMaxDuration = var_453_5

					if var_453_5 + var_453_1 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + var_453_1
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_6 = math.max(var_453_2, arg_450_1.talkMaxDuration)

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_6 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_1) / var_453_6

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_1 + var_453_6 and arg_450_1.time_ < var_453_1 + var_453_6 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play933011395 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 933011395
		arg_454_1.duration_ = 5.6

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play933011396(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.var_.moveOldPos1066ui_story = arg_454_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_457_0 = 0.001

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 then
				arg_454_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_454_1.time_ - 0) / var_457_0)
				arg_454_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_454_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1066ui_story"].transform.position).z)
				arg_454_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_454_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_454_1.actors_["1066ui_story"].transform.localEulerAngles = arg_454_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 then
				arg_454_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_454_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_454_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_454_1.actors_["1066ui_story"].transform.position).z)
				arg_454_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_454_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_454_1.actors_["1066ui_story"].transform.localEulerAngles = arg_454_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_457_1 = arg_454_1.actors_["1033ui_story"].transform

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.var_.moveOldPos1033ui_story = var_457_1.localPosition
			end

			local var_457_2 = 0.001

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_2 then
				var_457_1.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_454_1.time_ - 0) / var_457_2)
				var_457_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_1.position).x, (manager.ui.mainCamera.transform.position - var_457_1.position).y, (manager.ui.mainCamera.transform.position - var_457_1.position).z)
				var_457_1.localEulerAngles.z = 0
				var_457_1.localEulerAngles.x = 0
				var_457_1.localEulerAngles = var_457_1.localEulerAngles
			end

			if arg_454_1.time_ >= 0 + var_457_2 and arg_454_1.time_ < 0 + var_457_2 + arg_457_0 then
				var_457_1.localPosition = Vector3.New(0, 100, 0)
				var_457_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_1.position).x, (manager.ui.mainCamera.transform.position - var_457_1.position).y, (manager.ui.mainCamera.transform.position - var_457_1.position).z)
				var_457_1.localEulerAngles.z = 0
				var_457_1.localEulerAngles.x = 0
				var_457_1.localEulerAngles = var_457_1.localEulerAngles
			end

			local var_457_3 = arg_454_1.actors_["1066ui_story"]

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(var_457_3) and arg_454_1.var_.characterEffect1066ui_story == nil then
				arg_454_1.var_.characterEffect1066ui_story = var_457_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_4 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_4 and not isNil(var_457_3) then
				if arg_454_1.var_.characterEffect1066ui_story and not isNil(var_457_3) then
					arg_454_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= 0 + var_457_4 and arg_454_1.time_ < 0 + var_457_4 + arg_457_0 and not isNil(var_457_3) and arg_454_1.var_.characterEffect1066ui_story then
				arg_454_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_457_6 = 0
			local var_457_7 = 0.65

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_6 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_8 = arg_454_1:GetWordFromCfg(933011395)
				local var_457_9 = arg_454_1:FormatText(var_457_8.content)

				arg_454_1.text_.text = var_457_9

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_11 = 26 <= 0 and var_457_7 or var_457_7 * (utf8.len(var_457_9) / 26)

				if (26 <= 0 and var_457_7 or var_457_7 * (utf8.len(var_457_9) / 26)) > 0 and var_457_7 < var_457_11 then
					arg_454_1.talkMaxDuration = var_457_11

					if var_457_11 + var_457_6 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_11 + var_457_6
					end
				end

				arg_454_1.text_.text = var_457_9
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011395", "story_v_side_old_933011.awb") ~= 0 then
					local var_457_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011395", "story_v_side_old_933011.awb") / 1000

					if var_457_12 + var_457_6 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_12 + var_457_6
					end

					if var_457_8.prefab_name ~= "" and arg_454_1.actors_[var_457_8.prefab_name] ~= nil then
						local var_457_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_8.prefab_name].transform, "story_v_side_old_933011", "933011395", "story_v_side_old_933011.awb")

						arg_454_1:RecordAudio("933011395", var_457_13)
						arg_454_1:RecordAudio("933011395", var_457_13)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011395", "story_v_side_old_933011.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011395", "story_v_side_old_933011.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_14 = math.max(var_457_7, arg_454_1.talkMaxDuration)

			if var_457_6 <= arg_454_1.time_ and arg_454_1.time_ < var_457_6 + var_457_14 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_6) / var_457_14

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_6 + var_457_14 and arg_454_1.time_ < var_457_6 + var_457_14 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play933011396 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 933011396
		arg_458_1.duration_ = 3.17

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play933011397(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos10102ui_story = arg_458_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_461_0 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 then
				arg_458_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_458_1.time_ - 0) / var_461_0)
				arg_458_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["10102ui_story"].transform.position).z)
				arg_458_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["10102ui_story"].transform.localEulerAngles = arg_458_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 then
				arg_458_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_458_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["10102ui_story"].transform.position).z)
				arg_458_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["10102ui_story"].transform.localEulerAngles = arg_458_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_461_1 = arg_458_1.actors_["10102ui_story"]

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(var_461_1) and arg_458_1.var_.characterEffect10102ui_story == nil then
				arg_458_1.var_.characterEffect10102ui_story = var_461_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_2 and not isNil(var_461_1) then
				if arg_458_1.var_.characterEffect10102ui_story and not isNil(var_461_1) then
					arg_458_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 0 + var_461_2 and arg_458_1.time_ < 0 + var_461_2 + arg_461_0 and not isNil(var_461_1) and arg_458_1.var_.characterEffect10102ui_story then
				arg_458_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_461_4 = arg_458_1.actors_["1066ui_story"]

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(var_461_4) and arg_458_1.var_.characterEffect1066ui_story == nil then
				arg_458_1.var_.characterEffect1066ui_story = var_461_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_5 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_5 and not isNil(var_461_4) then
				if arg_458_1.var_.characterEffect1066ui_story and not isNil(var_461_4) then
					arg_458_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_5)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_5 and arg_458_1.time_ < 0 + var_461_5 + arg_461_0 and not isNil(var_461_4) and arg_458_1.var_.characterEffect1066ui_story then
				arg_458_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_461_6 = 0
			local var_461_7 = 0.35

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_8 = arg_458_1:GetWordFromCfg(933011396)
				local var_461_9 = arg_458_1:FormatText(var_461_8.content)

				arg_458_1.text_.text = var_461_9

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_11 = 14 <= 0 and var_461_7 or var_461_7 * (utf8.len(var_461_9) / 14)

				if (14 <= 0 and var_461_7 or var_461_7 * (utf8.len(var_461_9) / 14)) > 0 and var_461_7 < var_461_11 then
					arg_458_1.talkMaxDuration = var_461_11

					if var_461_11 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_11 + var_461_6
					end
				end

				arg_458_1.text_.text = var_461_9
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011396", "story_v_side_old_933011.awb") ~= 0 then
					local var_461_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011396", "story_v_side_old_933011.awb") / 1000

					if var_461_12 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_12 + var_461_6
					end

					if var_461_8.prefab_name ~= "" and arg_458_1.actors_[var_461_8.prefab_name] ~= nil then
						local var_461_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_8.prefab_name].transform, "story_v_side_old_933011", "933011396", "story_v_side_old_933011.awb")

						arg_458_1:RecordAudio("933011396", var_461_13)
						arg_458_1:RecordAudio("933011396", var_461_13)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011396", "story_v_side_old_933011.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011396", "story_v_side_old_933011.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_14 = math.max(var_461_7, arg_458_1.talkMaxDuration)

			if var_461_6 <= arg_458_1.time_ and arg_458_1.time_ < var_461_6 + var_461_14 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_6) / var_461_14

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_6 + var_461_14 and arg_458_1.time_ < var_461_6 + var_461_14 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play933011397 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 933011397
		arg_462_1.duration_ = 3.2

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play933011398(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos1033ui_story = arg_462_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_465_0 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 then
				arg_462_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_462_1.time_ - 0) / var_465_0)
				arg_462_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_462_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["1033ui_story"].transform.position).z)
				arg_462_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_462_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_462_1.actors_["1033ui_story"].transform.localEulerAngles = arg_462_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 then
				arg_462_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_462_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_462_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["1033ui_story"].transform.position).z)
				arg_462_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_462_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_462_1.actors_["1033ui_story"].transform.localEulerAngles = arg_462_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_465_1 = arg_462_1.actors_["10102ui_story"].transform

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos10102ui_story = var_465_1.localPosition
			end

			local var_465_2 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_2 then
				var_465_1.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_462_1.time_ - 0) / var_465_2)
				var_465_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_465_1.position).x, (manager.ui.mainCamera.transform.position - var_465_1.position).y, (manager.ui.mainCamera.transform.position - var_465_1.position).z)
				var_465_1.localEulerAngles.z = 0
				var_465_1.localEulerAngles.x = 0
				var_465_1.localEulerAngles = var_465_1.localEulerAngles
			end

			if arg_462_1.time_ >= 0 + var_465_2 and arg_462_1.time_ < 0 + var_465_2 + arg_465_0 then
				var_465_1.localPosition = Vector3.New(0, 100, 0)
				var_465_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_465_1.position).x, (manager.ui.mainCamera.transform.position - var_465_1.position).y, (manager.ui.mainCamera.transform.position - var_465_1.position).z)
				var_465_1.localEulerAngles.z = 0
				var_465_1.localEulerAngles.x = 0
				var_465_1.localEulerAngles = var_465_1.localEulerAngles
			end

			local var_465_3 = arg_462_1.actors_["1033ui_story"]

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(var_465_3) and arg_462_1.var_.characterEffect1033ui_story == nil then
				arg_462_1.var_.characterEffect1033ui_story = var_465_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_4 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 and not isNil(var_465_3) then
				if arg_462_1.var_.characterEffect1033ui_story and not isNil(var_465_3) then
					arg_462_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 and not isNil(var_465_3) and arg_462_1.var_.characterEffect1033ui_story then
				arg_462_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_465_6 = arg_462_1.actors_["10102ui_story"]

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(var_465_6) and arg_462_1.var_.characterEffect10102ui_story == nil then
				arg_462_1.var_.characterEffect10102ui_story = var_465_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_7 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_7 and not isNil(var_465_6) then
				if arg_462_1.var_.characterEffect10102ui_story and not isNil(var_465_6) then
					arg_462_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_462_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_462_1.time_ - 0) / var_465_7)
				end
			end

			if arg_462_1.time_ >= 0 + var_465_7 and arg_462_1.time_ < 0 + var_465_7 + arg_465_0 and not isNil(var_465_6) and arg_462_1.var_.characterEffect10102ui_story then
				arg_462_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_462_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_465_8 = 0
			local var_465_9 = 0.325

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_8 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_10 = arg_462_1:GetWordFromCfg(933011397)
				local var_465_11 = arg_462_1:FormatText(var_465_10.content)

				arg_462_1.text_.text = var_465_11

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_13 = 13 <= 0 and var_465_9 or var_465_9 * (utf8.len(var_465_11) / 13)

				if (13 <= 0 and var_465_9 or var_465_9 * (utf8.len(var_465_11) / 13)) > 0 and var_465_9 < var_465_13 then
					arg_462_1.talkMaxDuration = var_465_13

					if var_465_13 + var_465_8 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_13 + var_465_8
					end
				end

				arg_462_1.text_.text = var_465_11
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011397", "story_v_side_old_933011.awb") ~= 0 then
					local var_465_14 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011397", "story_v_side_old_933011.awb") / 1000

					if var_465_14 + var_465_8 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_14 + var_465_8
					end

					if var_465_10.prefab_name ~= "" and arg_462_1.actors_[var_465_10.prefab_name] ~= nil then
						local var_465_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_10.prefab_name].transform, "story_v_side_old_933011", "933011397", "story_v_side_old_933011.awb")

						arg_462_1:RecordAudio("933011397", var_465_15)
						arg_462_1:RecordAudio("933011397", var_465_15)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011397", "story_v_side_old_933011.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011397", "story_v_side_old_933011.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_16 = math.max(var_465_9, arg_462_1.talkMaxDuration)

			if var_465_8 <= arg_462_1.time_ and arg_462_1.time_ < var_465_8 + var_465_16 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_8) / var_465_16

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_8 + var_465_16 and arg_462_1.time_ < var_465_8 + var_465_16 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play933011398 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 933011398
		arg_466_1.duration_ = 3.8

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play933011399(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.var_.moveOldPos1066ui_story = arg_466_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_469_0 = 0.001

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 then
				arg_466_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_466_1.time_ - 0) / var_469_0)
				arg_466_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).z)
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles = arg_466_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 then
				arg_466_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_466_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1066ui_story"].transform.position).z)
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_466_1.actors_["1066ui_story"].transform.localEulerAngles = arg_466_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_469_1 = arg_466_1.actors_["1066ui_story"]

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(var_469_1) and arg_466_1.var_.characterEffect1066ui_story == nil then
				arg_466_1.var_.characterEffect1066ui_story = var_469_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_2 and not isNil(var_469_1) then
				if arg_466_1.var_.characterEffect1066ui_story and not isNil(var_469_1) then
					arg_466_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= 0 + var_469_2 and arg_466_1.time_ < 0 + var_469_2 + arg_469_0 and not isNil(var_469_1) and arg_466_1.var_.characterEffect1066ui_story then
				arg_466_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_469_4 = arg_466_1.actors_["1033ui_story"]

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(var_469_4) and arg_466_1.var_.characterEffect1033ui_story == nil then
				arg_466_1.var_.characterEffect1033ui_story = var_469_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_5 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_5 and not isNil(var_469_4) then
				if arg_466_1.var_.characterEffect1033ui_story and not isNil(var_469_4) then
					arg_466_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_5)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_5 and arg_466_1.time_ < 0 + var_469_5 + arg_469_0 and not isNil(var_469_4) and arg_466_1.var_.characterEffect1033ui_story then
				arg_466_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_469_6 = 0
			local var_469_7 = 0.425

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_8 = arg_466_1:GetWordFromCfg(933011398)
				local var_469_9 = arg_466_1:FormatText(var_469_8.content)

				arg_466_1.text_.text = var_469_9

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_11 = 17 <= 0 and var_469_7 or var_469_7 * (utf8.len(var_469_9) / 17)

				if (17 <= 0 and var_469_7 or var_469_7 * (utf8.len(var_469_9) / 17)) > 0 and var_469_7 < var_469_11 then
					arg_466_1.talkMaxDuration = var_469_11

					if var_469_11 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_11 + var_469_6
					end
				end

				arg_466_1.text_.text = var_469_9
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011398", "story_v_side_old_933011.awb") ~= 0 then
					local var_469_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011398", "story_v_side_old_933011.awb") / 1000

					if var_469_12 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_12 + var_469_6
					end

					if var_469_8.prefab_name ~= "" and arg_466_1.actors_[var_469_8.prefab_name] ~= nil then
						local var_469_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_8.prefab_name].transform, "story_v_side_old_933011", "933011398", "story_v_side_old_933011.awb")

						arg_466_1:RecordAudio("933011398", var_469_13)
						arg_466_1:RecordAudio("933011398", var_469_13)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011398", "story_v_side_old_933011.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011398", "story_v_side_old_933011.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_14 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_14 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_14

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_14 and arg_466_1.time_ < var_469_6 + var_469_14 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play933011399 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 933011399
		arg_470_1.duration_ = 7.8

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play933011400(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1033ui_story = arg_470_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).z)
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles = arg_470_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_470_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).z)
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles = arg_470_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_473_1 = arg_470_1.actors_["1033ui_story"]

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect1033ui_story == nil then
				arg_470_1.var_.characterEffect1033ui_story = var_473_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_2 and not isNil(var_473_1) then
				if arg_470_1.var_.characterEffect1033ui_story and not isNil(var_473_1) then
					arg_470_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= 0 + var_473_2 and arg_470_1.time_ < 0 + var_473_2 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect1033ui_story then
				arg_470_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_473_4 = arg_470_1.actors_["1066ui_story"]

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(var_473_4) and arg_470_1.var_.characterEffect1066ui_story == nil then
				arg_470_1.var_.characterEffect1066ui_story = var_473_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_5 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_5 and not isNil(var_473_4) then
				if arg_470_1.var_.characterEffect1066ui_story and not isNil(var_473_4) then
					arg_470_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_470_1.time_ - 0) / var_473_5)
				end
			end

			if arg_470_1.time_ >= 0 + var_473_5 and arg_470_1.time_ < 0 + var_473_5 + arg_473_0 and not isNil(var_473_4) and arg_470_1.var_.characterEffect1066ui_story then
				arg_470_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action426")
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_473_6 = 0
			local var_473_7 = 1.075

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_6 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_8 = arg_470_1:GetWordFromCfg(933011399)
				local var_473_9 = arg_470_1:FormatText(var_473_8.content)

				arg_470_1.text_.text = var_473_9

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_11 = 43 <= 0 and var_473_7 or var_473_7 * (utf8.len(var_473_9) / 43)

				if (43 <= 0 and var_473_7 or var_473_7 * (utf8.len(var_473_9) / 43)) > 0 and var_473_7 < var_473_11 then
					arg_470_1.talkMaxDuration = var_473_11

					if var_473_11 + var_473_6 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_11 + var_473_6
					end
				end

				arg_470_1.text_.text = var_473_9
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011399", "story_v_side_old_933011.awb") ~= 0 then
					local var_473_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011399", "story_v_side_old_933011.awb") / 1000

					if var_473_12 + var_473_6 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_12 + var_473_6
					end

					if var_473_8.prefab_name ~= "" and arg_470_1.actors_[var_473_8.prefab_name] ~= nil then
						local var_473_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_8.prefab_name].transform, "story_v_side_old_933011", "933011399", "story_v_side_old_933011.awb")

						arg_470_1:RecordAudio("933011399", var_473_13)
						arg_470_1:RecordAudio("933011399", var_473_13)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011399", "story_v_side_old_933011.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011399", "story_v_side_old_933011.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_14 = math.max(var_473_7, arg_470_1.talkMaxDuration)

			if var_473_6 <= arg_470_1.time_ and arg_470_1.time_ < var_473_6 + var_473_14 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_6) / var_473_14

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_6 + var_473_14 and arg_470_1.time_ < var_473_6 + var_473_14 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play933011400 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 933011400
		arg_474_1.duration_ = 11.63

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play933011401(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1066ui_story = arg_474_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_477_0 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 then
				arg_474_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_474_1.time_ - 0) / var_477_0)
				arg_474_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).z)
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles = arg_474_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 then
				arg_474_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_474_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1066ui_story"].transform.position).z)
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1066ui_story"].transform.localEulerAngles = arg_474_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_477_1 = arg_474_1.actors_["1066ui_story"]

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(var_477_1) and arg_474_1.var_.characterEffect1066ui_story == nil then
				arg_474_1.var_.characterEffect1066ui_story = var_477_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_2 and not isNil(var_477_1) then
				if arg_474_1.var_.characterEffect1066ui_story and not isNil(var_477_1) then
					arg_474_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= 0 + var_477_2 and arg_474_1.time_ < 0 + var_477_2 + arg_477_0 and not isNil(var_477_1) and arg_474_1.var_.characterEffect1066ui_story then
				arg_474_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_477_4 = arg_474_1.actors_["1033ui_story"]

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(var_477_4) and arg_474_1.var_.characterEffect1033ui_story == nil then
				arg_474_1.var_.characterEffect1033ui_story = var_477_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_5 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_5 and not isNil(var_477_4) then
				if arg_474_1.var_.characterEffect1033ui_story and not isNil(var_477_4) then
					arg_474_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_474_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_474_1.time_ - 0) / var_477_5)
				end
			end

			if arg_474_1.time_ >= 0 + var_477_5 and arg_474_1.time_ < 0 + var_477_5 + arg_477_0 and not isNil(var_477_4) and arg_474_1.var_.characterEffect1033ui_story then
				arg_474_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_474_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action453")
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_477_6 = 0
			local var_477_7 = 1.225

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_6 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_8 = arg_474_1:GetWordFromCfg(933011400)
				local var_477_9 = arg_474_1:FormatText(var_477_8.content)

				arg_474_1.text_.text = var_477_9

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_11 = 49 <= 0 and var_477_7 or var_477_7 * (utf8.len(var_477_9) / 49)

				if (49 <= 0 and var_477_7 or var_477_7 * (utf8.len(var_477_9) / 49)) > 0 and var_477_7 < var_477_11 then
					arg_474_1.talkMaxDuration = var_477_11

					if var_477_11 + var_477_6 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_11 + var_477_6
					end
				end

				arg_474_1.text_.text = var_477_9
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011400", "story_v_side_old_933011.awb") ~= 0 then
					local var_477_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011400", "story_v_side_old_933011.awb") / 1000

					if var_477_12 + var_477_6 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_12 + var_477_6
					end

					if var_477_8.prefab_name ~= "" and arg_474_1.actors_[var_477_8.prefab_name] ~= nil then
						local var_477_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_8.prefab_name].transform, "story_v_side_old_933011", "933011400", "story_v_side_old_933011.awb")

						arg_474_1:RecordAudio("933011400", var_477_13)
						arg_474_1:RecordAudio("933011400", var_477_13)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011400", "story_v_side_old_933011.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011400", "story_v_side_old_933011.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_14 = math.max(var_477_7, arg_474_1.talkMaxDuration)

			if var_477_6 <= arg_474_1.time_ and arg_474_1.time_ < var_477_6 + var_477_14 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_6) / var_477_14

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_6 + var_477_14 and arg_474_1.time_ < var_477_6 + var_477_14 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play933011401 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 933011401
		arg_478_1.duration_ = 12.47

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play933011402(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos1033ui_story = arg_478_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_481_0 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 then
				arg_478_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_478_1.time_ - 0) / var_481_0)
				arg_478_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_478_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1033ui_story"].transform.position).z)
				arg_478_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_478_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_478_1.actors_["1033ui_story"].transform.localEulerAngles = arg_478_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 then
				arg_478_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_478_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_478_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1033ui_story"].transform.position).z)
				arg_478_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_478_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_478_1.actors_["1033ui_story"].transform.localEulerAngles = arg_478_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_481_1 = arg_478_1.actors_["1033ui_story"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_1) and arg_478_1.var_.characterEffect1033ui_story == nil then
				arg_478_1.var_.characterEffect1033ui_story = var_481_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_2 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_2 and not isNil(var_481_1) then
				if arg_478_1.var_.characterEffect1033ui_story and not isNil(var_481_1) then
					arg_478_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= 0 + var_481_2 and arg_478_1.time_ < 0 + var_481_2 + arg_481_0 and not isNil(var_481_1) and arg_478_1.var_.characterEffect1033ui_story then
				arg_478_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_481_4 = arg_478_1.actors_["1066ui_story"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_4) and arg_478_1.var_.characterEffect1066ui_story == nil then
				arg_478_1.var_.characterEffect1066ui_story = var_481_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_5 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_5 and not isNil(var_481_4) then
				if arg_478_1.var_.characterEffect1066ui_story and not isNil(var_481_4) then
					arg_478_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_478_1.time_ - 0) / var_481_5)
				end
			end

			if arg_478_1.time_ >= 0 + var_481_5 and arg_478_1.time_ < 0 + var_481_5 + arg_481_0 and not isNil(var_481_4) and arg_478_1.var_.characterEffect1066ui_story then
				arg_478_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action6_2")
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_481_6 = 0
			local var_481_7 = 1.575

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_6 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_8 = arg_478_1:GetWordFromCfg(933011401)
				local var_481_9 = arg_478_1:FormatText(var_481_8.content)

				arg_478_1.text_.text = var_481_9

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_11 = 63 <= 0 and var_481_7 or var_481_7 * (utf8.len(var_481_9) / 63)

				if (63 <= 0 and var_481_7 or var_481_7 * (utf8.len(var_481_9) / 63)) > 0 and var_481_7 < var_481_11 then
					arg_478_1.talkMaxDuration = var_481_11

					if var_481_11 + var_481_6 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_11 + var_481_6
					end
				end

				arg_478_1.text_.text = var_481_9
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011401", "story_v_side_old_933011.awb") ~= 0 then
					local var_481_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011401", "story_v_side_old_933011.awb") / 1000

					if var_481_12 + var_481_6 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_12 + var_481_6
					end

					if var_481_8.prefab_name ~= "" and arg_478_1.actors_[var_481_8.prefab_name] ~= nil then
						local var_481_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_8.prefab_name].transform, "story_v_side_old_933011", "933011401", "story_v_side_old_933011.awb")

						arg_478_1:RecordAudio("933011401", var_481_13)
						arg_478_1:RecordAudio("933011401", var_481_13)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011401", "story_v_side_old_933011.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011401", "story_v_side_old_933011.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_14 = math.max(var_481_7, arg_478_1.talkMaxDuration)

			if var_481_6 <= arg_478_1.time_ and arg_478_1.time_ < var_481_6 + var_481_14 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_6) / var_481_14

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_6 + var_481_14 and arg_478_1.time_ < var_481_6 + var_481_14 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play933011402 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 933011402
		arg_482_1.duration_ = 9.27

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play933011403(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.var_.moveOldPos1066ui_story = arg_482_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_485_0 = 0.001

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 then
				arg_482_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_482_1.time_ - 0) / var_485_0)
				arg_482_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_482_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["1066ui_story"].transform.position).z)
				arg_482_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_482_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_482_1.actors_["1066ui_story"].transform.localEulerAngles = arg_482_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 then
				arg_482_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_482_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_482_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["1066ui_story"].transform.position).z)
				arg_482_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_482_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_482_1.actors_["1066ui_story"].transform.localEulerAngles = arg_482_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_485_1 = arg_482_1.actors_["1066ui_story"]

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(var_485_1) and arg_482_1.var_.characterEffect1066ui_story == nil then
				arg_482_1.var_.characterEffect1066ui_story = var_485_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_2 and not isNil(var_485_1) then
				if arg_482_1.var_.characterEffect1066ui_story and not isNil(var_485_1) then
					arg_482_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= 0 + var_485_2 and arg_482_1.time_ < 0 + var_485_2 + arg_485_0 and not isNil(var_485_1) and arg_482_1.var_.characterEffect1066ui_story then
				arg_482_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_485_4 = arg_482_1.actors_["1033ui_story"]

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(var_485_4) and arg_482_1.var_.characterEffect1033ui_story == nil then
				arg_482_1.var_.characterEffect1033ui_story = var_485_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_5 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_5 and not isNil(var_485_4) then
				if arg_482_1.var_.characterEffect1033ui_story and not isNil(var_485_4) then
					arg_482_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_482_1.time_ - 0) / var_485_5)
				end
			end

			if arg_482_1.time_ >= 0 + var_485_5 and arg_482_1.time_ < 0 + var_485_5 + arg_485_0 and not isNil(var_485_4) and arg_482_1.var_.characterEffect1033ui_story then
				arg_482_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_485_6 = 0
			local var_485_7 = 1.075

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_6 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_8 = arg_482_1:GetWordFromCfg(933011402)
				local var_485_9 = arg_482_1:FormatText(var_485_8.content)

				arg_482_1.text_.text = var_485_9

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_11 = 43 <= 0 and var_485_7 or var_485_7 * (utf8.len(var_485_9) / 43)

				if (43 <= 0 and var_485_7 or var_485_7 * (utf8.len(var_485_9) / 43)) > 0 and var_485_7 < var_485_11 then
					arg_482_1.talkMaxDuration = var_485_11

					if var_485_11 + var_485_6 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_11 + var_485_6
					end
				end

				arg_482_1.text_.text = var_485_9
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011402", "story_v_side_old_933011.awb") ~= 0 then
					local var_485_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011402", "story_v_side_old_933011.awb") / 1000

					if var_485_12 + var_485_6 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_12 + var_485_6
					end

					if var_485_8.prefab_name ~= "" and arg_482_1.actors_[var_485_8.prefab_name] ~= nil then
						local var_485_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_8.prefab_name].transform, "story_v_side_old_933011", "933011402", "story_v_side_old_933011.awb")

						arg_482_1:RecordAudio("933011402", var_485_13)
						arg_482_1:RecordAudio("933011402", var_485_13)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011402", "story_v_side_old_933011.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011402", "story_v_side_old_933011.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_14 = math.max(var_485_7, arg_482_1.talkMaxDuration)

			if var_485_6 <= arg_482_1.time_ and arg_482_1.time_ < var_485_6 + var_485_14 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_6) / var_485_14

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_6 + var_485_14 and arg_482_1.time_ < var_485_6 + var_485_14 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_482_1:InitPlayNodeList()
	end,
	Play933011403 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 933011403
		arg_486_1.duration_ = 13.7

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play933011404(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.moveOldPos1066ui_story = arg_486_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_489_0 = 0.001

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 then
				arg_486_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_486_1.time_ - 0) / var_489_0)
				arg_486_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1066ui_story"].transform.position).z)
				arg_486_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["1066ui_story"].transform.localEulerAngles = arg_486_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 then
				arg_486_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_486_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1066ui_story"].transform.position).z)
				arg_486_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["1066ui_story"].transform.localEulerAngles = arg_486_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_489_1 = 0
			local var_489_2 = 1.525

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_3 = arg_486_1:GetWordFromCfg(933011403)
				local var_489_4 = arg_486_1:FormatText(var_489_3.content)

				arg_486_1.text_.text = var_489_4

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_6 = 61 <= 0 and var_489_2 or var_489_2 * (utf8.len(var_489_4) / 61)

				if (61 <= 0 and var_489_2 or var_489_2 * (utf8.len(var_489_4) / 61)) > 0 and var_489_2 < var_489_6 then
					arg_486_1.talkMaxDuration = var_489_6

					if var_489_6 + var_489_1 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_6 + var_489_1
					end
				end

				arg_486_1.text_.text = var_489_4
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011403", "story_v_side_old_933011.awb") ~= 0 then
					local var_489_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011403", "story_v_side_old_933011.awb") / 1000

					if var_489_7 + var_489_1 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_1
					end

					if var_489_3.prefab_name ~= "" and arg_486_1.actors_[var_489_3.prefab_name] ~= nil then
						local var_489_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_3.prefab_name].transform, "story_v_side_old_933011", "933011403", "story_v_side_old_933011.awb")

						arg_486_1:RecordAudio("933011403", var_489_8)
						arg_486_1:RecordAudio("933011403", var_489_8)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011403", "story_v_side_old_933011.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011403", "story_v_side_old_933011.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_9 = math.max(var_489_2, arg_486_1.talkMaxDuration)

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_9 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_1) / var_489_9

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_1 + var_489_9 and arg_486_1.time_ < var_489_1 + var_489_9 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_486_1:InitPlayNodeList()
	end,
	Play933011404 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 933011404
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play933011405(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.var_.moveOldPos1033ui_story = arg_490_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_493_0 = 0.001

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 then
				arg_490_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_490_1.time_ - 0) / var_493_0)
				arg_490_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).z)
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles = arg_490_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 then
				arg_490_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_490_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1033ui_story"].transform.position).z)
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_490_1.actors_["1033ui_story"].transform.localEulerAngles = arg_490_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_493_1 = arg_490_1.actors_["1033ui_story"]

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(var_493_1) and arg_490_1.var_.characterEffect1033ui_story == nil then
				arg_490_1.var_.characterEffect1033ui_story = var_493_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_2 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_2 and not isNil(var_493_1) then
				if arg_490_1.var_.characterEffect1033ui_story and not isNil(var_493_1) then
					arg_490_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= 0 + var_493_2 and arg_490_1.time_ < 0 + var_493_2 + arg_493_0 and not isNil(var_493_1) and arg_490_1.var_.characterEffect1033ui_story then
				arg_490_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_493_4 = arg_490_1.actors_["1066ui_story"]

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(var_493_4) and arg_490_1.var_.characterEffect1066ui_story == nil then
				arg_490_1.var_.characterEffect1066ui_story = var_493_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_5 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_5 and not isNil(var_493_4) then
				if arg_490_1.var_.characterEffect1066ui_story and not isNil(var_493_4) then
					arg_490_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_490_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_490_1.time_ - 0) / var_493_5)
				end
			end

			if arg_490_1.time_ >= 0 + var_493_5 and arg_490_1.time_ < 0 + var_493_5 + arg_493_0 and not isNil(var_493_4) and arg_490_1.var_.characterEffect1066ui_story then
				arg_490_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_490_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action5_1")
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_493_6 = 0
			local var_493_7 = 0.775

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_6 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_8 = arg_490_1:GetWordFromCfg(933011404)
				local var_493_9 = arg_490_1:FormatText(var_493_8.content)

				arg_490_1.text_.text = var_493_9

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_11 = 31 <= 0 and var_493_7 or var_493_7 * (utf8.len(var_493_9) / 31)

				if (31 <= 0 and var_493_7 or var_493_7 * (utf8.len(var_493_9) / 31)) > 0 and var_493_7 < var_493_11 then
					arg_490_1.talkMaxDuration = var_493_11

					if var_493_11 + var_493_6 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_11 + var_493_6
					end
				end

				arg_490_1.text_.text = var_493_9
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011404", "story_v_side_old_933011.awb") ~= 0 then
					local var_493_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011404", "story_v_side_old_933011.awb") / 1000

					if var_493_12 + var_493_6 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_12 + var_493_6
					end

					if var_493_8.prefab_name ~= "" and arg_490_1.actors_[var_493_8.prefab_name] ~= nil then
						local var_493_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_8.prefab_name].transform, "story_v_side_old_933011", "933011404", "story_v_side_old_933011.awb")

						arg_490_1:RecordAudio("933011404", var_493_13)
						arg_490_1:RecordAudio("933011404", var_493_13)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011404", "story_v_side_old_933011.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011404", "story_v_side_old_933011.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_14 = math.max(var_493_7, arg_490_1.talkMaxDuration)

			if var_493_6 <= arg_490_1.time_ and arg_490_1.time_ < var_493_6 + var_493_14 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_6) / var_493_14

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_6 + var_493_14 and arg_490_1.time_ < var_493_6 + var_493_14 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play933011405 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 933011405
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play933011406(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(arg_494_1.actors_["1033ui_story"]) and arg_494_1.var_.characterEffect1033ui_story == nil then
				arg_494_1.var_.characterEffect1033ui_story = arg_494_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_0 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 and not isNil(arg_494_1.actors_["1033ui_story"]) then
				if arg_494_1.var_.characterEffect1033ui_story and not isNil(arg_494_1.actors_["1033ui_story"]) then
					arg_494_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_494_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_494_1.time_ - 0) / var_497_0)
				end
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 and not isNil(arg_494_1.actors_["1033ui_story"]) and arg_494_1.var_.characterEffect1033ui_story then
				arg_494_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_494_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_497_1 = 0
			local var_497_2 = 0.2

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_3 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(933011405).content)

				arg_494_1.text_.text = var_497_3

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 8 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 8)

				if (8 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 8)) > 0 and var_497_2 < var_497_5 then
					arg_494_1.talkMaxDuration = var_497_5

					if var_497_5 + var_497_1 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + var_497_1
					end
				end

				arg_494_1.text_.text = var_497_3
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_6 = math.max(var_497_2, arg_494_1.talkMaxDuration)

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_6 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_1) / var_497_6

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_1 + var_497_6 and arg_494_1.time_ < var_497_1 + var_497_6 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play933011406 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 933011406
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play933011407(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.var_.moveOldPos1033ui_story = arg_498_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_501_0 = 0.001

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 then
				arg_498_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_498_1.time_ - 0) / var_501_0)
				arg_498_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).z)
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles = arg_498_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 then
				arg_498_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_498_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).z)
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles = arg_498_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_501_1 = arg_498_1.actors_["1066ui_story"].transform

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.var_.moveOldPos1066ui_story = var_501_1.localPosition
			end

			local var_501_2 = 0.001

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_2 then
				var_501_1.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_498_1.time_ - 0) / var_501_2)
				var_501_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_501_1.position).x, (manager.ui.mainCamera.transform.position - var_501_1.position).y, (manager.ui.mainCamera.transform.position - var_501_1.position).z)
				var_501_1.localEulerAngles.z = 0
				var_501_1.localEulerAngles.x = 0
				var_501_1.localEulerAngles = var_501_1.localEulerAngles
			end

			if arg_498_1.time_ >= 0 + var_501_2 and arg_498_1.time_ < 0 + var_501_2 + arg_501_0 then
				var_501_1.localPosition = Vector3.New(0, 100, 0)
				var_501_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_501_1.position).x, (manager.ui.mainCamera.transform.position - var_501_1.position).y, (manager.ui.mainCamera.transform.position - var_501_1.position).z)
				var_501_1.localEulerAngles.z = 0
				var_501_1.localEulerAngles.x = 0
				var_501_1.localEulerAngles = var_501_1.localEulerAngles
			end

			local var_501_3 = 0
			local var_501_4 = 0.85

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_3 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_5 = arg_498_1:FormatText(arg_498_1:GetWordFromCfg(933011406).content)

				arg_498_1.text_.text = var_501_5

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_7 = 34 <= 0 and var_501_4 or var_501_4 * (utf8.len(var_501_5) / 34)

				if (34 <= 0 and var_501_4 or var_501_4 * (utf8.len(var_501_5) / 34)) > 0 and var_501_4 < var_501_7 then
					arg_498_1.talkMaxDuration = var_501_7

					if var_501_7 + var_501_3 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_3
					end
				end

				arg_498_1.text_.text = var_501_5
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_8 = math.max(var_501_4, arg_498_1.talkMaxDuration)

			if var_501_3 <= arg_498_1.time_ and arg_498_1.time_ < var_501_3 + var_501_8 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_3) / var_501_8

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_3 + var_501_8 and arg_498_1.time_ < var_501_3 + var_501_8 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_498_1:InitPlayNodeList()
	end,
	Play933011407 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 933011407
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play933011408(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0.275

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_1 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(933011407).content)

				arg_502_1.text_.text = var_505_1

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_3 = 11 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_1) / 11)

				if (11 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_1) / 11)) > 0 and var_505_0 < var_505_3 then
					arg_502_1.talkMaxDuration = var_505_3

					if var_505_3 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_3 + 0
					end
				end

				arg_502_1.text_.text = var_505_1
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_4 = math.max(var_505_0, arg_502_1.talkMaxDuration)

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_4 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - 0) / var_505_4

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= 0 + var_505_4 and arg_502_1.time_ < 0 + var_505_4 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play933011408 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 933011408
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play933011409(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 1.175

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_1 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(933011408).content)

				arg_506_1.text_.text = var_509_1

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_3 = 47 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 47)

				if (47 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 47)) > 0 and var_509_0 < var_509_3 then
					arg_506_1.talkMaxDuration = var_509_3

					if var_509_3 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_3 + 0
					end
				end

				arg_506_1.text_.text = var_509_1
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_4 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_4

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play933011409 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 933011409
		arg_510_1.duration_ = 4.13

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play933011410(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.var_.moveOldPos1033ui_story = arg_510_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_513_0 = 0.001

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 then
				arg_510_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_510_1.time_ - 0) / var_513_0)
				arg_510_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).z)
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles = arg_510_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 then
				arg_510_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_510_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).z)
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles = arg_510_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_513_1 = arg_510_1.actors_["1033ui_story"]

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(var_513_1) and arg_510_1.var_.characterEffect1033ui_story == nil then
				arg_510_1.var_.characterEffect1033ui_story = var_513_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_2 and not isNil(var_513_1) then
				if arg_510_1.var_.characterEffect1033ui_story and not isNil(var_513_1) then
					arg_510_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= 0 + var_513_2 and arg_510_1.time_ < 0 + var_513_2 + arg_513_0 and not isNil(var_513_1) and arg_510_1.var_.characterEffect1033ui_story then
				arg_510_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_513_4 = 0
			local var_513_5 = 0.6

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_4 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_6 = arg_510_1:GetWordFromCfg(933011409)
				local var_513_7 = arg_510_1:FormatText(var_513_6.content)

				arg_510_1.text_.text = var_513_7

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_9 = 24 <= 0 and var_513_5 or var_513_5 * (utf8.len(var_513_7) / 24)

				if (24 <= 0 and var_513_5 or var_513_5 * (utf8.len(var_513_7) / 24)) > 0 and var_513_5 < var_513_9 then
					arg_510_1.talkMaxDuration = var_513_9

					if var_513_9 + var_513_4 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_9 + var_513_4
					end
				end

				arg_510_1.text_.text = var_513_7
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011409", "story_v_side_old_933011.awb") ~= 0 then
					local var_513_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011409", "story_v_side_old_933011.awb") / 1000

					if var_513_10 + var_513_4 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_10 + var_513_4
					end

					if var_513_6.prefab_name ~= "" and arg_510_1.actors_[var_513_6.prefab_name] ~= nil then
						local var_513_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_6.prefab_name].transform, "story_v_side_old_933011", "933011409", "story_v_side_old_933011.awb")

						arg_510_1:RecordAudio("933011409", var_513_11)
						arg_510_1:RecordAudio("933011409", var_513_11)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011409", "story_v_side_old_933011.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011409", "story_v_side_old_933011.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_12 = math.max(var_513_5, arg_510_1.talkMaxDuration)

			if var_513_4 <= arg_510_1.time_ and arg_510_1.time_ < var_513_4 + var_513_12 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_4) / var_513_12

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_4 + var_513_12 and arg_510_1.time_ < var_513_4 + var_513_12 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play933011410 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 933011410
		arg_514_1.duration_ = 1

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"

			SetActive(arg_514_1.choicesGo_, true)

			for iter_515_0, iter_515_1 in ipairs(arg_514_1.choices_) do
				SetActive(iter_515_1.go, iter_515_0 <= 2)
			end

			arg_514_1.choices_[1].txt.text = arg_514_1:FormatText(StoryChoiceCfg[1584].name)
			arg_514_1.choices_[2].txt.text = arg_514_1:FormatText(StoryChoiceCfg[1585].name)
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play933011411(arg_514_1)
			end

			if arg_516_0 == 2 then
				arg_514_0:Play933011416(arg_514_1)
			end

			arg_514_1:RecordChoiceLog(933011410, 1584, 1585)
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(arg_514_1.actors_["1033ui_story"]) and arg_514_1.var_.characterEffect1033ui_story == nil then
				arg_514_1.var_.characterEffect1033ui_story = arg_514_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_0 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 and not isNil(arg_514_1.actors_["1033ui_story"]) then
				if arg_514_1.var_.characterEffect1033ui_story and not isNil(arg_514_1.actors_["1033ui_story"]) then
					arg_514_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_514_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_514_1.time_ - 0) / var_517_0)
				end
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 and not isNil(arg_514_1.actors_["1033ui_story"]) and arg_514_1.var_.characterEffect1033ui_story then
				arg_514_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_514_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_517_1 = 0

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.allBtn_.enabled = false
			end

			if arg_514_1.time_ >= var_517_1 + 0.6 and arg_514_1.time_ < var_517_1 + 0.6 + arg_517_0 then
				arg_514_1.allBtn_.enabled = true
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play933011411 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 933011411
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play933011412(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0.45

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_1 = arg_518_1:FormatText(arg_518_1:GetWordFromCfg(933011411).content)

				arg_518_1.text_.text = var_521_1

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_3 = 18 <= 0 and var_521_0 or var_521_0 * (utf8.len(var_521_1) / 18)

				if (18 <= 0 and var_521_0 or var_521_0 * (utf8.len(var_521_1) / 18)) > 0 and var_521_0 < var_521_3 then
					arg_518_1.talkMaxDuration = var_521_3

					if var_521_3 + 0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_3 + 0
					end
				end

				arg_518_1.text_.text = var_521_1
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_4 = math.max(var_521_0, arg_518_1.talkMaxDuration)

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_4 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - 0) / var_521_4

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= 0 + var_521_4 and arg_518_1.time_ < 0 + var_521_4 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play933011412 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 933011412
		arg_522_1.duration_ = 3.3

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play933011413(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.var_.moveOldPos10102ui_story = arg_522_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_525_0 = 0.001

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 then
				arg_522_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_522_1.time_ - 0) / var_525_0)
				arg_522_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_522_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["10102ui_story"].transform.position).z)
				arg_522_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_522_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_522_1.actors_["10102ui_story"].transform.localEulerAngles = arg_522_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 then
				arg_522_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_522_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_522_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["10102ui_story"].transform.position).z)
				arg_522_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_522_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_522_1.actors_["10102ui_story"].transform.localEulerAngles = arg_522_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_525_1 = arg_522_1.actors_["10102ui_story"]

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(var_525_1) and arg_522_1.var_.characterEffect10102ui_story == nil then
				arg_522_1.var_.characterEffect10102ui_story = var_525_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_2 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_2 and not isNil(var_525_1) then
				if arg_522_1.var_.characterEffect10102ui_story and not isNil(var_525_1) then
					arg_522_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= 0 + var_525_2 and arg_522_1.time_ < 0 + var_525_2 + arg_525_0 and not isNil(var_525_1) and arg_522_1.var_.characterEffect10102ui_story then
				arg_522_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_525_4 = arg_522_1.actors_["1033ui_story"].transform

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.var_.moveOldPos1033ui_story = var_525_4.localPosition
			end

			local var_525_5 = 0.001

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_5 then
				var_525_4.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_522_1.time_ - 0) / var_525_5)
				var_525_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_525_4.position).x, (manager.ui.mainCamera.transform.position - var_525_4.position).y, (manager.ui.mainCamera.transform.position - var_525_4.position).z)
				var_525_4.localEulerAngles.z = 0
				var_525_4.localEulerAngles.x = 0
				var_525_4.localEulerAngles = var_525_4.localEulerAngles
			end

			if arg_522_1.time_ >= 0 + var_525_5 and arg_522_1.time_ < 0 + var_525_5 + arg_525_0 then
				var_525_4.localPosition = Vector3.New(0, 100, 0)
				var_525_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_525_4.position).x, (manager.ui.mainCamera.transform.position - var_525_4.position).y, (manager.ui.mainCamera.transform.position - var_525_4.position).z)
				var_525_4.localEulerAngles.z = 0
				var_525_4.localEulerAngles.x = 0
				var_525_4.localEulerAngles = var_525_4.localEulerAngles
			end

			local var_525_6 = 0
			local var_525_7 = 0.325

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_6 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_8 = arg_522_1:GetWordFromCfg(933011412)
				local var_525_9 = arg_522_1:FormatText(var_525_8.content)

				arg_522_1.text_.text = var_525_9

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_11 = 13 <= 0 and var_525_7 or var_525_7 * (utf8.len(var_525_9) / 13)

				if (13 <= 0 and var_525_7 or var_525_7 * (utf8.len(var_525_9) / 13)) > 0 and var_525_7 < var_525_11 then
					arg_522_1.talkMaxDuration = var_525_11

					if var_525_11 + var_525_6 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_11 + var_525_6
					end
				end

				arg_522_1.text_.text = var_525_9
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011412", "story_v_side_old_933011.awb") ~= 0 then
					local var_525_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011412", "story_v_side_old_933011.awb") / 1000

					if var_525_12 + var_525_6 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_12 + var_525_6
					end

					if var_525_8.prefab_name ~= "" and arg_522_1.actors_[var_525_8.prefab_name] ~= nil then
						local var_525_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_8.prefab_name].transform, "story_v_side_old_933011", "933011412", "story_v_side_old_933011.awb")

						arg_522_1:RecordAudio("933011412", var_525_13)
						arg_522_1:RecordAudio("933011412", var_525_13)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011412", "story_v_side_old_933011.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011412", "story_v_side_old_933011.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_14 = math.max(var_525_7, arg_522_1.talkMaxDuration)

			if var_525_6 <= arg_522_1.time_ and arg_522_1.time_ < var_525_6 + var_525_14 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_6) / var_525_14

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_6 + var_525_14 and arg_522_1.time_ < var_525_6 + var_525_14 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play933011413 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 933011413
		arg_526_1.duration_ = 7.8

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play933011414(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.var_.moveOldPos1033ui_story = arg_526_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_529_0 = 0.001

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 then
				arg_526_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_526_1.time_ - 0) / var_529_0)
				arg_526_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).z)
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles = arg_526_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 then
				arg_526_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_526_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1033ui_story"].transform.position).z)
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_526_1.actors_["1033ui_story"].transform.localEulerAngles = arg_526_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_529_1 = arg_526_1.actors_["10102ui_story"].transform

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.var_.moveOldPos10102ui_story = var_529_1.localPosition
			end

			local var_529_2 = 0.001

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_2 then
				var_529_1.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_526_1.time_ - 0) / var_529_2)
				var_529_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_529_1.position).x, (manager.ui.mainCamera.transform.position - var_529_1.position).y, (manager.ui.mainCamera.transform.position - var_529_1.position).z)
				var_529_1.localEulerAngles.z = 0
				var_529_1.localEulerAngles.x = 0
				var_529_1.localEulerAngles = var_529_1.localEulerAngles
			end

			if arg_526_1.time_ >= 0 + var_529_2 and arg_526_1.time_ < 0 + var_529_2 + arg_529_0 then
				var_529_1.localPosition = Vector3.New(0, 100, 0)
				var_529_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_529_1.position).x, (manager.ui.mainCamera.transform.position - var_529_1.position).y, (manager.ui.mainCamera.transform.position - var_529_1.position).z)
				var_529_1.localEulerAngles.z = 0
				var_529_1.localEulerAngles.x = 0
				var_529_1.localEulerAngles = var_529_1.localEulerAngles
			end

			local var_529_3 = arg_526_1.actors_["1033ui_story"]

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(var_529_3) and arg_526_1.var_.characterEffect1033ui_story == nil then
				arg_526_1.var_.characterEffect1033ui_story = var_529_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_4 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_4 and not isNil(var_529_3) then
				if arg_526_1.var_.characterEffect1033ui_story and not isNil(var_529_3) then
					arg_526_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= 0 + var_529_4 and arg_526_1.time_ < 0 + var_529_4 + arg_529_0 and not isNil(var_529_3) and arg_526_1.var_.characterEffect1033ui_story then
				arg_526_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_529_6 = arg_526_1.actors_["10102ui_story"]

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(var_529_6) and arg_526_1.var_.characterEffect10102ui_story == nil then
				arg_526_1.var_.characterEffect10102ui_story = var_529_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_7 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_7 and not isNil(var_529_6) then
				if arg_526_1.var_.characterEffect10102ui_story and not isNil(var_529_6) then
					arg_526_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_526_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_526_1.time_ - 0) / var_529_7)
				end
			end

			if arg_526_1.time_ >= 0 + var_529_7 and arg_526_1.time_ < 0 + var_529_7 + arg_529_0 and not isNil(var_529_6) and arg_526_1.var_.characterEffect10102ui_story then
				arg_526_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_526_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_529_8 = 0
			local var_529_9 = 1.025

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_8 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_10 = arg_526_1:GetWordFromCfg(933011413)
				local var_529_11 = arg_526_1:FormatText(var_529_10.content)

				arg_526_1.text_.text = var_529_11

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_13 = 41 <= 0 and var_529_9 or var_529_9 * (utf8.len(var_529_11) / 41)

				if (41 <= 0 and var_529_9 or var_529_9 * (utf8.len(var_529_11) / 41)) > 0 and var_529_9 < var_529_13 then
					arg_526_1.talkMaxDuration = var_529_13

					if var_529_13 + var_529_8 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_13 + var_529_8
					end
				end

				arg_526_1.text_.text = var_529_11
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011413", "story_v_side_old_933011.awb") ~= 0 then
					local var_529_14 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011413", "story_v_side_old_933011.awb") / 1000

					if var_529_14 + var_529_8 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_14 + var_529_8
					end

					if var_529_10.prefab_name ~= "" and arg_526_1.actors_[var_529_10.prefab_name] ~= nil then
						local var_529_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_10.prefab_name].transform, "story_v_side_old_933011", "933011413", "story_v_side_old_933011.awb")

						arg_526_1:RecordAudio("933011413", var_529_15)
						arg_526_1:RecordAudio("933011413", var_529_15)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011413", "story_v_side_old_933011.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011413", "story_v_side_old_933011.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_16 = math.max(var_529_9, arg_526_1.talkMaxDuration)

			if var_529_8 <= arg_526_1.time_ and arg_526_1.time_ < var_529_8 + var_529_16 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_8) / var_529_16

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_8 + var_529_16 and arg_526_1.time_ < var_529_8 + var_529_16 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	Play933011414 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 933011414
		arg_530_1.duration_ = 13.7

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play933011415(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1.var_.moveOldPos1033ui_story = arg_530_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_533_0 = 0.001

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 then
				arg_530_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_530_1.time_ - 0) / var_533_0)
				arg_530_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_530_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["1033ui_story"].transform.position).z)
				arg_530_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_530_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_530_1.actors_["1033ui_story"].transform.localEulerAngles = arg_530_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 then
				arg_530_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_530_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_530_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["1033ui_story"].transform.position).z)
				arg_530_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_530_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_530_1.actors_["1033ui_story"].transform.localEulerAngles = arg_530_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_533_1 = 0
			local var_533_2 = 1.6

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_3 = arg_530_1:GetWordFromCfg(933011414)
				local var_533_4 = arg_530_1:FormatText(var_533_3.content)

				arg_530_1.text_.text = var_533_4

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_6 = 64 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_4) / 64)

				if (64 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_4) / 64)) > 0 and var_533_2 < var_533_6 then
					arg_530_1.talkMaxDuration = var_533_6

					if var_533_6 + var_533_1 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_6 + var_533_1
					end
				end

				arg_530_1.text_.text = var_533_4
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011414", "story_v_side_old_933011.awb") ~= 0 then
					local var_533_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011414", "story_v_side_old_933011.awb") / 1000

					if var_533_7 + var_533_1 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_7 + var_533_1
					end

					if var_533_3.prefab_name ~= "" and arg_530_1.actors_[var_533_3.prefab_name] ~= nil then
						local var_533_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_3.prefab_name].transform, "story_v_side_old_933011", "933011414", "story_v_side_old_933011.awb")

						arg_530_1:RecordAudio("933011414", var_533_8)
						arg_530_1:RecordAudio("933011414", var_533_8)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011414", "story_v_side_old_933011.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011414", "story_v_side_old_933011.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_9 = math.max(var_533_2, arg_530_1.talkMaxDuration)

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_9 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_1) / var_533_9

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_1 + var_533_9 and arg_530_1.time_ < var_533_1 + var_533_9 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_530_1:InitPlayNodeList()
	end,
	Play933011415 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 933011415
		arg_534_1.duration_ = 7.8

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play933011417(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.var_.moveOldPos1033ui_story = arg_534_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_537_0 = 0.001

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_0 then
				arg_534_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_534_1.time_ - 0) / var_537_0)
				arg_534_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_534_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1033ui_story"].transform.position).z)
				arg_534_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_534_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_534_1.actors_["1033ui_story"].transform.localEulerAngles = arg_534_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_534_1.time_ >= 0 + var_537_0 and arg_534_1.time_ < 0 + var_537_0 + arg_537_0 then
				arg_534_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_534_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_534_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1033ui_story"].transform.position).z)
				arg_534_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_534_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_534_1.actors_["1033ui_story"].transform.localEulerAngles = arg_534_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_537_1 = 0
			local var_537_2 = 1

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_3 = arg_534_1:GetWordFromCfg(933011415)
				local var_537_4 = arg_534_1:FormatText(var_537_3.content)

				arg_534_1.text_.text = var_537_4

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_6 = 40 <= 0 and var_537_2 or var_537_2 * (utf8.len(var_537_4) / 40)

				if (40 <= 0 and var_537_2 or var_537_2 * (utf8.len(var_537_4) / 40)) > 0 and var_537_2 < var_537_6 then
					arg_534_1.talkMaxDuration = var_537_6

					if var_537_6 + var_537_1 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_6 + var_537_1
					end
				end

				arg_534_1.text_.text = var_537_4
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011415", "story_v_side_old_933011.awb") ~= 0 then
					local var_537_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011415", "story_v_side_old_933011.awb") / 1000

					if var_537_7 + var_537_1 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_7 + var_537_1
					end

					if var_537_3.prefab_name ~= "" and arg_534_1.actors_[var_537_3.prefab_name] ~= nil then
						local var_537_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_3.prefab_name].transform, "story_v_side_old_933011", "933011415", "story_v_side_old_933011.awb")

						arg_534_1:RecordAudio("933011415", var_537_8)
						arg_534_1:RecordAudio("933011415", var_537_8)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011415", "story_v_side_old_933011.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011415", "story_v_side_old_933011.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_9 = math.max(var_537_2, arg_534_1.talkMaxDuration)

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_9 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_1) / var_537_9

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_1 + var_537_9 and arg_534_1.time_ < var_537_1 + var_537_9 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_534_1:InitPlayNodeList()
	end,
	Play933011417 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 933011417
		arg_538_1.duration_ = 10.9

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play933011418(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.var_.moveOldPos1033ui_story = arg_538_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_541_0 = 0.001

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 then
				arg_538_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_538_1.time_ - 0) / var_541_0)
				arg_538_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1033ui_story"].transform.position).z)
				arg_538_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["1033ui_story"].transform.localEulerAngles = arg_538_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 then
				arg_538_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_538_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1033ui_story"].transform.position).z)
				arg_538_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["1033ui_story"].transform.localEulerAngles = arg_538_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_541_1 = 0
			local var_541_2 = 1.225

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_3 = arg_538_1:GetWordFromCfg(933011417)
				local var_541_4 = arg_538_1:FormatText(var_541_3.content)

				arg_538_1.text_.text = var_541_4

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_6 = 49 <= 0 and var_541_2 or var_541_2 * (utf8.len(var_541_4) / 49)

				if (49 <= 0 and var_541_2 or var_541_2 * (utf8.len(var_541_4) / 49)) > 0 and var_541_2 < var_541_6 then
					arg_538_1.talkMaxDuration = var_541_6

					if var_541_6 + var_541_1 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_6 + var_541_1
					end
				end

				arg_538_1.text_.text = var_541_4
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011417", "story_v_side_old_933011.awb") ~= 0 then
					local var_541_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011417", "story_v_side_old_933011.awb") / 1000

					if var_541_7 + var_541_1 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_7 + var_541_1
					end

					if var_541_3.prefab_name ~= "" and arg_538_1.actors_[var_541_3.prefab_name] ~= nil then
						local var_541_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_3.prefab_name].transform, "story_v_side_old_933011", "933011417", "story_v_side_old_933011.awb")

						arg_538_1:RecordAudio("933011417", var_541_8)
						arg_538_1:RecordAudio("933011417", var_541_8)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011417", "story_v_side_old_933011.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011417", "story_v_side_old_933011.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_9 = math.max(var_541_2, arg_538_1.talkMaxDuration)

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_9 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_1) / var_541_9

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_1 + var_541_9 and arg_538_1.time_ < var_541_1 + var_541_9 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play933011418 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 933011418
		arg_542_1.duration_ = 12.6

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play933011419(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.var_.moveOldPos1033ui_story = arg_542_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_545_0 = 0.001

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_0 then
				arg_542_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_542_1.time_ - 0) / var_545_0)
				arg_542_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_542_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1033ui_story"].transform.position).z)
				arg_542_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_542_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_542_1.actors_["1033ui_story"].transform.localEulerAngles = arg_542_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_542_1.time_ >= 0 + var_545_0 and arg_542_1.time_ < 0 + var_545_0 + arg_545_0 then
				arg_542_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_542_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_542_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1033ui_story"].transform.position).z)
				arg_542_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_542_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_542_1.actors_["1033ui_story"].transform.localEulerAngles = arg_542_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_2")
			end

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_545_1 = 0
			local var_545_2 = 1.45

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_3 = arg_542_1:GetWordFromCfg(933011418)
				local var_545_4 = arg_542_1:FormatText(var_545_3.content)

				arg_542_1.text_.text = var_545_4

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_6 = 58 <= 0 and var_545_2 or var_545_2 * (utf8.len(var_545_4) / 58)

				if (58 <= 0 and var_545_2 or var_545_2 * (utf8.len(var_545_4) / 58)) > 0 and var_545_2 < var_545_6 then
					arg_542_1.talkMaxDuration = var_545_6

					if var_545_6 + var_545_1 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_6 + var_545_1
					end
				end

				arg_542_1.text_.text = var_545_4
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011418", "story_v_side_old_933011.awb") ~= 0 then
					local var_545_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011418", "story_v_side_old_933011.awb") / 1000

					if var_545_7 + var_545_1 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_7 + var_545_1
					end

					if var_545_3.prefab_name ~= "" and arg_542_1.actors_[var_545_3.prefab_name] ~= nil then
						local var_545_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_3.prefab_name].transform, "story_v_side_old_933011", "933011418", "story_v_side_old_933011.awb")

						arg_542_1:RecordAudio("933011418", var_545_8)
						arg_542_1:RecordAudio("933011418", var_545_8)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011418", "story_v_side_old_933011.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011418", "story_v_side_old_933011.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_9 = math.max(var_545_2, arg_542_1.talkMaxDuration)

			if var_545_1 <= arg_542_1.time_ and arg_542_1.time_ < var_545_1 + var_545_9 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_1) / var_545_9

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_1 + var_545_9 and arg_542_1.time_ < var_545_1 + var_545_9 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_542_1:InitPlayNodeList()
	end,
	Play933011419 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 933011419
		arg_546_1.duration_ = 12.17

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play933011420(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 1.55

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_1 = arg_546_1:GetWordFromCfg(933011419)
				local var_549_2 = arg_546_1:FormatText(var_549_1.content)

				arg_546_1.text_.text = var_549_2

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_4 = 62 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 62)

				if (62 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 62)) > 0 and var_549_0 < var_549_4 then
					arg_546_1.talkMaxDuration = var_549_4

					if var_549_4 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_4 + 0
					end
				end

				arg_546_1.text_.text = var_549_2
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011419", "story_v_side_old_933011.awb") ~= 0 then
					local var_549_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011419", "story_v_side_old_933011.awb") / 1000

					if var_549_5 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_5 + 0
					end

					if var_549_1.prefab_name ~= "" and arg_546_1.actors_[var_549_1.prefab_name] ~= nil then
						local var_549_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_1.prefab_name].transform, "story_v_side_old_933011", "933011419", "story_v_side_old_933011.awb")

						arg_546_1:RecordAudio("933011419", var_549_6)
						arg_546_1:RecordAudio("933011419", var_549_6)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011419", "story_v_side_old_933011.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011419", "story_v_side_old_933011.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_7 = math.max(var_549_0, arg_546_1.talkMaxDuration)

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_7 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - 0) / var_549_7

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= 0 + var_549_7 and arg_546_1.time_ < 0 + var_549_7 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play933011420 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 933011420
		arg_550_1.duration_ = 2.33

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play933011421(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.var_.moveOldPos10102ui_story = arg_550_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_553_0 = 0.001

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_0 then
				arg_550_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_550_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_550_1.time_ - 0) / var_553_0)
				arg_550_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_550_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["10102ui_story"].transform.position).z)
				arg_550_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_550_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_550_1.actors_["10102ui_story"].transform.localEulerAngles = arg_550_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_550_1.time_ >= 0 + var_553_0 and arg_550_1.time_ < 0 + var_553_0 + arg_553_0 then
				arg_550_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_550_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_550_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["10102ui_story"].transform.position).z)
				arg_550_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_550_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_550_1.actors_["10102ui_story"].transform.localEulerAngles = arg_550_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_553_1 = arg_550_1.actors_["1033ui_story"].transform

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.var_.moveOldPos1033ui_story = var_553_1.localPosition
			end

			local var_553_2 = 0.001

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_2 then
				var_553_1.localPosition = Vector3.Lerp(arg_550_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_550_1.time_ - 0) / var_553_2)
				var_553_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_553_1.position).x, (manager.ui.mainCamera.transform.position - var_553_1.position).y, (manager.ui.mainCamera.transform.position - var_553_1.position).z)
				var_553_1.localEulerAngles.z = 0
				var_553_1.localEulerAngles.x = 0
				var_553_1.localEulerAngles = var_553_1.localEulerAngles
			end

			if arg_550_1.time_ >= 0 + var_553_2 and arg_550_1.time_ < 0 + var_553_2 + arg_553_0 then
				var_553_1.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				var_553_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_553_1.position).x, (manager.ui.mainCamera.transform.position - var_553_1.position).y, (manager.ui.mainCamera.transform.position - var_553_1.position).z)
				var_553_1.localEulerAngles.z = 0
				var_553_1.localEulerAngles.x = 0
				var_553_1.localEulerAngles = var_553_1.localEulerAngles
			end

			local var_553_3 = arg_550_1.actors_["10102ui_story"]

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 and not isNil(var_553_3) and arg_550_1.var_.characterEffect10102ui_story == nil then
				arg_550_1.var_.characterEffect10102ui_story = var_553_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_4 = 0.200000002980232

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_4 and not isNil(var_553_3) then
				if arg_550_1.var_.characterEffect10102ui_story and not isNil(var_553_3) then
					arg_550_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_550_1.time_ >= 0 + var_553_4 and arg_550_1.time_ < 0 + var_553_4 + arg_553_0 and not isNil(var_553_3) and arg_550_1.var_.characterEffect10102ui_story then
				arg_550_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_553_6 = arg_550_1.actors_["1033ui_story"]

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 and not isNil(var_553_6) and arg_550_1.var_.characterEffect1033ui_story == nil then
				arg_550_1.var_.characterEffect1033ui_story = var_553_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_7 = 0.200000002980232

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_7 and not isNil(var_553_6) then
				if arg_550_1.var_.characterEffect1033ui_story and not isNil(var_553_6) then
					arg_550_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_550_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_550_1.time_ - 0) / var_553_7)
				end
			end

			if arg_550_1.time_ >= 0 + var_553_7 and arg_550_1.time_ < 0 + var_553_7 + arg_553_0 and not isNil(var_553_6) and arg_550_1.var_.characterEffect1033ui_story then
				arg_550_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_550_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_553_8 = 0
			local var_553_9 = 0.3

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_8 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				arg_550_1.leftNameTxt_.text = arg_550_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_10 = arg_550_1:GetWordFromCfg(933011420)
				local var_553_11 = arg_550_1:FormatText(var_553_10.content)

				arg_550_1.text_.text = var_553_11

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_13 = 12 <= 0 and var_553_9 or var_553_9 * (utf8.len(var_553_11) / 12)

				if (12 <= 0 and var_553_9 or var_553_9 * (utf8.len(var_553_11) / 12)) > 0 and var_553_9 < var_553_13 then
					arg_550_1.talkMaxDuration = var_553_13

					if var_553_13 + var_553_8 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_13 + var_553_8
					end
				end

				arg_550_1.text_.text = var_553_11
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011420", "story_v_side_old_933011.awb") ~= 0 then
					local var_553_14 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011420", "story_v_side_old_933011.awb") / 1000

					if var_553_14 + var_553_8 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_14 + var_553_8
					end

					if var_553_10.prefab_name ~= "" and arg_550_1.actors_[var_553_10.prefab_name] ~= nil then
						local var_553_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_10.prefab_name].transform, "story_v_side_old_933011", "933011420", "story_v_side_old_933011.awb")

						arg_550_1:RecordAudio("933011420", var_553_15)
						arg_550_1:RecordAudio("933011420", var_553_15)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011420", "story_v_side_old_933011.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011420", "story_v_side_old_933011.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_16 = math.max(var_553_9, arg_550_1.talkMaxDuration)

			if var_553_8 <= arg_550_1.time_ and arg_550_1.time_ < var_553_8 + var_553_16 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_8) / var_553_16

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_8 + var_553_16 and arg_550_1.time_ < var_553_8 + var_553_16 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_550_1:InitPlayNodeList()
	end,
	Play933011421 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 933011421
		arg_554_1.duration_ = 11.03

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play933011422(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.var_.moveOldPos1033ui_story = arg_554_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_557_0 = 0.001

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_0 then
				arg_554_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_554_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_554_1.time_ - 0) / var_557_0)
				arg_554_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_554_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1033ui_story"].transform.position).z)
				arg_554_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_554_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_554_1.actors_["1033ui_story"].transform.localEulerAngles = arg_554_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_554_1.time_ >= 0 + var_557_0 and arg_554_1.time_ < 0 + var_557_0 + arg_557_0 then
				arg_554_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_554_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_554_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1033ui_story"].transform.position).z)
				arg_554_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_554_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_554_1.actors_["1033ui_story"].transform.localEulerAngles = arg_554_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_557_1 = arg_554_1.actors_["1033ui_story"]

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 and not isNil(var_557_1) and arg_554_1.var_.characterEffect1033ui_story == nil then
				arg_554_1.var_.characterEffect1033ui_story = var_557_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_2 = 0.200000002980232

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_2 and not isNil(var_557_1) then
				if arg_554_1.var_.characterEffect1033ui_story and not isNil(var_557_1) then
					arg_554_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= 0 + var_557_2 and arg_554_1.time_ < 0 + var_557_2 + arg_557_0 and not isNil(var_557_1) and arg_554_1.var_.characterEffect1033ui_story then
				arg_554_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_557_4 = arg_554_1.actors_["10102ui_story"]

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 and not isNil(var_557_4) and arg_554_1.var_.characterEffect10102ui_story == nil then
				arg_554_1.var_.characterEffect10102ui_story = var_557_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_5 = 0.200000002980232

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_5 and not isNil(var_557_4) then
				if arg_554_1.var_.characterEffect10102ui_story and not isNil(var_557_4) then
					arg_554_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_554_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_554_1.time_ - 0) / var_557_5)
				end
			end

			if arg_554_1.time_ >= 0 + var_557_5 and arg_554_1.time_ < 0 + var_557_5 + arg_557_0 and not isNil(var_557_4) and arg_554_1.var_.characterEffect10102ui_story then
				arg_554_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_554_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action5_1")
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_557_6 = 0
			local var_557_7 = 1.325

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_6 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_8 = arg_554_1:GetWordFromCfg(933011421)
				local var_557_9 = arg_554_1:FormatText(var_557_8.content)

				arg_554_1.text_.text = var_557_9

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_11 = 53 <= 0 and var_557_7 or var_557_7 * (utf8.len(var_557_9) / 53)

				if (53 <= 0 and var_557_7 or var_557_7 * (utf8.len(var_557_9) / 53)) > 0 and var_557_7 < var_557_11 then
					arg_554_1.talkMaxDuration = var_557_11

					if var_557_11 + var_557_6 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_11 + var_557_6
					end
				end

				arg_554_1.text_.text = var_557_9
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011421", "story_v_side_old_933011.awb") ~= 0 then
					local var_557_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011421", "story_v_side_old_933011.awb") / 1000

					if var_557_12 + var_557_6 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_12 + var_557_6
					end

					if var_557_8.prefab_name ~= "" and arg_554_1.actors_[var_557_8.prefab_name] ~= nil then
						local var_557_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_8.prefab_name].transform, "story_v_side_old_933011", "933011421", "story_v_side_old_933011.awb")

						arg_554_1:RecordAudio("933011421", var_557_13)
						arg_554_1:RecordAudio("933011421", var_557_13)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011421", "story_v_side_old_933011.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011421", "story_v_side_old_933011.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_14 = math.max(var_557_7, arg_554_1.talkMaxDuration)

			if var_557_6 <= arg_554_1.time_ and arg_554_1.time_ < var_557_6 + var_557_14 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_6) / var_557_14

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_6 + var_557_14 and arg_554_1.time_ < var_557_6 + var_557_14 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_554_1:InitPlayNodeList()
	end,
	Play933011422 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 933011422
		arg_558_1.duration_ = 5.23

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play933011423(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0.675

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_1 = arg_558_1:GetWordFromCfg(933011422)
				local var_561_2 = arg_558_1:FormatText(var_561_1.content)

				arg_558_1.text_.text = var_561_2

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_4 = 27 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_2) / 27)

				if (27 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_2) / 27)) > 0 and var_561_0 < var_561_4 then
					arg_558_1.talkMaxDuration = var_561_4

					if var_561_4 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_4 + 0
					end
				end

				arg_558_1.text_.text = var_561_2
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011422", "story_v_side_old_933011.awb") ~= 0 then
					local var_561_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011422", "story_v_side_old_933011.awb") / 1000

					if var_561_5 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_5 + 0
					end

					if var_561_1.prefab_name ~= "" and arg_558_1.actors_[var_561_1.prefab_name] ~= nil then
						local var_561_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_1.prefab_name].transform, "story_v_side_old_933011", "933011422", "story_v_side_old_933011.awb")

						arg_558_1:RecordAudio("933011422", var_561_6)
						arg_558_1:RecordAudio("933011422", var_561_6)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011422", "story_v_side_old_933011.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011422", "story_v_side_old_933011.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_7 = math.max(var_561_0, arg_558_1.talkMaxDuration)

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_7 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - 0) / var_561_7

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= 0 + var_561_7 and arg_558_1.time_ < 0 + var_561_7 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play933011423 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 933011423
		arg_562_1.duration_ = 9.73

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play933011424(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action5_2")
			end

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_565_0 = 0
			local var_565_1 = 1.15

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_2 = arg_562_1:GetWordFromCfg(933011423)
				local var_565_3 = arg_562_1:FormatText(var_565_2.content)

				arg_562_1.text_.text = var_565_3

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_5 = 46 <= 0 and var_565_1 or var_565_1 * (utf8.len(var_565_3) / 46)

				if (46 <= 0 and var_565_1 or var_565_1 * (utf8.len(var_565_3) / 46)) > 0 and var_565_1 < var_565_5 then
					arg_562_1.talkMaxDuration = var_565_5

					if var_565_5 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_5 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_3
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011423", "story_v_side_old_933011.awb") ~= 0 then
					local var_565_6 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011423", "story_v_side_old_933011.awb") / 1000

					if var_565_6 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_6 + var_565_0
					end

					if var_565_2.prefab_name ~= "" and arg_562_1.actors_[var_565_2.prefab_name] ~= nil then
						local var_565_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_2.prefab_name].transform, "story_v_side_old_933011", "933011423", "story_v_side_old_933011.awb")

						arg_562_1:RecordAudio("933011423", var_565_7)
						arg_562_1:RecordAudio("933011423", var_565_7)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011423", "story_v_side_old_933011.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011423", "story_v_side_old_933011.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_8 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_8 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_8

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_8 and arg_562_1.time_ < var_565_0 + var_565_8 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play933011424 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 933011424
		arg_566_1.duration_ = 5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play933011425(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(arg_566_1.actors_["1033ui_story"]) and arg_566_1.var_.characterEffect1033ui_story == nil then
				arg_566_1.var_.characterEffect1033ui_story = arg_566_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_0 = 0.200000002980232

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_0 and not isNil(arg_566_1.actors_["1033ui_story"]) then
				if arg_566_1.var_.characterEffect1033ui_story and not isNil(arg_566_1.actors_["1033ui_story"]) then
					arg_566_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_566_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_566_1.time_ - 0) / var_569_0)
				end
			end

			if arg_566_1.time_ >= 0 + var_569_0 and arg_566_1.time_ < 0 + var_569_0 + arg_569_0 and not isNil(arg_566_1.actors_["1033ui_story"]) and arg_566_1.var_.characterEffect1033ui_story then
				arg_566_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_566_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_569_1 = 0
			local var_569_2 = 0.35

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, true)
				arg_566_1.iconController_:SetSelectedState("hero")

				arg_566_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_566_1.callingController_:SetSelectedState("normal")

				arg_566_1.keyicon_.color = Color.New(1, 1, 1)
				arg_566_1.icon_.color = Color.New(1, 1, 1)

				local var_569_3 = arg_566_1:FormatText(arg_566_1:GetWordFromCfg(933011424).content)

				arg_566_1.text_.text = var_569_3

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_5 = 14 <= 0 and var_569_2 or var_569_2 * (utf8.len(var_569_3) / 14)

				if (14 <= 0 and var_569_2 or var_569_2 * (utf8.len(var_569_3) / 14)) > 0 and var_569_2 < var_569_5 then
					arg_566_1.talkMaxDuration = var_569_5

					if var_569_5 + var_569_1 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_5 + var_569_1
					end
				end

				arg_566_1.text_.text = var_569_3
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_6 = math.max(var_569_2, arg_566_1.talkMaxDuration)

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_6 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_1) / var_569_6

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_1 + var_569_6 and arg_566_1.time_ < var_569_1 + var_569_6 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play933011425 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 933011425
		arg_570_1.duration_ = 7.37

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play933011426(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(arg_570_1.actors_["1033ui_story"]) and arg_570_1.var_.characterEffect1033ui_story == nil then
				arg_570_1.var_.characterEffect1033ui_story = arg_570_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_0 = 0.200000002980232

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 and not isNil(arg_570_1.actors_["1033ui_story"]) then
				if arg_570_1.var_.characterEffect1033ui_story and not isNil(arg_570_1.actors_["1033ui_story"]) then
					arg_570_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 and not isNil(arg_570_1.actors_["1033ui_story"]) and arg_570_1.var_.characterEffect1033ui_story then
				arg_570_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_573_2 = 0
			local var_573_3 = 0.975

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_2 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_4 = arg_570_1:GetWordFromCfg(933011425)
				local var_573_5 = arg_570_1:FormatText(var_573_4.content)

				arg_570_1.text_.text = var_573_5

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_7 = 39 <= 0 and var_573_3 or var_573_3 * (utf8.len(var_573_5) / 39)

				if (39 <= 0 and var_573_3 or var_573_3 * (utf8.len(var_573_5) / 39)) > 0 and var_573_3 < var_573_7 then
					arg_570_1.talkMaxDuration = var_573_7

					if var_573_7 + var_573_2 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_7 + var_573_2
					end
				end

				arg_570_1.text_.text = var_573_5
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011425", "story_v_side_old_933011.awb") ~= 0 then
					local var_573_8 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011425", "story_v_side_old_933011.awb") / 1000

					if var_573_8 + var_573_2 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_8 + var_573_2
					end

					if var_573_4.prefab_name ~= "" and arg_570_1.actors_[var_573_4.prefab_name] ~= nil then
						local var_573_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_4.prefab_name].transform, "story_v_side_old_933011", "933011425", "story_v_side_old_933011.awb")

						arg_570_1:RecordAudio("933011425", var_573_9)
						arg_570_1:RecordAudio("933011425", var_573_9)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011425", "story_v_side_old_933011.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011425", "story_v_side_old_933011.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_10 = math.max(var_573_3, arg_570_1.talkMaxDuration)

			if var_573_2 <= arg_570_1.time_ and arg_570_1.time_ < var_573_2 + var_573_10 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_2) / var_573_10

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_2 + var_573_10 and arg_570_1.time_ < var_573_2 + var_573_10 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play933011426 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 933011426
		arg_574_1.duration_ = 5.27

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play933011427(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_577_0 = 0
			local var_577_1 = 0.6

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_0 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_2 = arg_574_1:GetWordFromCfg(933011426)
				local var_577_3 = arg_574_1:FormatText(var_577_2.content)

				arg_574_1.text_.text = var_577_3

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_5 = 24 <= 0 and var_577_1 or var_577_1 * (utf8.len(var_577_3) / 24)

				if (24 <= 0 and var_577_1 or var_577_1 * (utf8.len(var_577_3) / 24)) > 0 and var_577_1 < var_577_5 then
					arg_574_1.talkMaxDuration = var_577_5

					if var_577_5 + var_577_0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_5 + var_577_0
					end
				end

				arg_574_1.text_.text = var_577_3
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011426", "story_v_side_old_933011.awb") ~= 0 then
					local var_577_6 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011426", "story_v_side_old_933011.awb") / 1000

					if var_577_6 + var_577_0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_6 + var_577_0
					end

					if var_577_2.prefab_name ~= "" and arg_574_1.actors_[var_577_2.prefab_name] ~= nil then
						local var_577_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_2.prefab_name].transform, "story_v_side_old_933011", "933011426", "story_v_side_old_933011.awb")

						arg_574_1:RecordAudio("933011426", var_577_7)
						arg_574_1:RecordAudio("933011426", var_577_7)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011426", "story_v_side_old_933011.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011426", "story_v_side_old_933011.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_8 = math.max(var_577_1, arg_574_1.talkMaxDuration)

			if var_577_0 <= arg_574_1.time_ and arg_574_1.time_ < var_577_0 + var_577_8 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_0) / var_577_8

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_0 + var_577_8 and arg_574_1.time_ < var_577_0 + var_577_8 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play933011427 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 933011427
		arg_578_1.duration_ = 2

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play933011428(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.var_.moveOldPos10102ui_story = arg_578_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_581_0 = 0.001

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 then
				arg_578_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_578_1.time_ - 0) / var_581_0)
				arg_578_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["10102ui_story"].transform.position).z)
				arg_578_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["10102ui_story"].transform.localEulerAngles = arg_578_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 then
				arg_578_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_578_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["10102ui_story"].transform.position).z)
				arg_578_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["10102ui_story"].transform.localEulerAngles = arg_578_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_581_1 = arg_578_1.actors_["10102ui_story"]

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(var_581_1) and arg_578_1.var_.characterEffect10102ui_story == nil then
				arg_578_1.var_.characterEffect10102ui_story = var_581_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_2 = 0.200000002980232

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_2 and not isNil(var_581_1) then
				if arg_578_1.var_.characterEffect10102ui_story and not isNil(var_581_1) then
					arg_578_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_578_1.time_ >= 0 + var_581_2 and arg_578_1.time_ < 0 + var_581_2 + arg_581_0 and not isNil(var_581_1) and arg_578_1.var_.characterEffect10102ui_story then
				arg_578_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_581_4 = arg_578_1.actors_["1033ui_story"]

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(var_581_4) and arg_578_1.var_.characterEffect1033ui_story == nil then
				arg_578_1.var_.characterEffect1033ui_story = var_581_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_5 = 0.200000002980232

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_5 and not isNil(var_581_4) then
				if arg_578_1.var_.characterEffect1033ui_story and not isNil(var_581_4) then
					arg_578_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_578_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_578_1.time_ - 0) / var_581_5)
				end
			end

			if arg_578_1.time_ >= 0 + var_581_5 and arg_578_1.time_ < 0 + var_581_5 + arg_581_0 and not isNil(var_581_4) and arg_578_1.var_.characterEffect1033ui_story then
				arg_578_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_578_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_581_6 = 0
			local var_581_7 = 0.1

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_6 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_8 = arg_578_1:GetWordFromCfg(933011427)
				local var_581_9 = arg_578_1:FormatText(var_581_8.content)

				arg_578_1.text_.text = var_581_9

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_11 = 4 <= 0 and var_581_7 or var_581_7 * (utf8.len(var_581_9) / 4)

				if (4 <= 0 and var_581_7 or var_581_7 * (utf8.len(var_581_9) / 4)) > 0 and var_581_7 < var_581_11 then
					arg_578_1.talkMaxDuration = var_581_11

					if var_581_11 + var_581_6 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_11 + var_581_6
					end
				end

				arg_578_1.text_.text = var_581_9
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011427", "story_v_side_old_933011.awb") ~= 0 then
					local var_581_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011427", "story_v_side_old_933011.awb") / 1000

					if var_581_12 + var_581_6 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_12 + var_581_6
					end

					if var_581_8.prefab_name ~= "" and arg_578_1.actors_[var_581_8.prefab_name] ~= nil then
						local var_581_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_8.prefab_name].transform, "story_v_side_old_933011", "933011427", "story_v_side_old_933011.awb")

						arg_578_1:RecordAudio("933011427", var_581_13)
						arg_578_1:RecordAudio("933011427", var_581_13)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011427", "story_v_side_old_933011.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011427", "story_v_side_old_933011.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_14 = math.max(var_581_7, arg_578_1.talkMaxDuration)

			if var_581_6 <= arg_578_1.time_ and arg_578_1.time_ < var_581_6 + var_581_14 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_6) / var_581_14

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_6 + var_581_14 and arg_578_1.time_ < var_581_6 + var_581_14 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play933011428 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 933011428
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play933011429(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 and not isNil(arg_582_1.actors_["10102ui_story"]) and arg_582_1.var_.characterEffect10102ui_story == nil then
				arg_582_1.var_.characterEffect10102ui_story = arg_582_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_0 = 0.200000002980232

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 and not isNil(arg_582_1.actors_["10102ui_story"]) then
				if arg_582_1.var_.characterEffect10102ui_story and not isNil(arg_582_1.actors_["10102ui_story"]) then
					arg_582_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_582_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_582_1.time_ - 0) / var_585_0)
				end
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 and not isNil(arg_582_1.actors_["10102ui_story"]) and arg_582_1.var_.characterEffect10102ui_story then
				arg_582_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_582_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_585_1 = 0
			local var_585_2 = 0.625

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, true)
				arg_582_1.iconController_:SetSelectedState("hero")

				arg_582_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_582_1.callingController_:SetSelectedState("normal")

				arg_582_1.keyicon_.color = Color.New(1, 1, 1)
				arg_582_1.icon_.color = Color.New(1, 1, 1)

				local var_585_3 = arg_582_1:FormatText(arg_582_1:GetWordFromCfg(933011428).content)

				arg_582_1.text_.text = var_585_3

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_5 = 25 <= 0 and var_585_2 or var_585_2 * (utf8.len(var_585_3) / 25)

				if (25 <= 0 and var_585_2 or var_585_2 * (utf8.len(var_585_3) / 25)) > 0 and var_585_2 < var_585_5 then
					arg_582_1.talkMaxDuration = var_585_5

					if var_585_5 + var_585_1 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_5 + var_585_1
					end
				end

				arg_582_1.text_.text = var_585_3
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_6 = math.max(var_585_2, arg_582_1.talkMaxDuration)

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_6 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_1) / var_585_6

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_1 + var_585_6 and arg_582_1.time_ < var_585_1 + var_585_6 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play933011429 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 933011429
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play933011430(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = 1.3

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, false)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_1 = arg_586_1:FormatText(arg_586_1:GetWordFromCfg(933011429).content)

				arg_586_1.text_.text = var_589_1

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_3 = 52 <= 0 and var_589_0 or var_589_0 * (utf8.len(var_589_1) / 52)

				if (52 <= 0 and var_589_0 or var_589_0 * (utf8.len(var_589_1) / 52)) > 0 and var_589_0 < var_589_3 then
					arg_586_1.talkMaxDuration = var_589_3

					if var_589_3 + 0 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_3 + 0
					end
				end

				arg_586_1.text_.text = var_589_1
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_4 = math.max(var_589_0, arg_586_1.talkMaxDuration)

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_4 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - 0) / var_589_4

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= 0 + var_589_4 and arg_586_1.time_ < 0 + var_589_4 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	Play933011430 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 933011430
		arg_590_1.duration_ = 6.17

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play933011431(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1.var_.moveOldPos1033ui_story = arg_590_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_593_0 = 0.001

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_0 then
				arg_590_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_590_1.time_ - 0) / var_593_0)
				arg_590_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_590_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_590_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_590_1.actors_["1033ui_story"].transform.position).z)
				arg_590_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_590_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_590_1.actors_["1033ui_story"].transform.localEulerAngles = arg_590_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_590_1.time_ >= 0 + var_593_0 and arg_590_1.time_ < 0 + var_593_0 + arg_593_0 then
				arg_590_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_590_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_590_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_590_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_590_1.actors_["1033ui_story"].transform.position).z)
				arg_590_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_590_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_590_1.actors_["1033ui_story"].transform.localEulerAngles = arg_590_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_593_1 = arg_590_1.actors_["1033ui_story"]

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 and not isNil(var_593_1) and arg_590_1.var_.characterEffect1033ui_story == nil then
				arg_590_1.var_.characterEffect1033ui_story = var_593_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_2 = 0.200000002980232

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_2 and not isNil(var_593_1) then
				if arg_590_1.var_.characterEffect1033ui_story and not isNil(var_593_1) then
					arg_590_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_590_1.time_ >= 0 + var_593_2 and arg_590_1.time_ < 0 + var_593_2 + arg_593_0 and not isNil(var_593_1) and arg_590_1.var_.characterEffect1033ui_story then
				arg_590_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_2")
			end

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_593_4 = 0
			local var_593_5 = 0.8

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_4 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				arg_590_1.leftNameTxt_.text = arg_590_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_6 = arg_590_1:GetWordFromCfg(933011430)
				local var_593_7 = arg_590_1:FormatText(var_593_6.content)

				arg_590_1.text_.text = var_593_7

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_9 = 32 <= 0 and var_593_5 or var_593_5 * (utf8.len(var_593_7) / 32)

				if (32 <= 0 and var_593_5 or var_593_5 * (utf8.len(var_593_7) / 32)) > 0 and var_593_5 < var_593_9 then
					arg_590_1.talkMaxDuration = var_593_9

					if var_593_9 + var_593_4 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_9 + var_593_4
					end
				end

				arg_590_1.text_.text = var_593_7
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011430", "story_v_side_old_933011.awb") ~= 0 then
					local var_593_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011430", "story_v_side_old_933011.awb") / 1000

					if var_593_10 + var_593_4 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_10 + var_593_4
					end

					if var_593_6.prefab_name ~= "" and arg_590_1.actors_[var_593_6.prefab_name] ~= nil then
						local var_593_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_590_1.actors_[var_593_6.prefab_name].transform, "story_v_side_old_933011", "933011430", "story_v_side_old_933011.awb")

						arg_590_1:RecordAudio("933011430", var_593_11)
						arg_590_1:RecordAudio("933011430", var_593_11)
					else
						arg_590_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011430", "story_v_side_old_933011.awb")
					end

					arg_590_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011430", "story_v_side_old_933011.awb")
				end

				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_12 = math.max(var_593_5, arg_590_1.talkMaxDuration)

			if var_593_4 <= arg_590_1.time_ and arg_590_1.time_ < var_593_4 + var_593_12 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_4) / var_593_12

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_4 + var_593_12 and arg_590_1.time_ < var_593_4 + var_593_12 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_590_1:InitPlayNodeList()
	end,
	Play933011431 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 933011431
		arg_594_1.duration_ = 2

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play933011432(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1.var_.moveOldPos10102ui_story = arg_594_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_597_0 = 0.001

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_0 then
				arg_594_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_594_1.time_ - 0) / var_597_0)
				arg_594_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_594_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_594_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_594_1.actors_["10102ui_story"].transform.position).z)
				arg_594_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_594_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_594_1.actors_["10102ui_story"].transform.localEulerAngles = arg_594_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_594_1.time_ >= 0 + var_597_0 and arg_594_1.time_ < 0 + var_597_0 + arg_597_0 then
				arg_594_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_594_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_594_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_594_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_594_1.actors_["10102ui_story"].transform.position).z)
				arg_594_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_594_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_594_1.actors_["10102ui_story"].transform.localEulerAngles = arg_594_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_597_1 = arg_594_1.actors_["10102ui_story"]

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 and not isNil(var_597_1) and arg_594_1.var_.characterEffect10102ui_story == nil then
				arg_594_1.var_.characterEffect10102ui_story = var_597_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_2 = 0.200000002980232

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_2 and not isNil(var_597_1) then
				if arg_594_1.var_.characterEffect10102ui_story and not isNil(var_597_1) then
					arg_594_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_594_1.time_ >= 0 + var_597_2 and arg_594_1.time_ < 0 + var_597_2 + arg_597_0 and not isNil(var_597_1) and arg_594_1.var_.characterEffect10102ui_story then
				arg_594_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_597_4 = arg_594_1.actors_["1033ui_story"]

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 and not isNil(var_597_4) and arg_594_1.var_.characterEffect1033ui_story == nil then
				arg_594_1.var_.characterEffect1033ui_story = var_597_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_5 = 0.200000002980232

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_5 and not isNil(var_597_4) then
				if arg_594_1.var_.characterEffect1033ui_story and not isNil(var_597_4) then
					arg_594_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_594_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_594_1.time_ - 0) / var_597_5)
				end
			end

			if arg_594_1.time_ >= 0 + var_597_5 and arg_594_1.time_ < 0 + var_597_5 + arg_597_0 and not isNil(var_597_4) and arg_594_1.var_.characterEffect1033ui_story then
				arg_594_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_594_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_597_6 = 0
			local var_597_7 = 0.125

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= var_597_6 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				arg_594_1.leftNameTxt_.text = arg_594_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_8 = arg_594_1:GetWordFromCfg(933011431)
				local var_597_9 = arg_594_1:FormatText(var_597_8.content)

				arg_594_1.text_.text = var_597_9

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_11 = 5 <= 0 and var_597_7 or var_597_7 * (utf8.len(var_597_9) / 5)

				if (5 <= 0 and var_597_7 or var_597_7 * (utf8.len(var_597_9) / 5)) > 0 and var_597_7 < var_597_11 then
					arg_594_1.talkMaxDuration = var_597_11

					if var_597_11 + var_597_6 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_11 + var_597_6
					end
				end

				arg_594_1.text_.text = var_597_9
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011431", "story_v_side_old_933011.awb") ~= 0 then
					local var_597_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011431", "story_v_side_old_933011.awb") / 1000

					if var_597_12 + var_597_6 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_12 + var_597_6
					end

					if var_597_8.prefab_name ~= "" and arg_594_1.actors_[var_597_8.prefab_name] ~= nil then
						local var_597_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_8.prefab_name].transform, "story_v_side_old_933011", "933011431", "story_v_side_old_933011.awb")

						arg_594_1:RecordAudio("933011431", var_597_13)
						arg_594_1:RecordAudio("933011431", var_597_13)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011431", "story_v_side_old_933011.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011431", "story_v_side_old_933011.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_14 = math.max(var_597_7, arg_594_1.talkMaxDuration)

			if var_597_6 <= arg_594_1.time_ and arg_594_1.time_ < var_597_6 + var_597_14 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_6) / var_597_14

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_6 + var_597_14 and arg_594_1.time_ < var_597_6 + var_597_14 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_594_1:InitPlayNodeList()
	end,
	Play933011432 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 933011432
		arg_598_1.duration_ = 4

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play933011433(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1.var_.moveOldPos1033ui_story = arg_598_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_601_0 = 0.001

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_0 then
				arg_598_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_598_1.time_ - 0) / var_601_0)
				arg_598_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_598_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["1033ui_story"].transform.position).z)
				arg_598_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_598_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_598_1.actors_["1033ui_story"].transform.localEulerAngles = arg_598_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_598_1.time_ >= 0 + var_601_0 and arg_598_1.time_ < 0 + var_601_0 + arg_601_0 then
				arg_598_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_598_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_598_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["1033ui_story"].transform.position).z)
				arg_598_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_598_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_598_1.actors_["1033ui_story"].transform.localEulerAngles = arg_598_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_601_1 = arg_598_1.actors_["1033ui_story"]

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 and not isNil(var_601_1) and arg_598_1.var_.characterEffect1033ui_story == nil then
				arg_598_1.var_.characterEffect1033ui_story = var_601_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_2 = 0.200000002980232

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_2 and not isNil(var_601_1) then
				if arg_598_1.var_.characterEffect1033ui_story and not isNil(var_601_1) then
					arg_598_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_598_1.time_ >= 0 + var_601_2 and arg_598_1.time_ < 0 + var_601_2 + arg_601_0 and not isNil(var_601_1) and arg_598_1.var_.characterEffect1033ui_story then
				arg_598_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_601_4 = arg_598_1.actors_["10102ui_story"]

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 and not isNil(var_601_4) and arg_598_1.var_.characterEffect10102ui_story == nil then
				arg_598_1.var_.characterEffect10102ui_story = var_601_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_5 = 0.200000002980232

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_5 and not isNil(var_601_4) then
				if arg_598_1.var_.characterEffect10102ui_story and not isNil(var_601_4) then
					arg_598_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_598_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_598_1.time_ - 0) / var_601_5)
				end
			end

			if arg_598_1.time_ >= 0 + var_601_5 and arg_598_1.time_ < 0 + var_601_5 + arg_601_0 and not isNil(var_601_4) and arg_598_1.var_.characterEffect10102ui_story then
				arg_598_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_598_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_601_6 = 0
			local var_601_7 = 0.45

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= var_601_6 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_8 = arg_598_1:GetWordFromCfg(933011432)
				local var_601_9 = arg_598_1:FormatText(var_601_8.content)

				arg_598_1.text_.text = var_601_9

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_11 = 18 <= 0 and var_601_7 or var_601_7 * (utf8.len(var_601_9) / 18)

				if (18 <= 0 and var_601_7 or var_601_7 * (utf8.len(var_601_9) / 18)) > 0 and var_601_7 < var_601_11 then
					arg_598_1.talkMaxDuration = var_601_11

					if var_601_11 + var_601_6 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_11 + var_601_6
					end
				end

				arg_598_1.text_.text = var_601_9
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011432", "story_v_side_old_933011.awb") ~= 0 then
					local var_601_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011432", "story_v_side_old_933011.awb") / 1000

					if var_601_12 + var_601_6 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_12 + var_601_6
					end

					if var_601_8.prefab_name ~= "" and arg_598_1.actors_[var_601_8.prefab_name] ~= nil then
						local var_601_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_8.prefab_name].transform, "story_v_side_old_933011", "933011432", "story_v_side_old_933011.awb")

						arg_598_1:RecordAudio("933011432", var_601_13)
						arg_598_1:RecordAudio("933011432", var_601_13)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011432", "story_v_side_old_933011.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011432", "story_v_side_old_933011.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_14 = math.max(var_601_7, arg_598_1.talkMaxDuration)

			if var_601_6 <= arg_598_1.time_ and arg_598_1.time_ < var_601_6 + var_601_14 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_6) / var_601_14

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_6 + var_601_14 and arg_598_1.time_ < var_601_6 + var_601_14 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_598_1:InitPlayNodeList()
	end,
	Play933011433 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 933011433
		arg_602_1.duration_ = 5

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play933011434(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1.var_.moveOldPos10102ui_story = arg_602_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_605_0 = 0.001

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_0 then
				arg_602_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_602_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_602_1.time_ - 0) / var_605_0)
				arg_602_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_602_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["10102ui_story"].transform.position).z)
				arg_602_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_602_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_602_1.actors_["10102ui_story"].transform.localEulerAngles = arg_602_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_602_1.time_ >= 0 + var_605_0 and arg_602_1.time_ < 0 + var_605_0 + arg_605_0 then
				arg_602_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_602_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_602_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["10102ui_story"].transform.position).z)
				arg_602_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_602_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_602_1.actors_["10102ui_story"].transform.localEulerAngles = arg_602_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_605_1 = arg_602_1.actors_["10102ui_story"]

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 and not isNil(var_605_1) and arg_602_1.var_.characterEffect10102ui_story == nil then
				arg_602_1.var_.characterEffect10102ui_story = var_605_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_2 = 0.200000002980232

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_2 and not isNil(var_605_1) then
				if arg_602_1.var_.characterEffect10102ui_story and not isNil(var_605_1) then
					arg_602_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_602_1.time_ >= 0 + var_605_2 and arg_602_1.time_ < 0 + var_605_2 + arg_605_0 and not isNil(var_605_1) and arg_602_1.var_.characterEffect10102ui_story then
				arg_602_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_605_4 = arg_602_1.actors_["1033ui_story"]

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 and not isNil(var_605_4) and arg_602_1.var_.characterEffect1033ui_story == nil then
				arg_602_1.var_.characterEffect1033ui_story = var_605_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_5 = 0.200000002980232

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_5 and not isNil(var_605_4) then
				if arg_602_1.var_.characterEffect1033ui_story and not isNil(var_605_4) then
					arg_602_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_602_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_602_1.time_ - 0) / var_605_5)
				end
			end

			if arg_602_1.time_ >= 0 + var_605_5 and arg_602_1.time_ < 0 + var_605_5 + arg_605_0 and not isNil(var_605_4) and arg_602_1.var_.characterEffect1033ui_story then
				arg_602_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_602_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action462")
			end

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_605_6 = 0
			local var_605_7 = 0.625

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= var_605_6 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				arg_602_1.leftNameTxt_.text = arg_602_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_8 = arg_602_1:GetWordFromCfg(933011433)
				local var_605_9 = arg_602_1:FormatText(var_605_8.content)

				arg_602_1.text_.text = var_605_9

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_11 = 25 <= 0 and var_605_7 or var_605_7 * (utf8.len(var_605_9) / 25)

				if (25 <= 0 and var_605_7 or var_605_7 * (utf8.len(var_605_9) / 25)) > 0 and var_605_7 < var_605_11 then
					arg_602_1.talkMaxDuration = var_605_11

					if var_605_11 + var_605_6 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_11 + var_605_6
					end
				end

				arg_602_1.text_.text = var_605_9
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011433", "story_v_side_old_933011.awb") ~= 0 then
					local var_605_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011433", "story_v_side_old_933011.awb") / 1000

					if var_605_12 + var_605_6 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_12 + var_605_6
					end

					if var_605_8.prefab_name ~= "" and arg_602_1.actors_[var_605_8.prefab_name] ~= nil then
						local var_605_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_602_1.actors_[var_605_8.prefab_name].transform, "story_v_side_old_933011", "933011433", "story_v_side_old_933011.awb")

						arg_602_1:RecordAudio("933011433", var_605_13)
						arg_602_1:RecordAudio("933011433", var_605_13)
					else
						arg_602_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011433", "story_v_side_old_933011.awb")
					end

					arg_602_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011433", "story_v_side_old_933011.awb")
				end

				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_14 = math.max(var_605_7, arg_602_1.talkMaxDuration)

			if var_605_6 <= arg_602_1.time_ and arg_602_1.time_ < var_605_6 + var_605_14 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_6) / var_605_14

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_6 + var_605_14 and arg_602_1.time_ < var_605_6 + var_605_14 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_602_1:InitPlayNodeList()
	end,
	Play933011434 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 933011434
		arg_606_1.duration_ = 5

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play933011435(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1.var_.moveOldPos10102ui_story = arg_606_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_609_0 = 0.001

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_0 then
				arg_606_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_606_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_606_1.time_ - 0) / var_609_0)
				arg_606_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_606_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_606_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_606_1.actors_["10102ui_story"].transform.position).z)
				arg_606_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_606_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_606_1.actors_["10102ui_story"].transform.localEulerAngles = arg_606_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_606_1.time_ >= 0 + var_609_0 and arg_606_1.time_ < 0 + var_609_0 + arg_609_0 then
				arg_606_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_606_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_606_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_606_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_606_1.actors_["10102ui_story"].transform.position).z)
				arg_606_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_606_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_606_1.actors_["10102ui_story"].transform.localEulerAngles = arg_606_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_609_1 = arg_606_1.actors_["1033ui_story"].transform

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1.var_.moveOldPos1033ui_story = var_609_1.localPosition
			end

			local var_609_2 = 0.001

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_2 then
				var_609_1.localPosition = Vector3.Lerp(arg_606_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_606_1.time_ - 0) / var_609_2)
				var_609_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_609_1.position).x, (manager.ui.mainCamera.transform.position - var_609_1.position).y, (manager.ui.mainCamera.transform.position - var_609_1.position).z)
				var_609_1.localEulerAngles.z = 0
				var_609_1.localEulerAngles.x = 0
				var_609_1.localEulerAngles = var_609_1.localEulerAngles
			end

			if arg_606_1.time_ >= 0 + var_609_2 and arg_606_1.time_ < 0 + var_609_2 + arg_609_0 then
				var_609_1.localPosition = Vector3.New(0, 100, 0)
				var_609_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_609_1.position).x, (manager.ui.mainCamera.transform.position - var_609_1.position).y, (manager.ui.mainCamera.transform.position - var_609_1.position).z)
				var_609_1.localEulerAngles.z = 0
				var_609_1.localEulerAngles.x = 0
				var_609_1.localEulerAngles = var_609_1.localEulerAngles
			end

			local var_609_3 = arg_606_1.actors_["10102ui_story"]

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 and not isNil(var_609_3) and arg_606_1.var_.characterEffect10102ui_story == nil then
				arg_606_1.var_.characterEffect10102ui_story = var_609_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_4 = 0.200000002980232

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_4 and not isNil(var_609_3) then
				if arg_606_1.var_.characterEffect10102ui_story and not isNil(var_609_3) then
					arg_606_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_606_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_606_1.time_ - 0) / var_609_4)
				end
			end

			if arg_606_1.time_ >= 0 + var_609_4 and arg_606_1.time_ < 0 + var_609_4 + arg_609_0 and not isNil(var_609_3) and arg_606_1.var_.characterEffect10102ui_story then
				arg_606_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_606_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_609_5 = 0
			local var_609_6 = 0.425

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= var_609_5 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, false)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_7 = arg_606_1:FormatText(arg_606_1:GetWordFromCfg(933011434).content)

				arg_606_1.text_.text = var_609_7

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_9 = 17 <= 0 and var_609_6 or var_609_6 * (utf8.len(var_609_7) / 17)

				if (17 <= 0 and var_609_6 or var_609_6 * (utf8.len(var_609_7) / 17)) > 0 and var_609_6 < var_609_9 then
					arg_606_1.talkMaxDuration = var_609_9

					if var_609_9 + var_609_5 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_9 + var_609_5
					end
				end

				arg_606_1.text_.text = var_609_7
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)
				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_10 = math.max(var_609_6, arg_606_1.talkMaxDuration)

			if var_609_5 <= arg_606_1.time_ and arg_606_1.time_ < var_609_5 + var_609_10 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_5) / var_609_10

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_5 + var_609_10 and arg_606_1.time_ < var_609_5 + var_609_10 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_606_1:InitPlayNodeList()
	end,
	Play933011435 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 933011435
		arg_610_1.duration_ = 5

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play933011436(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = 0.6

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, true)

				arg_610_1.leftNameTxt_.text = arg_610_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_610_1.leftNameTxt_.transform)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1.leftNameTxt_.text)
				SetActive(arg_610_1.iconTrs_.gameObject, true)
				arg_610_1.iconController_:SetSelectedState("hero")

				arg_610_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_610_1.callingController_:SetSelectedState("normal")

				arg_610_1.keyicon_.color = Color.New(1, 1, 1)
				arg_610_1.icon_.color = Color.New(1, 1, 1)

				local var_613_1 = arg_610_1:FormatText(arg_610_1:GetWordFromCfg(933011435).content)

				arg_610_1.text_.text = var_613_1

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_3 = 24 <= 0 and var_613_0 or var_613_0 * (utf8.len(var_613_1) / 24)

				if (24 <= 0 and var_613_0 or var_613_0 * (utf8.len(var_613_1) / 24)) > 0 and var_613_0 < var_613_3 then
					arg_610_1.talkMaxDuration = var_613_3

					if var_613_3 + 0 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_3 + 0
					end
				end

				arg_610_1.text_.text = var_613_1
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)
				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_4 = math.max(var_613_0, arg_610_1.talkMaxDuration)

			if 0 <= arg_610_1.time_ and arg_610_1.time_ < 0 + var_613_4 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - 0) / var_613_4

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= 0 + var_613_4 and arg_610_1.time_ < 0 + var_613_4 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play933011436 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 933011436
		arg_614_1.duration_ = 10.27

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play933011437(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1.var_.moveOldPos1033ui_story = arg_614_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_617_0 = 0.001

			if 0 <= arg_614_1.time_ and arg_614_1.time_ < 0 + var_617_0 then
				arg_614_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_614_1.time_ - 0) / var_617_0)
				arg_614_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_614_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_614_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_614_1.actors_["1033ui_story"].transform.position).z)
				arg_614_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_614_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_614_1.actors_["1033ui_story"].transform.localEulerAngles = arg_614_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_614_1.time_ >= 0 + var_617_0 and arg_614_1.time_ < 0 + var_617_0 + arg_617_0 then
				arg_614_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_614_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_614_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_614_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_614_1.actors_["1033ui_story"].transform.position).z)
				arg_614_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_614_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_614_1.actors_["1033ui_story"].transform.localEulerAngles = arg_614_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_617_1 = arg_614_1.actors_["1033ui_story"]

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 and not isNil(var_617_1) and arg_614_1.var_.characterEffect1033ui_story == nil then
				arg_614_1.var_.characterEffect1033ui_story = var_617_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_617_2 = 0.200000002980232

			if 0 <= arg_614_1.time_ and arg_614_1.time_ < 0 + var_617_2 and not isNil(var_617_1) then
				if arg_614_1.var_.characterEffect1033ui_story and not isNil(var_617_1) then
					arg_614_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_614_1.time_ >= 0 + var_617_2 and arg_614_1.time_ < 0 + var_617_2 + arg_617_0 and not isNil(var_617_1) and arg_614_1.var_.characterEffect1033ui_story then
				arg_614_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_617_4 = 0
			local var_617_5 = 1.15

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= var_617_4 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				arg_614_1.leftNameTxt_.text = arg_614_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_6 = arg_614_1:GetWordFromCfg(933011436)
				local var_617_7 = arg_614_1:FormatText(var_617_6.content)

				arg_614_1.text_.text = var_617_7

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_9 = 47 <= 0 and var_617_5 or var_617_5 * (utf8.len(var_617_7) / 47)

				if (47 <= 0 and var_617_5 or var_617_5 * (utf8.len(var_617_7) / 47)) > 0 and var_617_5 < var_617_9 then
					arg_614_1.talkMaxDuration = var_617_9

					if var_617_9 + var_617_4 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_9 + var_617_4
					end
				end

				arg_614_1.text_.text = var_617_7
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011436", "story_v_side_old_933011.awb") ~= 0 then
					local var_617_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011436", "story_v_side_old_933011.awb") / 1000

					if var_617_10 + var_617_4 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_10 + var_617_4
					end

					if var_617_6.prefab_name ~= "" and arg_614_1.actors_[var_617_6.prefab_name] ~= nil then
						local var_617_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_6.prefab_name].transform, "story_v_side_old_933011", "933011436", "story_v_side_old_933011.awb")

						arg_614_1:RecordAudio("933011436", var_617_11)
						arg_614_1:RecordAudio("933011436", var_617_11)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011436", "story_v_side_old_933011.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011436", "story_v_side_old_933011.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_12 = math.max(var_617_5, arg_614_1.talkMaxDuration)

			if var_617_4 <= arg_614_1.time_ and arg_614_1.time_ < var_617_4 + var_617_12 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_4) / var_617_12

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_4 + var_617_12 and arg_614_1.time_ < var_617_4 + var_617_12 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_614_1:InitPlayNodeList()
	end,
	Play933011437 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 933011437
		arg_618_1.duration_ = 9.1

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play933011438(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = 1.225

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				arg_618_1.leftNameTxt_.text = arg_618_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_1 = arg_618_1:GetWordFromCfg(933011437)
				local var_621_2 = arg_618_1:FormatText(var_621_1.content)

				arg_618_1.text_.text = var_621_2

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_4 = 49 <= 0 and var_621_0 or var_621_0 * (utf8.len(var_621_2) / 49)

				if (49 <= 0 and var_621_0 or var_621_0 * (utf8.len(var_621_2) / 49)) > 0 and var_621_0 < var_621_4 then
					arg_618_1.talkMaxDuration = var_621_4

					if var_621_4 + 0 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_4 + 0
					end
				end

				arg_618_1.text_.text = var_621_2
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011437", "story_v_side_old_933011.awb") ~= 0 then
					local var_621_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011437", "story_v_side_old_933011.awb") / 1000

					if var_621_5 + 0 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_5 + 0
					end

					if var_621_1.prefab_name ~= "" and arg_618_1.actors_[var_621_1.prefab_name] ~= nil then
						local var_621_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_1.prefab_name].transform, "story_v_side_old_933011", "933011437", "story_v_side_old_933011.awb")

						arg_618_1:RecordAudio("933011437", var_621_6)
						arg_618_1:RecordAudio("933011437", var_621_6)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011437", "story_v_side_old_933011.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011437", "story_v_side_old_933011.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_7 = math.max(var_621_0, arg_618_1.talkMaxDuration)

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_7 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - 0) / var_621_7

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= 0 + var_621_7 and arg_618_1.time_ < 0 + var_621_7 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {}

		arg_618_1:InitPlayNodeList()
	end,
	Play933011438 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 933011438
		arg_622_1.duration_ = 10.93

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play933011439(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1.var_.moveOldPos1033ui_story = arg_622_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_625_0 = 0.001

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_0 then
				arg_622_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_622_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_622_1.time_ - 0) / var_625_0)
				arg_622_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_622_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_622_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_622_1.actors_["1033ui_story"].transform.position).z)
				arg_622_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_622_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_622_1.actors_["1033ui_story"].transform.localEulerAngles = arg_622_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_622_1.time_ >= 0 + var_625_0 and arg_622_1.time_ < 0 + var_625_0 + arg_625_0 then
				arg_622_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_622_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_622_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_622_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_622_1.actors_["1033ui_story"].transform.position).z)
				arg_622_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_622_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_622_1.actors_["1033ui_story"].transform.localEulerAngles = arg_622_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_625_1 = 0
			local var_625_2 = 1.325

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= var_625_1 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, false)
				arg_622_1.callingController_:SetSelectedState("normal")

				local var_625_3 = arg_622_1:GetWordFromCfg(933011438)
				local var_625_4 = arg_622_1:FormatText(var_625_3.content)

				arg_622_1.text_.text = var_625_4

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_6 = 53 <= 0 and var_625_2 or var_625_2 * (utf8.len(var_625_4) / 53)

				if (53 <= 0 and var_625_2 or var_625_2 * (utf8.len(var_625_4) / 53)) > 0 and var_625_2 < var_625_6 then
					arg_622_1.talkMaxDuration = var_625_6

					if var_625_6 + var_625_1 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_6 + var_625_1
					end
				end

				arg_622_1.text_.text = var_625_4
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011438", "story_v_side_old_933011.awb") ~= 0 then
					local var_625_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011438", "story_v_side_old_933011.awb") / 1000

					if var_625_7 + var_625_1 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_7 + var_625_1
					end

					if var_625_3.prefab_name ~= "" and arg_622_1.actors_[var_625_3.prefab_name] ~= nil then
						local var_625_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_3.prefab_name].transform, "story_v_side_old_933011", "933011438", "story_v_side_old_933011.awb")

						arg_622_1:RecordAudio("933011438", var_625_8)
						arg_622_1:RecordAudio("933011438", var_625_8)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011438", "story_v_side_old_933011.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011438", "story_v_side_old_933011.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_9 = math.max(var_625_2, arg_622_1.talkMaxDuration)

			if var_625_1 <= arg_622_1.time_ and arg_622_1.time_ < var_625_1 + var_625_9 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_1) / var_625_9

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_1 + var_625_9 and arg_622_1.time_ < var_625_1 + var_625_9 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_622_1:InitPlayNodeList()
	end,
	Play933011439 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 933011439
		arg_626_1.duration_ = 9.3

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play933011440(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1.var_.moveOldPos1033ui_story = arg_626_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_629_0 = 0.001

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_0 then
				arg_626_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_626_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_626_1.time_ - 0) / var_629_0)
				arg_626_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_626_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_626_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_626_1.actors_["1033ui_story"].transform.position).z)
				arg_626_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_626_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_626_1.actors_["1033ui_story"].transform.localEulerAngles = arg_626_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_626_1.time_ >= 0 + var_629_0 and arg_626_1.time_ < 0 + var_629_0 + arg_629_0 then
				arg_626_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_626_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_626_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_626_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_626_1.actors_["1033ui_story"].transform.position).z)
				arg_626_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_626_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_626_1.actors_["1033ui_story"].transform.localEulerAngles = arg_626_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action446")
			end

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_629_1 = 0
			local var_629_2 = 1.175

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= var_629_1 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				arg_626_1.leftNameTxt_.text = arg_626_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_3 = arg_626_1:GetWordFromCfg(933011439)
				local var_629_4 = arg_626_1:FormatText(var_629_3.content)

				arg_626_1.text_.text = var_629_4

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_6 = 47 <= 0 and var_629_2 or var_629_2 * (utf8.len(var_629_4) / 47)

				if (47 <= 0 and var_629_2 or var_629_2 * (utf8.len(var_629_4) / 47)) > 0 and var_629_2 < var_629_6 then
					arg_626_1.talkMaxDuration = var_629_6

					if var_629_6 + var_629_1 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_6 + var_629_1
					end
				end

				arg_626_1.text_.text = var_629_4
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011439", "story_v_side_old_933011.awb") ~= 0 then
					local var_629_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011439", "story_v_side_old_933011.awb") / 1000

					if var_629_7 + var_629_1 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_7 + var_629_1
					end

					if var_629_3.prefab_name ~= "" and arg_626_1.actors_[var_629_3.prefab_name] ~= nil then
						local var_629_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_3.prefab_name].transform, "story_v_side_old_933011", "933011439", "story_v_side_old_933011.awb")

						arg_626_1:RecordAudio("933011439", var_629_8)
						arg_626_1:RecordAudio("933011439", var_629_8)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011439", "story_v_side_old_933011.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011439", "story_v_side_old_933011.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_9 = math.max(var_629_2, arg_626_1.talkMaxDuration)

			if var_629_1 <= arg_626_1.time_ and arg_626_1.time_ < var_629_1 + var_629_9 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_1) / var_629_9

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_1 + var_629_9 and arg_626_1.time_ < var_629_1 + var_629_9 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_626_1:InitPlayNodeList()
	end,
	Play933011440 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 933011440
		arg_630_1.duration_ = 5

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play933011441(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 and not isNil(arg_630_1.actors_["1033ui_story"]) and arg_630_1.var_.characterEffect1033ui_story == nil then
				arg_630_1.var_.characterEffect1033ui_story = arg_630_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_633_0 = 0.200000002980232

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_0 and not isNil(arg_630_1.actors_["1033ui_story"]) then
				if arg_630_1.var_.characterEffect1033ui_story and not isNil(arg_630_1.actors_["1033ui_story"]) then
					arg_630_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_630_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_630_1.time_ - 0) / var_633_0)
				end
			end

			if arg_630_1.time_ >= 0 + var_633_0 and arg_630_1.time_ < 0 + var_633_0 + arg_633_0 and not isNil(arg_630_1.actors_["1033ui_story"]) and arg_630_1.var_.characterEffect1033ui_story then
				arg_630_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_630_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_633_1 = 0
			local var_633_2 = 0.925

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= var_633_1 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				arg_630_1.leftNameTxt_.text = arg_630_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, true)
				arg_630_1.iconController_:SetSelectedState("hero")

				arg_630_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_630_1.callingController_:SetSelectedState("normal")

				arg_630_1.keyicon_.color = Color.New(1, 1, 1)
				arg_630_1.icon_.color = Color.New(1, 1, 1)

				local var_633_3 = arg_630_1:FormatText(arg_630_1:GetWordFromCfg(933011440).content)

				arg_630_1.text_.text = var_633_3

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_5 = 37 <= 0 and var_633_2 or var_633_2 * (utf8.len(var_633_3) / 37)

				if (37 <= 0 and var_633_2 or var_633_2 * (utf8.len(var_633_3) / 37)) > 0 and var_633_2 < var_633_5 then
					arg_630_1.talkMaxDuration = var_633_5

					if var_633_5 + var_633_1 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_5 + var_633_1
					end
				end

				arg_630_1.text_.text = var_633_3
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)
				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_6 = math.max(var_633_2, arg_630_1.talkMaxDuration)

			if var_633_1 <= arg_630_1.time_ and arg_630_1.time_ < var_633_1 + var_633_6 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_1) / var_633_6

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_1 + var_633_6 and arg_630_1.time_ < var_633_1 + var_633_6 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play933011441 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 933011441
		arg_634_1.duration_ = 9.1

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play933011442(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1.var_.moveOldPos1033ui_story = arg_634_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_637_0 = 0.001

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_0 then
				arg_634_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_634_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_634_1.time_ - 0) / var_637_0)
				arg_634_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_634_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_634_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_634_1.actors_["1033ui_story"].transform.position).z)
				arg_634_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_634_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_634_1.actors_["1033ui_story"].transform.localEulerAngles = arg_634_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_634_1.time_ >= 0 + var_637_0 and arg_634_1.time_ < 0 + var_637_0 + arg_637_0 then
				arg_634_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_634_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_634_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_634_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_634_1.actors_["1033ui_story"].transform.position).z)
				arg_634_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_634_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_634_1.actors_["1033ui_story"].transform.localEulerAngles = arg_634_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_637_1 = arg_634_1.actors_["1033ui_story"]

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 and not isNil(var_637_1) and arg_634_1.var_.characterEffect1033ui_story == nil then
				arg_634_1.var_.characterEffect1033ui_story = var_637_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_2 = 0.200000002980232

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_2 and not isNil(var_637_1) then
				if arg_634_1.var_.characterEffect1033ui_story and not isNil(var_637_1) then
					arg_634_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_634_1.time_ >= 0 + var_637_2 and arg_634_1.time_ < 0 + var_637_2 + arg_637_0 and not isNil(var_637_1) and arg_634_1.var_.characterEffect1033ui_story then
				arg_634_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action463")
			end

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_637_4 = 0
			local var_637_5 = 0.875

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= var_637_4 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, false)
				arg_634_1.callingController_:SetSelectedState("normal")

				local var_637_6 = arg_634_1:GetWordFromCfg(933011441)
				local var_637_7 = arg_634_1:FormatText(var_637_6.content)

				arg_634_1.text_.text = var_637_7

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_9 = 35 <= 0 and var_637_5 or var_637_5 * (utf8.len(var_637_7) / 35)

				if (35 <= 0 and var_637_5 or var_637_5 * (utf8.len(var_637_7) / 35)) > 0 and var_637_5 < var_637_9 then
					arg_634_1.talkMaxDuration = var_637_9

					if var_637_9 + var_637_4 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_9 + var_637_4
					end
				end

				arg_634_1.text_.text = var_637_7
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011441", "story_v_side_old_933011.awb") ~= 0 then
					local var_637_10 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011441", "story_v_side_old_933011.awb") / 1000

					if var_637_10 + var_637_4 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_10 + var_637_4
					end

					if var_637_6.prefab_name ~= "" and arg_634_1.actors_[var_637_6.prefab_name] ~= nil then
						local var_637_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_6.prefab_name].transform, "story_v_side_old_933011", "933011441", "story_v_side_old_933011.awb")

						arg_634_1:RecordAudio("933011441", var_637_11)
						arg_634_1:RecordAudio("933011441", var_637_11)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011441", "story_v_side_old_933011.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011441", "story_v_side_old_933011.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_12 = math.max(var_637_5, arg_634_1.talkMaxDuration)

			if var_637_4 <= arg_634_1.time_ and arg_634_1.time_ < var_637_4 + var_637_12 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_4) / var_637_12

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_4 + var_637_12 and arg_634_1.time_ < var_637_4 + var_637_12 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_634_1:InitPlayNodeList()
	end,
	Play933011442 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 933011442
		arg_638_1.duration_ = 2.07

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play933011443(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1.var_.moveOldPos10102ui_story = arg_638_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_641_0 = 0.001

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_0 then
				arg_638_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_638_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_638_1.time_ - 0) / var_641_0)
				arg_638_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_638_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["10102ui_story"].transform.position).z)
				arg_638_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_638_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_638_1.actors_["10102ui_story"].transform.localEulerAngles = arg_638_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_638_1.time_ >= 0 + var_641_0 and arg_638_1.time_ < 0 + var_641_0 + arg_641_0 then
				arg_638_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_638_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_638_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["10102ui_story"].transform.position).z)
				arg_638_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_638_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_638_1.actors_["10102ui_story"].transform.localEulerAngles = arg_638_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_641_1 = arg_638_1.actors_["1033ui_story"].transform

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1.var_.moveOldPos1033ui_story = var_641_1.localPosition
			end

			local var_641_2 = 0.001

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_2 then
				var_641_1.localPosition = Vector3.Lerp(arg_638_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_638_1.time_ - 0) / var_641_2)
				var_641_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_641_1.position).x, (manager.ui.mainCamera.transform.position - var_641_1.position).y, (manager.ui.mainCamera.transform.position - var_641_1.position).z)
				var_641_1.localEulerAngles.z = 0
				var_641_1.localEulerAngles.x = 0
				var_641_1.localEulerAngles = var_641_1.localEulerAngles
			end

			if arg_638_1.time_ >= 0 + var_641_2 and arg_638_1.time_ < 0 + var_641_2 + arg_641_0 then
				var_641_1.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				var_641_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_641_1.position).x, (manager.ui.mainCamera.transform.position - var_641_1.position).y, (manager.ui.mainCamera.transform.position - var_641_1.position).z)
				var_641_1.localEulerAngles.z = 0
				var_641_1.localEulerAngles.x = 0
				var_641_1.localEulerAngles = var_641_1.localEulerAngles
			end

			local var_641_3 = arg_638_1.actors_["10102ui_story"]

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 and not isNil(var_641_3) and arg_638_1.var_.characterEffect10102ui_story == nil then
				arg_638_1.var_.characterEffect10102ui_story = var_641_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_641_4 = 0.200000002980232

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_4 and not isNil(var_641_3) then
				if arg_638_1.var_.characterEffect10102ui_story and not isNil(var_641_3) then
					arg_638_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_638_1.time_ >= 0 + var_641_4 and arg_638_1.time_ < 0 + var_641_4 + arg_641_0 and not isNil(var_641_3) and arg_638_1.var_.characterEffect10102ui_story then
				arg_638_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_641_6 = arg_638_1.actors_["1033ui_story"]

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 and not isNil(var_641_6) and arg_638_1.var_.characterEffect1033ui_story == nil then
				arg_638_1.var_.characterEffect1033ui_story = var_641_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_641_7 = 0.200000002980232

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_7 and not isNil(var_641_6) then
				if arg_638_1.var_.characterEffect1033ui_story and not isNil(var_641_6) then
					arg_638_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_638_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_638_1.time_ - 0) / var_641_7)
				end
			end

			if arg_638_1.time_ >= 0 + var_641_7 and arg_638_1.time_ < 0 + var_641_7 + arg_641_0 and not isNil(var_641_6) and arg_638_1.var_.characterEffect1033ui_story then
				arg_638_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_638_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_641_8 = 0
			local var_641_9 = 0.225

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= var_641_8 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, true)

				arg_638_1.leftNameTxt_.text = arg_638_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_638_1.leftNameTxt_.transform)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1.leftNameTxt_.text)
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_10 = arg_638_1:GetWordFromCfg(933011442)
				local var_641_11 = arg_638_1:FormatText(var_641_10.content)

				arg_638_1.text_.text = var_641_11

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_13 = 9 <= 0 and var_641_9 or var_641_9 * (utf8.len(var_641_11) / 9)

				if (9 <= 0 and var_641_9 or var_641_9 * (utf8.len(var_641_11) / 9)) > 0 and var_641_9 < var_641_13 then
					arg_638_1.talkMaxDuration = var_641_13

					if var_641_13 + var_641_8 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_13 + var_641_8
					end
				end

				arg_638_1.text_.text = var_641_11
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011442", "story_v_side_old_933011.awb") ~= 0 then
					local var_641_14 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011442", "story_v_side_old_933011.awb") / 1000

					if var_641_14 + var_641_8 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_14 + var_641_8
					end

					if var_641_10.prefab_name ~= "" and arg_638_1.actors_[var_641_10.prefab_name] ~= nil then
						local var_641_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_638_1.actors_[var_641_10.prefab_name].transform, "story_v_side_old_933011", "933011442", "story_v_side_old_933011.awb")

						arg_638_1:RecordAudio("933011442", var_641_15)
						arg_638_1:RecordAudio("933011442", var_641_15)
					else
						arg_638_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011442", "story_v_side_old_933011.awb")
					end

					arg_638_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011442", "story_v_side_old_933011.awb")
				end

				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_16 = math.max(var_641_9, arg_638_1.talkMaxDuration)

			if var_641_8 <= arg_638_1.time_ and arg_638_1.time_ < var_641_8 + var_641_16 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_8) / var_641_16

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_8 + var_641_16 and arg_638_1.time_ < var_641_8 + var_641_16 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_638_1:InitPlayNodeList()
	end,
	Play933011443 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 933011443
		arg_642_1.duration_ = 11.73

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play933011444(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1.var_.moveOldPos1033ui_story = arg_642_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_645_0 = 0.001

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_0 then
				arg_642_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_642_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_642_1.time_ - 0) / var_645_0)
				arg_642_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_642_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_642_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_642_1.actors_["1033ui_story"].transform.position).z)
				arg_642_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_642_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_642_1.actors_["1033ui_story"].transform.localEulerAngles = arg_642_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_642_1.time_ >= 0 + var_645_0 and arg_642_1.time_ < 0 + var_645_0 + arg_645_0 then
				arg_642_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_642_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_642_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_642_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_642_1.actors_["1033ui_story"].transform.position).z)
				arg_642_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_642_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_642_1.actors_["1033ui_story"].transform.localEulerAngles = arg_642_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_645_1 = arg_642_1.actors_["1033ui_story"]

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 and not isNil(var_645_1) and arg_642_1.var_.characterEffect1033ui_story == nil then
				arg_642_1.var_.characterEffect1033ui_story = var_645_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_645_2 = 0.200000002980232

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_2 and not isNil(var_645_1) then
				if arg_642_1.var_.characterEffect1033ui_story and not isNil(var_645_1) then
					arg_642_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_642_1.time_ >= 0 + var_645_2 and arg_642_1.time_ < 0 + var_645_2 + arg_645_0 and not isNil(var_645_1) and arg_642_1.var_.characterEffect1033ui_story then
				arg_642_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_645_4 = arg_642_1.actors_["10102ui_story"]

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 and not isNil(var_645_4) and arg_642_1.var_.characterEffect10102ui_story == nil then
				arg_642_1.var_.characterEffect10102ui_story = var_645_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_645_5 = 0.200000002980232

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_5 and not isNil(var_645_4) then
				if arg_642_1.var_.characterEffect10102ui_story and not isNil(var_645_4) then
					arg_642_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_642_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_642_1.time_ - 0) / var_645_5)
				end
			end

			if arg_642_1.time_ >= 0 + var_645_5 and arg_642_1.time_ < 0 + var_645_5 + arg_645_0 and not isNil(var_645_4) and arg_642_1.var_.characterEffect10102ui_story then
				arg_642_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_642_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_2")
			end

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_645_6 = 0
			local var_645_7 = 1.275

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= var_645_6 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				arg_642_1.leftNameTxt_.text = arg_642_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_8 = arg_642_1:GetWordFromCfg(933011443)
				local var_645_9 = arg_642_1:FormatText(var_645_8.content)

				arg_642_1.text_.text = var_645_9

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_11 = 51 <= 0 and var_645_7 or var_645_7 * (utf8.len(var_645_9) / 51)

				if (51 <= 0 and var_645_7 or var_645_7 * (utf8.len(var_645_9) / 51)) > 0 and var_645_7 < var_645_11 then
					arg_642_1.talkMaxDuration = var_645_11

					if var_645_11 + var_645_6 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_11 + var_645_6
					end
				end

				arg_642_1.text_.text = var_645_9
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011443", "story_v_side_old_933011.awb") ~= 0 then
					local var_645_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011443", "story_v_side_old_933011.awb") / 1000

					if var_645_12 + var_645_6 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_12 + var_645_6
					end

					if var_645_8.prefab_name ~= "" and arg_642_1.actors_[var_645_8.prefab_name] ~= nil then
						local var_645_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_642_1.actors_[var_645_8.prefab_name].transform, "story_v_side_old_933011", "933011443", "story_v_side_old_933011.awb")

						arg_642_1:RecordAudio("933011443", var_645_13)
						arg_642_1:RecordAudio("933011443", var_645_13)
					else
						arg_642_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011443", "story_v_side_old_933011.awb")
					end

					arg_642_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011443", "story_v_side_old_933011.awb")
				end

				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_14 = math.max(var_645_7, arg_642_1.talkMaxDuration)

			if var_645_6 <= arg_642_1.time_ and arg_642_1.time_ < var_645_6 + var_645_14 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_6) / var_645_14

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_6 + var_645_14 and arg_642_1.time_ < var_645_6 + var_645_14 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_642_1:InitPlayNodeList()
	end,
	Play933011444 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 933011444
		arg_646_1.duration_ = 11.9

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play933011445(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			local var_649_0 = 1.45

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, true)

				arg_646_1.leftNameTxt_.text = arg_646_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_646_1.leftNameTxt_.transform)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1.leftNameTxt_.text)
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_1 = arg_646_1:GetWordFromCfg(933011444)
				local var_649_2 = arg_646_1:FormatText(var_649_1.content)

				arg_646_1.text_.text = var_649_2

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_4 = 58 <= 0 and var_649_0 or var_649_0 * (utf8.len(var_649_2) / 58)

				if (58 <= 0 and var_649_0 or var_649_0 * (utf8.len(var_649_2) / 58)) > 0 and var_649_0 < var_649_4 then
					arg_646_1.talkMaxDuration = var_649_4

					if var_649_4 + 0 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_4 + 0
					end
				end

				arg_646_1.text_.text = var_649_2
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011444", "story_v_side_old_933011.awb") ~= 0 then
					local var_649_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011444", "story_v_side_old_933011.awb") / 1000

					if var_649_5 + 0 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_5 + 0
					end

					if var_649_1.prefab_name ~= "" and arg_646_1.actors_[var_649_1.prefab_name] ~= nil then
						local var_649_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_646_1.actors_[var_649_1.prefab_name].transform, "story_v_side_old_933011", "933011444", "story_v_side_old_933011.awb")

						arg_646_1:RecordAudio("933011444", var_649_6)
						arg_646_1:RecordAudio("933011444", var_649_6)
					else
						arg_646_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011444", "story_v_side_old_933011.awb")
					end

					arg_646_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011444", "story_v_side_old_933011.awb")
				end

				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_7 = math.max(var_649_0, arg_646_1.talkMaxDuration)

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_7 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - 0) / var_649_7

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= 0 + var_649_7 and arg_646_1.time_ < 0 + var_649_7 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {}

		arg_646_1:InitPlayNodeList()
	end,
	Play933011445 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 933011445
		arg_650_1.duration_ = 10.7

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play933011446(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			local var_653_0 = 1.35

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, true)

				arg_650_1.leftNameTxt_.text = arg_650_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_1 = arg_650_1:GetWordFromCfg(933011445)
				local var_653_2 = arg_650_1:FormatText(var_653_1.content)

				arg_650_1.text_.text = var_653_2

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_4 = 54 <= 0 and var_653_0 or var_653_0 * (utf8.len(var_653_2) / 54)

				if (54 <= 0 and var_653_0 or var_653_0 * (utf8.len(var_653_2) / 54)) > 0 and var_653_0 < var_653_4 then
					arg_650_1.talkMaxDuration = var_653_4

					if var_653_4 + 0 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_4 + 0
					end
				end

				arg_650_1.text_.text = var_653_2
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011445", "story_v_side_old_933011.awb") ~= 0 then
					local var_653_5 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011445", "story_v_side_old_933011.awb") / 1000

					if var_653_5 + 0 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_5 + 0
					end

					if var_653_1.prefab_name ~= "" and arg_650_1.actors_[var_653_1.prefab_name] ~= nil then
						local var_653_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_650_1.actors_[var_653_1.prefab_name].transform, "story_v_side_old_933011", "933011445", "story_v_side_old_933011.awb")

						arg_650_1:RecordAudio("933011445", var_653_6)
						arg_650_1:RecordAudio("933011445", var_653_6)
					else
						arg_650_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011445", "story_v_side_old_933011.awb")
					end

					arg_650_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011445", "story_v_side_old_933011.awb")
				end

				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_7 = math.max(var_653_0, arg_650_1.talkMaxDuration)

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_7 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - 0) / var_653_7

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= 0 + var_653_7 and arg_650_1.time_ < 0 + var_653_7 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {}

		arg_650_1:InitPlayNodeList()
	end,
	Play933011446 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 933011446
		arg_654_1.duration_ = 5.23

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play933011447(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 then
				arg_654_1.var_.moveOldPos10102ui_story = arg_654_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_657_0 = 0.001

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_0 then
				arg_654_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_654_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_654_1.time_ - 0) / var_657_0)
				arg_654_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_654_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_654_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_654_1.actors_["10102ui_story"].transform.position).z)
				arg_654_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_654_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_654_1.actors_["10102ui_story"].transform.localEulerAngles = arg_654_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_654_1.time_ >= 0 + var_657_0 and arg_654_1.time_ < 0 + var_657_0 + arg_657_0 then
				arg_654_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_654_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_654_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_654_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_654_1.actors_["10102ui_story"].transform.position).z)
				arg_654_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_654_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_654_1.actors_["10102ui_story"].transform.localEulerAngles = arg_654_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_657_1 = arg_654_1.actors_["10102ui_story"]

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 and not isNil(var_657_1) and arg_654_1.var_.characterEffect10102ui_story == nil then
				arg_654_1.var_.characterEffect10102ui_story = var_657_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_657_2 = 0.200000002980232

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_2 and not isNil(var_657_1) then
				if arg_654_1.var_.characterEffect10102ui_story and not isNil(var_657_1) then
					arg_654_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_654_1.time_ >= 0 + var_657_2 and arg_654_1.time_ < 0 + var_657_2 + arg_657_0 and not isNil(var_657_1) and arg_654_1.var_.characterEffect10102ui_story then
				arg_654_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_657_4 = arg_654_1.actors_["1033ui_story"]

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 and not isNil(var_657_4) and arg_654_1.var_.characterEffect1033ui_story == nil then
				arg_654_1.var_.characterEffect1033ui_story = var_657_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_657_5 = 0.200000002980232

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_5 and not isNil(var_657_4) then
				if arg_654_1.var_.characterEffect1033ui_story and not isNil(var_657_4) then
					arg_654_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_654_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_654_1.time_ - 0) / var_657_5)
				end
			end

			if arg_654_1.time_ >= 0 + var_657_5 and arg_654_1.time_ < 0 + var_657_5 + arg_657_0 and not isNil(var_657_4) and arg_654_1.var_.characterEffect1033ui_story then
				arg_654_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_654_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 then
				arg_654_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 then
				arg_654_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_657_6 = 0
			local var_657_7 = 0.575

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= var_657_6 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				arg_654_1.leftNameTxt_.text = arg_654_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, false)
				arg_654_1.callingController_:SetSelectedState("normal")

				local var_657_8 = arg_654_1:GetWordFromCfg(933011446)
				local var_657_9 = arg_654_1:FormatText(var_657_8.content)

				arg_654_1.text_.text = var_657_9

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_11 = 23 <= 0 and var_657_7 or var_657_7 * (utf8.len(var_657_9) / 23)

				if (23 <= 0 and var_657_7 or var_657_7 * (utf8.len(var_657_9) / 23)) > 0 and var_657_7 < var_657_11 then
					arg_654_1.talkMaxDuration = var_657_11

					if var_657_11 + var_657_6 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_11 + var_657_6
					end
				end

				arg_654_1.text_.text = var_657_9
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011446", "story_v_side_old_933011.awb") ~= 0 then
					local var_657_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011446", "story_v_side_old_933011.awb") / 1000

					if var_657_12 + var_657_6 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_12 + var_657_6
					end

					if var_657_8.prefab_name ~= "" and arg_654_1.actors_[var_657_8.prefab_name] ~= nil then
						local var_657_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_654_1.actors_[var_657_8.prefab_name].transform, "story_v_side_old_933011", "933011446", "story_v_side_old_933011.awb")

						arg_654_1:RecordAudio("933011446", var_657_13)
						arg_654_1:RecordAudio("933011446", var_657_13)
					else
						arg_654_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011446", "story_v_side_old_933011.awb")
					end

					arg_654_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011446", "story_v_side_old_933011.awb")
				end

				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_14 = math.max(var_657_7, arg_654_1.talkMaxDuration)

			if var_657_6 <= arg_654_1.time_ and arg_654_1.time_ < var_657_6 + var_657_14 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_6) / var_657_14

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_6 + var_657_14 and arg_654_1.time_ < var_657_6 + var_657_14 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_654_1:InitPlayNodeList()
	end,
	Play933011447 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 933011447
		arg_658_1.duration_ = 6.27

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
		end

		function arg_658_1.playNext_(arg_660_0)
			if arg_660_0 == 1 then
				arg_658_0:Play933011448(arg_658_1)
			end
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1.var_.moveOldPos1033ui_story = arg_658_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_661_0 = 0.001

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_0 then
				arg_658_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_658_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_658_1.time_ - 0) / var_661_0)
				arg_658_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_658_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1033ui_story"].transform.position).z)
				arg_658_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_658_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_658_1.actors_["1033ui_story"].transform.localEulerAngles = arg_658_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_658_1.time_ >= 0 + var_661_0 and arg_658_1.time_ < 0 + var_661_0 + arg_661_0 then
				arg_658_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_658_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_658_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1033ui_story"].transform.position).z)
				arg_658_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_658_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_658_1.actors_["1033ui_story"].transform.localEulerAngles = arg_658_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_661_1 = arg_658_1.actors_["1033ui_story"]

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 and not isNil(var_661_1) and arg_658_1.var_.characterEffect1033ui_story == nil then
				arg_658_1.var_.characterEffect1033ui_story = var_661_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_661_2 = 0.200000002980232

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_2 and not isNil(var_661_1) then
				if arg_658_1.var_.characterEffect1033ui_story and not isNil(var_661_1) then
					arg_658_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_658_1.time_ >= 0 + var_661_2 and arg_658_1.time_ < 0 + var_661_2 + arg_661_0 and not isNil(var_661_1) and arg_658_1.var_.characterEffect1033ui_story then
				arg_658_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_661_4 = arg_658_1.actors_["10102ui_story"]

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 and not isNil(var_661_4) and arg_658_1.var_.characterEffect10102ui_story == nil then
				arg_658_1.var_.characterEffect10102ui_story = var_661_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_661_5 = 0.200000002980232

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_5 and not isNil(var_661_4) then
				if arg_658_1.var_.characterEffect10102ui_story and not isNil(var_661_4) then
					arg_658_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_658_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_658_1.time_ - 0) / var_661_5)
				end
			end

			if arg_658_1.time_ >= 0 + var_661_5 and arg_658_1.time_ < 0 + var_661_5 + arg_661_0 and not isNil(var_661_4) and arg_658_1.var_.characterEffect10102ui_story then
				arg_658_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_658_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_661_6 = 0
			local var_661_7 = 0.775

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= var_661_6 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				arg_658_1.leftNameTxt_.text = arg_658_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, false)
				arg_658_1.callingController_:SetSelectedState("normal")

				local var_661_8 = arg_658_1:GetWordFromCfg(933011447)
				local var_661_9 = arg_658_1:FormatText(var_661_8.content)

				arg_658_1.text_.text = var_661_9

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_11 = 31 <= 0 and var_661_7 or var_661_7 * (utf8.len(var_661_9) / 31)

				if (31 <= 0 and var_661_7 or var_661_7 * (utf8.len(var_661_9) / 31)) > 0 and var_661_7 < var_661_11 then
					arg_658_1.talkMaxDuration = var_661_11

					if var_661_11 + var_661_6 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_11 + var_661_6
					end
				end

				arg_658_1.text_.text = var_661_9
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011447", "story_v_side_old_933011.awb") ~= 0 then
					local var_661_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011447", "story_v_side_old_933011.awb") / 1000

					if var_661_12 + var_661_6 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_12 + var_661_6
					end

					if var_661_8.prefab_name ~= "" and arg_658_1.actors_[var_661_8.prefab_name] ~= nil then
						local var_661_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_658_1.actors_[var_661_8.prefab_name].transform, "story_v_side_old_933011", "933011447", "story_v_side_old_933011.awb")

						arg_658_1:RecordAudio("933011447", var_661_13)
						arg_658_1:RecordAudio("933011447", var_661_13)
					else
						arg_658_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011447", "story_v_side_old_933011.awb")
					end

					arg_658_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011447", "story_v_side_old_933011.awb")
				end

				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_14 = math.max(var_661_7, arg_658_1.talkMaxDuration)

			if var_661_6 <= arg_658_1.time_ and arg_658_1.time_ < var_661_6 + var_661_14 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - var_661_6) / var_661_14

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= var_661_6 + var_661_14 and arg_658_1.time_ < var_661_6 + var_661_14 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_658_1:InitPlayNodeList()
	end,
	Play933011448 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 933011448
		arg_662_1.duration_ = 10.63

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play933011449(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 then
				arg_662_1.var_.moveOldPos1033ui_story = arg_662_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_665_0 = 0.001

			if 0 <= arg_662_1.time_ and arg_662_1.time_ < 0 + var_665_0 then
				arg_662_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_662_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_662_1.time_ - 0) / var_665_0)
				arg_662_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_662_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_662_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_662_1.actors_["1033ui_story"].transform.position).z)
				arg_662_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_662_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_662_1.actors_["1033ui_story"].transform.localEulerAngles = arg_662_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_662_1.time_ >= 0 + var_665_0 and arg_662_1.time_ < 0 + var_665_0 + arg_665_0 then
				arg_662_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_662_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_662_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_662_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_662_1.actors_["1033ui_story"].transform.position).z)
				arg_662_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_662_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_662_1.actors_["1033ui_story"].transform.localEulerAngles = arg_662_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 then
				arg_662_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 then
				arg_662_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_665_1 = 0
			local var_665_2 = 1.4

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= var_665_1 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				arg_662_1.leftNameTxt_.text = arg_662_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, false)
				arg_662_1.callingController_:SetSelectedState("normal")

				local var_665_3 = arg_662_1:GetWordFromCfg(933011448)
				local var_665_4 = arg_662_1:FormatText(var_665_3.content)

				arg_662_1.text_.text = var_665_4

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_6 = 56 <= 0 and var_665_2 or var_665_2 * (utf8.len(var_665_4) / 56)

				if (56 <= 0 and var_665_2 or var_665_2 * (utf8.len(var_665_4) / 56)) > 0 and var_665_2 < var_665_6 then
					arg_662_1.talkMaxDuration = var_665_6

					if var_665_6 + var_665_1 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_6 + var_665_1
					end
				end

				arg_662_1.text_.text = var_665_4
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011448", "story_v_side_old_933011.awb") ~= 0 then
					local var_665_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011448", "story_v_side_old_933011.awb") / 1000

					if var_665_7 + var_665_1 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_7 + var_665_1
					end

					if var_665_3.prefab_name ~= "" and arg_662_1.actors_[var_665_3.prefab_name] ~= nil then
						local var_665_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_3.prefab_name].transform, "story_v_side_old_933011", "933011448", "story_v_side_old_933011.awb")

						arg_662_1:RecordAudio("933011448", var_665_8)
						arg_662_1:RecordAudio("933011448", var_665_8)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011448", "story_v_side_old_933011.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011448", "story_v_side_old_933011.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_9 = math.max(var_665_2, arg_662_1.talkMaxDuration)

			if var_665_1 <= arg_662_1.time_ and arg_662_1.time_ < var_665_1 + var_665_9 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_1) / var_665_9

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_1 + var_665_9 and arg_662_1.time_ < var_665_1 + var_665_9 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_662_1:InitPlayNodeList()
	end,
	Play933011449 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 933011449
		arg_666_1.duration_ = 2

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play933011450(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 then
				arg_666_1.var_.moveOldPos10102ui_story = arg_666_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_669_0 = 0.001

			if 0 <= arg_666_1.time_ and arg_666_1.time_ < 0 + var_669_0 then
				arg_666_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_666_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_666_1.time_ - 0) / var_669_0)
				arg_666_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_666_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_666_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_666_1.actors_["10102ui_story"].transform.position).z)
				arg_666_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_666_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_666_1.actors_["10102ui_story"].transform.localEulerAngles = arg_666_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_666_1.time_ >= 0 + var_669_0 and arg_666_1.time_ < 0 + var_669_0 + arg_669_0 then
				arg_666_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_666_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_666_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_666_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_666_1.actors_["10102ui_story"].transform.position).z)
				arg_666_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_666_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_666_1.actors_["10102ui_story"].transform.localEulerAngles = arg_666_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_669_1 = arg_666_1.actors_["10102ui_story"]

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 and not isNil(var_669_1) and arg_666_1.var_.characterEffect10102ui_story == nil then
				arg_666_1.var_.characterEffect10102ui_story = var_669_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_669_2 = 0.200000002980232

			if 0 <= arg_666_1.time_ and arg_666_1.time_ < 0 + var_669_2 and not isNil(var_669_1) then
				if arg_666_1.var_.characterEffect10102ui_story and not isNil(var_669_1) then
					arg_666_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_666_1.time_ >= 0 + var_669_2 and arg_666_1.time_ < 0 + var_669_2 + arg_669_0 and not isNil(var_669_1) and arg_666_1.var_.characterEffect10102ui_story then
				arg_666_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_669_4 = arg_666_1.actors_["1033ui_story"]

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 and not isNil(var_669_4) and arg_666_1.var_.characterEffect1033ui_story == nil then
				arg_666_1.var_.characterEffect1033ui_story = var_669_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_669_5 = 0.200000002980232

			if 0 <= arg_666_1.time_ and arg_666_1.time_ < 0 + var_669_5 and not isNil(var_669_4) then
				if arg_666_1.var_.characterEffect1033ui_story and not isNil(var_669_4) then
					arg_666_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_666_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_666_1.time_ - 0) / var_669_5)
				end
			end

			if arg_666_1.time_ >= 0 + var_669_5 and arg_666_1.time_ < 0 + var_669_5 + arg_669_0 and not isNil(var_669_4) and arg_666_1.var_.characterEffect1033ui_story then
				arg_666_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_666_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 then
				arg_666_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action454")
			end

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 then
				arg_666_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_669_6 = 0
			local var_669_7 = 0.2

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= var_669_6 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, true)

				arg_666_1.leftNameTxt_.text = arg_666_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_666_1.leftNameTxt_.transform)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1.leftNameTxt_.text)
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_8 = arg_666_1:GetWordFromCfg(933011449)
				local var_669_9 = arg_666_1:FormatText(var_669_8.content)

				arg_666_1.text_.text = var_669_9

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_11 = 8 <= 0 and var_669_7 or var_669_7 * (utf8.len(var_669_9) / 8)

				if (8 <= 0 and var_669_7 or var_669_7 * (utf8.len(var_669_9) / 8)) > 0 and var_669_7 < var_669_11 then
					arg_666_1.talkMaxDuration = var_669_11

					if var_669_11 + var_669_6 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_11 + var_669_6
					end
				end

				arg_666_1.text_.text = var_669_9
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011449", "story_v_side_old_933011.awb") ~= 0 then
					local var_669_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011449", "story_v_side_old_933011.awb") / 1000

					if var_669_12 + var_669_6 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_12 + var_669_6
					end

					if var_669_8.prefab_name ~= "" and arg_666_1.actors_[var_669_8.prefab_name] ~= nil then
						local var_669_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_666_1.actors_[var_669_8.prefab_name].transform, "story_v_side_old_933011", "933011449", "story_v_side_old_933011.awb")

						arg_666_1:RecordAudio("933011449", var_669_13)
						arg_666_1:RecordAudio("933011449", var_669_13)
					else
						arg_666_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011449", "story_v_side_old_933011.awb")
					end

					arg_666_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011449", "story_v_side_old_933011.awb")
				end

				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_14 = math.max(var_669_7, arg_666_1.talkMaxDuration)

			if var_669_6 <= arg_666_1.time_ and arg_666_1.time_ < var_669_6 + var_669_14 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - var_669_6) / var_669_14

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= var_669_6 + var_669_14 and arg_666_1.time_ < var_669_6 + var_669_14 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_666_1:InitPlayNodeList()
	end,
	Play933011450 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 933011450
		arg_670_1.duration_ = 4.8

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play933011451(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 then
				arg_670_1.var_.moveOldPos1033ui_story = arg_670_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_673_0 = 0.001

			if 0 <= arg_670_1.time_ and arg_670_1.time_ < 0 + var_673_0 then
				arg_670_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_670_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_670_1.time_ - 0) / var_673_0)
				arg_670_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_670_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_670_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_670_1.actors_["1033ui_story"].transform.position).z)
				arg_670_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_670_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_670_1.actors_["1033ui_story"].transform.localEulerAngles = arg_670_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_670_1.time_ >= 0 + var_673_0 and arg_670_1.time_ < 0 + var_673_0 + arg_673_0 then
				arg_670_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_670_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_670_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_670_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_670_1.actors_["1033ui_story"].transform.position).z)
				arg_670_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_670_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_670_1.actors_["1033ui_story"].transform.localEulerAngles = arg_670_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_673_1 = arg_670_1.actors_["1033ui_story"]

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 and not isNil(var_673_1) and arg_670_1.var_.characterEffect1033ui_story == nil then
				arg_670_1.var_.characterEffect1033ui_story = var_673_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_673_2 = 0.200000002980232

			if 0 <= arg_670_1.time_ and arg_670_1.time_ < 0 + var_673_2 and not isNil(var_673_1) then
				if arg_670_1.var_.characterEffect1033ui_story and not isNil(var_673_1) then
					arg_670_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_670_1.time_ >= 0 + var_673_2 and arg_670_1.time_ < 0 + var_673_2 + arg_673_0 and not isNil(var_673_1) and arg_670_1.var_.characterEffect1033ui_story then
				arg_670_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_673_4 = arg_670_1.actors_["10102ui_story"]

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 and not isNil(var_673_4) and arg_670_1.var_.characterEffect10102ui_story == nil then
				arg_670_1.var_.characterEffect10102ui_story = var_673_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_673_5 = 0.200000002980232

			if 0 <= arg_670_1.time_ and arg_670_1.time_ < 0 + var_673_5 and not isNil(var_673_4) then
				if arg_670_1.var_.characterEffect10102ui_story and not isNil(var_673_4) then
					arg_670_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_670_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_670_1.time_ - 0) / var_673_5)
				end
			end

			if arg_670_1.time_ >= 0 + var_673_5 and arg_670_1.time_ < 0 + var_673_5 + arg_673_0 and not isNil(var_673_4) and arg_670_1.var_.characterEffect10102ui_story then
				arg_670_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_670_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 then
				arg_670_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_2")
			end

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 then
				arg_670_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 then
				arg_670_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			local var_673_6 = 0
			local var_673_7 = 0.5

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= var_673_6 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, true)

				arg_670_1.leftNameTxt_.text = arg_670_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_670_1.leftNameTxt_.transform)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1.leftNameTxt_.text)
				SetActive(arg_670_1.iconTrs_.gameObject, false)
				arg_670_1.callingController_:SetSelectedState("normal")

				local var_673_8 = arg_670_1:GetWordFromCfg(933011450)
				local var_673_9 = arg_670_1:FormatText(var_673_8.content)

				arg_670_1.text_.text = var_673_9

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_11 = 20 <= 0 and var_673_7 or var_673_7 * (utf8.len(var_673_9) / 20)

				if (20 <= 0 and var_673_7 or var_673_7 * (utf8.len(var_673_9) / 20)) > 0 and var_673_7 < var_673_11 then
					arg_670_1.talkMaxDuration = var_673_11

					if var_673_11 + var_673_6 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_11 + var_673_6
					end
				end

				arg_670_1.text_.text = var_673_9
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011450", "story_v_side_old_933011.awb") ~= 0 then
					local var_673_12 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011450", "story_v_side_old_933011.awb") / 1000

					if var_673_12 + var_673_6 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_12 + var_673_6
					end

					if var_673_8.prefab_name ~= "" and arg_670_1.actors_[var_673_8.prefab_name] ~= nil then
						local var_673_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_670_1.actors_[var_673_8.prefab_name].transform, "story_v_side_old_933011", "933011450", "story_v_side_old_933011.awb")

						arg_670_1:RecordAudio("933011450", var_673_13)
						arg_670_1:RecordAudio("933011450", var_673_13)
					else
						arg_670_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011450", "story_v_side_old_933011.awb")
					end

					arg_670_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011450", "story_v_side_old_933011.awb")
				end

				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_14 = math.max(var_673_7, arg_670_1.talkMaxDuration)

			if var_673_6 <= arg_670_1.time_ and arg_670_1.time_ < var_673_6 + var_673_14 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - var_673_6) / var_673_14

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= var_673_6 + var_673_14 and arg_670_1.time_ < var_673_6 + var_673_14 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_670_1:InitPlayNodeList()
	end,
	Play933011451 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 933011451
		arg_674_1.duration_ = 4.8

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
		end

		function arg_674_1.playNext_(arg_676_0)
			if arg_676_0 == 1 then
				arg_674_0:Play933011452(arg_674_1)
			end
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1.var_.moveOldPos1033ui_story = arg_674_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_677_0 = 0.001

			if 0 <= arg_674_1.time_ and arg_674_1.time_ < 0 + var_677_0 then
				arg_674_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_674_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_674_1.time_ - 0) / var_677_0)
				arg_674_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_674_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1033ui_story"].transform.position).z)
				arg_674_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_674_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_674_1.actors_["1033ui_story"].transform.localEulerAngles = arg_674_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_674_1.time_ >= 0 + var_677_0 and arg_674_1.time_ < 0 + var_677_0 + arg_677_0 then
				arg_674_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_674_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_674_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1033ui_story"].transform.position).z)
				arg_674_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_674_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_674_1.actors_["1033ui_story"].transform.localEulerAngles = arg_674_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action5_1")
			end

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_677_1 = 0
			local var_677_2 = 0.65

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= var_677_1 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				arg_674_1.leftNameTxt_.text = arg_674_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_3 = arg_674_1:GetWordFromCfg(933011451)
				local var_677_4 = arg_674_1:FormatText(var_677_3.content)

				arg_674_1.text_.text = var_677_4

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_6 = 26 <= 0 and var_677_2 or var_677_2 * (utf8.len(var_677_4) / 26)

				if (26 <= 0 and var_677_2 or var_677_2 * (utf8.len(var_677_4) / 26)) > 0 and var_677_2 < var_677_6 then
					arg_674_1.talkMaxDuration = var_677_6

					if var_677_6 + var_677_1 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_6 + var_677_1
					end
				end

				arg_674_1.text_.text = var_677_4
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011451", "story_v_side_old_933011.awb") ~= 0 then
					local var_677_7 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011451", "story_v_side_old_933011.awb") / 1000

					if var_677_7 + var_677_1 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_7 + var_677_1
					end

					if var_677_3.prefab_name ~= "" and arg_674_1.actors_[var_677_3.prefab_name] ~= nil then
						local var_677_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_3.prefab_name].transform, "story_v_side_old_933011", "933011451", "story_v_side_old_933011.awb")

						arg_674_1:RecordAudio("933011451", var_677_8)
						arg_674_1:RecordAudio("933011451", var_677_8)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011451", "story_v_side_old_933011.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011451", "story_v_side_old_933011.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_9 = math.max(var_677_2, arg_674_1.talkMaxDuration)

			if var_677_1 <= arg_674_1.time_ and arg_674_1.time_ < var_677_1 + var_677_9 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - var_677_1) / var_677_9

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= var_677_1 + var_677_9 and arg_674_1.time_ < var_677_1 + var_677_9 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_674_1:InitPlayNodeList()
	end,
	Play933011452 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 933011452
		arg_678_1.duration_ = 9

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play933011453(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			if arg_678_1.bgs_.ST21 == nil then
				local var_681_0 = Object.Instantiate(arg_678_1.paintGo_)

				var_681_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST21")
				var_681_0.name = "ST21"
				var_681_0.transform.parent = arg_678_1.stage_.transform
				var_681_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_678_1.bgs_.ST21 = var_681_0
			end

			if 2 < arg_678_1.time_ and arg_678_1.time_ <= 2 + arg_681_0 then
				local var_681_1 = arg_678_1.bgs_.ST21

				arg_678_1.bgs_.ST21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_681_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_681_2 = var_681_1:GetComponent("SpriteRenderer")

				if var_681_2 and var_681_2.sprite then
					local var_681_3 = 2 * (var_681_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_681_1.transform.localScale = Vector3.New(var_681_3 / var_681_2.sprite.bounds.size.y < var_681_3 * manager.ui.mainCameraCom_.aspect / var_681_2.sprite.bounds.size.x and var_681_3 * manager.ui.mainCameraCom_.aspect / var_681_2.sprite.bounds.size.x or var_681_3 / var_681_2.sprite.bounds.size.y, var_681_3 / var_681_2.sprite.bounds.size.y < var_681_3 * manager.ui.mainCameraCom_.aspect / var_681_2.sprite.bounds.size.x and var_681_3 * manager.ui.mainCameraCom_.aspect / var_681_2.sprite.bounds.size.x or var_681_3 / var_681_2.sprite.bounds.size.y, 0)
				end

				for iter_681_0, iter_681_1 in pairs(arg_678_1.bgs_) do
					if iter_681_0 ~= "ST21" then
						iter_681_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_681_4 = 3.999999999999

			if 3.999999999999 < arg_678_1.time_ and arg_678_1.time_ <= var_681_4 + arg_681_0 then
				arg_678_1.allBtn_.enabled = false
			end

			if arg_678_1.time_ >= var_681_4 + 0.3 and arg_678_1.time_ < var_681_4 + 0.3 + arg_681_0 then
				arg_678_1.allBtn_.enabled = true
			end

			local var_681_5 = 0

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= var_681_5 + arg_681_0 then
				arg_678_1.mask_.enabled = true
				arg_678_1.mask_.raycastTarget = true

				arg_678_1:SetGaussion(false)
			end

			local var_681_6 = 2

			if var_681_5 <= arg_678_1.time_ and arg_678_1.time_ < var_681_5 + var_681_6 then
				local var_681_7 = Color.New(0, 0, 0)

				var_681_7.a = Mathf.Lerp(0, 1, (arg_678_1.time_ - var_681_5) / var_681_6)
				arg_678_1.mask_.color = var_681_7
			end

			if arg_678_1.time_ >= var_681_5 + var_681_6 and arg_678_1.time_ < var_681_5 + var_681_6 + arg_681_0 then
				local var_681_8 = Color.New(0, 0, 0)

				var_681_8.a = 1
				arg_678_1.mask_.color = var_681_8
			end

			local var_681_9 = 2

			if 2 < arg_678_1.time_ and arg_678_1.time_ <= var_681_9 + arg_681_0 then
				arg_678_1.mask_.enabled = true
				arg_678_1.mask_.raycastTarget = true

				arg_678_1:SetGaussion(false)
			end

			local var_681_10 = 2

			if var_681_9 <= arg_678_1.time_ and arg_678_1.time_ < var_681_9 + var_681_10 then
				local var_681_11 = Color.New(0, 0, 0)

				var_681_11.a = Mathf.Lerp(1, 0, (arg_678_1.time_ - var_681_9) / var_681_10)
				arg_678_1.mask_.color = var_681_11
			end

			if arg_678_1.time_ >= var_681_9 + var_681_10 and arg_678_1.time_ < var_681_9 + var_681_10 + arg_681_0 then
				local var_681_12 = Color.New(0, 0, 0)

				arg_678_1.mask_.enabled = false
				var_681_12.a = 0
				arg_678_1.mask_.color = var_681_12
			end

			local var_681_13 = arg_678_1.actors_["10102ui_story"].transform

			if 1.96599999815226 < arg_678_1.time_ and arg_678_1.time_ <= 1.96599999815226 + arg_681_0 then
				arg_678_1.var_.moveOldPos10102ui_story = var_681_13.localPosition
			end

			local var_681_14 = 0.001

			if 1.96599999815226 <= arg_678_1.time_ and arg_678_1.time_ < 1.96599999815226 + var_681_14 then
				var_681_13.localPosition = Vector3.Lerp(arg_678_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_678_1.time_ - 1.96599999815226) / var_681_14)
				var_681_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_681_13.position).x, (manager.ui.mainCamera.transform.position - var_681_13.position).y, (manager.ui.mainCamera.transform.position - var_681_13.position).z)
				var_681_13.localEulerAngles.z = 0
				var_681_13.localEulerAngles.x = 0
				var_681_13.localEulerAngles = var_681_13.localEulerAngles
			end

			if arg_678_1.time_ >= 1.96599999815226 + var_681_14 and arg_678_1.time_ < 1.96599999815226 + var_681_14 + arg_681_0 then
				var_681_13.localPosition = Vector3.New(0, 100, 0)
				var_681_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_681_13.position).x, (manager.ui.mainCamera.transform.position - var_681_13.position).y, (manager.ui.mainCamera.transform.position - var_681_13.position).z)
				var_681_13.localEulerAngles.z = 0
				var_681_13.localEulerAngles.x = 0
				var_681_13.localEulerAngles = var_681_13.localEulerAngles
			end

			local var_681_15 = arg_678_1.actors_["1033ui_story"].transform

			if 1.96599999815226 < arg_678_1.time_ and arg_678_1.time_ <= 1.96599999815226 + arg_681_0 then
				arg_678_1.var_.moveOldPos1033ui_story = var_681_15.localPosition
			end

			local var_681_16 = 0.001

			if 1.96599999815226 <= arg_678_1.time_ and arg_678_1.time_ < 1.96599999815226 + var_681_16 then
				var_681_15.localPosition = Vector3.Lerp(arg_678_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_678_1.time_ - 1.96599999815226) / var_681_16)
				var_681_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_681_15.position).x, (manager.ui.mainCamera.transform.position - var_681_15.position).y, (manager.ui.mainCamera.transform.position - var_681_15.position).z)
				var_681_15.localEulerAngles.z = 0
				var_681_15.localEulerAngles.x = 0
				var_681_15.localEulerAngles = var_681_15.localEulerAngles
			end

			if arg_678_1.time_ >= 1.96599999815226 + var_681_16 and arg_678_1.time_ < 1.96599999815226 + var_681_16 + arg_681_0 then
				var_681_15.localPosition = Vector3.New(0, 100, 0)
				var_681_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_681_15.position).x, (manager.ui.mainCamera.transform.position - var_681_15.position).y, (manager.ui.mainCamera.transform.position - var_681_15.position).z)
				var_681_15.localEulerAngles.z = 0
				var_681_15.localEulerAngles.x = 0
				var_681_15.localEulerAngles = var_681_15.localEulerAngles
			end

			local var_681_17 = arg_678_1.actors_["1033ui_story"]

			if 1.96599999815226 < arg_678_1.time_ and arg_678_1.time_ <= 1.96599999815226 + arg_681_0 and not isNil(var_681_17) and arg_678_1.var_.characterEffect1033ui_story == nil then
				arg_678_1.var_.characterEffect1033ui_story = var_681_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_681_18 = 0.034000001847744

			if 1.96599999815226 <= arg_678_1.time_ and arg_678_1.time_ < 1.96599999815226 + var_681_18 and not isNil(var_681_17) then
				if arg_678_1.var_.characterEffect1033ui_story and not isNil(var_681_17) then
					arg_678_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_678_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_678_1.time_ - 1.96599999815226) / var_681_18)
				end
			end

			if arg_678_1.time_ >= 1.96599999815226 + var_681_18 and arg_678_1.time_ < 1.96599999815226 + var_681_18 + arg_681_0 and not isNil(var_681_17) and arg_678_1.var_.characterEffect1033ui_story then
				arg_678_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_678_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0.233333333333333 < arg_678_1.time_ and arg_678_1.time_ <= 0.233333333333333 + arg_681_0 then
				arg_678_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_681_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_678_1.bgmTxt_.text ~= var_681_21 and arg_678_1.bgmTxt_.text ~= "" then
						if arg_678_1.bgmTxt2_.text ~= "" then
							arg_678_1.bgmTxt_.text = arg_678_1.bgmTxt2_.text
						end

						arg_678_1.bgmTxt2_.text = var_681_21

						arg_678_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_678_1.bgmTxt_.text = var_681_21
						arg_678_1.bgmTxt2_.text = var_681_21
					end

					if arg_678_1.bgmTimer then
						arg_678_1.bgmTimer:Stop()

						arg_678_1.bgmTimer = nil
					end

					if arg_678_1.settingData.show_music_name == 1 then
						arg_678_1.musicController:SetSelectedState("show")
						arg_678_1.musicAnimator_:Play("open", 0, 0)

						if arg_678_1.settingData.music_time ~= 0 then
							arg_678_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_678_1.settingData.music_time), function()
								if arg_678_1 == nil or isNil(arg_678_1.bgmTxt_) then
									return
								end

								arg_678_1.musicController:SetSelectedState("hide")
								arg_678_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_678_1.time_ and arg_678_1.time_ <= 0.233333333333333 + arg_681_0 then
				arg_678_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 1.46666666666667 < arg_678_1.time_ and arg_678_1.time_ <= 1.46666666666667 + arg_681_0 then
				arg_678_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_678_1.frameCnt_ <= 1 then
				arg_678_1.dialog_:SetActive(false)
			end

			local var_681_24 = 4
			local var_681_25 = 1

			if 4 < arg_678_1.time_ and arg_678_1.time_ <= var_681_24 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0

				arg_678_1.dialog_:SetActive(true)

				arg_678_1.dialogCg_.alpha = 0

				local var_681_26 = LeanTween.value(arg_678_1.dialog_, 0, 1, 0.3)

				var_681_26:setOnUpdate(LuaHelper.FloatAction(function(arg_683_0)
					arg_678_1.dialogCg_.alpha = arg_683_0
				end))
				var_681_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_678_1.dialog_)
					var_681_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_678_1.duration_ = arg_678_1.duration_ + 0.3

				SetActive(arg_678_1.leftNameGo_, false)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_678_1.iconTrs_.gameObject, false)
				arg_678_1.callingController_:SetSelectedState("normal")

				local var_681_27 = arg_678_1:FormatText(arg_678_1:GetWordFromCfg(933011452).content)

				arg_678_1.text_.text = var_681_27

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_29 = 40 <= 0 and var_681_25 or var_681_25 * (utf8.len(var_681_27) / 40)

				if (40 <= 0 and var_681_25 or var_681_25 * (utf8.len(var_681_27) / 40)) > 0 and var_681_25 < var_681_29 then
					arg_678_1.talkMaxDuration = var_681_29
					var_681_24 = var_681_24 + 0.3

					if var_681_29 + var_681_24 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_29 + var_681_24
					end
				end

				arg_678_1.text_.text = var_681_27
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)
				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_30 = var_681_24 + 0.3
			local var_681_31 = math.max(var_681_25, arg_678_1.talkMaxDuration)

			if var_681_24 + 0.3 <= arg_678_1.time_ and arg_678_1.time_ < var_681_30 + var_681_31 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - var_681_30) / var_681_31

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= var_681_30 + var_681_31 and arg_678_1.time_ < var_681_30 + var_681_31 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_678_1:InitPlayNodeList()
	end,
	Play933011453 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 933011453
		arg_685_1.duration_ = 5

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play933011454(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 0.85

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				arg_685_1.leftNameTxt_.text = arg_685_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, true)
				arg_685_1.iconController_:SetSelectedState("hero")

				arg_685_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_685_1.callingController_:SetSelectedState("normal")

				arg_685_1.keyicon_.color = Color.New(1, 1, 1)
				arg_685_1.icon_.color = Color.New(1, 1, 1)

				local var_688_1 = arg_685_1:FormatText(arg_685_1:GetWordFromCfg(933011453).content)

				arg_685_1.text_.text = var_688_1

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_3 = 34 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_1) / 34)

				if (34 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_1) / 34)) > 0 and var_688_0 < var_688_3 then
					arg_685_1.talkMaxDuration = var_688_3

					if var_688_3 + 0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_3 + 0
					end
				end

				arg_685_1.text_.text = var_688_1
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_4 = math.max(var_688_0, arg_685_1.talkMaxDuration)

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_4 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - 0) / var_688_4

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= 0 + var_688_4 and arg_685_1.time_ < 0 + var_688_4 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play933011454 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 933011454
		arg_689_1.duration_ = 5

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play933011455(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = 0.35

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				arg_689_1.leftNameTxt_.text = arg_689_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, true)
				arg_689_1.iconController_:SetSelectedState("hero")

				arg_689_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_689_1.callingController_:SetSelectedState("normal")

				arg_689_1.keyicon_.color = Color.New(1, 1, 1)
				arg_689_1.icon_.color = Color.New(1, 1, 1)

				local var_692_1 = arg_689_1:FormatText(arg_689_1:GetWordFromCfg(933011454).content)

				arg_689_1.text_.text = var_692_1

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_3 = 14 <= 0 and var_692_0 or var_692_0 * (utf8.len(var_692_1) / 14)

				if (14 <= 0 and var_692_0 or var_692_0 * (utf8.len(var_692_1) / 14)) > 0 and var_692_0 < var_692_3 then
					arg_689_1.talkMaxDuration = var_692_3

					if var_692_3 + 0 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_3 + 0
					end
				end

				arg_689_1.text_.text = var_692_1
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_4 = math.max(var_692_0, arg_689_1.talkMaxDuration)

			if 0 <= arg_689_1.time_ and arg_689_1.time_ < 0 + var_692_4 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - 0) / var_692_4

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= 0 + var_692_4 and arg_689_1.time_ < 0 + var_692_4 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play933011455 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 933011455
		arg_693_1.duration_ = 5

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play933011456(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = 0.75

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				arg_693_1.leftNameTxt_.text = arg_693_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, true)
				arg_693_1.iconController_:SetSelectedState("hero")

				arg_693_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_693_1.callingController_:SetSelectedState("normal")

				arg_693_1.keyicon_.color = Color.New(1, 1, 1)
				arg_693_1.icon_.color = Color.New(1, 1, 1)

				local var_696_1 = arg_693_1:FormatText(arg_693_1:GetWordFromCfg(933011455).content)

				arg_693_1.text_.text = var_696_1

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_3 = 30 <= 0 and var_696_0 or var_696_0 * (utf8.len(var_696_1) / 30)

				if (30 <= 0 and var_696_0 or var_696_0 * (utf8.len(var_696_1) / 30)) > 0 and var_696_0 < var_696_3 then
					arg_693_1.talkMaxDuration = var_696_3

					if var_696_3 + 0 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_3 + 0
					end
				end

				arg_693_1.text_.text = var_696_1
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)
				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_4 = math.max(var_696_0, arg_693_1.talkMaxDuration)

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_4 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - 0) / var_696_4

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= 0 + var_696_4 and arg_693_1.time_ < 0 + var_696_4 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play933011456 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 933011456
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play933011457(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = 0.95

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, false)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_1 = arg_697_1:FormatText(arg_697_1:GetWordFromCfg(933011456).content)

				arg_697_1.text_.text = var_700_1

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_3 = 38 <= 0 and var_700_0 or var_700_0 * (utf8.len(var_700_1) / 38)

				if (38 <= 0 and var_700_0 or var_700_0 * (utf8.len(var_700_1) / 38)) > 0 and var_700_0 < var_700_3 then
					arg_697_1.talkMaxDuration = var_700_3

					if var_700_3 + 0 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_3 + 0
					end
				end

				arg_697_1.text_.text = var_700_1
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_4 = math.max(var_700_0, arg_697_1.talkMaxDuration)

			if 0 <= arg_697_1.time_ and arg_697_1.time_ < 0 + var_700_4 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - 0) / var_700_4

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= 0 + var_700_4 and arg_697_1.time_ < 0 + var_700_4 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play933011457 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 933011457
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play933011458(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 1

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				arg_701_1.leftNameTxt_.text = arg_701_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, true)
				arg_701_1.iconController_:SetSelectedState("hero")

				arg_701_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_701_1.callingController_:SetSelectedState("normal")

				arg_701_1.keyicon_.color = Color.New(1, 1, 1)
				arg_701_1.icon_.color = Color.New(1, 1, 1)

				local var_704_1 = arg_701_1:FormatText(arg_701_1:GetWordFromCfg(933011457).content)

				arg_701_1.text_.text = var_704_1

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_3 = 40 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 40)

				if (40 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 40)) > 0 and var_704_0 < var_704_3 then
					arg_701_1.talkMaxDuration = var_704_3

					if var_704_3 + 0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_3 + 0
					end
				end

				arg_701_1.text_.text = var_704_1
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_4 = math.max(var_704_0, arg_701_1.talkMaxDuration)

			if 0 <= arg_701_1.time_ and arg_701_1.time_ < 0 + var_704_4 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - 0) / var_704_4

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= 0 + var_704_4 and arg_701_1.time_ < 0 + var_704_4 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play933011458 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 933011458
		arg_705_1.duration_ = 1

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"

			SetActive(arg_705_1.choicesGo_, true)

			for iter_706_0, iter_706_1 in ipairs(arg_705_1.choices_) do
				SetActive(iter_706_1.go, iter_706_0 <= 3)
			end

			arg_705_1.choices_[1].txt.text = arg_705_1:FormatText(StoryChoiceCfg[1586].name)
			arg_705_1.choices_[2].txt.text = arg_705_1:FormatText(StoryChoiceCfg[1587].name)
			arg_705_1.choices_[3].txt.text = arg_705_1:FormatText(StoryChoiceCfg[1588].name)
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play933011459(arg_705_1)
			end

			if arg_707_0 == 2 then
				arg_705_0:Play933011461(arg_705_1)
			end

			if arg_707_0 == 3 then
				arg_705_0:Play933011463(arg_705_1)
			end

			arg_705_1:RecordChoiceLog(933011458, 1586, 1587, 1588)
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.allBtn_.enabled = false
			end

			if arg_705_1.time_ >= 0 + 0.5 and arg_705_1.time_ < 0 + 0.5 + arg_708_0 then
				arg_705_1.allBtn_.enabled = true
			end
		end

		arg_705_1.nodeConfigList_ = {}

		arg_705_1:InitPlayNodeList()
	end,
	Play933011459 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 933011459
		arg_709_1.duration_ = 5

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play933011460(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = 0.95

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, true)

				arg_709_1.leftNameTxt_.text = arg_709_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_709_1.leftNameTxt_.transform)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1.leftNameTxt_.text)
				SetActive(arg_709_1.iconTrs_.gameObject, true)
				arg_709_1.iconController_:SetSelectedState("hero")

				arg_709_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_709_1.callingController_:SetSelectedState("normal")

				arg_709_1.keyicon_.color = Color.New(1, 1, 1)
				arg_709_1.icon_.color = Color.New(1, 1, 1)

				local var_712_1 = arg_709_1:FormatText(arg_709_1:GetWordFromCfg(933011459).content)

				arg_709_1.text_.text = var_712_1

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_3 = 38 <= 0 and var_712_0 or var_712_0 * (utf8.len(var_712_1) / 38)

				if (38 <= 0 and var_712_0 or var_712_0 * (utf8.len(var_712_1) / 38)) > 0 and var_712_0 < var_712_3 then
					arg_709_1.talkMaxDuration = var_712_3

					if var_712_3 + 0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_3 + 0
					end
				end

				arg_709_1.text_.text = var_712_1
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)
				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_4 = math.max(var_712_0, arg_709_1.talkMaxDuration)

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_4 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - 0) / var_712_4

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= 0 + var_712_4 and arg_709_1.time_ < 0 + var_712_4 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play933011460 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 933011460
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play933011465(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0.775

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				arg_713_1.leftNameTxt_.text = arg_713_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, true)
				arg_713_1.iconController_:SetSelectedState("hero")

				arg_713_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_713_1.callingController_:SetSelectedState("normal")

				arg_713_1.keyicon_.color = Color.New(1, 1, 1)
				arg_713_1.icon_.color = Color.New(1, 1, 1)

				local var_716_1 = arg_713_1:FormatText(arg_713_1:GetWordFromCfg(933011460).content)

				arg_713_1.text_.text = var_716_1

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_3 = 31 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 31)

				if (31 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 31)) > 0 and var_716_0 < var_716_3 then
					arg_713_1.talkMaxDuration = var_716_3

					if var_716_3 + 0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_3 + 0
					end
				end

				arg_713_1.text_.text = var_716_1
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)
				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_4 = math.max(var_716_0, arg_713_1.talkMaxDuration)

			if 0 <= arg_713_1.time_ and arg_713_1.time_ < 0 + var_716_4 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - 0) / var_716_4

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= 0 + var_716_4 and arg_713_1.time_ < 0 + var_716_4 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play933011465 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 933011465
		arg_717_1.duration_ = 5

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play933011466(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = 0.525

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				arg_717_1.leftNameTxt_.text = arg_717_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, true)
				arg_717_1.iconController_:SetSelectedState("hero")

				arg_717_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_717_1.callingController_:SetSelectedState("normal")

				arg_717_1.keyicon_.color = Color.New(1, 1, 1)
				arg_717_1.icon_.color = Color.New(1, 1, 1)

				local var_720_1 = arg_717_1:FormatText(arg_717_1:GetWordFromCfg(933011465).content)

				arg_717_1.text_.text = var_720_1

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_3 = 21 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_1) / 21)

				if (21 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_1) / 21)) > 0 and var_720_0 < var_720_3 then
					arg_717_1.talkMaxDuration = var_720_3

					if var_720_3 + 0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_3 + 0
					end
				end

				arg_717_1.text_.text = var_720_1
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)
				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_4 = math.max(var_720_0, arg_717_1.talkMaxDuration)

			if 0 <= arg_717_1.time_ and arg_717_1.time_ < 0 + var_720_4 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - 0) / var_720_4

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= 0 + var_720_4 and arg_717_1.time_ < 0 + var_720_4 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play933011466 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 933011466
		arg_721_1.duration_ = 5

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play933011467(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = 1.25

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, false)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_1 = arg_721_1:FormatText(arg_721_1:GetWordFromCfg(933011466).content)

				arg_721_1.text_.text = var_724_1

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_3 = 50 <= 0 and var_724_0 or var_724_0 * (utf8.len(var_724_1) / 50)

				if (50 <= 0 and var_724_0 or var_724_0 * (utf8.len(var_724_1) / 50)) > 0 and var_724_0 < var_724_3 then
					arg_721_1.talkMaxDuration = var_724_3

					if var_724_3 + 0 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_3 + 0
					end
				end

				arg_721_1.text_.text = var_724_1
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)
				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_4 = math.max(var_724_0, arg_721_1.talkMaxDuration)

			if 0 <= arg_721_1.time_ and arg_721_1.time_ < 0 + var_724_4 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - 0) / var_724_4

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= 0 + var_724_4 and arg_721_1.time_ < 0 + var_724_4 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play933011467 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 933011467
		arg_725_1.duration_ = 5

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play933011468(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			local var_728_0 = 1.675

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, false)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_725_1.iconTrs_.gameObject, false)
				arg_725_1.callingController_:SetSelectedState("normal")

				local var_728_1 = arg_725_1:FormatText(arg_725_1:GetWordFromCfg(933011467).content)

				arg_725_1.text_.text = var_728_1

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_3 = 67 <= 0 and var_728_0 or var_728_0 * (utf8.len(var_728_1) / 67)

				if (67 <= 0 and var_728_0 or var_728_0 * (utf8.len(var_728_1) / 67)) > 0 and var_728_0 < var_728_3 then
					arg_725_1.talkMaxDuration = var_728_3

					if var_728_3 + 0 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_3 + 0
					end
				end

				arg_725_1.text_.text = var_728_1
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)
				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_4 = math.max(var_728_0, arg_725_1.talkMaxDuration)

			if 0 <= arg_725_1.time_ and arg_725_1.time_ < 0 + var_728_4 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - 0) / var_728_4

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= 0 + var_728_4 and arg_725_1.time_ < 0 + var_728_4 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {}

		arg_725_1:InitPlayNodeList()
	end,
	Play933011468 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 933011468
		arg_729_1.duration_ = 5

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play933011469(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 0.125

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				arg_729_1.leftNameTxt_.text = arg_729_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, true)
				arg_729_1.iconController_:SetSelectedState("hero")

				arg_729_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_729_1.callingController_:SetSelectedState("normal")

				arg_729_1.keyicon_.color = Color.New(1, 1, 1)
				arg_729_1.icon_.color = Color.New(1, 1, 1)

				local var_732_1 = arg_729_1:FormatText(arg_729_1:GetWordFromCfg(933011468).content)

				arg_729_1.text_.text = var_732_1

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_3 = 5 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_1) / 5)

				if (5 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_1) / 5)) > 0 and var_732_0 < var_732_3 then
					arg_729_1.talkMaxDuration = var_732_3

					if var_732_3 + 0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_3 + 0
					end
				end

				arg_729_1.text_.text = var_732_1
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)
				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_4 = math.max(var_732_0, arg_729_1.talkMaxDuration)

			if 0 <= arg_729_1.time_ and arg_729_1.time_ < 0 + var_732_4 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - 0) / var_732_4

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= 0 + var_732_4 and arg_729_1.time_ < 0 + var_732_4 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play933011469 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 933011469
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play933011470(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = 1.6

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, false)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_1 = arg_733_1:FormatText(arg_733_1:GetWordFromCfg(933011469).content)

				arg_733_1.text_.text = var_736_1

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_3 = 64 <= 0 and var_736_0 or var_736_0 * (utf8.len(var_736_1) / 64)

				if (64 <= 0 and var_736_0 or var_736_0 * (utf8.len(var_736_1) / 64)) > 0 and var_736_0 < var_736_3 then
					arg_733_1.talkMaxDuration = var_736_3

					if var_736_3 + 0 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_3 + 0
					end
				end

				arg_733_1.text_.text = var_736_1
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_4 = math.max(var_736_0, arg_733_1.talkMaxDuration)

			if 0 <= arg_733_1.time_ and arg_733_1.time_ < 0 + var_736_4 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - 0) / var_736_4

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= 0 + var_736_4 and arg_733_1.time_ < 0 + var_736_4 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play933011470 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 933011470
		arg_737_1.duration_ = 5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play933011471(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			local var_740_0 = 0.6

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				arg_737_1.leftNameTxt_.text = arg_737_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, true)
				arg_737_1.iconController_:SetSelectedState("hero")

				arg_737_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_737_1.callingController_:SetSelectedState("normal")

				arg_737_1.keyicon_.color = Color.New(1, 1, 1)
				arg_737_1.icon_.color = Color.New(1, 1, 1)

				local var_740_1 = arg_737_1:FormatText(arg_737_1:GetWordFromCfg(933011470).content)

				arg_737_1.text_.text = var_740_1

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_3 = 24 <= 0 and var_740_0 or var_740_0 * (utf8.len(var_740_1) / 24)

				if (24 <= 0 and var_740_0 or var_740_0 * (utf8.len(var_740_1) / 24)) > 0 and var_740_0 < var_740_3 then
					arg_737_1.talkMaxDuration = var_740_3

					if var_740_3 + 0 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_3 + 0
					end
				end

				arg_737_1.text_.text = var_740_1
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)
				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_4 = math.max(var_740_0, arg_737_1.talkMaxDuration)

			if 0 <= arg_737_1.time_ and arg_737_1.time_ < 0 + var_740_4 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - 0) / var_740_4

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= 0 + var_740_4 and arg_737_1.time_ < 0 + var_740_4 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play933011471 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 933011471
		arg_741_1.duration_ = 5

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play933011472(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = 1

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				arg_741_1.leftNameTxt_.text = arg_741_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, true)
				arg_741_1.iconController_:SetSelectedState("hero")

				arg_741_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_741_1.callingController_:SetSelectedState("normal")

				arg_741_1.keyicon_.color = Color.New(1, 1, 1)
				arg_741_1.icon_.color = Color.New(1, 1, 1)

				local var_744_1 = arg_741_1:FormatText(arg_741_1:GetWordFromCfg(933011471).content)

				arg_741_1.text_.text = var_744_1

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_3 = 40 <= 0 and var_744_0 or var_744_0 * (utf8.len(var_744_1) / 40)

				if (40 <= 0 and var_744_0 or var_744_0 * (utf8.len(var_744_1) / 40)) > 0 and var_744_0 < var_744_3 then
					arg_741_1.talkMaxDuration = var_744_3

					if var_744_3 + 0 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_3 + 0
					end
				end

				arg_741_1.text_.text = var_744_1
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)
				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_4 = math.max(var_744_0, arg_741_1.talkMaxDuration)

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_4 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - 0) / var_744_4

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= 0 + var_744_4 and arg_741_1.time_ < 0 + var_744_4 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play933011472 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 933011472
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play933011473(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = 1.175

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, false)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_1 = arg_745_1:FormatText(arg_745_1:GetWordFromCfg(933011472).content)

				arg_745_1.text_.text = var_748_1

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_3 = 47 <= 0 and var_748_0 or var_748_0 * (utf8.len(var_748_1) / 47)

				if (47 <= 0 and var_748_0 or var_748_0 * (utf8.len(var_748_1) / 47)) > 0 and var_748_0 < var_748_3 then
					arg_745_1.talkMaxDuration = var_748_3

					if var_748_3 + 0 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_3 + 0
					end
				end

				arg_745_1.text_.text = var_748_1
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_4 = math.max(var_748_0, arg_745_1.talkMaxDuration)

			if 0 <= arg_745_1.time_ and arg_745_1.time_ < 0 + var_748_4 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - 0) / var_748_4

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= 0 + var_748_4 and arg_745_1.time_ < 0 + var_748_4 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play933011473 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 933011473
		arg_749_1.duration_ = 5

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
			arg_749_1.auto_ = false
		end

		function arg_749_1.playNext_(arg_751_0)
			arg_749_1.onStoryFinished_()
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			local var_752_0 = 0.625

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, true)

				arg_749_1.leftNameTxt_.text = arg_749_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, true)
				arg_749_1.iconController_:SetSelectedState("hero")

				arg_749_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_749_1.callingController_:SetSelectedState("normal")

				arg_749_1.keyicon_.color = Color.New(1, 1, 1)
				arg_749_1.icon_.color = Color.New(1, 1, 1)

				local var_752_1 = arg_749_1:FormatText(arg_749_1:GetWordFromCfg(933011473).content)

				arg_749_1.text_.text = var_752_1

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_3 = 25 <= 0 and var_752_0 or var_752_0 * (utf8.len(var_752_1) / 25)

				if (25 <= 0 and var_752_0 or var_752_0 * (utf8.len(var_752_1) / 25)) > 0 and var_752_0 < var_752_3 then
					arg_749_1.talkMaxDuration = var_752_3

					if var_752_3 + 0 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_3 + 0
					end
				end

				arg_749_1.text_.text = var_752_1
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)
				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_4 = math.max(var_752_0, arg_749_1.talkMaxDuration)

			if 0 <= arg_749_1.time_ and arg_749_1.time_ < 0 + var_752_4 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - 0) / var_752_4

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= 0 + var_752_4 and arg_749_1.time_ < 0 + var_752_4 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {}

		arg_749_1:InitPlayNodeList()
	end,
	Play933011461 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 933011461
		arg_753_1.duration_ = 5

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play933011462(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			local var_756_0 = 0.875

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, true)

				arg_753_1.leftNameTxt_.text = arg_753_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_753_1.leftNameTxt_.transform)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1.leftNameTxt_.text)
				SetActive(arg_753_1.iconTrs_.gameObject, true)
				arg_753_1.iconController_:SetSelectedState("hero")

				arg_753_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_753_1.callingController_:SetSelectedState("normal")

				arg_753_1.keyicon_.color = Color.New(1, 1, 1)
				arg_753_1.icon_.color = Color.New(1, 1, 1)

				local var_756_1 = arg_753_1:FormatText(arg_753_1:GetWordFromCfg(933011461).content)

				arg_753_1.text_.text = var_756_1

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_3 = 35 <= 0 and var_756_0 or var_756_0 * (utf8.len(var_756_1) / 35)

				if (35 <= 0 and var_756_0 or var_756_0 * (utf8.len(var_756_1) / 35)) > 0 and var_756_0 < var_756_3 then
					arg_753_1.talkMaxDuration = var_756_3

					if var_756_3 + 0 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_3 + 0
					end
				end

				arg_753_1.text_.text = var_756_1
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)
				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_4 = math.max(var_756_0, arg_753_1.talkMaxDuration)

			if 0 <= arg_753_1.time_ and arg_753_1.time_ < 0 + var_756_4 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - 0) / var_756_4

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= 0 + var_756_4 and arg_753_1.time_ < 0 + var_756_4 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play933011462 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 933011462
		arg_757_1.duration_ = 5

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play933011465(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			local var_760_0 = 1.325

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, true)

				arg_757_1.leftNameTxt_.text = arg_757_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_757_1.leftNameTxt_.transform)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1.leftNameTxt_.text)
				SetActive(arg_757_1.iconTrs_.gameObject, true)
				arg_757_1.iconController_:SetSelectedState("hero")

				arg_757_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_757_1.callingController_:SetSelectedState("normal")

				arg_757_1.keyicon_.color = Color.New(1, 1, 1)
				arg_757_1.icon_.color = Color.New(1, 1, 1)

				local var_760_1 = arg_757_1:FormatText(arg_757_1:GetWordFromCfg(933011462).content)

				arg_757_1.text_.text = var_760_1

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_3 = 53 <= 0 and var_760_0 or var_760_0 * (utf8.len(var_760_1) / 53)

				if (53 <= 0 and var_760_0 or var_760_0 * (utf8.len(var_760_1) / 53)) > 0 and var_760_0 < var_760_3 then
					arg_757_1.talkMaxDuration = var_760_3

					if var_760_3 + 0 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_3 + 0
					end
				end

				arg_757_1.text_.text = var_760_1
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)
				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_4 = math.max(var_760_0, arg_757_1.talkMaxDuration)

			if 0 <= arg_757_1.time_ and arg_757_1.time_ < 0 + var_760_4 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - 0) / var_760_4

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= 0 + var_760_4 and arg_757_1.time_ < 0 + var_760_4 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {}

		arg_757_1:InitPlayNodeList()
	end,
	Play933011463 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 933011463
		arg_761_1.duration_ = 5

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play933011464(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			local var_764_0 = 1.075

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				arg_761_1.leftNameTxt_.text = arg_761_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, true)
				arg_761_1.iconController_:SetSelectedState("hero")

				arg_761_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_761_1.callingController_:SetSelectedState("normal")

				arg_761_1.keyicon_.color = Color.New(1, 1, 1)
				arg_761_1.icon_.color = Color.New(1, 1, 1)

				local var_764_1 = arg_761_1:FormatText(arg_761_1:GetWordFromCfg(933011463).content)

				arg_761_1.text_.text = var_764_1

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_3 = 43 <= 0 and var_764_0 or var_764_0 * (utf8.len(var_764_1) / 43)

				if (43 <= 0 and var_764_0 or var_764_0 * (utf8.len(var_764_1) / 43)) > 0 and var_764_0 < var_764_3 then
					arg_761_1.talkMaxDuration = var_764_3

					if var_764_3 + 0 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_3 + 0
					end
				end

				arg_761_1.text_.text = var_764_1
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)
				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_4 = math.max(var_764_0, arg_761_1.talkMaxDuration)

			if 0 <= arg_761_1.time_ and arg_761_1.time_ < 0 + var_764_4 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - 0) / var_764_4

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= 0 + var_764_4 and arg_761_1.time_ < 0 + var_764_4 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play933011464 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 933011464
		arg_765_1.duration_ = 5

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play933011465(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			local var_768_0 = 0.95

			if 0 < arg_765_1.time_ and arg_765_1.time_ <= 0 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				arg_765_1.leftNameTxt_.text = arg_765_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, true)
				arg_765_1.iconController_:SetSelectedState("hero")

				arg_765_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_765_1.callingController_:SetSelectedState("normal")

				arg_765_1.keyicon_.color = Color.New(1, 1, 1)
				arg_765_1.icon_.color = Color.New(1, 1, 1)

				local var_768_1 = arg_765_1:FormatText(arg_765_1:GetWordFromCfg(933011464).content)

				arg_765_1.text_.text = var_768_1

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_3 = 38 <= 0 and var_768_0 or var_768_0 * (utf8.len(var_768_1) / 38)

				if (38 <= 0 and var_768_0 or var_768_0 * (utf8.len(var_768_1) / 38)) > 0 and var_768_0 < var_768_3 then
					arg_765_1.talkMaxDuration = var_768_3

					if var_768_3 + 0 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_3 + 0
					end
				end

				arg_765_1.text_.text = var_768_1
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)
				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_4 = math.max(var_768_0, arg_765_1.talkMaxDuration)

			if 0 <= arg_765_1.time_ and arg_765_1.time_ < 0 + var_768_4 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - 0) / var_768_4

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= 0 + var_768_4 and arg_765_1.time_ < 0 + var_768_4 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {}

		arg_765_1:InitPlayNodeList()
	end,
	Play933011416 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 933011416
		arg_769_1.duration_ = 13.13

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play933011417(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 then
				arg_769_1.var_.moveOldPos1033ui_story = arg_769_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_772_0 = 0.001

			if 0 <= arg_769_1.time_ and arg_769_1.time_ < 0 + var_772_0 then
				arg_769_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_769_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_769_1.time_ - 0) / var_772_0)
				arg_769_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_769_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1033ui_story"].transform.position).z)
				arg_769_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_769_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_769_1.actors_["1033ui_story"].transform.localEulerAngles = arg_769_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_769_1.time_ >= 0 + var_772_0 and arg_769_1.time_ < 0 + var_772_0 + arg_772_0 then
				arg_769_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_769_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_769_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_769_1.actors_["1033ui_story"].transform.position).z)
				arg_769_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_769_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_769_1.actors_["1033ui_story"].transform.localEulerAngles = arg_769_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_772_1 = "1033ui_story"

			if arg_769_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_772_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_769_1.stage_.transform)

				var_772_2.name = var_772_1
				var_772_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_769_1.actors_[var_772_1] = var_772_2

				local var_772_3 = var_772_2:GetComponentInChildren(typeof(CharacterEffect))

				var_772_3.enabled = true

				local var_772_4 = GameObjectTools.GetOrAddComponent(var_772_2, typeof(DynamicBoneHelper))

				if var_772_4 then
					var_772_4:EnableDynamicBone(false)
				end

				arg_769_1:ShowWeapon(var_772_3.transform, false)

				arg_769_1.var_[var_772_1 .. "Animator"] = var_772_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_769_1.var_[var_772_1 .. "Animator"].applyRootMotion = true
				arg_769_1.var_[var_772_1 .. "LipSync"] = var_772_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 then
				arg_769_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_772_5 = "1033ui_story"

			if arg_769_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_772_6 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_769_1.stage_.transform)

				var_772_6.name = var_772_5
				var_772_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_769_1.actors_[var_772_5] = var_772_6

				local var_772_7 = var_772_6:GetComponentInChildren(typeof(CharacterEffect))

				var_772_7.enabled = true

				local var_772_8 = GameObjectTools.GetOrAddComponent(var_772_6, typeof(DynamicBoneHelper))

				if var_772_8 then
					var_772_8:EnableDynamicBone(false)
				end

				arg_769_1:ShowWeapon(var_772_7.transform, false)

				arg_769_1.var_[var_772_5 .. "Animator"] = var_772_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_769_1.var_[var_772_5 .. "Animator"].applyRootMotion = true
				arg_769_1.var_[var_772_5 .. "LipSync"] = var_772_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 then
				arg_769_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_772_9 = arg_769_1.actors_["1033ui_story"]

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 and not isNil(var_772_9) and arg_769_1.var_.characterEffect1033ui_story == nil then
				arg_769_1.var_.characterEffect1033ui_story = var_772_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_772_10 = 0.2

			if 0 <= arg_769_1.time_ and arg_769_1.time_ < 0 + var_772_10 and not isNil(var_772_9) then
				if arg_769_1.var_.characterEffect1033ui_story and not isNil(var_772_9) then
					arg_769_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_769_1.time_ >= 0 + var_772_10 and arg_769_1.time_ < 0 + var_772_10 + arg_772_0 and not isNil(var_772_9) and arg_769_1.var_.characterEffect1033ui_story then
				arg_769_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_772_12 = 0
			local var_772_13 = 1.475

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= var_772_12 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, true)

				arg_769_1.leftNameTxt_.text = arg_769_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_769_1.leftNameTxt_.transform)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1.leftNameTxt_.text)
				SetActive(arg_769_1.iconTrs_.gameObject, false)
				arg_769_1.callingController_:SetSelectedState("normal")

				local var_772_14 = arg_769_1:GetWordFromCfg(933011416)
				local var_772_15 = arg_769_1:FormatText(var_772_14.content)

				arg_769_1.text_.text = var_772_15

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_17 = 59 <= 0 and var_772_13 or var_772_13 * (utf8.len(var_772_15) / 59)

				if (59 <= 0 and var_772_13 or var_772_13 * (utf8.len(var_772_15) / 59)) > 0 and var_772_13 < var_772_17 then
					arg_769_1.talkMaxDuration = var_772_17

					if var_772_17 + var_772_12 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_17 + var_772_12
					end
				end

				arg_769_1.text_.text = var_772_15
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_933011", "933011416", "story_v_side_old_933011.awb") ~= 0 then
					local var_772_18 = manager.audio:GetVoiceLength("story_v_side_old_933011", "933011416", "story_v_side_old_933011.awb") / 1000

					if var_772_18 + var_772_12 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_18 + var_772_12
					end

					if var_772_14.prefab_name ~= "" and arg_769_1.actors_[var_772_14.prefab_name] ~= nil then
						local var_772_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_769_1.actors_[var_772_14.prefab_name].transform, "story_v_side_old_933011", "933011416", "story_v_side_old_933011.awb")

						arg_769_1:RecordAudio("933011416", var_772_19)
						arg_769_1:RecordAudio("933011416", var_772_19)
					else
						arg_769_1:AudioAction("play", "voice", "story_v_side_old_933011", "933011416", "story_v_side_old_933011.awb")
					end

					arg_769_1:RecordHistoryTalkVoice("story_v_side_old_933011", "933011416", "story_v_side_old_933011.awb")
				end

				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_20 = math.max(var_772_13, arg_769_1.talkMaxDuration)

			if var_772_12 <= arg_769_1.time_ and arg_769_1.time_ < var_772_12 + var_772_20 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_12) / var_772_20

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_12 + var_772_20 and arg_769_1.time_ < var_772_12 + var_772_20 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_769_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/ST15",
		"TextureConfig/Background/SP93301",
		"TextureConfig/Background/SP93301a",
		"TextureConfig/Background/SP93301b",
		"TextureConfig/Background/ST15a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/D02a",
		"TextureConfig/Background/ST21"
	},
	voices = {
		"story_v_side_old_933011.awb"
	}
}
