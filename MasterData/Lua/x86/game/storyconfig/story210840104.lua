return {
	Play1108408001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108408001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108408002(arg_1_1)
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

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_4_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1108408001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 11 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 11)

				if (11 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 11)) > 0 and var_4_15 < var_4_19 then
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
	Play1108408002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1108408002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1108408003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.1

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1108408002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 44 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 44)

				if (44 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 44)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1108408003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1108408003
		arg_12_1.duration_ = 5.97

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1108408004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1084ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1084ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1084ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1084ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1084ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, -0.97, -6)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_15_8 = 0
			local var_15_9 = 0.5

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
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

				local var_15_10 = arg_12_1:GetWordFromCfg(1108408003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 20 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 20)

				if (20 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 20)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408003", "story_v_side_new_1108408.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408003", "story_v_side_new_1108408.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_side_new_1108408", "1108408003", "story_v_side_new_1108408.awb")

						arg_12_1:RecordAudio("1108408003", var_15_15)
						arg_12_1:RecordAudio("1108408003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408003", "story_v_side_new_1108408.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408003", "story_v_side_new_1108408.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play1108408004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1108408004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1108408005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = arg_16_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1084ui_story"].transform.position).z)
				arg_16_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1084ui_story"].transform.localEulerAngles = arg_16_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1084ui_story"].transform.position).z)
				arg_16_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1084ui_story"].transform.localEulerAngles = arg_16_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["1084ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 and not isNil(var_19_1) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_1) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_2)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_19_3 = 0
			local var_19_4 = 1.25

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_5 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(1108408004).content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 50 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_5) / 50)

				if (50 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_5) / 50)) > 0 and var_19_4 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_3
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_4, arg_16_1.talkMaxDuration)

			if var_19_3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_3 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_3) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_3 + var_19_8 and arg_16_1.time_ < var_19_3 + var_19_8 + arg_19_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play1108408005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1108408005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1108408006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.75

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(1108408005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 30 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 30)

				if (30 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 30)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1108408006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1108408006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1108408007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1.3

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(1108408006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 52 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 52)

				if (52 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 52)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1108408007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1108408007
		arg_28_1.duration_ = 14.27

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1108408008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = arg_28_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).z)
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles = arg_28_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_28_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).z)
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles = arg_28_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_31_1 = arg_28_1.actors_["1084ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 and not isNil(var_31_1) then
				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_1) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_31_4 = 0
			local var_31_5 = 1.15

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

				local var_31_6 = arg_28_1:GetWordFromCfg(1108408007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 46 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 46)

				if (46 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 46)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408007", "story_v_side_new_1108408.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408007", "story_v_side_new_1108408.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_side_new_1108408", "1108408007", "story_v_side_new_1108408.awb")

						arg_28_1:RecordAudio("1108408007", var_31_11)
						arg_28_1:RecordAudio("1108408007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408007", "story_v_side_new_1108408.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408007", "story_v_side_new_1108408.awb")
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

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play1108408008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1108408008
		arg_32_1.duration_ = 10.97

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1108408009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 1.025

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(1108408008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 41 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 41)

				if (41 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 41)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408008", "story_v_side_new_1108408.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408008", "story_v_side_new_1108408.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_side_new_1108408", "1108408008", "story_v_side_new_1108408.awb")

						arg_32_1:RecordAudio("1108408008", var_35_6)
						arg_32_1:RecordAudio("1108408008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408008", "story_v_side_new_1108408.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408008", "story_v_side_new_1108408.awb")
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
	Play1108408009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1108408009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1108408010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1084ui_story"]) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = arg_36_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1084ui_story"]) then
				if arg_36_1.var_.characterEffect1084ui_story and not isNil(arg_36_1.actors_["1084ui_story"]) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1084ui_story"]) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 0.6

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(1108408009).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 24 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 24)

				if (24 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 24)) > 0 and var_39_2 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_6 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_6 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_6

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_6 and arg_36_1.time_ < var_39_1 + var_39_6 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play1108408010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1108408010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1108408011(arg_40_1)
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

			local var_43_1 = 0
			local var_43_2 = 1.025

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(1108408010).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 41 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 41)

				if (41 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 41)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_6 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_6 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_6

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_6 and arg_40_1.time_ < var_43_1 + var_43_6 + arg_43_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play1108408011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1108408011
		arg_44_1.duration_ = 3.4

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1108408012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = arg_44_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).z)
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles = arg_44_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_44_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1084ui_story"].transform.position).z)
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1084ui_story"].transform.localEulerAngles = arg_44_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1084ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_47_4 = 0
			local var_47_5 = 0.15

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
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

				local var_47_6 = arg_44_1:GetWordFromCfg(1108408011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 6 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 6)

				if (6 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 6)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408011", "story_v_side_new_1108408.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408011", "story_v_side_new_1108408.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_side_new_1108408", "1108408011", "story_v_side_new_1108408.awb")

						arg_44_1:RecordAudio("1108408011", var_47_11)
						arg_44_1:RecordAudio("1108408011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408011", "story_v_side_new_1108408.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408011", "story_v_side_new_1108408.awb")
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

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play1108408012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1108408012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1108408013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = arg_48_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).z)
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles = arg_48_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).z)
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles = arg_48_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_51_1 = arg_48_1.actors_["1084ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_2)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_51_3 = 0
			local var_51_4 = 1.325

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_3 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_5 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(1108408012).content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 53 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_5) / 53)

				if (53 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_5) / 53)) > 0 and var_51_4 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_3 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_3
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_4, arg_48_1.talkMaxDuration)

			if var_51_3 <= arg_48_1.time_ and arg_48_1.time_ < var_51_3 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_3) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_3 + var_51_8 and arg_48_1.time_ < var_51_3 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play1108408013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1108408013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1108408014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 1.55

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(1108408013).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 62 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 62)

				if (62 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 62)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1108408014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1108408014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1108408015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.125

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(1108408014).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 45 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 45)

				if (45 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 45)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1108408015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1108408015
		arg_60_1.duration_ = 3.77

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1108408016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1084ui_story = arg_60_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1084ui_story"].transform.position).z)
				arg_60_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1084ui_story"].transform.localEulerAngles = arg_60_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_60_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1084ui_story"].transform.position).z)
				arg_60_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1084ui_story"].transform.localEulerAngles = arg_60_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["1084ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 and not isNil(var_63_1) then
				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_1) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_63_4 = 0
			local var_63_5 = 0.35

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

				local var_63_6 = arg_60_1:GetWordFromCfg(1108408015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 14 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 14)

				if (14 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 14)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408015", "story_v_side_new_1108408.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408015", "story_v_side_new_1108408.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_side_new_1108408", "1108408015", "story_v_side_new_1108408.awb")

						arg_60_1:RecordAudio("1108408015", var_63_11)
						arg_60_1:RecordAudio("1108408015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408015", "story_v_side_new_1108408.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408015", "story_v_side_new_1108408.awb")
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

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play1108408016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1108408016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1108408017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = arg_64_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) then
				if arg_64_1.var_.characterEffect1084ui_story and not isNil(arg_64_1.actors_["1084ui_story"]) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 0.4

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(1108408016).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 16 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 16)

				if (16 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 16)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play1108408017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1108408017
		arg_68_1.duration_ = 2.3

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1108408018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = arg_68_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) then
				if arg_68_1.var_.characterEffect1084ui_story and not isNil(arg_68_1.actors_["1084ui_story"]) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_71_2 = 0
			local var_71_3 = 0.175

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(1108408017)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 7 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 7)

				if (7 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 7)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408017", "story_v_side_new_1108408.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408017", "story_v_side_new_1108408.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_side_new_1108408", "1108408017", "story_v_side_new_1108408.awb")

						arg_68_1:RecordAudio("1108408017", var_71_9)
						arg_68_1:RecordAudio("1108408017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408017", "story_v_side_new_1108408.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408017", "story_v_side_new_1108408.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_10 and arg_68_1.time_ < var_71_2 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1108408018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1108408018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1108408019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = arg_72_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) then
				if arg_72_1.var_.characterEffect1084ui_story and not isNil(arg_72_1.actors_["1084ui_story"]) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.475

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(1108408018).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 19 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 19)

				if (19 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 19)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1108408019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1108408019
		arg_76_1.duration_ = 2.3

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1108408020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1084ui_story"]) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = arg_76_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1084ui_story"]) then
				if arg_76_1.var_.characterEffect1084ui_story and not isNil(arg_76_1.actors_["1084ui_story"]) then
					arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1084ui_story"]) and arg_76_1.var_.characterEffect1084ui_story then
				arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_2 = 0
			local var_79_3 = 0.25

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(1108408019)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 10 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 10)

				if (10 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 10)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408019", "story_v_side_new_1108408.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408019", "story_v_side_new_1108408.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_side_new_1108408", "1108408019", "story_v_side_new_1108408.awb")

						arg_76_1:RecordAudio("1108408019", var_79_9)
						arg_76_1:RecordAudio("1108408019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408019", "story_v_side_new_1108408.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408019", "story_v_side_new_1108408.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_10 and arg_76_1.time_ < var_79_2 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1108408020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1108408020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1108408021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = arg_80_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1084ui_story"].transform.position).z)
				arg_80_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1084ui_story"].transform.localEulerAngles = arg_80_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1084ui_story"].transform.position).z)
				arg_80_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1084ui_story"].transform.localEulerAngles = arg_80_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["1084ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 and not isNil(var_83_1) then
				if arg_80_1.var_.characterEffect1084ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_2)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_83_3 = 0
			local var_83_4 = 0.95

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_5 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(1108408020).content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 38 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_5) / 38)

				if (38 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_5) / 38)) > 0 and var_83_4 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_3 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_3
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_4, arg_80_1.talkMaxDuration)

			if var_83_3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_3 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_3) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_3 + var_83_8 and arg_80_1.time_ < var_83_3 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play1108408021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1108408021
		arg_84_1.duration_ = 11.37

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1108408022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = arg_84_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).z)
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles = arg_84_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_84_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1084ui_story"].transform.position).z)
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1084ui_story"].transform.localEulerAngles = arg_84_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["1084ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 and not isNil(var_87_1) then
				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_1) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_87_4 = 0
			local var_87_5 = 1

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
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

				local var_87_6 = arg_84_1:GetWordFromCfg(1108408021)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 40 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 40)

				if (40 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 40)) > 0 and var_87_5 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408021", "story_v_side_new_1108408.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408021", "story_v_side_new_1108408.awb") / 1000

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end

					if var_87_6.prefab_name ~= "" and arg_84_1.actors_[var_87_6.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_6.prefab_name].transform, "story_v_side_new_1108408", "1108408021", "story_v_side_new_1108408.awb")

						arg_84_1:RecordAudio("1108408021", var_87_11)
						arg_84_1:RecordAudio("1108408021", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408021", "story_v_side_new_1108408.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408021", "story_v_side_new_1108408.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_12 and arg_84_1.time_ < var_87_4 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play1108408022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1108408022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1108408023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1084ui_story"]) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = arg_88_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

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

			local var_91_1 = 0
			local var_91_2 = 0.75

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(1108408022).content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 30 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 30)

				if (30 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 30)) > 0 and var_91_2 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_6 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_6 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_6

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_6 and arg_88_1.time_ < var_91_1 + var_91_6 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play1108408023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1108408023
		arg_92_1.duration_ = 2.2

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1108408024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1084ui_story"]) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = arg_92_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1084ui_story"]) then
				if arg_92_1.var_.characterEffect1084ui_story and not isNil(arg_92_1.actors_["1084ui_story"]) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1084ui_story"]) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action436")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_95_2 = 0
			local var_95_3 = 0.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:GetWordFromCfg(1108408023)
				local var_95_5 = arg_92_1:FormatText(var_95_4.content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 9 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 9)

				if (9 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 9)) > 0 and var_95_3 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408023", "story_v_side_new_1108408.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408023", "story_v_side_new_1108408.awb") / 1000

					if var_95_8 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_2
					end

					if var_95_4.prefab_name ~= "" and arg_92_1.actors_[var_95_4.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_4.prefab_name].transform, "story_v_side_new_1108408", "1108408023", "story_v_side_new_1108408.awb")

						arg_92_1:RecordAudio("1108408023", var_95_9)
						arg_92_1:RecordAudio("1108408023", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408023", "story_v_side_new_1108408.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408023", "story_v_side_new_1108408.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_10 and arg_92_1.time_ < var_95_2 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play1108408024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1108408024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1108408025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_9000

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1084ui_story = arg_96_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1084ui_story"].transform.position).z)
				arg_96_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1084ui_story"].transform.localEulerAngles = arg_96_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1084ui_story"].transform.position).z)
				arg_96_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1084ui_story"].transform.localEulerAngles = arg_96_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["1084ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1084ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_2)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1084ui_story then
				arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				local var_99_3 = arg_96_1.var_.effectxiyangluoxia

				if not arg_96_1.var_.effectxiyangluoxia then
					var_99_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_guangban2"), manager.ui.mainCamera.transform)
					var_99_3.name = "xiyangluoxia"
					arg_96_1.var_.effectxiyangluoxia = var_99_3
				else
					var_99_3.transform:SetParent(var_99_9000)
				end

				var_99_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_99_3.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_99_5 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_99_3.transform.localScale = Vector3.New(var_99_3.transform.localScale.x * var_99_5, var_99_3.transform.localScale.y * var_99_5, var_99_3.transform.localScale.z * var_99_5)
			end

			local var_99_6 = 0
			local var_99_7 = 1.15

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_8 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(1108408024).content)

				arg_96_1.text_.text = var_99_8

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_10 = 46 <= 0 and var_99_7 or var_99_7 * (utf8.len(var_99_8) / 46)

				if (46 <= 0 and var_99_7 or var_99_7 * (utf8.len(var_99_8) / 46)) > 0 and var_99_7 < var_99_10 then
					arg_96_1.talkMaxDuration = var_99_10

					if var_99_10 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_8
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_11 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_11 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_11

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_11 and arg_96_1.time_ < var_99_6 + var_99_11 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play1108408025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1108408025
		arg_100_1.duration_ = 5.7

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1108408026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1084ui_story = arg_100_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1084ui_story"].transform.position).z)
				arg_100_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1084ui_story"].transform.localEulerAngles = arg_100_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_100_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1084ui_story"].transform.position).z)
				arg_100_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1084ui_story"].transform.localEulerAngles = arg_100_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["1084ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1084ui_story == nil then
				arg_100_1.var_.characterEffect1084ui_story = var_103_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 and not isNil(var_103_1) then
				if arg_100_1.var_.characterEffect1084ui_story and not isNil(var_103_1) then
					arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1084ui_story then
				arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_103_4 = 0
			local var_103_5 = 0.85

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(1108408025)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 34 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 34)

				if (34 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 34)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408025", "story_v_side_new_1108408.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408025", "story_v_side_new_1108408.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_side_new_1108408", "1108408025", "story_v_side_new_1108408.awb")

						arg_100_1:RecordAudio("1108408025", var_103_11)
						arg_100_1:RecordAudio("1108408025", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408025", "story_v_side_new_1108408.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408025", "story_v_side_new_1108408.awb")
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

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play1108408026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1108408026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1108408027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1084ui_story"]) and arg_104_1.var_.characterEffect1084ui_story == nil then
				arg_104_1.var_.characterEffect1084ui_story = arg_104_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1084ui_story"]) then
				if arg_104_1.var_.characterEffect1084ui_story and not isNil(arg_104_1.actors_["1084ui_story"]) then
					arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_0)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1084ui_story"]) and arg_104_1.var_.characterEffect1084ui_story then
				arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_107_1 = 0
			local var_107_2 = 1.45

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
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

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(1108408026).content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 58 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_3) / 58)

				if (58 <= 0 and var_107_2 or var_107_2 * (utf8.len(var_107_3) / 58)) > 0 and var_107_2 < var_107_5 then
					arg_104_1.talkMaxDuration = var_107_5

					if var_107_5 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + var_107_1
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_6 = math.max(var_107_2, arg_104_1.talkMaxDuration)

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_6 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_1) / var_107_6

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_1 + var_107_6 and arg_104_1.time_ < var_107_1 + var_107_6 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1108408027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1108408027
		arg_108_1.duration_ = 6.6

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1108408028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1084ui_story"]) and arg_108_1.var_.characterEffect1084ui_story == nil then
				arg_108_1.var_.characterEffect1084ui_story = arg_108_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1084ui_story"]) then
				if arg_108_1.var_.characterEffect1084ui_story and not isNil(arg_108_1.actors_["1084ui_story"]) then
					arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1084ui_story"]) and arg_108_1.var_.characterEffect1084ui_story then
				arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action425")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_111_2 = 0
			local var_111_3 = 0.65

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_4 = arg_108_1:GetWordFromCfg(1108408027)
				local var_111_5 = arg_108_1:FormatText(var_111_4.content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 26 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 26)

				if (26 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 26)) > 0 and var_111_3 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408027", "story_v_side_new_1108408.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408027", "story_v_side_new_1108408.awb") / 1000

					if var_111_8 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_2
					end

					if var_111_4.prefab_name ~= "" and arg_108_1.actors_[var_111_4.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_4.prefab_name].transform, "story_v_side_new_1108408", "1108408027", "story_v_side_new_1108408.awb")

						arg_108_1:RecordAudio("1108408027", var_111_9)
						arg_108_1:RecordAudio("1108408027", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408027", "story_v_side_new_1108408.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408027", "story_v_side_new_1108408.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_10 and arg_108_1.time_ < var_111_2 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1108408028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1108408028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1108408029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1084ui_story = arg_112_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).z)
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles = arg_112_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).z)
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles = arg_112_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["1084ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = var_115_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 and not isNil(var_115_1) then
				if arg_112_1.var_.characterEffect1084ui_story and not isNil(var_115_1) then
					arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_2)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1084ui_story then
				arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_115_3 = 0
			local var_115_4 = 1.575

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_3 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				arg_112_1.dialog_:SetActive(true)

				arg_112_1.dialogCg_.alpha = 0

				local var_115_5 = LeanTween.value(arg_112_1.dialog_, 0, 1, 0.3)

				var_115_5:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_112_1.dialogCg_.alpha = arg_116_0
				end))
				var_115_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_112_1.dialog_)
					var_115_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_112_1.duration_ = arg_112_1.duration_ + 0.3

				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(1108408028).content)

				arg_112_1.text_.text = var_115_6

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_8 = 63 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_6) / 63)

				if (63 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_6) / 63)) > 0 and var_115_4 < var_115_8 then
					arg_112_1.talkMaxDuration = var_115_8
					var_115_3 = var_115_3 + 0.3

					if var_115_8 + var_115_3 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_3
					end
				end

				arg_112_1.text_.text = var_115_6
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_9 = var_115_3 + 0.3
			local var_115_10 = math.max(var_115_4, arg_112_1.talkMaxDuration)

			if var_115_3 + 0.3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_9) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_9 + var_115_10 and arg_112_1.time_ < var_115_9 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play1108408029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1108408029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1108408030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = arg_118_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).z)
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles = arg_118_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_118_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).z)
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles = arg_118_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["1084ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 and not isNil(var_121_1) then
				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_1) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action458")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_121_4 = 0
			local var_121_5 = 0.55

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(1108408029)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 22 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 22)

				if (22 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 22)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408029", "story_v_side_new_1108408.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408029", "story_v_side_new_1108408.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_side_new_1108408", "1108408029", "story_v_side_new_1108408.awb")

						arg_118_1:RecordAudio("1108408029", var_121_11)
						arg_118_1:RecordAudio("1108408029", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408029", "story_v_side_new_1108408.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408029", "story_v_side_new_1108408.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play1108408030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1108408030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1108408031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = arg_122_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) then
				if arg_122_1.var_.characterEffect1084ui_story and not isNil(arg_122_1.actors_["1084ui_story"]) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_0)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_125_1 = 0
			local var_125_2 = 0.925

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(1108408030).content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 37 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 37)

				if (37 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 37)) > 0 and var_125_2 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_6 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_6 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_6

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_6 and arg_122_1.time_ < var_125_1 + var_125_6 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play1108408031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1108408031
		arg_126_1.duration_ = 9.37

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1108408032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_9001
			local var_129_9000

			if arg_126_1.bgs_.R8405 == nil then
				local var_129_0 = Object.Instantiate(arg_126_1.paintGo_)

				var_129_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R8405")
				var_129_0.name = "R8405"
				var_129_0.transform.parent = arg_126_1.stage_.transform
				var_129_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.bgs_.R8405 = var_129_0
			end

			if 0.966666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 0.966666666666667 + arg_129_0 then
				local var_129_1 = arg_126_1.bgs_.R8405

				arg_126_1.bgs_.R8405.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_129_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_2 = var_129_1:GetComponent("SpriteRenderer")

				if var_129_2 and var_129_2.sprite then
					local var_129_3 = 2 * (var_129_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_129_1.transform.localScale = Vector3.New(var_129_3 / var_129_2.sprite.bounds.size.y < var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x and var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x or var_129_3 / var_129_2.sprite.bounds.size.y, var_129_3 / var_129_2.sprite.bounds.size.y < var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x and var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x or var_129_3 / var_129_2.sprite.bounds.size.y, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "R8405" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_4 = 2

			if 2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.allBtn_.enabled = false
			end

			if arg_126_1.time_ >= var_129_4 + 0.3 and arg_126_1.time_ < var_129_4 + 0.3 + arg_129_0 then
				arg_126_1.allBtn_.enabled = true
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				local var_129_5 = arg_126_1.var_.effectjinguangshanshuo1

				if not arg_126_1.var_.effectjinguangshanshuo1 then
					var_129_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_129_5.name = "jinguangshanshuo1"
					arg_126_1.var_.effectjinguangshanshuo1 = var_129_5
				else
					var_129_5.transform:SetParent(var_129_9001)
				end

				var_129_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_129_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_129_7 = arg_126_1.actors_["1084ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = var_129_7.localPosition
			end

			local var_129_8 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_8 then
				var_129_7.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_8)
				var_129_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_7.position).x, (manager.ui.mainCamera.transform.position - var_129_7.position).y, (manager.ui.mainCamera.transform.position - var_129_7.position).z)
				var_129_7.localEulerAngles.z = 0
				var_129_7.localEulerAngles.x = 0
				var_129_7.localEulerAngles = var_129_7.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_8 and arg_126_1.time_ < 0 + var_129_8 + arg_129_0 then
				var_129_7.localPosition = Vector3.New(0, 100, 0)
				var_129_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_7.position).x, (manager.ui.mainCamera.transform.position - var_129_7.position).y, (manager.ui.mainCamera.transform.position - var_129_7.position).z)
				var_129_7.localEulerAngles.z = 0
				var_129_7.localEulerAngles.x = 0
				var_129_7.localEulerAngles = var_129_7.localEulerAngles
			end

			if 1.5 < arg_126_1.time_ and arg_126_1.time_ <= 1.5 + arg_129_0 then
				local var_129_9 = arg_126_1.var_.effectjinguangshanshuo2

				if not arg_126_1.var_.effectjinguangshanshuo2 then
					var_129_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_129_9.name = "jinguangshanshuo2"
					arg_126_1.var_.effectjinguangshanshuo2 = var_129_9
				else
					var_129_9.transform:SetParent(var_129_9000)
				end

				var_129_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_129_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.3 < arg_126_1.time_ and arg_126_1.time_ <= 2.3 + arg_129_0 then
				if arg_126_1.var_.effectjinguangshanshuo2 then
					Object.Destroy(arg_126_1.var_.effectjinguangshanshuo2)

					arg_126_1.var_.effectjinguangshanshuo2 = nil
				end
			end

			if 1.5 < arg_126_1.time_ and arg_126_1.time_ <= 1.5 + arg_129_0 then
				if arg_126_1.var_.effectjinguangshanshuo1 then
					Object.Destroy(arg_126_1.var_.effectjinguangshanshuo1)

					arg_126_1.var_.effectjinguangshanshuo1 = nil
				end
			end

			if 1 < arg_126_1.time_ and arg_126_1.time_ <= 1 + arg_129_0 then
				arg_126_1:AudioAction("play", "music", "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_129_15 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if "" ~= "" then
					if arg_126_1.bgmTxt_.text ~= var_129_15 and arg_126_1.bgmTxt_.text ~= "" then
						if arg_126_1.bgmTxt2_.text ~= "" then
							arg_126_1.bgmTxt_.text = arg_126_1.bgmTxt2_.text
						end

						arg_126_1.bgmTxt2_.text = var_129_15

						arg_126_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_126_1.bgmTxt_.text = var_129_15
						arg_126_1.bgmTxt2_.text = var_129_15
					end

					if arg_126_1.bgmTimer then
						arg_126_1.bgmTimer:Stop()

						arg_126_1.bgmTimer = nil
					end

					if arg_126_1.settingData.show_music_name == 1 then
						arg_126_1.musicController:SetSelectedState("show")
						arg_126_1.musicAnimator_:Play("open", 0, 0)

						if arg_126_1.settingData.music_time ~= 0 then
							arg_126_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_126_1.settingData.music_time), function()
								if arg_126_1 == nil or isNil(arg_126_1.bgmTxt_) then
									return
								end

								arg_126_1.musicController:SetSelectedState("hide")
								arg_126_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 0.9 < arg_126_1.time_ and arg_126_1.time_ <= 0.9 + arg_129_0 then
				if arg_126_1.var_.effectxiyangluoxia then
					Object.Destroy(arg_126_1.var_.effectxiyangluoxia)

					arg_126_1.var_.effectxiyangluoxia = nil
				end
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_18 = 2
			local var_129_19 = 0.8

			if 2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_18 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_20 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_20:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_126_1.dialogCg_.alpha = arg_131_0
				end))
				var_129_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_21 = arg_126_1:GetWordFromCfg(1108408031)
				local var_129_22 = arg_126_1:FormatText(var_129_21.content)

				arg_126_1.text_.text = var_129_22

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_24 = 32 <= 0 and var_129_19 or var_129_19 * (utf8.len(var_129_22) / 32)

				if (32 <= 0 and var_129_19 or var_129_19 * (utf8.len(var_129_22) / 32)) > 0 and var_129_19 < var_129_24 then
					arg_126_1.talkMaxDuration = var_129_24
					var_129_18 = var_129_18 + 0.3

					if var_129_24 + var_129_18 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_24 + var_129_18
					end
				end

				arg_126_1.text_.text = var_129_22
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408031", "story_v_side_new_1108408.awb") ~= 0 then
					local var_129_25 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408031", "story_v_side_new_1108408.awb") / 1000

					if var_129_25 + var_129_18 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_25 + var_129_18
					end

					if var_129_21.prefab_name ~= "" and arg_126_1.actors_[var_129_21.prefab_name] ~= nil then
						local var_129_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_21.prefab_name].transform, "story_v_side_new_1108408", "1108408031", "story_v_side_new_1108408.awb")

						arg_126_1:RecordAudio("1108408031", var_129_26)
						arg_126_1:RecordAudio("1108408031", var_129_26)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408031", "story_v_side_new_1108408.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408031", "story_v_side_new_1108408.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_27 = var_129_18 + 0.3
			local var_129_28 = math.max(var_129_19, arg_126_1.talkMaxDuration)

			if var_129_18 + 0.3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_27 + var_129_28 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_27) / var_129_28

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_27 + var_129_28 and arg_126_1.time_ < var_129_27 + var_129_28 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play1108408032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1108408032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1108408033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.5

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1108408032).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 20 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 20)

				if (20 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 20)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1108408033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1108408033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1108408034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.4

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1108408033).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 16 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 16)

				if (16 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 16)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1108408034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1108408034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1108408035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0.3 < arg_141_1.time_ and arg_141_1.time_ <= 0.3 + arg_144_0 then
				arg_141_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_water", "")
			end

			local var_144_1 = 0
			local var_144_2 = 0.75

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(1108408034).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 30 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 30)

				if (30 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 30)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1108408035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1108408035
		arg_145_1.duration_ = 3.3

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1108408036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.375

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(1108408035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 15 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 15)

				if (15 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 15)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408035", "story_v_side_new_1108408.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408035", "story_v_side_new_1108408.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_side_new_1108408", "1108408035", "story_v_side_new_1108408.awb")

						arg_145_1:RecordAudio("1108408035", var_148_6)
						arg_145_1:RecordAudio("1108408035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408035", "story_v_side_new_1108408.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408035", "story_v_side_new_1108408.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1108408036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1108408036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1108408037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.825

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(1108408036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 33 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 33)

				if (33 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 33)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1108408037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1108408037
		arg_153_1.duration_ = 5.33

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1108408038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.875

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(1108408037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 35 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 35)

				if (35 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 35)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408037", "story_v_side_new_1108408.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408037", "story_v_side_new_1108408.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_side_new_1108408", "1108408037", "story_v_side_new_1108408.awb")

						arg_153_1:RecordAudio("1108408037", var_156_6)
						arg_153_1:RecordAudio("1108408037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408037", "story_v_side_new_1108408.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408037", "story_v_side_new_1108408.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1108408038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1108408038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1108408039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.325

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1108408038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 13 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 13)

				if (13 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 13)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1108408039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1108408039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1108408040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.45

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(1108408039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 58 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 58)

				if (58 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 58)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1108408040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1108408040
		arg_165_1.duration_ = 2.93

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1108408041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.35

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(1108408040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 14 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 14)

				if (14 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 14)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408040", "story_v_side_new_1108408.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408040", "story_v_side_new_1108408.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_side_new_1108408", "1108408040", "story_v_side_new_1108408.awb")

						arg_165_1:RecordAudio("1108408040", var_168_6)
						arg_165_1:RecordAudio("1108408040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408040", "story_v_side_new_1108408.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408040", "story_v_side_new_1108408.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1108408041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1108408041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1108408042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.525

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(1108408041).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 21 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 21)

				if (21 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 21)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1108408042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1108408042
		arg_173_1.duration_ = 1.33

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1108408043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.1

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:GetWordFromCfg(1108408042)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 4 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 4)

				if (4 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 4)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408042", "story_v_side_new_1108408.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408042", "story_v_side_new_1108408.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_side_new_1108408", "1108408042", "story_v_side_new_1108408.awb")

						arg_173_1:RecordAudio("1108408042", var_176_6)
						arg_173_1:RecordAudio("1108408042", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408042", "story_v_side_new_1108408.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408042", "story_v_side_new_1108408.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1108408043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1108408043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1108408044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1.35

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(1108408043).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 54 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 54)

				if (54 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 54)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1108408044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1108408044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1108408045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.3

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(1108408044).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 52 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 52)

				if (52 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 52)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1108408045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1108408045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1108408046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.8

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(1108408045).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 32 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 32)

				if (32 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 32)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1108408046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1108408046
		arg_189_1.duration_ = 4

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1108408047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.475

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(1108408046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 19 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 19)

				if (19 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 19)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408046", "story_v_side_new_1108408.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408046", "story_v_side_new_1108408.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_side_new_1108408", "1108408046", "story_v_side_new_1108408.awb")

						arg_189_1:RecordAudio("1108408046", var_192_6)
						arg_189_1:RecordAudio("1108408046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408046", "story_v_side_new_1108408.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408046", "story_v_side_new_1108408.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1108408047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1108408047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1108408048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.625

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(1108408047).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 25 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 25)

				if (25 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 25)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1108408048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1108408048
		arg_197_1.duration_ = 1.37

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1108408049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.125

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(1108408048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 5 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 5)

				if (5 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 5)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408048", "story_v_side_new_1108408.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408048", "story_v_side_new_1108408.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_side_new_1108408", "1108408048", "story_v_side_new_1108408.awb")

						arg_197_1:RecordAudio("1108408048", var_200_6)
						arg_197_1:RecordAudio("1108408048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408048", "story_v_side_new_1108408.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408048", "story_v_side_new_1108408.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1108408049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1108408049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1108408050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.1

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1108408049).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 44 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 44)

				if (44 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 44)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1108408050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1108408050
		arg_205_1.duration_ = 14.37

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1108408051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.875

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

				local var_208_1 = arg_205_1:GetWordFromCfg(1108408050)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 75 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 75)

				if (75 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 75)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408050", "story_v_side_new_1108408.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408050", "story_v_side_new_1108408.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_side_new_1108408", "1108408050", "story_v_side_new_1108408.awb")

						arg_205_1:RecordAudio("1108408050", var_208_6)
						arg_205_1:RecordAudio("1108408050", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408050", "story_v_side_new_1108408.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408050", "story_v_side_new_1108408.awb")
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
	Play1108408051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1108408051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1108408052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.5

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1108408051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 20 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 20)

				if (20 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 20)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1108408052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1108408052
		arg_213_1.duration_ = 10.5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1108408053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 1.175

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(1108408052)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 47 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 47)

				if (47 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 47)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408052", "story_v_side_new_1108408.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408052", "story_v_side_new_1108408.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_side_new_1108408", "1108408052", "story_v_side_new_1108408.awb")

						arg_213_1:RecordAudio("1108408052", var_216_6)
						arg_213_1:RecordAudio("1108408052", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408052", "story_v_side_new_1108408.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408052", "story_v_side_new_1108408.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1108408053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1108408053
		arg_217_1.duration_ = 12.77

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1108408054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 1.575

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

				local var_220_1 = arg_217_1:GetWordFromCfg(1108408053)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 61 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 61)

				if (61 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 61)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408053", "story_v_side_new_1108408.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408053", "story_v_side_new_1108408.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_side_new_1108408", "1108408053", "story_v_side_new_1108408.awb")

						arg_217_1:RecordAudio("1108408053", var_220_6)
						arg_217_1:RecordAudio("1108408053", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408053", "story_v_side_new_1108408.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408053", "story_v_side_new_1108408.awb")
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
	Play1108408054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1108408054
		arg_221_1.duration_ = 8.07

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1108408055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1

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

				local var_224_1 = arg_221_1:GetWordFromCfg(1108408054)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 40 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 40)

				if (40 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 40)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408054", "story_v_side_new_1108408.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408054", "story_v_side_new_1108408.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_side_new_1108408", "1108408054", "story_v_side_new_1108408.awb")

						arg_221_1:RecordAudio("1108408054", var_224_6)
						arg_221_1:RecordAudio("1108408054", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408054", "story_v_side_new_1108408.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408054", "story_v_side_new_1108408.awb")
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
	Play1108408055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1108408055
		arg_225_1.duration_ = 1

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"

			SetActive(arg_225_1.choicesGo_, true)

			for iter_226_0, iter_226_1 in ipairs(arg_225_1.choices_) do
				SetActive(iter_226_1.go, iter_226_0 <= 2)
			end

			arg_225_1.choices_[1].txt.text = arg_225_1:FormatText(StoryChoiceCfg[1690].name)
			arg_225_1.choices_[2].txt.text = arg_225_1:FormatText(StoryChoiceCfg[1691].name)
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1108408056(arg_225_1)
			end

			if arg_227_0 == 2 then
				arg_225_0:Play1108408056(arg_225_1)
			end

			arg_225_1:RecordChoiceLog(1108408055, 1690, 1691)
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.allBtn_.enabled = false
			end

			if arg_225_1.time_ >= 0 + 1 and arg_225_1.time_ < 0 + 1 + arg_228_0 then
				arg_225_1.allBtn_.enabled = true
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1108408056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1108408056
		arg_229_1.duration_ = 9.8

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1108408057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1.075

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

				local var_232_1 = arg_229_1:GetWordFromCfg(1108408056)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 43 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 43)

				if (43 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 43)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408056", "story_v_side_new_1108408.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408056", "story_v_side_new_1108408.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_side_new_1108408", "1108408056", "story_v_side_new_1108408.awb")

						arg_229_1:RecordAudio("1108408056", var_232_6)
						arg_229_1:RecordAudio("1108408056", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408056", "story_v_side_new_1108408.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408056", "story_v_side_new_1108408.awb")
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
	Play1108408057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1108408057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1108408058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 1.075

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1108408057).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 43 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 43)

				if (43 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 43)) > 0 and var_236_0 < var_236_3 then
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
	Play1108408058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1108408058
		arg_237_1.duration_ = 9.9

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1108408059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if arg_237_1.bgs_.H02a == nil then
				local var_240_0 = Object.Instantiate(arg_237_1.paintGo_)

				var_240_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02a")
				var_240_0.name = "H02a"
				var_240_0.transform.parent = arg_237_1.stage_.transform
				var_240_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.bgs_.H02a = var_240_0
			end

			if 2 < arg_237_1.time_ and arg_237_1.time_ <= 2 + arg_240_0 then
				local var_240_1 = arg_237_1.bgs_.H02a

				arg_237_1.bgs_.H02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_240_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_2 = var_240_1:GetComponent("SpriteRenderer")

				if var_240_2 and var_240_2.sprite then
					local var_240_3 = 2 * (var_240_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_240_1.transform.localScale = Vector3.New(var_240_3 / var_240_2.sprite.bounds.size.y < var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x and var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x or var_240_3 / var_240_2.sprite.bounds.size.y, var_240_3 / var_240_2.sprite.bounds.size.y < var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x and var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x or var_240_3 / var_240_2.sprite.bounds.size.y, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "H02a" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_4 = 4.00000000298023

			if 4.00000000298023 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.allBtn_.enabled = false
			end

			if arg_237_1.time_ >= var_240_4 + 0.3 and arg_237_1.time_ < var_240_4 + 0.3 + arg_240_0 then
				arg_237_1.allBtn_.enabled = true
			end

			local var_240_5 = 0

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_6 = 2

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_6 then
				local var_240_7 = Color.New(0, 0, 0)

				var_240_7.a = Mathf.Lerp(0, 1, (arg_237_1.time_ - var_240_5) / var_240_6)
				arg_237_1.mask_.color = var_240_7
			end

			if arg_237_1.time_ >= var_240_5 + var_240_6 and arg_237_1.time_ < var_240_5 + var_240_6 + arg_240_0 then
				local var_240_8 = Color.New(0, 0, 0)

				var_240_8.a = 1
				arg_237_1.mask_.color = var_240_8
			end

			local var_240_9 = 2

			if 2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_10 = 2

			if var_240_9 <= arg_237_1.time_ and arg_237_1.time_ < var_240_9 + var_240_10 then
				local var_240_11 = Color.New(0, 0, 0)

				var_240_11.a = Mathf.Lerp(1, 0, (arg_237_1.time_ - var_240_9) / var_240_10)
				arg_237_1.mask_.color = var_240_11
			end

			if arg_237_1.time_ >= var_240_9 + var_240_10 and arg_237_1.time_ < var_240_9 + var_240_10 + arg_240_0 then
				local var_240_12 = Color.New(0, 0, 0)

				arg_237_1.mask_.enabled = false
				var_240_12.a = 0
				arg_237_1.mask_.color = var_240_12
			end

			local var_240_13 = arg_237_1.actors_["1084ui_story"].transform

			if 3.8 < arg_237_1.time_ and arg_237_1.time_ <= 3.8 + arg_240_0 then
				arg_237_1.var_.moveOldPos1084ui_story = var_240_13.localPosition
			end

			local var_240_14 = 0.001

			if 3.8 <= arg_237_1.time_ and arg_237_1.time_ < 3.8 + var_240_14 then
				var_240_13.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_237_1.time_ - 3.8) / var_240_14)
				var_240_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_13.position).x, (manager.ui.mainCamera.transform.position - var_240_13.position).y, (manager.ui.mainCamera.transform.position - var_240_13.position).z)
				var_240_13.localEulerAngles.z = 0
				var_240_13.localEulerAngles.x = 0
				var_240_13.localEulerAngles = var_240_13.localEulerAngles
			end

			if arg_237_1.time_ >= 3.8 + var_240_14 and arg_237_1.time_ < 3.8 + var_240_14 + arg_240_0 then
				var_240_13.localPosition = Vector3.New(0, -0.97, -6)
				var_240_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_13.position).x, (manager.ui.mainCamera.transform.position - var_240_13.position).y, (manager.ui.mainCamera.transform.position - var_240_13.position).z)
				var_240_13.localEulerAngles.z = 0
				var_240_13.localEulerAngles.x = 0
				var_240_13.localEulerAngles = var_240_13.localEulerAngles
			end

			local var_240_15 = arg_237_1.actors_["1084ui_story"]

			if 3.8 < arg_237_1.time_ and arg_237_1.time_ <= 3.8 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.characterEffect1084ui_story == nil then
				arg_237_1.var_.characterEffect1084ui_story = var_240_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_16 = 0.200000002980232

			if 3.8 <= arg_237_1.time_ and arg_237_1.time_ < 3.8 + var_240_16 and not isNil(var_240_15) then
				if arg_237_1.var_.characterEffect1084ui_story and not isNil(var_240_15) then
					arg_237_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 3.8 + var_240_16 and arg_237_1.time_ < 3.8 + var_240_16 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.characterEffect1084ui_story then
				arg_237_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 3.8 < arg_237_1.time_ and arg_237_1.time_ <= 3.8 + arg_240_0 then
				arg_237_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 3.8 < arg_237_1.time_ and arg_237_1.time_ <= 3.8 + arg_240_0 then
				arg_237_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_18 = 4.00000000298023
			local var_240_19 = 0.65

			if 4.00000000298023 < arg_237_1.time_ and arg_237_1.time_ <= var_240_18 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_20 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_20:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_237_1.dialogCg_.alpha = arg_241_0
				end))
				var_240_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_21 = arg_237_1:GetWordFromCfg(1108408058)
				local var_240_22 = arg_237_1:FormatText(var_240_21.content)

				arg_237_1.text_.text = var_240_22

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_24 = 26 <= 0 and var_240_19 or var_240_19 * (utf8.len(var_240_22) / 26)

				if (26 <= 0 and var_240_19 or var_240_19 * (utf8.len(var_240_22) / 26)) > 0 and var_240_19 < var_240_24 then
					arg_237_1.talkMaxDuration = var_240_24
					var_240_18 = var_240_18 + 0.3

					if var_240_24 + var_240_18 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_24 + var_240_18
					end
				end

				arg_237_1.text_.text = var_240_22
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408058", "story_v_side_new_1108408.awb") ~= 0 then
					local var_240_25 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408058", "story_v_side_new_1108408.awb") / 1000

					if var_240_25 + var_240_18 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_25 + var_240_18
					end

					if var_240_21.prefab_name ~= "" and arg_237_1.actors_[var_240_21.prefab_name] ~= nil then
						local var_240_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_21.prefab_name].transform, "story_v_side_new_1108408", "1108408058", "story_v_side_new_1108408.awb")

						arg_237_1:RecordAudio("1108408058", var_240_26)
						arg_237_1:RecordAudio("1108408058", var_240_26)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408058", "story_v_side_new_1108408.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408058", "story_v_side_new_1108408.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_27 = var_240_18 + 0.3
			local var_240_28 = math.max(var_240_19, arg_237_1.talkMaxDuration)

			if var_240_18 + 0.3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_27 + var_240_28 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_27) / var_240_28

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_27 + var_240_28 and arg_237_1.time_ < var_240_27 + var_240_28 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1108408059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1108408059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1108408060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story == nil then
				arg_243_1.var_.characterEffect1084ui_story = arg_243_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) then
				if arg_243_1.var_.characterEffect1084ui_story and not isNil(arg_243_1.actors_["1084ui_story"]) then
					arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story then
				arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.2

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(1108408059).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 8 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 8)

				if (8 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 8)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1108408060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1108408060
		arg_247_1.duration_ = 2.23

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1108408061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story == nil then
				arg_247_1.var_.characterEffect1084ui_story = arg_247_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) then
				if arg_247_1.var_.characterEffect1084ui_story and not isNil(arg_247_1.actors_["1084ui_story"]) then
					arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story then
				arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_250_2 = 0
			local var_250_3 = 0.175

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(1108408060)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 7 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 7)

				if (7 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 7)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408060", "story_v_side_new_1108408.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408060", "story_v_side_new_1108408.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_side_new_1108408", "1108408060", "story_v_side_new_1108408.awb")

						arg_247_1:RecordAudio("1108408060", var_250_9)
						arg_247_1:RecordAudio("1108408060", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408060", "story_v_side_new_1108408.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408060", "story_v_side_new_1108408.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1108408061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1108408061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1108408062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1084ui_story"]) and arg_251_1.var_.characterEffect1084ui_story == nil then
				arg_251_1.var_.characterEffect1084ui_story = arg_251_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1084ui_story"]) then
				if arg_251_1.var_.characterEffect1084ui_story and not isNil(arg_251_1.actors_["1084ui_story"]) then
					arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1084ui_story"]) and arg_251_1.var_.characterEffect1084ui_story then
				arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 1.075

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(1108408061).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 43 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 43)

				if (43 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 43)) > 0 and var_254_2 < var_254_5 then
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

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1108408062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1108408062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1108408063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.725

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1108408062).content)

				arg_255_1.text_.text = var_258_1

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_3 = 29 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_1) / 29)

				if (29 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_1) / 29)) > 0 and var_258_0 < var_258_3 then
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
	Play1108408063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1108408063
		arg_259_1.duration_ = 2

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1108408064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1084ui_story"]) and arg_259_1.var_.characterEffect1084ui_story == nil then
				arg_259_1.var_.characterEffect1084ui_story = arg_259_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1084ui_story"]) then
				if arg_259_1.var_.characterEffect1084ui_story and not isNil(arg_259_1.actors_["1084ui_story"]) then
					arg_259_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1084ui_story"]) and arg_259_1.var_.characterEffect1084ui_story then
				arg_259_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_262_2 = 0
			local var_262_3 = 0.1

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_4 = arg_259_1:GetWordFromCfg(1108408063)
				local var_262_5 = arg_259_1:FormatText(var_262_4.content)

				arg_259_1.text_.text = var_262_5

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_7 = 4 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_5) / 4)

				if (4 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_5) / 4)) > 0 and var_262_3 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_2
					end
				end

				arg_259_1.text_.text = var_262_5
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408063", "story_v_side_new_1108408.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408063", "story_v_side_new_1108408.awb") / 1000

					if var_262_8 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_2
					end

					if var_262_4.prefab_name ~= "" and arg_259_1.actors_[var_262_4.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_4.prefab_name].transform, "story_v_side_new_1108408", "1108408063", "story_v_side_new_1108408.awb")

						arg_259_1:RecordAudio("1108408063", var_262_9)
						arg_259_1:RecordAudio("1108408063", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408063", "story_v_side_new_1108408.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408063", "story_v_side_new_1108408.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_3, arg_259_1.talkMaxDuration)

			if var_262_2 <= arg_259_1.time_ and arg_259_1.time_ < var_262_2 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_2) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_2 + var_262_10 and arg_259_1.time_ < var_262_2 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1108408064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1108408064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1108408065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1084ui_story = arg_263_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).z)
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles = arg_263_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).z)
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles = arg_263_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1084ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1084ui_story == nil then
				arg_263_1.var_.characterEffect1084ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1084ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_2)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1084ui_story then
				arg_263_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_266_3 = 0
			local var_266_4 = 1.15

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_5 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1108408064).content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 46 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_5) / 46)

				if (46 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_5) / 46)) > 0 and var_266_4 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_3 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_3
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_8 = math.max(var_266_4, arg_263_1.talkMaxDuration)

			if var_266_3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_3 + var_266_8 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_3) / var_266_8

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_3 + var_266_8 and arg_263_1.time_ < var_266_3 + var_266_8 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play1108408065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1108408065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1108408066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.225

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1108408065).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 49 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 49)

				if (49 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 49)) > 0 and var_270_0 < var_270_3 then
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
	Play1108408066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1108408066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1108408067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.425

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

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(1108408066).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 17 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 17)

				if (17 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 17)) > 0 and var_274_0 < var_274_3 then
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
	Play1108408067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1108408067
		arg_275_1.duration_ = 9.57

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1108408068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1084ui_story = arg_275_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1084ui_story"].transform.position).z)
				arg_275_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1084ui_story"].transform.localEulerAngles = arg_275_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_275_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1084ui_story"].transform.position).z)
				arg_275_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1084ui_story"].transform.localEulerAngles = arg_275_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1084ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1084ui_story == nil then
				arg_275_1.var_.characterEffect1084ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1084ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1084ui_story then
				arg_275_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_278_4 = 0
			local var_278_5 = 0.925

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:GetWordFromCfg(1108408067)
				local var_278_7 = arg_275_1:FormatText(var_278_6.content)

				arg_275_1.text_.text = var_278_7

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 37 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 37)

				if (37 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 37)) > 0 and var_278_5 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_7
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408067", "story_v_side_new_1108408.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408067", "story_v_side_new_1108408.awb") / 1000

					if var_278_10 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_4
					end

					if var_278_6.prefab_name ~= "" and arg_275_1.actors_[var_278_6.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_6.prefab_name].transform, "story_v_side_new_1108408", "1108408067", "story_v_side_new_1108408.awb")

						arg_275_1:RecordAudio("1108408067", var_278_11)
						arg_275_1:RecordAudio("1108408067", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408067", "story_v_side_new_1108408.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408067", "story_v_side_new_1108408.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_12 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_12 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_12

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_12 and arg_275_1.time_ < var_278_4 + var_278_12 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play1108408068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1108408068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1108408069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1084ui_story"]) and arg_279_1.var_.characterEffect1084ui_story == nil then
				arg_279_1.var_.characterEffect1084ui_story = arg_279_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1084ui_story"]) then
				if arg_279_1.var_.characterEffect1084ui_story and not isNil(arg_279_1.actors_["1084ui_story"]) then
					arg_279_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1084ui_story"]) and arg_279_1.var_.characterEffect1084ui_story then
				arg_279_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.425

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
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

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(1108408068).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 17 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 17)

				if (17 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 17)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1108408069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1108408069
		arg_283_1.duration_ = 5.03

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1108408070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1084ui_story"]) and arg_283_1.var_.characterEffect1084ui_story == nil then
				arg_283_1.var_.characterEffect1084ui_story = arg_283_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1084ui_story"]) then
				if arg_283_1.var_.characterEffect1084ui_story and not isNil(arg_283_1.actors_["1084ui_story"]) then
					arg_283_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1084ui_story"]) and arg_283_1.var_.characterEffect1084ui_story then
				arg_283_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_286_2 = 0
			local var_286_3 = 0.45

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:GetWordFromCfg(1108408069)
				local var_286_5 = arg_283_1:FormatText(var_286_4.content)

				arg_283_1.text_.text = var_286_5

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_7 = 18 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 18)

				if (18 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 18)) > 0 and var_286_3 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_5
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408069", "story_v_side_new_1108408.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408069", "story_v_side_new_1108408.awb") / 1000

					if var_286_8 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_2
					end

					if var_286_4.prefab_name ~= "" and arg_283_1.actors_[var_286_4.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_4.prefab_name].transform, "story_v_side_new_1108408", "1108408069", "story_v_side_new_1108408.awb")

						arg_283_1:RecordAudio("1108408069", var_286_9)
						arg_283_1:RecordAudio("1108408069", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408069", "story_v_side_new_1108408.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408069", "story_v_side_new_1108408.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_10 and arg_283_1.time_ < var_286_2 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1108408070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1108408070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1108408071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1084ui_story"]) and arg_287_1.var_.characterEffect1084ui_story == nil then
				arg_287_1.var_.characterEffect1084ui_story = arg_287_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1084ui_story"]) then
				if arg_287_1.var_.characterEffect1084ui_story and not isNil(arg_287_1.actors_["1084ui_story"]) then
					arg_287_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_0)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1084ui_story"]) and arg_287_1.var_.characterEffect1084ui_story then
				arg_287_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_290_1 = 0
			local var_290_2 = 0.125

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

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1108408070).content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 5 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 5)

				if (5 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 5)) > 0 and var_290_2 < var_290_5 then
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
	Play1108408071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1108408071
		arg_291_1.duration_ = 3.5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1108408072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1084ui_story"]) and arg_291_1.var_.characterEffect1084ui_story == nil then
				arg_291_1.var_.characterEffect1084ui_story = arg_291_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1084ui_story"]) then
				if arg_291_1.var_.characterEffect1084ui_story and not isNil(arg_291_1.actors_["1084ui_story"]) then
					arg_291_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1084ui_story"]) and arg_291_1.var_.characterEffect1084ui_story then
				arg_291_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_294_2 = 0
			local var_294_3 = 0.3

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_4 = arg_291_1:GetWordFromCfg(1108408071)
				local var_294_5 = arg_291_1:FormatText(var_294_4.content)

				arg_291_1.text_.text = var_294_5

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_7 = 12 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 12)

				if (12 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 12)) > 0 and var_294_3 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_5
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408071", "story_v_side_new_1108408.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408071", "story_v_side_new_1108408.awb") / 1000

					if var_294_8 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_2
					end

					if var_294_4.prefab_name ~= "" and arg_291_1.actors_[var_294_4.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_4.prefab_name].transform, "story_v_side_new_1108408", "1108408071", "story_v_side_new_1108408.awb")

						arg_291_1:RecordAudio("1108408071", var_294_9)
						arg_291_1:RecordAudio("1108408071", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408071", "story_v_side_new_1108408.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408071", "story_v_side_new_1108408.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_10 and arg_291_1.time_ < var_294_2 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1108408072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1108408072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1108408073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1084ui_story = arg_295_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1084ui_story"].transform.position).z)
				arg_295_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1084ui_story"].transform.localEulerAngles = arg_295_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_295_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1084ui_story"].transform.position).z)
				arg_295_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1084ui_story"].transform.localEulerAngles = arg_295_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1084ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1084ui_story == nil then
				arg_295_1.var_.characterEffect1084ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1084ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_2)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1084ui_story then
				arg_295_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_298_3 = 0
			local var_298_4 = 1.6

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_3 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_5 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(1108408072).content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 64 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_5) / 64)

				if (64 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_5) / 64)) > 0 and var_298_4 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_3 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_3
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_4, arg_295_1.talkMaxDuration)

			if var_298_3 <= arg_295_1.time_ and arg_295_1.time_ < var_298_3 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_3) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_3 + var_298_8 and arg_295_1.time_ < var_298_3 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play1108408073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1108408073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1108408074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.825

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
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

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(1108408073).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 33 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 33)

				if (33 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 33)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1108408074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1108408074
		arg_303_1.duration_ = 4.3

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1108408075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1084ui_story = arg_303_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).z)
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles = arg_303_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_303_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).z)
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles = arg_303_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["1084ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1084ui_story == nil then
				arg_303_1.var_.characterEffect1084ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect1084ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1084ui_story then
				arg_303_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_306_4 = 0
			local var_306_5 = 0.5

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_6 = arg_303_1:GetWordFromCfg(1108408074)
				local var_306_7 = arg_303_1:FormatText(var_306_6.content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_9 = 20 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 20)

				if (20 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 20)) > 0 and var_306_5 < var_306_9 then
					arg_303_1.talkMaxDuration = var_306_9

					if var_306_9 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_9 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408074", "story_v_side_new_1108408.awb") ~= 0 then
					local var_306_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408074", "story_v_side_new_1108408.awb") / 1000

					if var_306_10 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_10 + var_306_4
					end

					if var_306_6.prefab_name ~= "" and arg_303_1.actors_[var_306_6.prefab_name] ~= nil then
						local var_306_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_6.prefab_name].transform, "story_v_side_new_1108408", "1108408074", "story_v_side_new_1108408.awb")

						arg_303_1:RecordAudio("1108408074", var_306_11)
						arg_303_1:RecordAudio("1108408074", var_306_11)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408074", "story_v_side_new_1108408.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408074", "story_v_side_new_1108408.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_12 = math.max(var_306_5, arg_303_1.talkMaxDuration)

			if var_306_4 <= arg_303_1.time_ and arg_303_1.time_ < var_306_4 + var_306_12 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_4) / var_306_12

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_4 + var_306_12 and arg_303_1.time_ < var_306_4 + var_306_12 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play1108408075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1108408075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1108408076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1084ui_story"]) and arg_307_1.var_.characterEffect1084ui_story == nil then
				arg_307_1.var_.characterEffect1084ui_story = arg_307_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1084ui_story"]) then
				if arg_307_1.var_.characterEffect1084ui_story and not isNil(arg_307_1.actors_["1084ui_story"]) then
					arg_307_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1084ui_story"]) and arg_307_1.var_.characterEffect1084ui_story then
				arg_307_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0
			local var_310_2 = 0.4

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(1108408075).content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 16 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 16)

				if (16 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 16)) > 0 and var_310_2 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_6 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_6 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_6

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_6 and arg_307_1.time_ < var_310_1 + var_310_6 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1108408076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1108408076
		arg_311_1.duration_ = 16.33

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1108408077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1084ui_story"]) and arg_311_1.var_.characterEffect1084ui_story == nil then
				arg_311_1.var_.characterEffect1084ui_story = arg_311_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1084ui_story"]) then
				if arg_311_1.var_.characterEffect1084ui_story and not isNil(arg_311_1.actors_["1084ui_story"]) then
					arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1084ui_story"]) and arg_311_1.var_.characterEffect1084ui_story then
				arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_314_2 = 0
			local var_314_3 = 1.375

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_2 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_4 = arg_311_1:GetWordFromCfg(1108408076)
				local var_314_5 = arg_311_1:FormatText(var_314_4.content)

				arg_311_1.text_.text = var_314_5

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_7 = 55 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_5) / 55)

				if (55 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_5) / 55)) > 0 and var_314_3 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_2
					end
				end

				arg_311_1.text_.text = var_314_5
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408076", "story_v_side_new_1108408.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408076", "story_v_side_new_1108408.awb") / 1000

					if var_314_8 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_2
					end

					if var_314_4.prefab_name ~= "" and arg_311_1.actors_[var_314_4.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_4.prefab_name].transform, "story_v_side_new_1108408", "1108408076", "story_v_side_new_1108408.awb")

						arg_311_1:RecordAudio("1108408076", var_314_9)
						arg_311_1:RecordAudio("1108408076", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408076", "story_v_side_new_1108408.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408076", "story_v_side_new_1108408.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = math.max(var_314_3, arg_311_1.talkMaxDuration)

			if var_314_2 <= arg_311_1.time_ and arg_311_1.time_ < var_314_2 + var_314_10 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_2) / var_314_10

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_2 + var_314_10 and arg_311_1.time_ < var_314_2 + var_314_10 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1108408077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1108408077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1108408078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1084ui_story = arg_315_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).z)
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles = arg_315_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_315_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1084ui_story"].transform.position).z)
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1084ui_story"].transform.localEulerAngles = arg_315_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["1084ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1084ui_story == nil then
				arg_315_1.var_.characterEffect1084ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect1084ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_2)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1084ui_story then
				arg_315_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_318_3 = 0
			local var_318_4 = 1

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_3 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_5 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1108408077).content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 40 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_5) / 40)

				if (40 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_5) / 40)) > 0 and var_318_4 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_3 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_3
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_8 = math.max(var_318_4, arg_315_1.talkMaxDuration)

			if var_318_3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_3 + var_318_8 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_3) / var_318_8

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_3 + var_318_8 and arg_315_1.time_ < var_318_3 + var_318_8 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play1108408078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1108408078
		arg_319_1.duration_ = 1

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"

			SetActive(arg_319_1.choicesGo_, true)

			for iter_320_0, iter_320_1 in ipairs(arg_319_1.choices_) do
				SetActive(iter_320_1.go, iter_320_0 <= 2)
			end

			arg_319_1.choices_[1].txt.text = arg_319_1:FormatText(StoryChoiceCfg[1692].name)
			arg_319_1.choices_[2].txt.text = arg_319_1:FormatText(StoryChoiceCfg[1693].name)
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1108408079(arg_319_1)
			end

			if arg_321_0 == 2 then
				arg_319_0:Play1108408079(arg_319_1)
			end

			arg_319_1:RecordChoiceLog(1108408078, 1692, 1693)
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.allBtn_.enabled = false
			end

			if arg_319_1.time_ >= 0 + 0.5 and arg_319_1.time_ < 0 + 0.5 + arg_322_0 then
				arg_319_1.allBtn_.enabled = true
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1108408079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1108408079
		arg_323_1.duration_ = 3.4

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1108408080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1084ui_story = arg_323_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1084ui_story"].transform.position).z)
				arg_323_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1084ui_story"].transform.localEulerAngles = arg_323_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_323_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1084ui_story"].transform.position).z)
				arg_323_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1084ui_story"].transform.localEulerAngles = arg_323_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["1084ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1084ui_story == nil then
				arg_323_1.var_.characterEffect1084ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect1084ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1084ui_story then
				arg_323_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_326_4 = 0
			local var_326_5 = 0.2

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:GetWordFromCfg(1108408079)
				local var_326_7 = arg_323_1:FormatText(var_326_6.content)

				arg_323_1.text_.text = var_326_7

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 8 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 8)

				if (8 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 8)) > 0 and var_326_5 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_7
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408079", "story_v_side_new_1108408.awb") ~= 0 then
					local var_326_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408079", "story_v_side_new_1108408.awb") / 1000

					if var_326_10 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_4
					end

					if var_326_6.prefab_name ~= "" and arg_323_1.actors_[var_326_6.prefab_name] ~= nil then
						local var_326_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_6.prefab_name].transform, "story_v_side_new_1108408", "1108408079", "story_v_side_new_1108408.awb")

						arg_323_1:RecordAudio("1108408079", var_326_11)
						arg_323_1:RecordAudio("1108408079", var_326_11)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408079", "story_v_side_new_1108408.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408079", "story_v_side_new_1108408.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_12 and arg_323_1.time_ < var_326_4 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play1108408080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1108408080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1108408081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1084ui_story"]) and arg_327_1.var_.characterEffect1084ui_story == nil then
				arg_327_1.var_.characterEffect1084ui_story = arg_327_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1084ui_story"]) then
				if arg_327_1.var_.characterEffect1084ui_story and not isNil(arg_327_1.actors_["1084ui_story"]) then
					arg_327_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1084ui_story"]) and arg_327_1.var_.characterEffect1084ui_story then
				arg_327_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 0.525

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(1108408080).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 21 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 21)

				if (21 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 21)) > 0 and var_330_2 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_6 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_6 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_6

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_6 and arg_327_1.time_ < var_330_1 + var_330_6 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1108408081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1108408081
		arg_331_1.duration_ = 9

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1108408082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 1.999999999999 < arg_331_1.time_ and arg_331_1.time_ <= 1.999999999999 + arg_334_0 then
				local var_334_0 = arg_331_1.bgs_.H02a

				arg_331_1.bgs_.H02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_334_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_334_1 = var_334_0:GetComponent("SpriteRenderer")

				if var_334_1 and var_334_1.sprite then
					local var_334_2 = 2 * (var_334_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_334_0.transform.localScale = Vector3.New(var_334_2 / var_334_1.sprite.bounds.size.y < var_334_2 * manager.ui.mainCameraCom_.aspect / var_334_1.sprite.bounds.size.x and var_334_2 * manager.ui.mainCameraCom_.aspect / var_334_1.sprite.bounds.size.x or var_334_2 / var_334_1.sprite.bounds.size.y, var_334_2 / var_334_1.sprite.bounds.size.y < var_334_2 * manager.ui.mainCameraCom_.aspect / var_334_1.sprite.bounds.size.x and var_334_2 * manager.ui.mainCameraCom_.aspect / var_334_1.sprite.bounds.size.x or var_334_2 / var_334_1.sprite.bounds.size.y, 0)
				end

				for iter_334_0, iter_334_1 in pairs(arg_331_1.bgs_) do
					if iter_334_0 ~= "H02a" then
						iter_334_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_334_3 = 3.999999999999

			if 3.999999999999 < arg_331_1.time_ and arg_331_1.time_ <= var_334_3 + arg_334_0 then
				arg_331_1.allBtn_.enabled = false
			end

			if arg_331_1.time_ >= var_334_3 + 0.3 and arg_331_1.time_ < var_334_3 + 0.3 + arg_334_0 then
				arg_331_1.allBtn_.enabled = true
			end

			local var_334_4 = 0

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_5 = 2

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_5 then
				local var_334_6 = Color.New(0, 0, 0)

				var_334_6.a = Mathf.Lerp(0, 1, (arg_331_1.time_ - var_334_4) / var_334_5)
				arg_331_1.mask_.color = var_334_6
			end

			if arg_331_1.time_ >= var_334_4 + var_334_5 and arg_331_1.time_ < var_334_4 + var_334_5 + arg_334_0 then
				local var_334_7 = Color.New(0, 0, 0)

				var_334_7.a = 1
				arg_331_1.mask_.color = var_334_7
			end

			local var_334_8 = 2

			if 2 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_9 = 2

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_9 then
				local var_334_10 = Color.New(0, 0, 0)

				var_334_10.a = Mathf.Lerp(1, 0, (arg_331_1.time_ - var_334_8) / var_334_9)
				arg_331_1.mask_.color = var_334_10
			end

			if arg_331_1.time_ >= var_334_8 + var_334_9 and arg_331_1.time_ < var_334_8 + var_334_9 + arg_334_0 then
				local var_334_11 = Color.New(0, 0, 0)

				arg_331_1.mask_.enabled = false
				var_334_11.a = 0
				arg_331_1.mask_.color = var_334_11
			end

			local var_334_12 = arg_331_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_331_1.time_ and arg_331_1.time_ <= 1.96599999815226 + arg_334_0 then
				arg_331_1.var_.moveOldPos1084ui_story = var_334_12.localPosition
			end

			local var_334_13 = 0.001

			if 1.96599999815226 <= arg_331_1.time_ and arg_331_1.time_ < 1.96599999815226 + var_334_13 then
				var_334_12.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 1.96599999815226) / var_334_13)
				var_334_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_12.position).x, (manager.ui.mainCamera.transform.position - var_334_12.position).y, (manager.ui.mainCamera.transform.position - var_334_12.position).z)
				var_334_12.localEulerAngles.z = 0
				var_334_12.localEulerAngles.x = 0
				var_334_12.localEulerAngles = var_334_12.localEulerAngles
			end

			if arg_331_1.time_ >= 1.96599999815226 + var_334_13 and arg_331_1.time_ < 1.96599999815226 + var_334_13 + arg_334_0 then
				var_334_12.localPosition = Vector3.New(0, 100, 0)
				var_334_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_12.position).x, (manager.ui.mainCamera.transform.position - var_334_12.position).y, (manager.ui.mainCamera.transform.position - var_334_12.position).z)
				var_334_12.localEulerAngles.z = 0
				var_334_12.localEulerAngles.x = 0
				var_334_12.localEulerAngles = var_334_12.localEulerAngles
			end

			if arg_331_1.frameCnt_ <= 1 then
				arg_331_1.dialog_:SetActive(false)
			end

			local var_334_14 = 3.999999999999
			local var_334_15 = 1.375

			if 3.999999999999 < arg_331_1.time_ and arg_331_1.time_ <= var_334_14 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0

				arg_331_1.dialog_:SetActive(true)

				arg_331_1.dialogCg_.alpha = 0

				local var_334_16 = LeanTween.value(arg_331_1.dialog_, 0, 1, 0.3)

				var_334_16:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_331_1.dialogCg_.alpha = arg_335_0
				end))
				var_334_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_331_1.dialog_)
					var_334_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_331_1.duration_ = arg_331_1.duration_ + 0.3

				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_17 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1108408081).content)

				arg_331_1.text_.text = var_334_17

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_19 = 55 <= 0 and var_334_15 or var_334_15 * (utf8.len(var_334_17) / 55)

				if (55 <= 0 and var_334_15 or var_334_15 * (utf8.len(var_334_17) / 55)) > 0 and var_334_15 < var_334_19 then
					arg_331_1.talkMaxDuration = var_334_19
					var_334_14 = var_334_14 + 0.3

					if var_334_19 + var_334_14 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_19 + var_334_14
					end
				end

				arg_331_1.text_.text = var_334_17
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_20 = var_334_14 + 0.3
			local var_334_21 = math.max(var_334_15, arg_331_1.talkMaxDuration)

			if var_334_14 + 0.3 <= arg_331_1.time_ and arg_331_1.time_ < var_334_20 + var_334_21 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_20) / var_334_21

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_20 + var_334_21 and arg_331_1.time_ < var_334_20 + var_334_21 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play1108408082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1108408082
		arg_337_1.duration_ = 3.73

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1108408083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1084ui_story = arg_337_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1084ui_story"].transform.position).z)
				arg_337_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1084ui_story"].transform.localEulerAngles = arg_337_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_337_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1084ui_story"].transform.position).z)
				arg_337_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1084ui_story"].transform.localEulerAngles = arg_337_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["1084ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1084ui_story == nil then
				arg_337_1.var_.characterEffect1084ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.characterEffect1084ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1084ui_story then
				arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_340_4 = 0
			local var_340_5 = 0.5

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

				local var_340_6 = arg_337_1:GetWordFromCfg(1108408082)
				local var_340_7 = arg_337_1:FormatText(var_340_6.content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 20 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 20)

				if (20 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 20)) > 0 and var_340_5 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408082", "story_v_side_new_1108408.awb") ~= 0 then
					local var_340_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408082", "story_v_side_new_1108408.awb") / 1000

					if var_340_10 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_4
					end

					if var_340_6.prefab_name ~= "" and arg_337_1.actors_[var_340_6.prefab_name] ~= nil then
						local var_340_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_6.prefab_name].transform, "story_v_side_new_1108408", "1108408082", "story_v_side_new_1108408.awb")

						arg_337_1:RecordAudio("1108408082", var_340_11)
						arg_337_1:RecordAudio("1108408082", var_340_11)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408082", "story_v_side_new_1108408.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408082", "story_v_side_new_1108408.awb")
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
				actorName = "1084ui_story",
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
	Play1108408083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1108408083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1108408084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1084ui_story"]) and arg_341_1.var_.characterEffect1084ui_story == nil then
				arg_341_1.var_.characterEffect1084ui_story = arg_341_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1084ui_story"]) then
				if arg_341_1.var_.characterEffect1084ui_story and not isNil(arg_341_1.actors_["1084ui_story"]) then
					arg_341_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_0)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1084ui_story"]) and arg_341_1.var_.characterEffect1084ui_story then
				arg_341_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_344_1 = 0
			local var_344_2 = 0.475

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
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

				local var_344_3 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1108408083).content)

				arg_341_1.text_.text = var_344_3

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 19 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 19)

				if (19 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 19)) > 0 and var_344_2 < var_344_5 then
					arg_341_1.talkMaxDuration = var_344_5

					if var_344_5 + var_344_1 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + var_344_1
					end
				end

				arg_341_1.text_.text = var_344_3
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_6 = math.max(var_344_2, arg_341_1.talkMaxDuration)

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_6 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_1) / var_344_6

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_1 + var_344_6 and arg_341_1.time_ < var_344_1 + var_344_6 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1108408084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1108408084
		arg_345_1.duration_ = 3.2

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1108408085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1084ui_story"]) and arg_345_1.var_.characterEffect1084ui_story == nil then
				arg_345_1.var_.characterEffect1084ui_story = arg_345_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1084ui_story"]) then
				if arg_345_1.var_.characterEffect1084ui_story and not isNil(arg_345_1.actors_["1084ui_story"]) then
					arg_345_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1084ui_story"]) and arg_345_1.var_.characterEffect1084ui_story then
				arg_345_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_348_2 = 0
			local var_348_3 = 0.125

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_4 = arg_345_1:GetWordFromCfg(1108408084)
				local var_348_5 = arg_345_1:FormatText(var_348_4.content)

				arg_345_1.text_.text = var_348_5

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_7 = 5 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_5) / 5)

				if (5 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_5) / 5)) > 0 and var_348_3 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_2
					end
				end

				arg_345_1.text_.text = var_348_5
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408084", "story_v_side_new_1108408.awb") ~= 0 then
					local var_348_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408084", "story_v_side_new_1108408.awb") / 1000

					if var_348_8 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_8 + var_348_2
					end

					if var_348_4.prefab_name ~= "" and arg_345_1.actors_[var_348_4.prefab_name] ~= nil then
						local var_348_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_4.prefab_name].transform, "story_v_side_new_1108408", "1108408084", "story_v_side_new_1108408.awb")

						arg_345_1:RecordAudio("1108408084", var_348_9)
						arg_345_1:RecordAudio("1108408084", var_348_9)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408084", "story_v_side_new_1108408.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408084", "story_v_side_new_1108408.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_10 = math.max(var_348_3, arg_345_1.talkMaxDuration)

			if var_348_2 <= arg_345_1.time_ and arg_345_1.time_ < var_348_2 + var_348_10 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_2) / var_348_10

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_2 + var_348_10 and arg_345_1.time_ < var_348_2 + var_348_10 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1108408085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1108408085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1108408086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1084ui_story = arg_349_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).z)
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles = arg_349_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).z)
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles = arg_349_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1084ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1084ui_story == nil then
				arg_349_1.var_.characterEffect1084ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect1084ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_2)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1084ui_story then
				arg_349_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_352_3 = 0
			local var_352_4 = 1.575

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_3 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_5 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(1108408085).content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 63 <= 0 and var_352_4 or var_352_4 * (utf8.len(var_352_5) / 63)

				if (63 <= 0 and var_352_4 or var_352_4 * (utf8.len(var_352_5) / 63)) > 0 and var_352_4 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_3 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_3
					end
				end

				arg_349_1.text_.text = var_352_5
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_8 = math.max(var_352_4, arg_349_1.talkMaxDuration)

			if var_352_3 <= arg_349_1.time_ and arg_349_1.time_ < var_352_3 + var_352_8 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_3) / var_352_8

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_3 + var_352_8 and arg_349_1.time_ < var_352_3 + var_352_8 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play1108408086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1108408086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1108408087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.85

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(1108408086).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 34 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 34)

				if (34 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 34)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1108408087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1108408087
		arg_357_1.duration_ = 3.53

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1108408088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1084ui_story = arg_357_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1084ui_story"].transform.position).z)
				arg_357_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1084ui_story"].transform.localEulerAngles = arg_357_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_357_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1084ui_story"].transform.position).z)
				arg_357_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1084ui_story"].transform.localEulerAngles = arg_357_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1084ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1084ui_story == nil then
				arg_357_1.var_.characterEffect1084ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1084ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1084ui_story then
				arg_357_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_360_4 = 0
			local var_360_5 = 0.425

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(1108408087)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 17 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 17)

				if (17 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 17)) > 0 and var_360_5 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408087", "story_v_side_new_1108408.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408087", "story_v_side_new_1108408.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_side_new_1108408", "1108408087", "story_v_side_new_1108408.awb")

						arg_357_1:RecordAudio("1108408087", var_360_11)
						arg_357_1:RecordAudio("1108408087", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408087", "story_v_side_new_1108408.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408087", "story_v_side_new_1108408.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_12 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_12 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_12

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_12 and arg_357_1.time_ < var_360_4 + var_360_12 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play1108408088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1108408088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1108408089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1084ui_story"]) and arg_361_1.var_.characterEffect1084ui_story == nil then
				arg_361_1.var_.characterEffect1084ui_story = arg_361_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1084ui_story"]) then
				if arg_361_1.var_.characterEffect1084ui_story and not isNil(arg_361_1.actors_["1084ui_story"]) then
					arg_361_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1084ui_story"]) and arg_361_1.var_.characterEffect1084ui_story then
				arg_361_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 1.35

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1108408088).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 54 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 54)

				if (54 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 54)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1108408089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1108408089
		arg_365_1.duration_ = 4.57

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1108408090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1084ui_story"]) and arg_365_1.var_.characterEffect1084ui_story == nil then
				arg_365_1.var_.characterEffect1084ui_story = arg_365_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1084ui_story"]) then
				if arg_365_1.var_.characterEffect1084ui_story and not isNil(arg_365_1.actors_["1084ui_story"]) then
					arg_365_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1084ui_story"]) and arg_365_1.var_.characterEffect1084ui_story then
				arg_365_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_368_2 = 0
			local var_368_3 = 0.675

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:GetWordFromCfg(1108408089)
				local var_368_5 = arg_365_1:FormatText(var_368_4.content)

				arg_365_1.text_.text = var_368_5

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_7 = 27 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 27)

				if (27 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 27)) > 0 and var_368_3 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_5
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408089", "story_v_side_new_1108408.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408089", "story_v_side_new_1108408.awb") / 1000

					if var_368_8 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_2
					end

					if var_368_4.prefab_name ~= "" and arg_365_1.actors_[var_368_4.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_4.prefab_name].transform, "story_v_side_new_1108408", "1108408089", "story_v_side_new_1108408.awb")

						arg_365_1:RecordAudio("1108408089", var_368_9)
						arg_365_1:RecordAudio("1108408089", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408089", "story_v_side_new_1108408.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408089", "story_v_side_new_1108408.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_3, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_2) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_10 and arg_365_1.time_ < var_368_2 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1108408090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1108408090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1108408091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1084ui_story"]) and arg_369_1.var_.characterEffect1084ui_story == nil then
				arg_369_1.var_.characterEffect1084ui_story = arg_369_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1084ui_story"]) then
				if arg_369_1.var_.characterEffect1084ui_story and not isNil(arg_369_1.actors_["1084ui_story"]) then
					arg_369_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1084ui_story"]) and arg_369_1.var_.characterEffect1084ui_story then
				arg_369_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 1.125

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1108408090).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 45 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 45)

				if (45 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 45)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1108408091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1108408091
		arg_373_1.duration_ = 2.17

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1108408092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1084ui_story"]) and arg_373_1.var_.characterEffect1084ui_story == nil then
				arg_373_1.var_.characterEffect1084ui_story = arg_373_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1084ui_story"]) then
				if arg_373_1.var_.characterEffect1084ui_story and not isNil(arg_373_1.actors_["1084ui_story"]) then
					arg_373_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1084ui_story"]) and arg_373_1.var_.characterEffect1084ui_story then
				arg_373_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_376_2 = 0
			local var_376_3 = 0.225

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(1108408091)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 9 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 9)

				if (9 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 9)) > 0 and var_376_3 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408091", "story_v_side_new_1108408.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408091", "story_v_side_new_1108408.awb") / 1000

					if var_376_8 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_2
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_side_new_1108408", "1108408091", "story_v_side_new_1108408.awb")

						arg_373_1:RecordAudio("1108408091", var_376_9)
						arg_373_1:RecordAudio("1108408091", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408091", "story_v_side_new_1108408.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408091", "story_v_side_new_1108408.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_10 and arg_373_1.time_ < var_376_2 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play1108408092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1108408092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1108408093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1084ui_story"]) and arg_377_1.var_.characterEffect1084ui_story == nil then
				arg_377_1.var_.characterEffect1084ui_story = arg_377_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1084ui_story"]) then
				if arg_377_1.var_.characterEffect1084ui_story and not isNil(arg_377_1.actors_["1084ui_story"]) then
					arg_377_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1084ui_story"]) and arg_377_1.var_.characterEffect1084ui_story then
				arg_377_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_380_1 = 0
			local var_380_2 = 0.525

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(1108408092).content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 21 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 21)

				if (21 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 21)) > 0 and var_380_2 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_6 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_6 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_6

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_6 and arg_377_1.time_ < var_380_1 + var_380_6 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1108408093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1108408093
		arg_381_1.duration_ = 2.57

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1108408094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1084ui_story"]) and arg_381_1.var_.characterEffect1084ui_story == nil then
				arg_381_1.var_.characterEffect1084ui_story = arg_381_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1084ui_story"]) then
				if arg_381_1.var_.characterEffect1084ui_story and not isNil(arg_381_1.actors_["1084ui_story"]) then
					arg_381_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1084ui_story"]) and arg_381_1.var_.characterEffect1084ui_story then
				arg_381_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_384_2 = 0
			local var_384_3 = 0.5

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_2 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:GetWordFromCfg(1108408093)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_7 = 20 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 20)

				if (20 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 20)) > 0 and var_384_3 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_2
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408093", "story_v_side_new_1108408.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408093", "story_v_side_new_1108408.awb") / 1000

					if var_384_8 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_2
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_side_new_1108408", "1108408093", "story_v_side_new_1108408.awb")

						arg_381_1:RecordAudio("1108408093", var_384_9)
						arg_381_1:RecordAudio("1108408093", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408093", "story_v_side_new_1108408.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408093", "story_v_side_new_1108408.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_3, arg_381_1.talkMaxDuration)

			if var_384_2 <= arg_381_1.time_ and arg_381_1.time_ < var_384_2 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_2) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_2 + var_384_10 and arg_381_1.time_ < var_384_2 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play1108408094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1108408094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1108408095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1084ui_story"]) and arg_385_1.var_.characterEffect1084ui_story == nil then
				arg_385_1.var_.characterEffect1084ui_story = arg_385_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1084ui_story"]) then
				if arg_385_1.var_.characterEffect1084ui_story and not isNil(arg_385_1.actors_["1084ui_story"]) then
					arg_385_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1084ui_story"]) and arg_385_1.var_.characterEffect1084ui_story then
				arg_385_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 0.325

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(1108408094).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 13 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 13)

				if (13 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 13)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1108408095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1108408095
		arg_389_1.duration_ = 2

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1108408096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) and arg_389_1.var_.characterEffect1084ui_story == nil then
				arg_389_1.var_.characterEffect1084ui_story = arg_389_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) then
				if arg_389_1.var_.characterEffect1084ui_story and not isNil(arg_389_1.actors_["1084ui_story"]) then
					arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) and arg_389_1.var_.characterEffect1084ui_story then
				arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_392_2 = 0
			local var_392_3 = 0.125

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:GetWordFromCfg(1108408095)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 5 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 5)

				if (5 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 5)) > 0 and var_392_3 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408095", "story_v_side_new_1108408.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408095", "story_v_side_new_1108408.awb") / 1000

					if var_392_8 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_2
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_side_new_1108408", "1108408095", "story_v_side_new_1108408.awb")

						arg_389_1:RecordAudio("1108408095", var_392_9)
						arg_389_1:RecordAudio("1108408095", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408095", "story_v_side_new_1108408.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408095", "story_v_side_new_1108408.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_3, arg_389_1.talkMaxDuration)

			if var_392_2 <= arg_389_1.time_ and arg_389_1.time_ < var_392_2 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_2) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_2 + var_392_10 and arg_389_1.time_ < var_392_2 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1108408096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1108408096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1108408097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1084ui_story"]) and arg_393_1.var_.characterEffect1084ui_story == nil then
				arg_393_1.var_.characterEffect1084ui_story = arg_393_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1084ui_story"]) then
				if arg_393_1.var_.characterEffect1084ui_story and not isNil(arg_393_1.actors_["1084ui_story"]) then
					arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_0)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1084ui_story"]) and arg_393_1.var_.characterEffect1084ui_story then
				arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_396_1 = 0
			local var_396_2 = 0.375

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_3 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(1108408096).content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 15 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 15)

				if (15 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 15)) > 0 and var_396_2 < var_396_5 then
					arg_393_1.talkMaxDuration = var_396_5

					if var_396_5 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + var_396_1
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_6 = math.max(var_396_2, arg_393_1.talkMaxDuration)

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_6 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_1) / var_396_6

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_1 + var_396_6 and arg_393_1.time_ < var_396_1 + var_396_6 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play1108408097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1108408097
		arg_397_1.duration_ = 6.23

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1108408098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1084ui_story"]) and arg_397_1.var_.characterEffect1084ui_story == nil then
				arg_397_1.var_.characterEffect1084ui_story = arg_397_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1084ui_story"]) then
				if arg_397_1.var_.characterEffect1084ui_story and not isNil(arg_397_1.actors_["1084ui_story"]) then
					arg_397_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1084ui_story"]) and arg_397_1.var_.characterEffect1084ui_story then
				arg_397_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_400_2 = 0
			local var_400_3 = 0.525

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:GetWordFromCfg(1108408097)
				local var_400_5 = arg_397_1:FormatText(var_400_4.content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 21 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 21)

				if (21 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 21)) > 0 and var_400_3 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_2
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408097", "story_v_side_new_1108408.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408097", "story_v_side_new_1108408.awb") / 1000

					if var_400_8 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_2
					end

					if var_400_4.prefab_name ~= "" and arg_397_1.actors_[var_400_4.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_4.prefab_name].transform, "story_v_side_new_1108408", "1108408097", "story_v_side_new_1108408.awb")

						arg_397_1:RecordAudio("1108408097", var_400_9)
						arg_397_1:RecordAudio("1108408097", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408097", "story_v_side_new_1108408.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408097", "story_v_side_new_1108408.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_3, arg_397_1.talkMaxDuration)

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_2) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_2 + var_400_10 and arg_397_1.time_ < var_400_2 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1108408098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1108408098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1108408099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1084ui_story = arg_401_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_404_0 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 then
				arg_401_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_401_1.time_ - 0) / var_404_0)
				arg_401_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).z)
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles = arg_401_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 then
				arg_401_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_401_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).z)
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles = arg_401_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_404_1 = arg_401_1.actors_["1084ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1084ui_story == nil then
				arg_401_1.var_.characterEffect1084ui_story = var_404_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_2 and not isNil(var_404_1) then
				if arg_401_1.var_.characterEffect1084ui_story and not isNil(var_404_1) then
					arg_401_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_2)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_2 and arg_401_1.time_ < 0 + var_404_2 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1084ui_story then
				arg_401_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_404_3 = 0
			local var_404_4 = 1.25

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_3 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_5 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(1108408098).content)

				arg_401_1.text_.text = var_404_5

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_7 = 50 <= 0 and var_404_4 or var_404_4 * (utf8.len(var_404_5) / 50)

				if (50 <= 0 and var_404_4 or var_404_4 * (utf8.len(var_404_5) / 50)) > 0 and var_404_4 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_3 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_3
					end
				end

				arg_401_1.text_.text = var_404_5
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_8 = math.max(var_404_4, arg_401_1.talkMaxDuration)

			if var_404_3 <= arg_401_1.time_ and arg_401_1.time_ < var_404_3 + var_404_8 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_3) / var_404_8

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_3 + var_404_8 and arg_401_1.time_ < var_404_3 + var_404_8 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play1108408099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1108408099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1108408100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.2

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(1108408099).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 8 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 8)

				if (8 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 8)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1108408100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1108408100
		arg_409_1.duration_ = 2.67

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1108408101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1084ui_story = arg_409_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).z)
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles = arg_409_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_409_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).z)
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles = arg_409_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_412_1 = arg_409_1.actors_["1084ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1084ui_story == nil then
				arg_409_1.var_.characterEffect1084ui_story = var_412_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_2 and not isNil(var_412_1) then
				if arg_409_1.var_.characterEffect1084ui_story and not isNil(var_412_1) then
					arg_409_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_2 and arg_409_1.time_ < 0 + var_412_2 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1084ui_story then
				arg_409_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action434")
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_412_4 = 0
			local var_412_5 = 0.4

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_6 = arg_409_1:GetWordFromCfg(1108408100)
				local var_412_7 = arg_409_1:FormatText(var_412_6.content)

				arg_409_1.text_.text = var_412_7

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_9 = 16 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 16)

				if (16 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 16)) > 0 and var_412_5 < var_412_9 then
					arg_409_1.talkMaxDuration = var_412_9

					if var_412_9 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_9 + var_412_4
					end
				end

				arg_409_1.text_.text = var_412_7
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408100", "story_v_side_new_1108408.awb") ~= 0 then
					local var_412_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408100", "story_v_side_new_1108408.awb") / 1000

					if var_412_10 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_10 + var_412_4
					end

					if var_412_6.prefab_name ~= "" and arg_409_1.actors_[var_412_6.prefab_name] ~= nil then
						local var_412_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_6.prefab_name].transform, "story_v_side_new_1108408", "1108408100", "story_v_side_new_1108408.awb")

						arg_409_1:RecordAudio("1108408100", var_412_11)
						arg_409_1:RecordAudio("1108408100", var_412_11)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408100", "story_v_side_new_1108408.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408100", "story_v_side_new_1108408.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_12 = math.max(var_412_5, arg_409_1.talkMaxDuration)

			if var_412_4 <= arg_409_1.time_ and arg_409_1.time_ < var_412_4 + var_412_12 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_4) / var_412_12

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_4 + var_412_12 and arg_409_1.time_ < var_412_4 + var_412_12 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play1108408101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1108408101
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1108408102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1084ui_story = arg_413_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).z)
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles = arg_413_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_413_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).z)
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles = arg_413_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["1084ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1084ui_story == nil then
				arg_413_1.var_.characterEffect1084ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect1084ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_2)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1084ui_story then
				arg_413_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_416_3 = 0
			local var_416_4 = 0.525

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_3 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_5 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(1108408101).content)

				arg_413_1.text_.text = var_416_5

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_7 = 21 <= 0 and var_416_4 or var_416_4 * (utf8.len(var_416_5) / 21)

				if (21 <= 0 and var_416_4 or var_416_4 * (utf8.len(var_416_5) / 21)) > 0 and var_416_4 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_3 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_3
					end
				end

				arg_413_1.text_.text = var_416_5
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_8 = math.max(var_416_4, arg_413_1.talkMaxDuration)

			if var_416_3 <= arg_413_1.time_ and arg_413_1.time_ < var_416_3 + var_416_8 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_3) / var_416_8

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_3 + var_416_8 and arg_413_1.time_ < var_416_3 + var_416_8 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play1108408102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1108408102
		arg_417_1.duration_ = 5.27

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1108408103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_420_0 = 0.266666666666667

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				local var_420_1, var_420_2 = math.modf((arg_417_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_420_2 * 0.13, var_420_2 * 0.13, var_420_2 * 0.13) + arg_417_1.var_.shakeOldPos
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				manager.ui.mainCamera.transform.localPosition = arg_417_1.var_.shakeOldPos
			end

			local var_420_3 = 0

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_3 + arg_420_0 then
				arg_417_1.allBtn_.enabled = false
			end

			if arg_417_1.time_ >= var_420_3 + 0.266666666666667 and arg_417_1.time_ < var_420_3 + 0.266666666666667 + arg_420_0 then
				arg_417_1.allBtn_.enabled = true
			end

			if arg_417_1.frameCnt_ <= 1 then
				arg_417_1.dialog_:SetActive(false)
			end

			local var_420_4 = 0.266666666666667
			local var_420_5 = 0.125

			if 0.266666666666667 < arg_417_1.time_ and arg_417_1.time_ <= var_420_4 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0

				arg_417_1.dialog_:SetActive(true)

				arg_417_1.dialogCg_.alpha = 0

				local var_420_6 = LeanTween.value(arg_417_1.dialog_, 0, 1, 0.3)

				var_420_6:setOnUpdate(LuaHelper.FloatAction(function(arg_421_0)
					arg_417_1.dialogCg_.alpha = arg_421_0
				end))
				var_420_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_417_1.dialog_)
					var_420_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_417_1.duration_ = arg_417_1.duration_ + 0.3

				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_7 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(1108408102).content)

				arg_417_1.text_.text = var_420_7

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_9 = 5 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 5)

				if (5 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 5)) > 0 and var_420_5 < var_420_9 then
					arg_417_1.talkMaxDuration = var_420_9
					var_420_4 = var_420_4 + 0.3

					if var_420_9 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_9 + var_420_4
					end
				end

				arg_417_1.text_.text = var_420_7
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_10 = var_420_4 + 0.3
			local var_420_11 = math.max(var_420_5, arg_417_1.talkMaxDuration)

			if var_420_4 + 0.3 <= arg_417_1.time_ and arg_417_1.time_ < var_420_10 + var_420_11 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_10) / var_420_11

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_10 + var_420_11 and arg_417_1.time_ < var_420_10 + var_420_11 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1108408103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1108408103
		arg_423_1.duration_ = 3.57

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1108408104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1084ui_story = arg_423_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1084ui_story"].transform.position).z)
				arg_423_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1084ui_story"].transform.localEulerAngles = arg_423_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_423_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1084ui_story"].transform.position).z)
				arg_423_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1084ui_story"].transform.localEulerAngles = arg_423_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_426_1 = arg_423_1.actors_["1084ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1084ui_story == nil then
				arg_423_1.var_.characterEffect1084ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1084ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1084ui_story then
				arg_423_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_426_4 = 0
			local var_426_5 = 0.725

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(1108408103)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 29 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 29)

				if (29 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 29)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408103", "story_v_side_new_1108408.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408103", "story_v_side_new_1108408.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_side_new_1108408", "1108408103", "story_v_side_new_1108408.awb")

						arg_423_1:RecordAudio("1108408103", var_426_11)
						arg_423_1:RecordAudio("1108408103", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408103", "story_v_side_new_1108408.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408103", "story_v_side_new_1108408.awb")
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
				actorName = "1084ui_story",
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
	Play1108408104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1108408104
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1108408105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1084ui_story"]) and arg_427_1.var_.characterEffect1084ui_story == nil then
				arg_427_1.var_.characterEffect1084ui_story = arg_427_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1084ui_story"]) then
				if arg_427_1.var_.characterEffect1084ui_story and not isNil(arg_427_1.actors_["1084ui_story"]) then
					arg_427_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_0)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1084ui_story"]) and arg_427_1.var_.characterEffect1084ui_story then
				arg_427_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_430_1 = 0
			local var_430_2 = 0.3

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
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

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(1108408104).content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 12 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 12)

				if (12 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 12)) > 0 and var_430_2 < var_430_5 then
					arg_427_1.talkMaxDuration = var_430_5

					if var_430_5 + var_430_1 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + var_430_1
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_6 = math.max(var_430_2, arg_427_1.talkMaxDuration)

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_6 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_1) / var_430_6

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_1 + var_430_6 and arg_427_1.time_ < var_430_1 + var_430_6 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1108408105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1108408105
		arg_431_1.duration_ = 2.6

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1108408106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1084ui_story"]) and arg_431_1.var_.characterEffect1084ui_story == nil then
				arg_431_1.var_.characterEffect1084ui_story = arg_431_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1084ui_story"]) then
				if arg_431_1.var_.characterEffect1084ui_story and not isNil(arg_431_1.actors_["1084ui_story"]) then
					arg_431_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1084ui_story"]) and arg_431_1.var_.characterEffect1084ui_story then
				arg_431_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_434_2 = 0
			local var_434_3 = 0.225

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_2 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_4 = arg_431_1:GetWordFromCfg(1108408105)
				local var_434_5 = arg_431_1:FormatText(var_434_4.content)

				arg_431_1.text_.text = var_434_5

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_7 = 9 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_5) / 9)

				if (9 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_5) / 9)) > 0 and var_434_3 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_2
					end
				end

				arg_431_1.text_.text = var_434_5
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408105", "story_v_side_new_1108408.awb") ~= 0 then
					local var_434_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408105", "story_v_side_new_1108408.awb") / 1000

					if var_434_8 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_8 + var_434_2
					end

					if var_434_4.prefab_name ~= "" and arg_431_1.actors_[var_434_4.prefab_name] ~= nil then
						local var_434_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_4.prefab_name].transform, "story_v_side_new_1108408", "1108408105", "story_v_side_new_1108408.awb")

						arg_431_1:RecordAudio("1108408105", var_434_9)
						arg_431_1:RecordAudio("1108408105", var_434_9)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408105", "story_v_side_new_1108408.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408105", "story_v_side_new_1108408.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_10 = math.max(var_434_3, arg_431_1.talkMaxDuration)

			if var_434_2 <= arg_431_1.time_ and arg_431_1.time_ < var_434_2 + var_434_10 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_2) / var_434_10

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_2 + var_434_10 and arg_431_1.time_ < var_434_2 + var_434_10 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1108408106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1108408106
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1108408107(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1084ui_story"]) and arg_435_1.var_.characterEffect1084ui_story == nil then
				arg_435_1.var_.characterEffect1084ui_story = arg_435_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1084ui_story"]) then
				if arg_435_1.var_.characterEffect1084ui_story and not isNil(arg_435_1.actors_["1084ui_story"]) then
					arg_435_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_0)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1084ui_story"]) and arg_435_1.var_.characterEffect1084ui_story then
				arg_435_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_438_1 = 0
			local var_438_2 = 0.575

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(1108408106).content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 23 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 23)

				if (23 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 23)) > 0 and var_438_2 < var_438_5 then
					arg_435_1.talkMaxDuration = var_438_5

					if var_438_5 + var_438_1 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + var_438_1
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_6 = math.max(var_438_2, arg_435_1.talkMaxDuration)

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_6 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_1) / var_438_6

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_1 + var_438_6 and arg_435_1.time_ < var_438_1 + var_438_6 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1108408107 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1108408107
		arg_439_1.duration_ = 2

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1108408108(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["1084ui_story"]) and arg_439_1.var_.characterEffect1084ui_story == nil then
				arg_439_1.var_.characterEffect1084ui_story = arg_439_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["1084ui_story"]) then
				if arg_439_1.var_.characterEffect1084ui_story and not isNil(arg_439_1.actors_["1084ui_story"]) then
					arg_439_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["1084ui_story"]) and arg_439_1.var_.characterEffect1084ui_story then
				arg_439_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_442_2 = 0
			local var_442_3 = 0.15

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_2 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_4 = arg_439_1:GetWordFromCfg(1108408107)
				local var_442_5 = arg_439_1:FormatText(var_442_4.content)

				arg_439_1.text_.text = var_442_5

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_7 = 6 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 6)

				if (6 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 6)) > 0 and var_442_3 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_2
					end
				end

				arg_439_1.text_.text = var_442_5
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408107", "story_v_side_new_1108408.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408107", "story_v_side_new_1108408.awb") / 1000

					if var_442_8 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_2
					end

					if var_442_4.prefab_name ~= "" and arg_439_1.actors_[var_442_4.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_4.prefab_name].transform, "story_v_side_new_1108408", "1108408107", "story_v_side_new_1108408.awb")

						arg_439_1:RecordAudio("1108408107", var_442_9)
						arg_439_1:RecordAudio("1108408107", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408107", "story_v_side_new_1108408.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408107", "story_v_side_new_1108408.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_3, arg_439_1.talkMaxDuration)

			if var_442_2 <= arg_439_1.time_ and arg_439_1.time_ < var_442_2 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_2) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_2 + var_442_10 and arg_439_1.time_ < var_442_2 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1108408108 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1108408108
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1108408109(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1084ui_story = arg_443_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1084ui_story"].transform.position).z)
				arg_443_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1084ui_story"].transform.localEulerAngles = arg_443_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_443_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1084ui_story"].transform.position).z)
				arg_443_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1084ui_story"].transform.localEulerAngles = arg_443_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_446_1 = arg_443_1.actors_["1084ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1084ui_story == nil then
				arg_443_1.var_.characterEffect1084ui_story = var_446_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_2 and not isNil(var_446_1) then
				if arg_443_1.var_.characterEffect1084ui_story and not isNil(var_446_1) then
					arg_443_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_443_1.time_ - 0) / var_446_2)
				end
			end

			if arg_443_1.time_ >= 0 + var_446_2 and arg_443_1.time_ < 0 + var_446_2 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1084ui_story then
				arg_443_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_446_3 = 0
			local var_446_4 = 0.925

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_3 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_5 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(1108408108).content)

				arg_443_1.text_.text = var_446_5

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_7 = 37 <= 0 and var_446_4 or var_446_4 * (utf8.len(var_446_5) / 37)

				if (37 <= 0 and var_446_4 or var_446_4 * (utf8.len(var_446_5) / 37)) > 0 and var_446_4 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_3 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_3
					end
				end

				arg_443_1.text_.text = var_446_5
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_8 = math.max(var_446_4, arg_443_1.talkMaxDuration)

			if var_446_3 <= arg_443_1.time_ and arg_443_1.time_ < var_446_3 + var_446_8 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_3) / var_446_8

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_3 + var_446_8 and arg_443_1.time_ < var_446_3 + var_446_8 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play1108408109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1108408109
		arg_447_1.duration_ = 11.9

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1108408110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if arg_447_1.bgs_.A00 == nil then
				local var_450_0 = Object.Instantiate(arg_447_1.paintGo_)

				var_450_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_450_0.name = "A00"
				var_450_0.transform.parent = arg_447_1.stage_.transform
				var_450_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_447_1.bgs_.A00 = var_450_0
			end

			if 2 < arg_447_1.time_ and arg_447_1.time_ <= 2 + arg_450_0 then
				local var_450_1 = arg_447_1.bgs_.A00

				arg_447_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_450_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_450_2 = var_450_1:GetComponent("SpriteRenderer")

				if var_450_2 and var_450_2.sprite then
					local var_450_3 = 2 * (var_450_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_450_1.transform.localScale = Vector3.New(var_450_3 / var_450_2.sprite.bounds.size.y < var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x and var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x or var_450_3 / var_450_2.sprite.bounds.size.y, var_450_3 / var_450_2.sprite.bounds.size.y < var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x and var_450_3 * manager.ui.mainCameraCom_.aspect / var_450_2.sprite.bounds.size.x or var_450_3 / var_450_2.sprite.bounds.size.y, 0)
				end

				for iter_450_0, iter_450_1 in pairs(arg_447_1.bgs_) do
					if iter_450_0 ~= "A00" then
						iter_450_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_450_4 = 4.00000000298023

			if 4.00000000298023 < arg_447_1.time_ and arg_447_1.time_ <= var_450_4 + arg_450_0 then
				arg_447_1.allBtn_.enabled = false
			end

			if arg_447_1.time_ >= var_450_4 + 0.3 and arg_447_1.time_ < var_450_4 + 0.3 + arg_450_0 then
				arg_447_1.allBtn_.enabled = true
			end

			local var_450_5 = 0

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_5 + arg_450_0 then
				arg_447_1.mask_.enabled = true
				arg_447_1.mask_.raycastTarget = true

				arg_447_1:SetGaussion(false)
			end

			local var_450_6 = 2

			if var_450_5 <= arg_447_1.time_ and arg_447_1.time_ < var_450_5 + var_450_6 then
				local var_450_7 = Color.New(0, 0, 0)

				var_450_7.a = Mathf.Lerp(0, 1, (arg_447_1.time_ - var_450_5) / var_450_6)
				arg_447_1.mask_.color = var_450_7
			end

			if arg_447_1.time_ >= var_450_5 + var_450_6 and arg_447_1.time_ < var_450_5 + var_450_6 + arg_450_0 then
				local var_450_8 = Color.New(0, 0, 0)

				var_450_8.a = 1
				arg_447_1.mask_.color = var_450_8
			end

			local var_450_9 = 2

			if 2 < arg_447_1.time_ and arg_447_1.time_ <= var_450_9 + arg_450_0 then
				arg_447_1.mask_.enabled = true
				arg_447_1.mask_.raycastTarget = true

				arg_447_1:SetGaussion(false)
			end

			local var_450_10 = 2

			if var_450_9 <= arg_447_1.time_ and arg_447_1.time_ < var_450_9 + var_450_10 then
				local var_450_11 = Color.New(0, 0, 0)

				var_450_11.a = Mathf.Lerp(1, 0, (arg_447_1.time_ - var_450_9) / var_450_10)
				arg_447_1.mask_.color = var_450_11
			end

			if arg_447_1.time_ >= var_450_9 + var_450_10 and arg_447_1.time_ < var_450_9 + var_450_10 + arg_450_0 then
				local var_450_12 = Color.New(0, 0, 0)

				arg_447_1.mask_.enabled = false
				var_450_12.a = 0
				arg_447_1.mask_.color = var_450_12
			end

			local var_450_13 = arg_447_1.actors_["1084ui_story"].transform

			if 3.8 < arg_447_1.time_ and arg_447_1.time_ <= 3.8 + arg_450_0 then
				arg_447_1.var_.moveOldPos1084ui_story = var_450_13.localPosition
			end

			local var_450_14 = 0.001

			if 3.8 <= arg_447_1.time_ and arg_447_1.time_ < 3.8 + var_450_14 then
				var_450_13.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_447_1.time_ - 3.8) / var_450_14)
				var_450_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_450_13.position).x, (manager.ui.mainCamera.transform.position - var_450_13.position).y, (manager.ui.mainCamera.transform.position - var_450_13.position).z)
				var_450_13.localEulerAngles.z = 0
				var_450_13.localEulerAngles.x = 0
				var_450_13.localEulerAngles = var_450_13.localEulerAngles
			end

			if arg_447_1.time_ >= 3.8 + var_450_14 and arg_447_1.time_ < 3.8 + var_450_14 + arg_450_0 then
				var_450_13.localPosition = Vector3.New(0, -0.97, -6)
				var_450_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_450_13.position).x, (manager.ui.mainCamera.transform.position - var_450_13.position).y, (manager.ui.mainCamera.transform.position - var_450_13.position).z)
				var_450_13.localEulerAngles.z = 0
				var_450_13.localEulerAngles.x = 0
				var_450_13.localEulerAngles = var_450_13.localEulerAngles
			end

			local var_450_15 = arg_447_1.actors_["1084ui_story"]

			if 3.8 < arg_447_1.time_ and arg_447_1.time_ <= 3.8 + arg_450_0 and not isNil(var_450_15) and arg_447_1.var_.characterEffect1084ui_story == nil then
				arg_447_1.var_.characterEffect1084ui_story = var_450_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_16 = 0.200000002980232

			if 3.8 <= arg_447_1.time_ and arg_447_1.time_ < 3.8 + var_450_16 and not isNil(var_450_15) then
				if arg_447_1.var_.characterEffect1084ui_story and not isNil(var_450_15) then
					arg_447_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= 3.8 + var_450_16 and arg_447_1.time_ < 3.8 + var_450_16 + arg_450_0 and not isNil(var_450_15) and arg_447_1.var_.characterEffect1084ui_story then
				arg_447_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 3.8 < arg_447_1.time_ and arg_447_1.time_ <= 3.8 + arg_450_0 then
				arg_447_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 3.8 < arg_447_1.time_ and arg_447_1.time_ <= 3.8 + arg_450_0 then
				arg_447_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_447_1.time_ and arg_447_1.time_ <= 1.2 + arg_450_0 then
				arg_447_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if 0.2 < arg_447_1.time_ and arg_447_1.time_ <= 0.2 + arg_450_0 then
				arg_447_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:AudioAction("play", "music", "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_450_22 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

				if "" ~= "" then
					if arg_447_1.bgmTxt_.text ~= var_450_22 and arg_447_1.bgmTxt_.text ~= "" then
						if arg_447_1.bgmTxt2_.text ~= "" then
							arg_447_1.bgmTxt_.text = arg_447_1.bgmTxt2_.text
						end

						arg_447_1.bgmTxt2_.text = var_450_22

						arg_447_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_447_1.bgmTxt_.text = var_450_22
						arg_447_1.bgmTxt2_.text = var_450_22
					end

					if arg_447_1.bgmTimer then
						arg_447_1.bgmTimer:Stop()

						arg_447_1.bgmTimer = nil
					end

					if arg_447_1.settingData.show_music_name == 1 then
						arg_447_1.musicController:SetSelectedState("show")
						arg_447_1.musicAnimator_:Play("open", 0, 0)

						if arg_447_1.settingData.music_time ~= 0 then
							arg_447_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_447_1.settingData.music_time), function()
								if arg_447_1 == nil or isNil(arg_447_1.bgmTxt_) then
									return
								end

								arg_447_1.musicController:SetSelectedState("hide")
								arg_447_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_447_1.frameCnt_ <= 1 then
				arg_447_1.dialog_:SetActive(false)
			end

			local var_450_23 = 4
			local var_450_24 = 0.9

			if 4 < arg_447_1.time_ and arg_447_1.time_ <= var_450_23 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0

				arg_447_1.dialog_:SetActive(true)

				arg_447_1.dialogCg_.alpha = 0

				local var_450_25 = LeanTween.value(arg_447_1.dialog_, 0, 1, 0.3)

				var_450_25:setOnUpdate(LuaHelper.FloatAction(function(arg_452_0)
					arg_447_1.dialogCg_.alpha = arg_452_0
				end))
				var_450_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_447_1.dialog_)
					var_450_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_447_1.duration_ = arg_447_1.duration_ + 0.3

				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_26 = arg_447_1:GetWordFromCfg(1108408109)
				local var_450_27 = arg_447_1:FormatText(var_450_26.content)

				arg_447_1.text_.text = var_450_27

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_29 = 36 <= 0 and var_450_24 or var_450_24 * (utf8.len(var_450_27) / 36)

				if (36 <= 0 and var_450_24 or var_450_24 * (utf8.len(var_450_27) / 36)) > 0 and var_450_24 < var_450_29 then
					arg_447_1.talkMaxDuration = var_450_29
					var_450_23 = var_450_23 + 0.3

					if var_450_29 + var_450_23 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_29 + var_450_23
					end
				end

				arg_447_1.text_.text = var_450_27
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408109", "story_v_side_new_1108408.awb") ~= 0 then
					local var_450_30 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408109", "story_v_side_new_1108408.awb") / 1000

					if var_450_30 + var_450_23 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_30 + var_450_23
					end

					if var_450_26.prefab_name ~= "" and arg_447_1.actors_[var_450_26.prefab_name] ~= nil then
						local var_450_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_26.prefab_name].transform, "story_v_side_new_1108408", "1108408109", "story_v_side_new_1108408.awb")

						arg_447_1:RecordAudio("1108408109", var_450_31)
						arg_447_1:RecordAudio("1108408109", var_450_31)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408109", "story_v_side_new_1108408.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408109", "story_v_side_new_1108408.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_32 = var_450_23 + 0.3
			local var_450_33 = math.max(var_450_24, arg_447_1.talkMaxDuration)

			if var_450_23 + 0.3 <= arg_447_1.time_ and arg_447_1.time_ < var_450_32 + var_450_33 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_32) / var_450_33

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_32 + var_450_33 and arg_447_1.time_ < var_450_32 + var_450_33 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play1108408110 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1108408110
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1108408111(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1084ui_story"]) and arg_454_1.var_.characterEffect1084ui_story == nil then
				arg_454_1.var_.characterEffect1084ui_story = arg_454_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_0 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1084ui_story"]) then
				if arg_454_1.var_.characterEffect1084ui_story and not isNil(arg_454_1.actors_["1084ui_story"]) then
					arg_454_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_454_1.time_ - 0) / var_457_0)
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1084ui_story"]) and arg_454_1.var_.characterEffect1084ui_story then
				arg_454_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_457_1 = 0
			local var_457_2 = 0.775

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_3 = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(1108408110).content)

				arg_454_1.text_.text = var_457_3

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 31 <= 0 and var_457_2 or var_457_2 * (utf8.len(var_457_3) / 31)

				if (31 <= 0 and var_457_2 or var_457_2 * (utf8.len(var_457_3) / 31)) > 0 and var_457_2 < var_457_5 then
					arg_454_1.talkMaxDuration = var_457_5

					if var_457_5 + var_457_1 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_5 + var_457_1
					end
				end

				arg_454_1.text_.text = var_457_3
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_6 = math.max(var_457_2, arg_454_1.talkMaxDuration)

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_6 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_1) / var_457_6

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_1 + var_457_6 and arg_454_1.time_ < var_457_1 + var_457_6 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1108408111 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1108408111
		arg_458_1.duration_ = 6.53

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1108408112(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1084ui_story"]) and arg_458_1.var_.characterEffect1084ui_story == nil then
				arg_458_1.var_.characterEffect1084ui_story = arg_458_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1084ui_story"]) then
				if arg_458_1.var_.characterEffect1084ui_story and not isNil(arg_458_1.actors_["1084ui_story"]) then
					arg_458_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1084ui_story"]) and arg_458_1.var_.characterEffect1084ui_story then
				arg_458_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_461_2 = 0
			local var_461_3 = 0.475

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_2 + arg_461_0 then
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

				local var_461_4 = arg_458_1:GetWordFromCfg(1108408111)
				local var_461_5 = arg_458_1:FormatText(var_461_4.content)

				arg_458_1.text_.text = var_461_5

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_7 = 19 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_5) / 19)

				if (19 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_5) / 19)) > 0 and var_461_3 < var_461_7 then
					arg_458_1.talkMaxDuration = var_461_7

					if var_461_7 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_7 + var_461_2
					end
				end

				arg_458_1.text_.text = var_461_5
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408111", "story_v_side_new_1108408.awb") ~= 0 then
					local var_461_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408111", "story_v_side_new_1108408.awb") / 1000

					if var_461_8 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_8 + var_461_2
					end

					if var_461_4.prefab_name ~= "" and arg_458_1.actors_[var_461_4.prefab_name] ~= nil then
						local var_461_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_4.prefab_name].transform, "story_v_side_new_1108408", "1108408111", "story_v_side_new_1108408.awb")

						arg_458_1:RecordAudio("1108408111", var_461_9)
						arg_458_1:RecordAudio("1108408111", var_461_9)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408111", "story_v_side_new_1108408.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408111", "story_v_side_new_1108408.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_10 = math.max(var_461_3, arg_458_1.talkMaxDuration)

			if var_461_2 <= arg_458_1.time_ and arg_458_1.time_ < var_461_2 + var_461_10 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_2) / var_461_10

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_2 + var_461_10 and arg_458_1.time_ < var_461_2 + var_461_10 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1108408112 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1108408112
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1108408113(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["1084ui_story"]) and arg_462_1.var_.characterEffect1084ui_story == nil then
				arg_462_1.var_.characterEffect1084ui_story = arg_462_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_0 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["1084ui_story"]) then
				if arg_462_1.var_.characterEffect1084ui_story and not isNil(arg_462_1.actors_["1084ui_story"]) then
					arg_462_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_462_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_462_1.time_ - 0) / var_465_0)
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["1084ui_story"]) and arg_462_1.var_.characterEffect1084ui_story then
				arg_462_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_462_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_465_1 = 0
			local var_465_2 = 1.075

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_3 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(1108408112).content)

				arg_462_1.text_.text = var_465_3

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_5 = 43 <= 0 and var_465_2 or var_465_2 * (utf8.len(var_465_3) / 43)

				if (43 <= 0 and var_465_2 or var_465_2 * (utf8.len(var_465_3) / 43)) > 0 and var_465_2 < var_465_5 then
					arg_462_1.talkMaxDuration = var_465_5

					if var_465_5 + var_465_1 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_5 + var_465_1
					end
				end

				arg_462_1.text_.text = var_465_3
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_6 = math.max(var_465_2, arg_462_1.talkMaxDuration)

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_6 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_1) / var_465_6

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_1 + var_465_6 and arg_462_1.time_ < var_465_1 + var_465_6 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play1108408113 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1108408113
		arg_466_1.duration_ = 3

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1108408114(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1084ui_story"]) and arg_466_1.var_.characterEffect1084ui_story == nil then
				arg_466_1.var_.characterEffect1084ui_story = arg_466_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1084ui_story"]) then
				if arg_466_1.var_.characterEffect1084ui_story and not isNil(arg_466_1.actors_["1084ui_story"]) then
					arg_466_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1084ui_story"]) and arg_466_1.var_.characterEffect1084ui_story then
				arg_466_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_469_2 = 0
			local var_469_3 = 0.55

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_2 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_4 = arg_466_1:GetWordFromCfg(1108408113)
				local var_469_5 = arg_466_1:FormatText(var_469_4.content)

				arg_466_1.text_.text = var_469_5

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_7 = 22 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_5) / 22)

				if (22 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_5) / 22)) > 0 and var_469_3 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_2
					end
				end

				arg_466_1.text_.text = var_469_5
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408113", "story_v_side_new_1108408.awb") ~= 0 then
					local var_469_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408113", "story_v_side_new_1108408.awb") / 1000

					if var_469_8 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_2
					end

					if var_469_4.prefab_name ~= "" and arg_466_1.actors_[var_469_4.prefab_name] ~= nil then
						local var_469_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_4.prefab_name].transform, "story_v_side_new_1108408", "1108408113", "story_v_side_new_1108408.awb")

						arg_466_1:RecordAudio("1108408113", var_469_9)
						arg_466_1:RecordAudio("1108408113", var_469_9)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408113", "story_v_side_new_1108408.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408113", "story_v_side_new_1108408.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_10 = math.max(var_469_3, arg_466_1.talkMaxDuration)

			if var_469_2 <= arg_466_1.time_ and arg_466_1.time_ < var_469_2 + var_469_10 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_2) / var_469_10

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_2 + var_469_10 and arg_466_1.time_ < var_469_2 + var_469_10 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1108408114 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1108408114
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1108408115(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1084ui_story = arg_470_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1084ui_story"].transform.position).z)
				arg_470_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1084ui_story"].transform.localEulerAngles = arg_470_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_470_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1084ui_story"].transform.position).z)
				arg_470_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1084ui_story"].transform.localEulerAngles = arg_470_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_473_1 = arg_470_1.actors_["1084ui_story"]

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect1084ui_story == nil then
				arg_470_1.var_.characterEffect1084ui_story = var_473_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_2 and not isNil(var_473_1) then
				if arg_470_1.var_.characterEffect1084ui_story and not isNil(var_473_1) then
					arg_470_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_470_1.time_ - 0) / var_473_2)
				end
			end

			if arg_470_1.time_ >= 0 + var_473_2 and arg_470_1.time_ < 0 + var_473_2 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect1084ui_story then
				arg_470_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_473_3 = 0
			local var_473_4 = 0.825

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_3 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_5 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(1108408114).content)

				arg_470_1.text_.text = var_473_5

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_7 = 33 <= 0 and var_473_4 or var_473_4 * (utf8.len(var_473_5) / 33)

				if (33 <= 0 and var_473_4 or var_473_4 * (utf8.len(var_473_5) / 33)) > 0 and var_473_4 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_3 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_3
					end
				end

				arg_470_1.text_.text = var_473_5
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_8 = math.max(var_473_4, arg_470_1.talkMaxDuration)

			if var_473_3 <= arg_470_1.time_ and arg_470_1.time_ < var_473_3 + var_473_8 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_3) / var_473_8

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_3 + var_473_8 and arg_470_1.time_ < var_473_3 + var_473_8 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play1108408115 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1108408115
		arg_474_1.duration_ = 3.7

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1108408116(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if arg_474_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_477_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_474_1.stage_.transform)

				var_477_0.name = "1047ui_story"
				var_477_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_474_1.actors_["1047ui_story"] = var_477_0

				local var_477_1 = var_477_0:GetComponentInChildren(typeof(CharacterEffect))

				var_477_1.enabled = true

				local var_477_2 = GameObjectTools.GetOrAddComponent(var_477_0, typeof(DynamicBoneHelper))

				if var_477_2 then
					var_477_2:EnableDynamicBone(false)
				end

				arg_474_1:ShowWeapon(var_477_1.transform, false)

				arg_474_1.var_["1047ui_story" .. "Animator"] = var_477_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_474_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_474_1.var_["1047ui_story" .. "LipSync"] = var_477_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_477_3 = arg_474_1.actors_["1047ui_story"].transform

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1047ui_story = var_477_3.localPosition
			end

			local var_477_4 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_4 then
				var_477_3.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_474_1.time_ - 0) / var_477_4)
				var_477_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_477_3.position).x, (manager.ui.mainCamera.transform.position - var_477_3.position).y, (manager.ui.mainCamera.transform.position - var_477_3.position).z)
				var_477_3.localEulerAngles.z = 0
				var_477_3.localEulerAngles.x = 0
				var_477_3.localEulerAngles = var_477_3.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_4 and arg_474_1.time_ < 0 + var_477_4 + arg_477_0 then
				var_477_3.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_477_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_477_3.position).x, (manager.ui.mainCamera.transform.position - var_477_3.position).y, (manager.ui.mainCamera.transform.position - var_477_3.position).z)
				var_477_3.localEulerAngles.z = 0
				var_477_3.localEulerAngles.x = 0
				var_477_3.localEulerAngles = var_477_3.localEulerAngles
			end

			local var_477_5 = arg_474_1.actors_["1047ui_story"]

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(var_477_5) and arg_474_1.var_.characterEffect1047ui_story == nil then
				arg_474_1.var_.characterEffect1047ui_story = var_477_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_6 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_6 and not isNil(var_477_5) then
				if arg_474_1.var_.characterEffect1047ui_story and not isNil(var_477_5) then
					arg_474_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= 0 + var_477_6 and arg_474_1.time_ < 0 + var_477_6 + arg_477_0 and not isNil(var_477_5) and arg_474_1.var_.characterEffect1047ui_story then
				arg_474_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_477_8 = 0
			local var_477_9 = 0.4

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_8 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_10 = arg_474_1:GetWordFromCfg(1108408115)
				local var_477_11 = arg_474_1:FormatText(var_477_10.content)

				arg_474_1.text_.text = var_477_11

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_13 = 16 <= 0 and var_477_9 or var_477_9 * (utf8.len(var_477_11) / 16)

				if (16 <= 0 and var_477_9 or var_477_9 * (utf8.len(var_477_11) / 16)) > 0 and var_477_9 < var_477_13 then
					arg_474_1.talkMaxDuration = var_477_13

					if var_477_13 + var_477_8 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_13 + var_477_8
					end
				end

				arg_474_1.text_.text = var_477_11
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408115", "story_v_side_new_1108408.awb") ~= 0 then
					local var_477_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408115", "story_v_side_new_1108408.awb") / 1000

					if var_477_14 + var_477_8 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_14 + var_477_8
					end

					if var_477_10.prefab_name ~= "" and arg_474_1.actors_[var_477_10.prefab_name] ~= nil then
						local var_477_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_10.prefab_name].transform, "story_v_side_new_1108408", "1108408115", "story_v_side_new_1108408.awb")

						arg_474_1:RecordAudio("1108408115", var_477_15)
						arg_474_1:RecordAudio("1108408115", var_477_15)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408115", "story_v_side_new_1108408.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408115", "story_v_side_new_1108408.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_16 = math.max(var_477_9, arg_474_1.talkMaxDuration)

			if var_477_8 <= arg_474_1.time_ and arg_474_1.time_ < var_477_8 + var_477_16 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_8) / var_477_16

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_8 + var_477_16 and arg_474_1.time_ < var_477_8 + var_477_16 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1108408116 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1108408116
		arg_478_1.duration_ = 4.4

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1108408117(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos1084ui_story = arg_478_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_481_0 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 then
				arg_478_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_478_1.time_ - 0) / var_481_0)
				arg_478_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_478_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1084ui_story"].transform.position).z)
				arg_478_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_478_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_478_1.actors_["1084ui_story"].transform.localEulerAngles = arg_478_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 then
				arg_478_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_478_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_478_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_478_1.actors_["1084ui_story"].transform.position).z)
				arg_478_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_478_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_478_1.actors_["1084ui_story"].transform.localEulerAngles = arg_478_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_481_1 = arg_478_1.actors_["1084ui_story"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_1) and arg_478_1.var_.characterEffect1084ui_story == nil then
				arg_478_1.var_.characterEffect1084ui_story = var_481_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_2 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_2 and not isNil(var_481_1) then
				if arg_478_1.var_.characterEffect1084ui_story and not isNil(var_481_1) then
					arg_478_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= 0 + var_481_2 and arg_478_1.time_ < 0 + var_481_2 + arg_481_0 and not isNil(var_481_1) and arg_478_1.var_.characterEffect1084ui_story then
				arg_478_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_481_4 = arg_478_1.actors_["1047ui_story"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_4) and arg_478_1.var_.characterEffect1047ui_story == nil then
				arg_478_1.var_.characterEffect1047ui_story = var_481_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_5 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_5 and not isNil(var_481_4) then
				if arg_478_1.var_.characterEffect1047ui_story and not isNil(var_481_4) then
					arg_478_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_478_1.time_ - 0) / var_481_5)
				end
			end

			if arg_478_1.time_ >= 0 + var_481_5 and arg_478_1.time_ < 0 + var_481_5 + arg_481_0 and not isNil(var_481_4) and arg_478_1.var_.characterEffect1047ui_story then
				arg_478_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_481_6 = 0
			local var_481_7 = 0.65

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_6 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_8 = arg_478_1:GetWordFromCfg(1108408116)
				local var_481_9 = arg_478_1:FormatText(var_481_8.content)

				arg_478_1.text_.text = var_481_9

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_11 = 26 <= 0 and var_481_7 or var_481_7 * (utf8.len(var_481_9) / 26)

				if (26 <= 0 and var_481_7 or var_481_7 * (utf8.len(var_481_9) / 26)) > 0 and var_481_7 < var_481_11 then
					arg_478_1.talkMaxDuration = var_481_11

					if var_481_11 + var_481_6 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_11 + var_481_6
					end
				end

				arg_478_1.text_.text = var_481_9
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408116", "story_v_side_new_1108408.awb") ~= 0 then
					local var_481_12 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408116", "story_v_side_new_1108408.awb") / 1000

					if var_481_12 + var_481_6 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_12 + var_481_6
					end

					if var_481_8.prefab_name ~= "" and arg_478_1.actors_[var_481_8.prefab_name] ~= nil then
						local var_481_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_8.prefab_name].transform, "story_v_side_new_1108408", "1108408116", "story_v_side_new_1108408.awb")

						arg_478_1:RecordAudio("1108408116", var_481_13)
						arg_478_1:RecordAudio("1108408116", var_481_13)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408116", "story_v_side_new_1108408.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408116", "story_v_side_new_1108408.awb")
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
				actorName = "1084ui_story",
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
	Play1108408117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1108408117
		arg_482_1.duration_ = 15.9

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1108408118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.var_.moveOldPos1047ui_story = arg_482_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_485_0 = 0.001

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 then
				arg_482_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_482_1.time_ - 0) / var_485_0)
				arg_482_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_482_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["1047ui_story"].transform.position).z)
				arg_482_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_482_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_482_1.actors_["1047ui_story"].transform.localEulerAngles = arg_482_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 then
				arg_482_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_482_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_482_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["1047ui_story"].transform.position).z)
				arg_482_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_482_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_482_1.actors_["1047ui_story"].transform.localEulerAngles = arg_482_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_485_1 = arg_482_1.actors_["1047ui_story"]

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(var_485_1) and arg_482_1.var_.characterEffect1047ui_story == nil then
				arg_482_1.var_.characterEffect1047ui_story = var_485_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_2 and not isNil(var_485_1) then
				if arg_482_1.var_.characterEffect1047ui_story and not isNil(var_485_1) then
					arg_482_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= 0 + var_485_2 and arg_482_1.time_ < 0 + var_485_2 + arg_485_0 and not isNil(var_485_1) and arg_482_1.var_.characterEffect1047ui_story then
				arg_482_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_485_4 = arg_482_1.actors_["1084ui_story"]

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(var_485_4) and arg_482_1.var_.characterEffect1084ui_story == nil then
				arg_482_1.var_.characterEffect1084ui_story = var_485_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_5 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_5 and not isNil(var_485_4) then
				if arg_482_1.var_.characterEffect1084ui_story and not isNil(var_485_4) then
					arg_482_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_482_1.time_ - 0) / var_485_5)
				end
			end

			if arg_482_1.time_ >= 0 + var_485_5 and arg_482_1.time_ < 0 + var_485_5 + arg_485_0 and not isNil(var_485_4) and arg_482_1.var_.characterEffect1084ui_story then
				arg_482_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_485_6 = 0
			local var_485_7 = 1.5

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_6 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_8 = arg_482_1:GetWordFromCfg(1108408117)
				local var_485_9 = arg_482_1:FormatText(var_485_8.content)

				arg_482_1.text_.text = var_485_9

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_11 = 60 <= 0 and var_485_7 or var_485_7 * (utf8.len(var_485_9) / 60)

				if (60 <= 0 and var_485_7 or var_485_7 * (utf8.len(var_485_9) / 60)) > 0 and var_485_7 < var_485_11 then
					arg_482_1.talkMaxDuration = var_485_11

					if var_485_11 + var_485_6 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_11 + var_485_6
					end
				end

				arg_482_1.text_.text = var_485_9
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408117", "story_v_side_new_1108408.awb") ~= 0 then
					local var_485_12 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408117", "story_v_side_new_1108408.awb") / 1000

					if var_485_12 + var_485_6 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_12 + var_485_6
					end

					if var_485_8.prefab_name ~= "" and arg_482_1.actors_[var_485_8.prefab_name] ~= nil then
						local var_485_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_8.prefab_name].transform, "story_v_side_new_1108408", "1108408117", "story_v_side_new_1108408.awb")

						arg_482_1:RecordAudio("1108408117", var_485_13)
						arg_482_1:RecordAudio("1108408117", var_485_13)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408117", "story_v_side_new_1108408.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408117", "story_v_side_new_1108408.awb")
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
				actorName = "1047ui_story",
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
	Play1108408118 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1108408118
		arg_486_1.duration_ = 7.8

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1108408119(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.moveOldPos1084ui_story = arg_486_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_489_0 = 0.001

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 then
				arg_486_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_486_1.time_ - 0) / var_489_0)
				arg_486_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1084ui_story"].transform.position).z)
				arg_486_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["1084ui_story"].transform.localEulerAngles = arg_486_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 then
				arg_486_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_486_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1084ui_story"].transform.position).z)
				arg_486_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["1084ui_story"].transform.localEulerAngles = arg_486_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_489_1 = arg_486_1.actors_["1084ui_story"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_1) and arg_486_1.var_.characterEffect1084ui_story == nil then
				arg_486_1.var_.characterEffect1084ui_story = var_489_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_2 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_2 and not isNil(var_489_1) then
				if arg_486_1.var_.characterEffect1084ui_story and not isNil(var_489_1) then
					arg_486_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= 0 + var_489_2 and arg_486_1.time_ < 0 + var_489_2 + arg_489_0 and not isNil(var_489_1) and arg_486_1.var_.characterEffect1084ui_story then
				arg_486_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_489_4 = arg_486_1.actors_["1047ui_story"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_4) and arg_486_1.var_.characterEffect1047ui_story == nil then
				arg_486_1.var_.characterEffect1047ui_story = var_489_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_5 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_5 and not isNil(var_489_4) then
				if arg_486_1.var_.characterEffect1047ui_story and not isNil(var_489_4) then
					arg_486_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_486_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_486_1.time_ - 0) / var_489_5)
				end
			end

			if arg_486_1.time_ >= 0 + var_489_5 and arg_486_1.time_ < 0 + var_489_5 + arg_489_0 and not isNil(var_489_4) and arg_486_1.var_.characterEffect1047ui_story then
				arg_486_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_486_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_489_6 = 0
			local var_489_7 = 1.15

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_6 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_8 = arg_486_1:GetWordFromCfg(1108408118)
				local var_489_9 = arg_486_1:FormatText(var_489_8.content)

				arg_486_1.text_.text = var_489_9

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_11 = 46 <= 0 and var_489_7 or var_489_7 * (utf8.len(var_489_9) / 46)

				if (46 <= 0 and var_489_7 or var_489_7 * (utf8.len(var_489_9) / 46)) > 0 and var_489_7 < var_489_11 then
					arg_486_1.talkMaxDuration = var_489_11

					if var_489_11 + var_489_6 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_11 + var_489_6
					end
				end

				arg_486_1.text_.text = var_489_9
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408118", "story_v_side_new_1108408.awb") ~= 0 then
					local var_489_12 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408118", "story_v_side_new_1108408.awb") / 1000

					if var_489_12 + var_489_6 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_12 + var_489_6
					end

					if var_489_8.prefab_name ~= "" and arg_486_1.actors_[var_489_8.prefab_name] ~= nil then
						local var_489_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_8.prefab_name].transform, "story_v_side_new_1108408", "1108408118", "story_v_side_new_1108408.awb")

						arg_486_1:RecordAudio("1108408118", var_489_13)
						arg_486_1:RecordAudio("1108408118", var_489_13)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408118", "story_v_side_new_1108408.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408118", "story_v_side_new_1108408.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_14 = math.max(var_489_7, arg_486_1.talkMaxDuration)

			if var_489_6 <= arg_486_1.time_ and arg_486_1.time_ < var_489_6 + var_489_14 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_6) / var_489_14

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_6 + var_489_14 and arg_486_1.time_ < var_489_6 + var_489_14 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play1108408119 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1108408119
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1108408120(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["1084ui_story"]) and arg_490_1.var_.characterEffect1084ui_story == nil then
				arg_490_1.var_.characterEffect1084ui_story = arg_490_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_0 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["1084ui_story"]) then
				if arg_490_1.var_.characterEffect1084ui_story and not isNil(arg_490_1.actors_["1084ui_story"]) then
					arg_490_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_490_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_490_1.time_ - 0) / var_493_0)
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["1084ui_story"]) and arg_490_1.var_.characterEffect1084ui_story then
				arg_490_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_490_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_493_1 = 0
			local var_493_2 = 0.675

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_3 = arg_490_1:FormatText(arg_490_1:GetWordFromCfg(1108408119).content)

				arg_490_1.text_.text = var_493_3

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 27 <= 0 and var_493_2 or var_493_2 * (utf8.len(var_493_3) / 27)

				if (27 <= 0 and var_493_2 or var_493_2 * (utf8.len(var_493_3) / 27)) > 0 and var_493_2 < var_493_5 then
					arg_490_1.talkMaxDuration = var_493_5

					if var_493_5 + var_493_1 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + var_493_1
					end
				end

				arg_490_1.text_.text = var_493_3
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_6 = math.max(var_493_2, arg_490_1.talkMaxDuration)

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_6 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_1) / var_493_6

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_1 + var_493_6 and arg_490_1.time_ < var_493_1 + var_493_6 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1108408120 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1108408120
		arg_494_1.duration_ = 6.47

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1108408121(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.var_.moveOldPos1047ui_story = arg_494_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_497_0 = 0.001

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 then
				arg_494_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_494_1.time_ - 0) / var_497_0)
				arg_494_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_494_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1047ui_story"].transform.position).z)
				arg_494_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_494_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_494_1.actors_["1047ui_story"].transform.localEulerAngles = arg_494_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 then
				arg_494_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_494_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_494_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1047ui_story"].transform.position).z)
				arg_494_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_494_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_494_1.actors_["1047ui_story"].transform.localEulerAngles = arg_494_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_497_1 = arg_494_1.actors_["1047ui_story"]

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(var_497_1) and arg_494_1.var_.characterEffect1047ui_story == nil then
				arg_494_1.var_.characterEffect1047ui_story = var_497_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_2 and not isNil(var_497_1) then
				if arg_494_1.var_.characterEffect1047ui_story and not isNil(var_497_1) then
					arg_494_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= 0 + var_497_2 and arg_494_1.time_ < 0 + var_497_2 + arg_497_0 and not isNil(var_497_1) and arg_494_1.var_.characterEffect1047ui_story then
				arg_494_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_497_4 = 0
			local var_497_5 = 0.675

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_4 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_6 = arg_494_1:GetWordFromCfg(1108408120)
				local var_497_7 = arg_494_1:FormatText(var_497_6.content)

				arg_494_1.text_.text = var_497_7

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_9 = 27 <= 0 and var_497_5 or var_497_5 * (utf8.len(var_497_7) / 27)

				if (27 <= 0 and var_497_5 or var_497_5 * (utf8.len(var_497_7) / 27)) > 0 and var_497_5 < var_497_9 then
					arg_494_1.talkMaxDuration = var_497_9

					if var_497_9 + var_497_4 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_9 + var_497_4
					end
				end

				arg_494_1.text_.text = var_497_7
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408120", "story_v_side_new_1108408.awb") ~= 0 then
					local var_497_10 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408120", "story_v_side_new_1108408.awb") / 1000

					if var_497_10 + var_497_4 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_10 + var_497_4
					end

					if var_497_6.prefab_name ~= "" and arg_494_1.actors_[var_497_6.prefab_name] ~= nil then
						local var_497_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_6.prefab_name].transform, "story_v_side_new_1108408", "1108408120", "story_v_side_new_1108408.awb")

						arg_494_1:RecordAudio("1108408120", var_497_11)
						arg_494_1:RecordAudio("1108408120", var_497_11)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408120", "story_v_side_new_1108408.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408120", "story_v_side_new_1108408.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_12 = math.max(var_497_5, arg_494_1.talkMaxDuration)

			if var_497_4 <= arg_494_1.time_ and arg_494_1.time_ < var_497_4 + var_497_12 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_4) / var_497_12

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_4 + var_497_12 and arg_494_1.time_ < var_497_4 + var_497_12 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_494_1:InitPlayNodeList()
	end,
	Play1108408121 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1108408121
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1108408122(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.var_.moveOldPos1047ui_story = arg_498_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_501_0 = 0.001

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 then
				arg_498_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_498_1.time_ - 0) / var_501_0)
				arg_498_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).z)
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles = arg_498_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 then
				arg_498_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_498_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).z)
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles = arg_498_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_501_1 = arg_498_1.actors_["1084ui_story"].transform

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.var_.moveOldPos1084ui_story = var_501_1.localPosition
			end

			local var_501_2 = 0.001

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_2 then
				var_501_1.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_498_1.time_ - 0) / var_501_2)
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

			local var_501_3 = arg_498_1.actors_["1047ui_story"]

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(var_501_3) and arg_498_1.var_.characterEffect1047ui_story == nil then
				arg_498_1.var_.characterEffect1047ui_story = var_501_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_4 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_4 and not isNil(var_501_3) then
				if arg_498_1.var_.characterEffect1047ui_story and not isNil(var_501_3) then
					arg_498_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_498_1.time_ - 0) / var_501_4)
				end
			end

			if arg_498_1.time_ >= 0 + var_501_4 and arg_498_1.time_ < 0 + var_501_4 + arg_501_0 and not isNil(var_501_3) and arg_498_1.var_.characterEffect1047ui_story then
				arg_498_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_501_5 = 0
			local var_501_6 = 1.25

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_5 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_7 = arg_498_1:FormatText(arg_498_1:GetWordFromCfg(1108408121).content)

				arg_498_1.text_.text = var_501_7

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_9 = 50 <= 0 and var_501_6 or var_501_6 * (utf8.len(var_501_7) / 50)

				if (50 <= 0 and var_501_6 or var_501_6 * (utf8.len(var_501_7) / 50)) > 0 and var_501_6 < var_501_9 then
					arg_498_1.talkMaxDuration = var_501_9

					if var_501_9 + var_501_5 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_9 + var_501_5
					end
				end

				arg_498_1.text_.text = var_501_7
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_10 = math.max(var_501_6, arg_498_1.talkMaxDuration)

			if var_501_5 <= arg_498_1.time_ and arg_498_1.time_ < var_501_5 + var_501_10 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_5) / var_501_10

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_5 + var_501_10 and arg_498_1.time_ < var_501_5 + var_501_10 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play1108408122 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1108408122
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
			arg_502_1.auto_ = false
		end

		function arg_502_1.playNext_(arg_504_0)
			arg_502_1.onStoryFinished_()
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_505_1 = 0
			local var_505_2 = 1.025

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_3 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(1108408122).content)

				arg_502_1.text_.text = var_505_3

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 41 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_3) / 41)

				if (41 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_3) / 41)) > 0 and var_505_2 < var_505_5 then
					arg_502_1.talkMaxDuration = var_505_5

					if var_505_5 + var_505_1 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_5 + var_505_1
					end
				end

				arg_502_1.text_.text = var_505_3
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_6 = math.max(var_505_2, arg_502_1.talkMaxDuration)

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_6 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_1) / var_505_6

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_1 + var_505_6 and arg_502_1.time_ < var_505_1 + var_505_6 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02",
		"TextureConfig/Background/R8405",
		"TextureConfig/Background/H02a",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_side_new_1108408.awb"
	}
}
