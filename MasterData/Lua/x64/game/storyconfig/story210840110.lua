return {
	Play1108410001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108410001
		arg_1_1.duration_ = 9.57

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108410002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST17 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST17")
				var_4_0.name = "ST17"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST17 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST17

				arg_1_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST17" then
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

			local var_4_9 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1084ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.97, -6)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1084ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = 1.999999999999
			local var_4_23 = 0.775

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(1108410001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 31 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 31)

				if (31 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 31)) > 0 and var_4_23 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_22 = var_4_22 + 0.3

					if var_4_28 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410001", "story_v_side_new_1108410.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410001", "story_v_side_new_1108410.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_side_new_1108410", "1108410001", "story_v_side_new_1108410.awb")

						arg_1_1:RecordAudio("1108410001", var_4_30)
						arg_1_1:RecordAudio("1108410001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410001", "story_v_side_new_1108410.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410001", "story_v_side_new_1108410.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1108410002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1108410002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1108410003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = arg_8_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_11_0 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 then
				arg_8_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_0)
				arg_8_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).z)
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles = arg_8_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 then
				arg_8_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).z)
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles = arg_8_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_11_1 = arg_8_1.actors_["1084ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_1) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_2 and not isNil(var_11_1) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_1) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_2)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_2 and arg_8_1.time_ < 0 + var_11_2 + arg_11_0 and not isNil(var_11_1) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_11_3 = 0
			local var_11_4 = 1.6

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_3 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_5 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1108410002).content)

				arg_8_1.text_.text = var_11_5

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_7 = 64 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_5) / 64)

				if (64 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_5) / 64)) > 0 and var_11_4 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_3 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_3
					end
				end

				arg_8_1.text_.text = var_11_5
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_4, arg_8_1.talkMaxDuration)

			if var_11_3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_3 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_3) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_3 + var_11_8 and arg_8_1.time_ < var_11_3 + var_11_8 + arg_11_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play1108410003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1108410003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1108410004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.8

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
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

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(1108410003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 32 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 32)

				if (32 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 32)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1108410004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1108410004
		arg_16_1.duration_ = 3.77

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1108410005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = arg_16_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1084ui_story"].transform.position).z)
				arg_16_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1084ui_story"].transform.localEulerAngles = arg_16_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
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
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_4 = 0
			local var_19_5 = 0.35

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_6 = arg_16_1:GetWordFromCfg(1108410004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 14 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 14)

				if (14 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 14)) > 0 and var_19_5 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410004", "story_v_side_new_1108410.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410004", "story_v_side_new_1108410.awb") / 1000

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end

					if var_19_6.prefab_name ~= "" and arg_16_1.actors_[var_19_6.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_6.prefab_name].transform, "story_v_side_new_1108410", "1108410004", "story_v_side_new_1108410.awb")

						arg_16_1:RecordAudio("1108410004", var_19_11)
						arg_16_1:RecordAudio("1108410004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410004", "story_v_side_new_1108410.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410004", "story_v_side_new_1108410.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_12 and arg_16_1.time_ < var_19_4 + var_19_12 + arg_19_0 then
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
	Play1108410005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1108410005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1108410006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1084ui_story"]) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = arg_20_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1084ui_story"]) then
				if arg_20_1.var_.characterEffect1084ui_story and not isNil(arg_20_1.actors_["1084ui_story"]) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1084ui_story"]) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 1.25

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
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

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(1108410005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 50 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 50)

				if (50 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 50)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1108410006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1108410006
		arg_24_1.duration_ = 5.73

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1108410007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = arg_24_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) then
				if arg_24_1.var_.characterEffect1084ui_story and not isNil(arg_24_1.actors_["1084ui_story"]) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_2 = 0
			local var_27_3 = 0.775

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(1108410006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 31 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 31)

				if (31 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 31)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410006", "story_v_side_new_1108410.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410006", "story_v_side_new_1108410.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_side_new_1108410", "1108410006", "story_v_side_new_1108410.awb")

						arg_24_1:RecordAudio("1108410006", var_27_9)
						arg_24_1:RecordAudio("1108410006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410006", "story_v_side_new_1108410.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410006", "story_v_side_new_1108410.awb")
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
	Play1108410007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1108410007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1108410008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = arg_28_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).z)
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles = arg_28_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
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
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_2)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_31_3 = 0
			local var_31_4 = 1.575

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

				local var_31_5 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(1108410007).content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 63 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 63)

				if (63 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 63)) > 0 and var_31_4 < var_31_7 then
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
	Play1108410008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1108410008
		arg_32_1.duration_ = 12.43

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1108410009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = arg_32_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).z)
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles = arg_32_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_32_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).z)
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles = arg_32_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_35_1 = arg_32_1.actors_["1084ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = var_35_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 and not isNil(var_35_1) then
				if arg_32_1.var_.characterEffect1084ui_story and not isNil(var_35_1) then
					arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1084ui_story then
				arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_35_4 = 0
			local var_35_5 = 1.175

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
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

				local var_35_6 = arg_32_1:GetWordFromCfg(1108410008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 47 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 47)

				if (47 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 47)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410008", "story_v_side_new_1108410.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410008", "story_v_side_new_1108410.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_side_new_1108410", "1108410008", "story_v_side_new_1108410.awb")

						arg_32_1:RecordAudio("1108410008", var_35_11)
						arg_32_1:RecordAudio("1108410008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410008", "story_v_side_new_1108410.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410008", "story_v_side_new_1108410.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play1108410009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1108410009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1108410010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = arg_36_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).z)
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles = arg_36_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).z)
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles = arg_36_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["1084ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 and not isNil(var_39_1) then
				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_1) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_2)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_39_3 = 0
			local var_39_4 = 1.1

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_3 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_5 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(1108410009).content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 44 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_5) / 44)

				if (44 <= 0 and var_39_4 or var_39_4 * (utf8.len(var_39_5) / 44)) > 0 and var_39_4 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_3 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_3
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_4, arg_36_1.talkMaxDuration)

			if var_39_3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_3 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_3) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_3 + var_39_8 and arg_36_1.time_ < var_39_3 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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

		arg_36_1:InitPlayNodeList()
	end,
	Play1108410010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1108410010
		arg_40_1.duration_ = 4.43

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1108410011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = arg_40_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_43_0 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				arg_40_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).z)
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles = arg_40_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				arg_40_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_40_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1084ui_story"].transform.position).z)
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1084ui_story"].transform.localEulerAngles = arg_40_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_43_1 = arg_40_1.actors_["1084ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_2 and not isNil(var_43_1) then
				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_1) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_2 and arg_40_1.time_ < 0 + var_43_2 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_4 = 0
			local var_43_5 = 0.7

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

				local var_43_6 = arg_40_1:GetWordFromCfg(1108410010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 28 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 28)

				if (28 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 28)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410010", "story_v_side_new_1108410.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410010", "story_v_side_new_1108410.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_side_new_1108410", "1108410010", "story_v_side_new_1108410.awb")

						arg_40_1:RecordAudio("1108410010", var_43_11)
						arg_40_1:RecordAudio("1108410010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410010", "story_v_side_new_1108410.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410010", "story_v_side_new_1108410.awb")
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
	Play1108410011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1108410011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1108410012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = arg_44_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(arg_44_1.actors_["1084ui_story"]) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 0.7

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(1108410011).content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 28 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 28)

				if (28 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 28)) > 0 and var_47_2 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_6 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_6 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_6

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_6 and arg_44_1.time_ < var_47_1 + var_47_6 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1108410012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1108410012
		arg_48_1.duration_ = 9.47

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1108410013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = arg_48_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(arg_48_1.actors_["1084ui_story"]) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_51_2 = 0
			local var_51_3 = 0.975

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
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

				local var_51_4 = arg_48_1:GetWordFromCfg(1108410012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 39 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 39)

				if (39 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 39)) > 0 and var_51_3 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410012", "story_v_side_new_1108410.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410012", "story_v_side_new_1108410.awb") / 1000

					if var_51_8 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_2
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_side_new_1108410", "1108410012", "story_v_side_new_1108410.awb")

						arg_48_1:RecordAudio("1108410012", var_51_9)
						arg_48_1:RecordAudio("1108410012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410012", "story_v_side_new_1108410.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410012", "story_v_side_new_1108410.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_3, arg_48_1.talkMaxDuration)

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_2) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_2 + var_51_10 and arg_48_1.time_ < var_51_2 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1108410013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1108410013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1108410014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = arg_52_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) then
				if arg_52_1.var_.characterEffect1084ui_story and not isNil(arg_52_1.actors_["1084ui_story"]) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.5

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(1108410013).content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 20 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 20)

				if (20 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 20)) > 0 and var_55_2 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_6 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_6 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_6

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_6 and arg_52_1.time_ < var_55_1 + var_55_6 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1108410014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1108410014
		arg_56_1.duration_ = 2

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1108410015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1084ui_story"]) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = arg_56_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1084ui_story"]) then
				if arg_56_1.var_.characterEffect1084ui_story and not isNil(arg_56_1.actors_["1084ui_story"]) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1084ui_story"]) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_2 = 0
			local var_59_3 = 0.125

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(1108410014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 5 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 5)

				if (5 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 5)) > 0 and var_59_3 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410014", "story_v_side_new_1108410.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410014", "story_v_side_new_1108410.awb") / 1000

					if var_59_8 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_2
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_side_new_1108410", "1108410014", "story_v_side_new_1108410.awb")

						arg_56_1:RecordAudio("1108410014", var_59_9)
						arg_56_1:RecordAudio("1108410014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410014", "story_v_side_new_1108410.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410014", "story_v_side_new_1108410.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_10 and arg_56_1.time_ < var_59_2 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1108410015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1108410015
		arg_60_1.duration_ = 7.57

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1108410016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_63_0 = 0
			local var_63_1 = 0.75

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
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

				local var_63_2 = arg_60_1:GetWordFromCfg(1108410015)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 30 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 30)

				if (30 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 30)) > 0 and var_63_1 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410015", "story_v_side_new_1108410.awb") ~= 0 then
					local var_63_6 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410015", "story_v_side_new_1108410.awb") / 1000

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end

					if var_63_2.prefab_name ~= "" and arg_60_1.actors_[var_63_2.prefab_name] ~= nil then
						local var_63_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_2.prefab_name].transform, "story_v_side_new_1108410", "1108410015", "story_v_side_new_1108410.awb")

						arg_60_1:RecordAudio("1108410015", var_63_7)
						arg_60_1:RecordAudio("1108410015", var_63_7)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410015", "story_v_side_new_1108410.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410015", "story_v_side_new_1108410.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1108410016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1108410016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1108410017(arg_64_1)
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
			local var_67_2 = 0.5

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

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(1108410016).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 20 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 20)

				if (20 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 20)) > 0 and var_67_2 < var_67_5 then
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
	Play1108410017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1108410017
		arg_68_1.duration_ = 5.9

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1108410018(arg_68_1)
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
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4127")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_71_2 = 0
			local var_71_3 = 0.575

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

				local var_71_4 = arg_68_1:GetWordFromCfg(1108410017)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 23 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 23)

				if (23 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 23)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410017", "story_v_side_new_1108410.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410017", "story_v_side_new_1108410.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_side_new_1108410", "1108410017", "story_v_side_new_1108410.awb")

						arg_68_1:RecordAudio("1108410017", var_71_9)
						arg_68_1:RecordAudio("1108410017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410017", "story_v_side_new_1108410.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410017", "story_v_side_new_1108410.awb")
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
	Play1108410018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1108410018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1108410019(arg_72_1)
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
			local var_75_2 = 0.7

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

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(1108410018).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 28 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 28)

				if (28 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 28)) > 0 and var_75_2 < var_75_5 then
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
	Play1108410019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1108410019
		arg_76_1.duration_ = 7.63

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1108410020(arg_76_1)
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
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_2 = 0
			local var_79_3 = 0.875

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

				local var_79_4 = arg_76_1:GetWordFromCfg(1108410019)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 35 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 35)

				if (35 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 35)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410019", "story_v_side_new_1108410.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410019", "story_v_side_new_1108410.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_side_new_1108410", "1108410019", "story_v_side_new_1108410.awb")

						arg_76_1:RecordAudio("1108410019", var_79_9)
						arg_76_1:RecordAudio("1108410019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410019", "story_v_side_new_1108410.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410019", "story_v_side_new_1108410.awb")
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
	Play1108410020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1108410020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1108410021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = arg_80_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) then
				if arg_80_1.var_.characterEffect1084ui_story and not isNil(arg_80_1.actors_["1084ui_story"]) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.225

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(1108410020).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 9 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 9)

				if (9 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 9)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1108410021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1108410021
		arg_84_1.duration_ = 7

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1108410022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_9000

			if arg_84_1.bgs_.F02a_1 == nil then
				local var_87_0 = Object.Instantiate(arg_84_1.paintGo_)

				var_87_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F02a_1")
				var_87_0.name = "F02a_1"
				var_87_0.transform.parent = arg_84_1.stage_.transform
				var_87_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.bgs_.F02a_1 = var_87_0
			end

			if 0.866666666666667 < arg_84_1.time_ and arg_84_1.time_ <= 0.866666666666667 + arg_87_0 then
				local var_87_1 = arg_84_1.bgs_.F02a_1

				arg_84_1.bgs_.F02a_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_87_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_2 = var_87_1:GetComponent("SpriteRenderer")

				if var_87_2 and var_87_2.sprite then
					local var_87_3 = 2 * (var_87_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_87_1.transform.localScale = Vector3.New(var_87_3 / var_87_2.sprite.bounds.size.y < var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x and var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x or var_87_3 / var_87_2.sprite.bounds.size.y, var_87_3 / var_87_2.sprite.bounds.size.y < var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x and var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x or var_87_3 / var_87_2.sprite.bounds.size.y, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "F02a_1" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_4 = 2

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.allBtn_.enabled = false
			end

			if arg_84_1.time_ >= var_87_4 + 0.3 and arg_84_1.time_ < var_87_4 + 0.3 + arg_87_0 then
				arg_84_1.allBtn_.enabled = true
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				local var_87_5 = arg_84_1.var_.effectjinrufuzhuangdian

				if not arg_84_1.var_.effectjinrufuzhuangdian then
					var_87_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_87_5.name = "jinrufuzhuangdian"
					arg_84_1.var_.effectjinrufuzhuangdian = var_87_5
				else
					var_87_5.transform:SetParent(var_87_9000)
				end

				var_87_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_87_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_87_5.transform.localScale = Vector3.New(var_87_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_87_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_87_5.transform.localScale.z)
			end

			if 2.3 < arg_84_1.time_ and arg_84_1.time_ <= 2.3 + arg_87_0 then
				if arg_84_1.var_.effectjinrufuzhuangdian then
					Object.Destroy(arg_84_1.var_.effectjinrufuzhuangdian)

					arg_84_1.var_.effectjinrufuzhuangdian = nil
				end
			end

			local var_87_8 = arg_84_1.actors_["1084ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_8.localPosition
			end

			local var_87_9 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_9 then
				var_87_8.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_9)
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

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_10 = 2
			local var_87_11 = 1.4

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_12 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_12:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_13 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(1108410021).content)

				arg_84_1.text_.text = var_87_13

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_15 = 56 <= 0 and var_87_11 or var_87_11 * (utf8.len(var_87_13) / 56)

				if (56 <= 0 and var_87_11 or var_87_11 * (utf8.len(var_87_13) / 56)) > 0 and var_87_11 < var_87_15 then
					arg_84_1.talkMaxDuration = var_87_15
					var_87_10 = var_87_10 + 0.3

					if var_87_15 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_15 + var_87_10
					end
				end

				arg_84_1.text_.text = var_87_13
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = var_87_10 + 0.3
			local var_87_17 = math.max(var_87_11, arg_84_1.talkMaxDuration)

			if var_87_10 + 0.3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_16 + var_87_17 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_16) / var_87_17

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_16 + var_87_17 and arg_84_1.time_ < var_87_16 + var_87_17 + arg_87_0 then
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
	Play1108410022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1108410022
		arg_90_1.duration_ = 9.5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play1108410023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1084ui_story = arg_90_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_93_0 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 then
				arg_90_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_90_1.time_ - 0) / var_93_0)
				arg_90_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).z)
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles = arg_90_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 then
				arg_90_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_90_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).z)
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles = arg_90_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_93_1 = arg_90_1.actors_["1084ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect1084ui_story == nil then
				arg_90_1.var_.characterEffect1084ui_story = var_93_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_2 and not isNil(var_93_1) then
				if arg_90_1.var_.characterEffect1084ui_story and not isNil(var_93_1) then
					arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_2 and arg_90_1.time_ < 0 + var_93_2 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect1084ui_story then
				arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_93_4 = 0
			local var_93_5 = 0.8

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(1108410022)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 30 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 30)

				if (30 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 30)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410022", "story_v_side_new_1108410.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410022", "story_v_side_new_1108410.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_side_new_1108410", "1108410022", "story_v_side_new_1108410.awb")

						arg_90_1:RecordAudio("1108410022", var_93_11)
						arg_90_1:RecordAudio("1108410022", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410022", "story_v_side_new_1108410.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410022", "story_v_side_new_1108410.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play1108410023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1108410023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1108410024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1084ui_story"]) and arg_94_1.var_.characterEffect1084ui_story == nil then
				arg_94_1.var_.characterEffect1084ui_story = arg_94_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1084ui_story"]) then
				if arg_94_1.var_.characterEffect1084ui_story and not isNil(arg_94_1.actors_["1084ui_story"]) then
					arg_94_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_0)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1084ui_story"]) and arg_94_1.var_.characterEffect1084ui_story then
				arg_94_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_97_1 = 0
			local var_97_2 = 0.775

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(1108410023).content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 31 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_3) / 31)

				if (31 <= 0 and var_97_2 or var_97_2 * (utf8.len(var_97_3) / 31)) > 0 and var_97_2 < var_97_5 then
					arg_94_1.talkMaxDuration = var_97_5

					if var_97_5 + var_97_1 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + var_97_1
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_6 = math.max(var_97_2, arg_94_1.talkMaxDuration)

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_6 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_1) / var_97_6

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_1 + var_97_6 and arg_94_1.time_ < var_97_1 + var_97_6 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play1108410024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1108410024
		arg_98_1.duration_ = 12.9

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1108410025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1084ui_story"]) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = arg_98_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1084ui_story"]) then
				if arg_98_1.var_.characterEffect1084ui_story and not isNil(arg_98_1.actors_["1084ui_story"]) then
					arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1084ui_story"]) and arg_98_1.var_.characterEffect1084ui_story then
				arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_101_2 = 0
			local var_101_3 = 1.35

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_4 = arg_98_1:GetWordFromCfg(1108410024)
				local var_101_5 = arg_98_1:FormatText(var_101_4.content)

				arg_98_1.text_.text = var_101_5

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 54 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 54)

				if (54 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 54)) > 0 and var_101_3 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_5
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410024", "story_v_side_new_1108410.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410024", "story_v_side_new_1108410.awb") / 1000

					if var_101_8 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_2
					end

					if var_101_4.prefab_name ~= "" and arg_98_1.actors_[var_101_4.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_4.prefab_name].transform, "story_v_side_new_1108410", "1108410024", "story_v_side_new_1108410.awb")

						arg_98_1:RecordAudio("1108410024", var_101_9)
						arg_98_1:RecordAudio("1108410024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410024", "story_v_side_new_1108410.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410024", "story_v_side_new_1108410.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_3, arg_98_1.talkMaxDuration)

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_2) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_2 + var_101_10 and arg_98_1.time_ < var_101_2 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play1108410025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1108410025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play1108410026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1084ui_story"]) and arg_102_1.var_.characterEffect1084ui_story == nil then
				arg_102_1.var_.characterEffect1084ui_story = arg_102_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1084ui_story"]) then
				if arg_102_1.var_.characterEffect1084ui_story and not isNil(arg_102_1.actors_["1084ui_story"]) then
					arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1084ui_story"]) and arg_102_1.var_.characterEffect1084ui_story then
				arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_105_1 = 0
			local var_105_2 = 0.4

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(1108410025).content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 16 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 16)

				if (16 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 16)) > 0 and var_105_2 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_1
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_6 = math.max(var_105_2, arg_102_1.talkMaxDuration)

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_6 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_1) / var_105_6

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_1 + var_105_6 and arg_102_1.time_ < var_105_1 + var_105_6 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play1108410026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1108410026
		arg_106_1.duration_ = 7.27

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1108410027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1084ui_story"]) and arg_106_1.var_.characterEffect1084ui_story == nil then
				arg_106_1.var_.characterEffect1084ui_story = arg_106_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1084ui_story"]) then
				if arg_106_1.var_.characterEffect1084ui_story and not isNil(arg_106_1.actors_["1084ui_story"]) then
					arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1084ui_story"]) and arg_106_1.var_.characterEffect1084ui_story then
				arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_2 = 0
			local var_109_3 = 0.75

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(1108410026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 30 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 30)

				if (30 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 30)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410026", "story_v_side_new_1108410.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410026", "story_v_side_new_1108410.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_side_new_1108410", "1108410026", "story_v_side_new_1108410.awb")

						arg_106_1:RecordAudio("1108410026", var_109_9)
						arg_106_1:RecordAudio("1108410026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410026", "story_v_side_new_1108410.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410026", "story_v_side_new_1108410.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_3, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_2) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_10 and arg_106_1.time_ < var_109_2 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play1108410027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1108410027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1108410028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1084ui_story"]) and arg_110_1.var_.characterEffect1084ui_story == nil then
				arg_110_1.var_.characterEffect1084ui_story = arg_110_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1084ui_story"]) then
				if arg_110_1.var_.characterEffect1084ui_story and not isNil(arg_110_1.actors_["1084ui_story"]) then
					arg_110_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1084ui_story"]) and arg_110_1.var_.characterEffect1084ui_story then
				arg_110_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_113_1 = 0
			local var_113_2 = 0.9

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(1108410027).content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 36 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 36)

				if (36 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 36)) > 0 and var_113_2 < var_113_5 then
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
	Play1108410028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1108410028
		arg_114_1.duration_ = 1

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"

			SetActive(arg_114_1.choicesGo_, true)

			for iter_115_0, iter_115_1 in ipairs(arg_114_1.choices_) do
				SetActive(iter_115_1.go, iter_115_0 <= 2)
			end

			arg_114_1.choices_[1].txt.text = arg_114_1:FormatText(StoryChoiceCfg[1699].name)
			arg_114_1.choices_[2].txt.text = arg_114_1:FormatText(StoryChoiceCfg[1700].name)
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1108410029(arg_114_1)
			end

			if arg_116_0 == 2 then
				arg_114_0:Play1108410029(arg_114_1)
			end

			arg_114_1:RecordChoiceLog(1108410028, 1699, 1700)
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1084ui_story = arg_114_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_117_0 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 then
				arg_114_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_114_1.time_ - 0) / var_117_0)
				arg_114_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1084ui_story"].transform.position).z)
				arg_114_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1084ui_story"].transform.localEulerAngles = arg_114_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 then
				arg_114_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_114_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1084ui_story"].transform.position).z)
				arg_114_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1084ui_story"].transform.localEulerAngles = arg_114_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_117_1 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			if arg_114_1.time_ >= var_117_1 + 0.633333333333333 and arg_114_1.time_ < var_117_1 + 0.633333333333333 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play1108410029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1108410029
		arg_118_1.duration_ = 9

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1108410030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 2 < arg_118_1.time_ and arg_118_1.time_ <= 2 + arg_121_0 then
				local var_121_0 = arg_118_1.bgs_.ST17

				arg_118_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_121_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_1 = var_121_0:GetComponent("SpriteRenderer")

				if var_121_1 and var_121_1.sprite then
					local var_121_2 = 2 * (var_121_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_121_0.transform.localScale = Vector3.New(var_121_2 / var_121_1.sprite.bounds.size.y < var_121_2 * manager.ui.mainCameraCom_.aspect / var_121_1.sprite.bounds.size.x and var_121_2 * manager.ui.mainCameraCom_.aspect / var_121_1.sprite.bounds.size.x or var_121_2 / var_121_1.sprite.bounds.size.y, var_121_2 / var_121_1.sprite.bounds.size.y < var_121_2 * manager.ui.mainCameraCom_.aspect / var_121_1.sprite.bounds.size.x and var_121_2 * manager.ui.mainCameraCom_.aspect / var_121_1.sprite.bounds.size.x or var_121_2 / var_121_1.sprite.bounds.size.y, 0)
				end

				for iter_121_0, iter_121_1 in pairs(arg_118_1.bgs_) do
					if iter_121_0 ~= "ST17" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_3 = 4

			if 4 < arg_118_1.time_ and arg_118_1.time_ <= var_121_3 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			if arg_118_1.time_ >= var_121_3 + 0.3 and arg_118_1.time_ < var_121_3 + 0.3 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			local var_121_4 = 0

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_5 = 2

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_5 then
				local var_121_6 = Color.New(0, 0, 0)

				var_121_6.a = Mathf.Lerp(0, 1, (arg_118_1.time_ - var_121_4) / var_121_5)
				arg_118_1.mask_.color = var_121_6
			end

			if arg_118_1.time_ >= var_121_4 + var_121_5 and arg_118_1.time_ < var_121_4 + var_121_5 + arg_121_0 then
				local var_121_7 = Color.New(0, 0, 0)

				var_121_7.a = 1
				arg_118_1.mask_.color = var_121_7
			end

			local var_121_8 = 2

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_9 = 2

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_9 then
				local var_121_10 = Color.New(0, 0, 0)

				var_121_10.a = Mathf.Lerp(1, 0, (arg_118_1.time_ - var_121_8) / var_121_9)
				arg_118_1.mask_.color = var_121_10
			end

			if arg_118_1.time_ >= var_121_8 + var_121_9 and arg_118_1.time_ < var_121_8 + var_121_9 + arg_121_0 then
				local var_121_11 = Color.New(0, 0, 0)

				arg_118_1.mask_.enabled = false
				var_121_11.a = 0
				arg_118_1.mask_.color = var_121_11
			end

			local var_121_12 = arg_118_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_118_1.time_ and arg_118_1.time_ <= 1.96599999815226 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = var_121_12.localPosition
			end

			local var_121_13 = 0.001

			if 1.96599999815226 <= arg_118_1.time_ and arg_118_1.time_ < 1.96599999815226 + var_121_13 then
				var_121_12.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 1.96599999815226) / var_121_13)
				var_121_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_12.position).x, (manager.ui.mainCamera.transform.position - var_121_12.position).y, (manager.ui.mainCamera.transform.position - var_121_12.position).z)
				var_121_12.localEulerAngles.z = 0
				var_121_12.localEulerAngles.x = 0
				var_121_12.localEulerAngles = var_121_12.localEulerAngles
			end

			if arg_118_1.time_ >= 1.96599999815226 + var_121_13 and arg_118_1.time_ < 1.96599999815226 + var_121_13 + arg_121_0 then
				var_121_12.localPosition = Vector3.New(0, 100, 0)
				var_121_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_12.position).x, (manager.ui.mainCamera.transform.position - var_121_12.position).y, (manager.ui.mainCamera.transform.position - var_121_12.position).z)
				var_121_12.localEulerAngles.z = 0
				var_121_12.localEulerAngles.x = 0
				var_121_12.localEulerAngles = var_121_12.localEulerAngles
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_14 = 4
			local var_121_15 = 1.575

			if 4 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_16 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_16:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_17 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(1108410029).content)

				arg_118_1.text_.text = var_121_17

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_19 = 63 <= 0 and var_121_15 or var_121_15 * (utf8.len(var_121_17) / 63)

				if (63 <= 0 and var_121_15 or var_121_15 * (utf8.len(var_121_17) / 63)) > 0 and var_121_15 < var_121_19 then
					arg_118_1.talkMaxDuration = var_121_19
					var_121_14 = var_121_14 + 0.3

					if var_121_19 + var_121_14 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_19 + var_121_14
					end
				end

				arg_118_1.text_.text = var_121_17
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_20 = var_121_14 + 0.3
			local var_121_21 = math.max(var_121_15, arg_118_1.talkMaxDuration)

			if var_121_14 + 0.3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_20 + var_121_21 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_20) / var_121_21

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_20 + var_121_21 and arg_118_1.time_ < var_121_20 + var_121_21 + arg_121_0 then
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
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play1108410030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1108410030
		arg_124_1.duration_ = 3.9

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1108410031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1084ui_story = arg_124_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_127_0 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				arg_124_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_124_1.time_ - 0) / var_127_0)
				arg_124_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1084ui_story"].transform.position).z)
				arg_124_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1084ui_story"].transform.localEulerAngles = arg_124_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				arg_124_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_124_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1084ui_story"].transform.position).z)
				arg_124_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1084ui_story"].transform.localEulerAngles = arg_124_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_127_1 = arg_124_1.actors_["1084ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1084ui_story == nil then
				arg_124_1.var_.characterEffect1084ui_story = var_127_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_2 and not isNil(var_127_1) then
				if arg_124_1.var_.characterEffect1084ui_story and not isNil(var_127_1) then
					arg_124_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_2 and arg_124_1.time_ < 0 + var_127_2 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1084ui_story then
				arg_124_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_127_4 = 0
			local var_127_5 = 0.625

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(1108410030)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_9 = 25 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 25)

				if (25 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 25)) > 0 and var_127_5 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410030", "story_v_side_new_1108410.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410030", "story_v_side_new_1108410.awb") / 1000

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end

					if var_127_6.prefab_name ~= "" and arg_124_1.actors_[var_127_6.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_6.prefab_name].transform, "story_v_side_new_1108410", "1108410030", "story_v_side_new_1108410.awb")

						arg_124_1:RecordAudio("1108410030", var_127_11)
						arg_124_1:RecordAudio("1108410030", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410030", "story_v_side_new_1108410.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410030", "story_v_side_new_1108410.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_12 = math.max(var_127_5, arg_124_1.talkMaxDuration)

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_12 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_4) / var_127_12

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_4 + var_127_12 and arg_124_1.time_ < var_127_4 + var_127_12 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play1108410031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1108410031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1108410032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) and arg_128_1.var_.characterEffect1084ui_story == nil then
				arg_128_1.var_.characterEffect1084ui_story = arg_128_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) then
				if arg_128_1.var_.characterEffect1084ui_story and not isNil(arg_128_1.actors_["1084ui_story"]) then
					arg_128_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_0)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) and arg_128_1.var_.characterEffect1084ui_story then
				arg_128_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_131_1 = 0
			local var_131_2 = 0.75

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(1108410031).content)

				arg_128_1.text_.text = var_131_3

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 30 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 30)

				if (30 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 30)) > 0 and var_131_2 < var_131_5 then
					arg_128_1.talkMaxDuration = var_131_5

					if var_131_5 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_3
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_6 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_6 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_6

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_6 and arg_128_1.time_ < var_131_1 + var_131_6 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play1108410032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1108410032
		arg_132_1.duration_ = 8.6

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1108410033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1084ui_story"]) and arg_132_1.var_.characterEffect1084ui_story == nil then
				arg_132_1.var_.characterEffect1084ui_story = arg_132_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1084ui_story"]) then
				if arg_132_1.var_.characterEffect1084ui_story and not isNil(arg_132_1.actors_["1084ui_story"]) then
					arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1084ui_story"]) and arg_132_1.var_.characterEffect1084ui_story then
				arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_135_2 = 0
			local var_135_3 = 0.775

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
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

				local var_135_4 = arg_132_1:GetWordFromCfg(1108410032)
				local var_135_5 = arg_132_1:FormatText(var_135_4.content)

				arg_132_1.text_.text = var_135_5

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_7 = 31 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 31)

				if (31 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 31)) > 0 and var_135_3 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_2
					end
				end

				arg_132_1.text_.text = var_135_5
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410032", "story_v_side_new_1108410.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410032", "story_v_side_new_1108410.awb") / 1000

					if var_135_8 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_2
					end

					if var_135_4.prefab_name ~= "" and arg_132_1.actors_[var_135_4.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_4.prefab_name].transform, "story_v_side_new_1108410", "1108410032", "story_v_side_new_1108410.awb")

						arg_132_1:RecordAudio("1108410032", var_135_9)
						arg_132_1:RecordAudio("1108410032", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410032", "story_v_side_new_1108410.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410032", "story_v_side_new_1108410.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_3, arg_132_1.talkMaxDuration)

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_2) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_2 + var_135_10 and arg_132_1.time_ < var_135_2 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1108410033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1108410033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1108410034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1084ui_story"]) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = arg_136_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1084ui_story"]) then
				if arg_136_1.var_.characterEffect1084ui_story and not isNil(arg_136_1.actors_["1084ui_story"]) then
					arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1084ui_story"]) and arg_136_1.var_.characterEffect1084ui_story then
				arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_139_1 = 0
			local var_139_2 = 0.925

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(1108410033).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 37 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 37)

				if (37 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 37)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1108410034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1108410034
		arg_140_1.duration_ = 6.73

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1108410035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) and arg_140_1.var_.characterEffect1084ui_story == nil then
				arg_140_1.var_.characterEffect1084ui_story = arg_140_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) then
				if arg_140_1.var_.characterEffect1084ui_story and not isNil(arg_140_1.actors_["1084ui_story"]) then
					arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1084ui_story"]) and arg_140_1.var_.characterEffect1084ui_story then
				arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4128")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_143_2 = 0
			local var_143_3 = 0.975

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
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

				local var_143_4 = arg_140_1:GetWordFromCfg(1108410034)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 39 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 39)

				if (39 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 39)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410034", "story_v_side_new_1108410.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410034", "story_v_side_new_1108410.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_side_new_1108410", "1108410034", "story_v_side_new_1108410.awb")

						arg_140_1:RecordAudio("1108410034", var_143_9)
						arg_140_1:RecordAudio("1108410034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410034", "story_v_side_new_1108410.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410034", "story_v_side_new_1108410.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1108410035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1108410035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1108410036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = arg_144_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) then
				if arg_144_1.var_.characterEffect1084ui_story and not isNil(arg_144_1.actors_["1084ui_story"]) then
					arg_144_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) and arg_144_1.var_.characterEffect1084ui_story then
				arg_144_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_147_1 = 0
			local var_147_2 = 0.4

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(1108410035).content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 16 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 16)

				if (16 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 16)) > 0 and var_147_2 < var_147_5 then
					arg_144_1.talkMaxDuration = var_147_5

					if var_147_5 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_6 = math.max(var_147_2, arg_144_1.talkMaxDuration)

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_6 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_1) / var_147_6

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_1 + var_147_6 and arg_144_1.time_ < var_147_1 + var_147_6 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1108410036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1108410036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1108410037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1084ui_story = arg_148_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1084ui_story"].transform.position).z)
				arg_148_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1084ui_story"].transform.localEulerAngles = arg_148_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1084ui_story"].transform.position).z)
				arg_148_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1084ui_story"].transform.localEulerAngles = arg_148_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_151_1 = 0
			local var_151_2 = 1.325

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

				local var_151_3 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(1108410036).content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 53 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 53)

				if (53 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 53)) > 0 and var_151_2 < var_151_5 then
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

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play1108410037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1108410037
		arg_152_1.duration_ = 3.1

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1108410038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1084ui_story = arg_152_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).z)
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles = arg_152_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_152_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).z)
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles = arg_152_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_155_1 = arg_152_1.actors_["1084ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1084ui_story == nil then
				arg_152_1.var_.characterEffect1084ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect1084ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1084ui_story then
				arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_155_4 = 0
			local var_155_5 = 0.675

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(1108410037)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 27 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 27)

				if (27 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 27)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410037", "story_v_side_new_1108410.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410037", "story_v_side_new_1108410.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_side_new_1108410", "1108410037", "story_v_side_new_1108410.awb")

						arg_152_1:RecordAudio("1108410037", var_155_11)
						arg_152_1:RecordAudio("1108410037", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410037", "story_v_side_new_1108410.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410037", "story_v_side_new_1108410.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play1108410038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1108410038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1108410039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1084ui_story = arg_156_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1084ui_story"].transform.position).z)
				arg_156_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1084ui_story"].transform.localEulerAngles = arg_156_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1084ui_story"].transform.position).z)
				arg_156_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1084ui_story"].transform.localEulerAngles = arg_156_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1084ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1084ui_story == nil then
				arg_156_1.var_.characterEffect1084ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1084ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_2)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1084ui_story then
				arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_159_3 = 0
			local var_159_4 = 0.875

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_3 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_5 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(1108410038).content)

				arg_156_1.text_.text = var_159_5

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 35 <= 0 and var_159_4 or var_159_4 * (utf8.len(var_159_5) / 35)

				if (35 <= 0 and var_159_4 or var_159_4 * (utf8.len(var_159_5) / 35)) > 0 and var_159_4 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_3 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_3
					end
				end

				arg_156_1.text_.text = var_159_5
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_4, arg_156_1.talkMaxDuration)

			if var_159_3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_3 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_3) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_3 + var_159_8 and arg_156_1.time_ < var_159_3 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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

		arg_156_1:InitPlayNodeList()
	end,
	Play1108410039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1108410039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1108410040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.9

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_1 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(1108410039).content)

				arg_160_1.text_.text = var_163_1

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_3 = 36 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 36)

				if (36 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 36)) > 0 and var_163_0 < var_163_3 then
					arg_160_1.talkMaxDuration = var_163_3

					if var_163_3 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_3 + 0
					end
				end

				arg_160_1.text_.text = var_163_1
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_4 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_4

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play1108410040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1108410040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1108410041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.925

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(1108410040).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 37 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 37)

				if (37 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 37)) > 0 and var_167_0 < var_167_3 then
					arg_164_1.talkMaxDuration = var_167_3

					if var_167_3 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_3 + 0
					end
				end

				arg_164_1.text_.text = var_167_1
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_4 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_4

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play1108410041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1108410041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1108410042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.85

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1084")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_1 = arg_168_1:GetWordFromCfg(1108410041)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 34 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 34)

				if (34 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 34)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410041", "story_v_side_new_1108410.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410041", "story_v_side_new_1108410.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_side_new_1108410", "1108410041", "story_v_side_new_1108410.awb")

						arg_168_1:RecordAudio("1108410041", var_171_6)
						arg_168_1:RecordAudio("1108410041", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410041", "story_v_side_new_1108410.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410041", "story_v_side_new_1108410.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1108410042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1108410042
		arg_172_1.duration_ = 4.8

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1108410043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.6

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1084")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:GetWordFromCfg(1108410042)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 24 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 24)

				if (24 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 24)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410042", "story_v_side_new_1108410.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410042", "story_v_side_new_1108410.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_side_new_1108410", "1108410042", "story_v_side_new_1108410.awb")

						arg_172_1:RecordAudio("1108410042", var_175_6)
						arg_172_1:RecordAudio("1108410042", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410042", "story_v_side_new_1108410.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410042", "story_v_side_new_1108410.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play1108410043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1108410043
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1108410044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 1.075

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(1108410043).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 43 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 43)

				if (43 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 43)) > 0 and var_179_0 < var_179_3 then
					arg_176_1.talkMaxDuration = var_179_3

					if var_179_3 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_3 + 0
					end
				end

				arg_176_1.text_.text = var_179_1
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_4 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_4

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1108410044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1108410044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1108410045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.55

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
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

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_1 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(1108410044).content)

				arg_180_1.text_.text = var_183_1

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_3 = 22 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_1) / 22)

				if (22 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_1) / 22)) > 0 and var_183_0 < var_183_3 then
					arg_180_1.talkMaxDuration = var_183_3

					if var_183_3 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_3 + 0
					end
				end

				arg_180_1.text_.text = var_183_1
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_4 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_4

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1108410045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1108410045
		arg_184_1.duration_ = 3.3

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1108410046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_187_0 = 0.35

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 then
				local var_187_1, var_187_2 = math.modf((arg_184_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_187_2 * 0.13, var_187_2 * 0.13, var_187_2 * 0.13) + arg_184_1.var_.shakeOldPos
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 then
				manager.ui.mainCamera.transform.localPosition = arg_184_1.var_.shakeOldPos
			end

			local var_187_3 = 0

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_3 + arg_187_0 then
				arg_184_1.allBtn_.enabled = false
			end

			if arg_184_1.time_ >= var_187_3 + 0.35 and arg_184_1.time_ < var_187_3 + 0.35 + arg_187_0 then
				arg_184_1.allBtn_.enabled = true
			end

			local var_187_4 = 0
			local var_187_5 = 0.35

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				arg_184_1.dialog_:SetActive(true)

				arg_184_1.dialogCg_.alpha = 0

				local var_187_6 = LeanTween.value(arg_184_1.dialog_, 0, 1, 0.3)

				var_187_6:setOnUpdate(LuaHelper.FloatAction(function(arg_188_0)
					arg_184_1.dialogCg_.alpha = arg_188_0
				end))
				var_187_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_184_1.dialog_)
					var_187_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_184_1.duration_ = arg_184_1.duration_ + 0.3

				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1084")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_7 = arg_184_1:GetWordFromCfg(1108410045)
				local var_187_8 = arg_184_1:FormatText(var_187_7.content)

				arg_184_1.text_.text = var_187_8

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_10 = 14 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_8) / 14)

				if (14 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_8) / 14)) > 0 and var_187_5 < var_187_10 then
					arg_184_1.talkMaxDuration = var_187_10
					var_187_4 = var_187_4 + 0.3

					if var_187_10 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_8
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410045", "story_v_side_new_1108410.awb") ~= 0 then
					local var_187_11 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410045", "story_v_side_new_1108410.awb") / 1000

					if var_187_11 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_11 + var_187_4
					end

					if var_187_7.prefab_name ~= "" and arg_184_1.actors_[var_187_7.prefab_name] ~= nil then
						local var_187_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_7.prefab_name].transform, "story_v_side_new_1108410", "1108410045", "story_v_side_new_1108410.awb")

						arg_184_1:RecordAudio("1108410045", var_187_12)
						arg_184_1:RecordAudio("1108410045", var_187_12)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410045", "story_v_side_new_1108410.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410045", "story_v_side_new_1108410.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_13 = var_187_4 + 0.3
			local var_187_14 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 + 0.3 <= arg_184_1.time_ and arg_184_1.time_ < var_187_13 + var_187_14 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_13) / var_187_14

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_13 + var_187_14 and arg_184_1.time_ < var_187_13 + var_187_14 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1108410046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1108410046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1108410047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1084ui_story = arg_190_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).z)
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles = arg_190_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_190_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).z)
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles = arg_190_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1084ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1084ui_story == nil then
				arg_190_1.var_.characterEffect1084ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1084ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_2)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1084ui_story then
				arg_190_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_193_3 = 0
			local var_193_4 = 1.9

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_3 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_5 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(1108410046).content)

				arg_190_1.text_.text = var_193_5

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_7 = 76 <= 0 and var_193_4 or var_193_4 * (utf8.len(var_193_5) / 76)

				if (76 <= 0 and var_193_4 or var_193_4 * (utf8.len(var_193_5) / 76)) > 0 and var_193_4 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_3 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_3
					end
				end

				arg_190_1.text_.text = var_193_5
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_8 = math.max(var_193_4, arg_190_1.talkMaxDuration)

			if var_193_3 <= arg_190_1.time_ and arg_190_1.time_ < var_193_3 + var_193_8 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_3) / var_193_8

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_3 + var_193_8 and arg_190_1.time_ < var_193_3 + var_193_8 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
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

		arg_190_1:InitPlayNodeList()
	end,
	Play1108410047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1108410047
		arg_194_1.duration_ = 4.03

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1108410048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_197_0 = 1

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 then
				local var_197_1, var_197_2 = math.modf((arg_194_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_197_2 * 0.13, var_197_2 * 0.13, var_197_2 * 0.13) + arg_194_1.var_.shakeOldPos
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 then
				manager.ui.mainCamera.transform.localPosition = arg_194_1.var_.shakeOldPos
			end

			local var_197_3 = 0

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_3 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			if arg_194_1.time_ >= var_197_3 + 1 and arg_194_1.time_ < var_197_3 + 1 + arg_197_0 then
				arg_194_1.allBtn_.enabled = true
			end

			if arg_194_1.frameCnt_ <= 1 then
				arg_194_1.dialog_:SetActive(false)
			end

			local var_197_4 = 0.825
			local var_197_5 = 0.175

			if 0.825 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0

				arg_194_1.dialog_:SetActive(true)

				arg_194_1.dialogCg_.alpha = 0

				local var_197_6 = LeanTween.value(arg_194_1.dialog_, 0, 1, 0.3)

				var_197_6:setOnUpdate(LuaHelper.FloatAction(function(arg_198_0)
					arg_194_1.dialogCg_.alpha = arg_198_0
				end))
				var_197_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_194_1.dialog_)
					var_197_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_194_1.duration_ = arg_194_1.duration_ + 0.3

				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1084")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_7 = arg_194_1:GetWordFromCfg(1108410047)
				local var_197_8 = arg_194_1:FormatText(var_197_7.content)

				arg_194_1.text_.text = var_197_8

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_10 = 7 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_8) / 7)

				if (7 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_8) / 7)) > 0 and var_197_5 < var_197_10 then
					arg_194_1.talkMaxDuration = var_197_10
					var_197_4 = var_197_4 + 0.3

					if var_197_10 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_4
					end
				end

				arg_194_1.text_.text = var_197_8
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410047", "story_v_side_new_1108410.awb") ~= 0 then
					local var_197_11 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410047", "story_v_side_new_1108410.awb") / 1000

					if var_197_11 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_11 + var_197_4
					end

					if var_197_7.prefab_name ~= "" and arg_194_1.actors_[var_197_7.prefab_name] ~= nil then
						local var_197_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_7.prefab_name].transform, "story_v_side_new_1108410", "1108410047", "story_v_side_new_1108410.awb")

						arg_194_1:RecordAudio("1108410047", var_197_12)
						arg_194_1:RecordAudio("1108410047", var_197_12)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410047", "story_v_side_new_1108410.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410047", "story_v_side_new_1108410.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_13 = var_197_4 + 0.3
			local var_197_14 = math.max(var_197_5, arg_194_1.talkMaxDuration)

			if var_197_4 + 0.3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_13 + var_197_14 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_13) / var_197_14

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_13 + var_197_14 and arg_194_1.time_ < var_197_13 + var_197_14 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1108410048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1108410048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1108410049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1084ui_story"]) and arg_200_1.var_.characterEffect1084ui_story == nil then
				arg_200_1.var_.characterEffect1084ui_story = arg_200_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1084ui_story"]) then
				if arg_200_1.var_.characterEffect1084ui_story and not isNil(arg_200_1.actors_["1084ui_story"]) then
					arg_200_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_0)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1084ui_story"]) and arg_200_1.var_.characterEffect1084ui_story then
				arg_200_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_203_1 = 0
			local var_203_2 = 0.275

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(1108410048).content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 11 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_3) / 11)

				if (11 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_3) / 11)) > 0 and var_203_2 < var_203_5 then
					arg_200_1.talkMaxDuration = var_203_5

					if var_203_5 + var_203_1 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + var_203_1
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_6 = math.max(var_203_2, arg_200_1.talkMaxDuration)

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_6 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_1) / var_203_6

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_1 + var_203_6 and arg_200_1.time_ < var_203_1 + var_203_6 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1108410049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1108410049
		arg_204_1.duration_ = 7.27

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1108410050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.95

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1084")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:GetWordFromCfg(1108410049)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 38 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 38)

				if (38 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 38)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410049", "story_v_side_new_1108410.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410049", "story_v_side_new_1108410.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_side_new_1108410", "1108410049", "story_v_side_new_1108410.awb")

						arg_204_1:RecordAudio("1108410049", var_207_6)
						arg_204_1:RecordAudio("1108410049", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410049", "story_v_side_new_1108410.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410049", "story_v_side_new_1108410.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play1108410050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1108410050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1108410051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1084ui_story"]) and arg_208_1.var_.characterEffect1084ui_story == nil then
				arg_208_1.var_.characterEffect1084ui_story = arg_208_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1084ui_story"]) then
				if arg_208_1.var_.characterEffect1084ui_story and not isNil(arg_208_1.actors_["1084ui_story"]) then
					arg_208_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1084ui_story"]) and arg_208_1.var_.characterEffect1084ui_story then
				arg_208_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_211_1 = 0
			local var_211_2 = 0.25

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_3 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(1108410050).content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 10 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 10)

				if (10 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 10)) > 0 and var_211_2 < var_211_5 then
					arg_208_1.talkMaxDuration = var_211_5

					if var_211_5 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_6 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_6 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_6

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_6 and arg_208_1.time_ < var_211_1 + var_211_6 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1108410051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1108410051
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1108410052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1084ui_story = arg_212_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1084ui_story"].transform.position).z)
				arg_212_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1084ui_story"].transform.localEulerAngles = arg_212_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1084ui_story"].transform.position).z)
				arg_212_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1084ui_story"].transform.localEulerAngles = arg_212_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_215_1 = 0
			local var_215_2 = 1.125

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_3 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(1108410051).content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 45 <= 0 and var_215_2 or var_215_2 * (utf8.len(var_215_3) / 45)

				if (45 <= 0 and var_215_2 or var_215_2 * (utf8.len(var_215_3) / 45)) > 0 and var_215_2 < var_215_5 then
					arg_212_1.talkMaxDuration = var_215_5

					if var_215_5 + var_215_1 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + var_215_1
					end
				end

				arg_212_1.text_.text = var_215_3
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_6 = math.max(var_215_2, arg_212_1.talkMaxDuration)

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_6 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_1) / var_215_6

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_1 + var_215_6 and arg_212_1.time_ < var_215_1 + var_215_6 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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

		arg_212_1:InitPlayNodeList()
	end,
	Play1108410052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1108410052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1108410053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0.35

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_1 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(1108410052).content)

				arg_216_1.text_.text = var_219_1

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_3 = 14 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_1) / 14)

				if (14 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_1) / 14)) > 0 and var_219_0 < var_219_3 then
					arg_216_1.talkMaxDuration = var_219_3

					if var_219_3 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_3 + 0
					end
				end

				arg_216_1.text_.text = var_219_1
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_4 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_4

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play1108410053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1108410053
		arg_220_1.duration_ = 5.3

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1108410054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.275

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1084")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_1 = arg_220_1:GetWordFromCfg(1108410053)
				local var_223_2 = arg_220_1:FormatText(var_223_1.content)

				arg_220_1.text_.text = var_223_2

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 11 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 11)

				if (11 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 11)) > 0 and var_223_0 < var_223_4 then
					arg_220_1.talkMaxDuration = var_223_4

					if var_223_4 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_4 + 0
					end
				end

				arg_220_1.text_.text = var_223_2
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410053", "story_v_side_new_1108410.awb") ~= 0 then
					local var_223_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410053", "story_v_side_new_1108410.awb") / 1000

					if var_223_5 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + 0
					end

					if var_223_1.prefab_name ~= "" and arg_220_1.actors_[var_223_1.prefab_name] ~= nil then
						local var_223_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_1.prefab_name].transform, "story_v_side_new_1108410", "1108410053", "story_v_side_new_1108410.awb")

						arg_220_1:RecordAudio("1108410053", var_223_6)
						arg_220_1:RecordAudio("1108410053", var_223_6)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410053", "story_v_side_new_1108410.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410053", "story_v_side_new_1108410.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play1108410054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1108410054
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play1108410055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1084ui_story = arg_224_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_227_0 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 then
				arg_224_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_224_1.time_ - 0) / var_227_0)
				arg_224_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).z)
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles = arg_224_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 then
				arg_224_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_224_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1084ui_story"].transform.position).z)
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1084ui_story"].transform.localEulerAngles = arg_224_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_227_1 = arg_224_1.actors_["1084ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect1084ui_story == nil then
				arg_224_1.var_.characterEffect1084ui_story = var_227_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_2 and not isNil(var_227_1) then
				if arg_224_1.var_.characterEffect1084ui_story and not isNil(var_227_1) then
					arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_2)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_2 and arg_224_1.time_ < 0 + var_227_2 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect1084ui_story then
				arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_227_3 = 0
			local var_227_4 = 1.8

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_3 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_5 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(1108410054).content)

				arg_224_1.text_.text = var_227_5

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_7 = 72 <= 0 and var_227_4 or var_227_4 * (utf8.len(var_227_5) / 72)

				if (72 <= 0 and var_227_4 or var_227_4 * (utf8.len(var_227_5) / 72)) > 0 and var_227_4 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_3 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_3
					end
				end

				arg_224_1.text_.text = var_227_5
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_8 = math.max(var_227_4, arg_224_1.talkMaxDuration)

			if var_227_3 <= arg_224_1.time_ and arg_224_1.time_ < var_227_3 + var_227_8 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_3) / var_227_8

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_3 + var_227_8 and arg_224_1.time_ < var_227_3 + var_227_8 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
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

		arg_224_1:InitPlayNodeList()
	end,
	Play1108410055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1108410055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1108410056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.575

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_1 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(1108410055).content)

				arg_228_1.text_.text = var_231_1

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_3 = 23 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 23)

				if (23 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 23)) > 0 and var_231_0 < var_231_3 then
					arg_228_1.talkMaxDuration = var_231_3

					if var_231_3 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_3 + 0
					end
				end

				arg_228_1.text_.text = var_231_1
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_4 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_4

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1108410056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1108410056
		arg_232_1.duration_ = 2

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1108410057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1084ui_story = arg_232_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).z)
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles = arg_232_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_232_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1084ui_story"].transform.position).z)
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1084ui_story"].transform.localEulerAngles = arg_232_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["1084ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1084ui_story == nil then
				arg_232_1.var_.characterEffect1084ui_story = var_235_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_2 and not isNil(var_235_1) then
				if arg_232_1.var_.characterEffect1084ui_story and not isNil(var_235_1) then
					arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_2 and arg_232_1.time_ < 0 + var_235_2 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1084ui_story then
				arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_235_4 = 0
			local var_235_5 = 0.075

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
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

				local var_235_6 = arg_232_1:GetWordFromCfg(1108410056)
				local var_235_7 = arg_232_1:FormatText(var_235_6.content)

				arg_232_1.text_.text = var_235_7

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_9 = 3 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 3)

				if (3 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 3)) > 0 and var_235_5 < var_235_9 then
					arg_232_1.talkMaxDuration = var_235_9

					if var_235_9 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_4
					end
				end

				arg_232_1.text_.text = var_235_7
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410056", "story_v_side_new_1108410.awb") ~= 0 then
					local var_235_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410056", "story_v_side_new_1108410.awb") / 1000

					if var_235_10 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_4
					end

					if var_235_6.prefab_name ~= "" and arg_232_1.actors_[var_235_6.prefab_name] ~= nil then
						local var_235_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_6.prefab_name].transform, "story_v_side_new_1108410", "1108410056", "story_v_side_new_1108410.awb")

						arg_232_1:RecordAudio("1108410056", var_235_11)
						arg_232_1:RecordAudio("1108410056", var_235_11)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410056", "story_v_side_new_1108410.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410056", "story_v_side_new_1108410.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_12 = math.max(var_235_5, arg_232_1.talkMaxDuration)

			if var_235_4 <= arg_232_1.time_ and arg_232_1.time_ < var_235_4 + var_235_12 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_4) / var_235_12

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_4 + var_235_12 and arg_232_1.time_ < var_235_4 + var_235_12 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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

		arg_232_1:InitPlayNodeList()
	end,
	Play1108410057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1108410057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1108410058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1084ui_story = arg_236_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1084ui_story"].transform.position).z)
				arg_236_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1084ui_story"].transform.localEulerAngles = arg_236_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1084ui_story"].transform.position).z)
				arg_236_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1084ui_story"].transform.localEulerAngles = arg_236_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_239_1 = arg_236_1.actors_["1084ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1084ui_story == nil then
				arg_236_1.var_.characterEffect1084ui_story = var_239_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_2 and not isNil(var_239_1) then
				if arg_236_1.var_.characterEffect1084ui_story and not isNil(var_239_1) then
					arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_2)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_2 and arg_236_1.time_ < 0 + var_239_2 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1084ui_story then
				arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_239_3 = 0
			local var_239_4 = 1.25

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_3 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_5 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(1108410057).content)

				arg_236_1.text_.text = var_239_5

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_7 = 50 <= 0 and var_239_4 or var_239_4 * (utf8.len(var_239_5) / 50)

				if (50 <= 0 and var_239_4 or var_239_4 * (utf8.len(var_239_5) / 50)) > 0 and var_239_4 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_3 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_3
					end
				end

				arg_236_1.text_.text = var_239_5
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_8 = math.max(var_239_4, arg_236_1.talkMaxDuration)

			if var_239_3 <= arg_236_1.time_ and arg_236_1.time_ < var_239_3 + var_239_8 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_3) / var_239_8

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_3 + var_239_8 and arg_236_1.time_ < var_239_3 + var_239_8 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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

		arg_236_1:InitPlayNodeList()
	end,
	Play1108410058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1108410058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1108410059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.65

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(1108410058).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 26 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 26)

				if (26 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 26)) > 0 and var_243_0 < var_243_3 then
					arg_240_1.talkMaxDuration = var_243_3

					if var_243_3 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_3 + 0
					end
				end

				arg_240_1.text_.text = var_243_1
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_4 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_4

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play1108410059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1108410059
		arg_244_1.duration_ = 20.43

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1108410060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1084ui_story = arg_244_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).z)
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles = arg_244_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_244_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1084ui_story"].transform.position).z)
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1084ui_story"].transform.localEulerAngles = arg_244_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["1084ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1084ui_story == nil then
				arg_244_1.var_.characterEffect1084ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.characterEffect1084ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1084ui_story then
				arg_244_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_247_4 = 0
			local var_247_5 = 1.975

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_6 = arg_244_1:GetWordFromCfg(1108410059)
				local var_247_7 = arg_244_1:FormatText(var_247_6.content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 79 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 79)

				if (79 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 79)) > 0 and var_247_5 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410059", "story_v_side_new_1108410.awb") ~= 0 then
					local var_247_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410059", "story_v_side_new_1108410.awb") / 1000

					if var_247_10 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_4
					end

					if var_247_6.prefab_name ~= "" and arg_244_1.actors_[var_247_6.prefab_name] ~= nil then
						local var_247_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_6.prefab_name].transform, "story_v_side_new_1108410", "1108410059", "story_v_side_new_1108410.awb")

						arg_244_1:RecordAudio("1108410059", var_247_11)
						arg_244_1:RecordAudio("1108410059", var_247_11)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410059", "story_v_side_new_1108410.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410059", "story_v_side_new_1108410.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_12 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_12 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_12

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_12 and arg_244_1.time_ < var_247_4 + var_247_12 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
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

		arg_244_1:InitPlayNodeList()
	end,
	Play1108410060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1108410060
		arg_248_1.duration_ = 7.23

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1108410061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4137")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_251_0 = 0
			local var_251_1 = 0.525

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_2 = arg_248_1:GetWordFromCfg(1108410060)
				local var_251_3 = arg_248_1:FormatText(var_251_2.content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 21 <= 0 and var_251_1 or var_251_1 * (utf8.len(var_251_3) / 21)

				if (21 <= 0 and var_251_1 or var_251_1 * (utf8.len(var_251_3) / 21)) > 0 and var_251_1 < var_251_5 then
					arg_248_1.talkMaxDuration = var_251_5

					if var_251_5 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410060", "story_v_side_new_1108410.awb") ~= 0 then
					local var_251_6 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410060", "story_v_side_new_1108410.awb") / 1000

					if var_251_6 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_6 + var_251_0
					end

					if var_251_2.prefab_name ~= "" and arg_248_1.actors_[var_251_2.prefab_name] ~= nil then
						local var_251_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_2.prefab_name].transform, "story_v_side_new_1108410", "1108410060", "story_v_side_new_1108410.awb")

						arg_248_1:RecordAudio("1108410060", var_251_7)
						arg_248_1:RecordAudio("1108410060", var_251_7)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410060", "story_v_side_new_1108410.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410060", "story_v_side_new_1108410.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_8 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_8 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_8

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_8 and arg_248_1.time_ < var_251_0 + var_251_8 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play1108410061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1108410061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1108410062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1084ui_story"]) and arg_252_1.var_.characterEffect1084ui_story == nil then
				arg_252_1.var_.characterEffect1084ui_story = arg_252_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1084ui_story"]) then
				if arg_252_1.var_.characterEffect1084ui_story and not isNil(arg_252_1.actors_["1084ui_story"]) then
					arg_252_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_0)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1084ui_story"]) and arg_252_1.var_.characterEffect1084ui_story then
				arg_252_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_255_1 = 0
			local var_255_2 = 1.05

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(1108410061).content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 42 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 42)

				if (42 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 42)) > 0 and var_255_2 < var_255_5 then
					arg_252_1.talkMaxDuration = var_255_5

					if var_255_5 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_6 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_6 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_6

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_6 and arg_252_1.time_ < var_255_1 + var_255_6 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1108410062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1108410062
		arg_256_1.duration_ = 8.47

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1108410063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1084ui_story"]) and arg_256_1.var_.characterEffect1084ui_story == nil then
				arg_256_1.var_.characterEffect1084ui_story = arg_256_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1084ui_story"]) then
				if arg_256_1.var_.characterEffect1084ui_story and not isNil(arg_256_1.actors_["1084ui_story"]) then
					arg_256_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1084ui_story"]) and arg_256_1.var_.characterEffect1084ui_story then
				arg_256_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4713")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_259_2 = 0
			local var_259_3 = 0.975

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_4 = arg_256_1:GetWordFromCfg(1108410062)
				local var_259_5 = arg_256_1:FormatText(var_259_4.content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_7 = 39 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 39)

				if (39 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 39)) > 0 and var_259_3 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_2
					end
				end

				arg_256_1.text_.text = var_259_5
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410062", "story_v_side_new_1108410.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410062", "story_v_side_new_1108410.awb") / 1000

					if var_259_8 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_2
					end

					if var_259_4.prefab_name ~= "" and arg_256_1.actors_[var_259_4.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_4.prefab_name].transform, "story_v_side_new_1108410", "1108410062", "story_v_side_new_1108410.awb")

						arg_256_1:RecordAudio("1108410062", var_259_9)
						arg_256_1:RecordAudio("1108410062", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410062", "story_v_side_new_1108410.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410062", "story_v_side_new_1108410.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_3, arg_256_1.talkMaxDuration)

			if var_259_2 <= arg_256_1.time_ and arg_256_1.time_ < var_259_2 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_2) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_2 + var_259_10 and arg_256_1.time_ < var_259_2 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1108410063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1108410063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1108410064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1084ui_story"]) and arg_260_1.var_.characterEffect1084ui_story == nil then
				arg_260_1.var_.characterEffect1084ui_story = arg_260_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1084ui_story"]) then
				if arg_260_1.var_.characterEffect1084ui_story and not isNil(arg_260_1.actors_["1084ui_story"]) then
					arg_260_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_0)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1084ui_story"]) and arg_260_1.var_.characterEffect1084ui_story then
				arg_260_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_263_1 = 0
			local var_263_2 = 0.85

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_3 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(1108410063).content)

				arg_260_1.text_.text = var_263_3

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 34 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_3) / 34)

				if (34 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_3) / 34)) > 0 and var_263_2 < var_263_5 then
					arg_260_1.talkMaxDuration = var_263_5

					if var_263_5 + var_263_1 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + var_263_1
					end
				end

				arg_260_1.text_.text = var_263_3
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_6 = math.max(var_263_2, arg_260_1.talkMaxDuration)

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_6 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_1) / var_263_6

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_1 + var_263_6 and arg_260_1.time_ < var_263_1 + var_263_6 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1108410064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1108410064
		arg_264_1.duration_ = 5.23

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play1108410065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1084ui_story"]) and arg_264_1.var_.characterEffect1084ui_story == nil then
				arg_264_1.var_.characterEffect1084ui_story = arg_264_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1084ui_story"]) then
				if arg_264_1.var_.characterEffect1084ui_story and not isNil(arg_264_1.actors_["1084ui_story"]) then
					arg_264_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1084ui_story"]) and arg_264_1.var_.characterEffect1084ui_story then
				arg_264_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_267_2 = 0
			local var_267_3 = 0.7

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_2 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_4 = arg_264_1:GetWordFromCfg(1108410064)
				local var_267_5 = arg_264_1:FormatText(var_267_4.content)

				arg_264_1.text_.text = var_267_5

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_7 = 28 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_5) / 28)

				if (28 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_5) / 28)) > 0 and var_267_3 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_2
					end
				end

				arg_264_1.text_.text = var_267_5
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410064", "story_v_side_new_1108410.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410064", "story_v_side_new_1108410.awb") / 1000

					if var_267_8 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_2
					end

					if var_267_4.prefab_name ~= "" and arg_264_1.actors_[var_267_4.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_4.prefab_name].transform, "story_v_side_new_1108410", "1108410064", "story_v_side_new_1108410.awb")

						arg_264_1:RecordAudio("1108410064", var_267_9)
						arg_264_1:RecordAudio("1108410064", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410064", "story_v_side_new_1108410.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410064", "story_v_side_new_1108410.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_3, arg_264_1.talkMaxDuration)

			if var_267_2 <= arg_264_1.time_ and arg_264_1.time_ < var_267_2 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_2) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_2 + var_267_10 and arg_264_1.time_ < var_267_2 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play1108410065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1108410065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1108410066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1084ui_story"]) and arg_268_1.var_.characterEffect1084ui_story == nil then
				arg_268_1.var_.characterEffect1084ui_story = arg_268_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1084ui_story"]) then
				if arg_268_1.var_.characterEffect1084ui_story and not isNil(arg_268_1.actors_["1084ui_story"]) then
					arg_268_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1084ui_story"]) and arg_268_1.var_.characterEffect1084ui_story then
				arg_268_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_271_1 = 0
			local var_271_2 = 0.525

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(1108410065).content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 21 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 21)

				if (21 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 21)) > 0 and var_271_2 < var_271_5 then
					arg_268_1.talkMaxDuration = var_271_5

					if var_271_5 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_6 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_6 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_6

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_6 and arg_268_1.time_ < var_271_1 + var_271_6 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1108410066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1108410066
		arg_272_1.duration_ = 6.93

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1108410067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1084ui_story"]) and arg_272_1.var_.characterEffect1084ui_story == nil then
				arg_272_1.var_.characterEffect1084ui_story = arg_272_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1084ui_story"]) then
				if arg_272_1.var_.characterEffect1084ui_story and not isNil(arg_272_1.actors_["1084ui_story"]) then
					arg_272_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1084ui_story"]) and arg_272_1.var_.characterEffect1084ui_story then
				arg_272_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_275_2 = 0
			local var_275_3 = 0.675

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_2 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_4 = arg_272_1:GetWordFromCfg(1108410066)
				local var_275_5 = arg_272_1:FormatText(var_275_4.content)

				arg_272_1.text_.text = var_275_5

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_7 = 27 <= 0 and var_275_3 or var_275_3 * (utf8.len(var_275_5) / 27)

				if (27 <= 0 and var_275_3 or var_275_3 * (utf8.len(var_275_5) / 27)) > 0 and var_275_3 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_2
					end
				end

				arg_272_1.text_.text = var_275_5
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410066", "story_v_side_new_1108410.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410066", "story_v_side_new_1108410.awb") / 1000

					if var_275_8 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_2
					end

					if var_275_4.prefab_name ~= "" and arg_272_1.actors_[var_275_4.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_4.prefab_name].transform, "story_v_side_new_1108410", "1108410066", "story_v_side_new_1108410.awb")

						arg_272_1:RecordAudio("1108410066", var_275_9)
						arg_272_1:RecordAudio("1108410066", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410066", "story_v_side_new_1108410.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410066", "story_v_side_new_1108410.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_3, arg_272_1.talkMaxDuration)

			if var_275_2 <= arg_272_1.time_ and arg_272_1.time_ < var_275_2 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_2) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_2 + var_275_10 and arg_272_1.time_ < var_275_2 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play1108410067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1108410067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1108410068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1084ui_story"]) and arg_276_1.var_.characterEffect1084ui_story == nil then
				arg_276_1.var_.characterEffect1084ui_story = arg_276_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1084ui_story"]) then
				if arg_276_1.var_.characterEffect1084ui_story and not isNil(arg_276_1.actors_["1084ui_story"]) then
					arg_276_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_0)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1084ui_story"]) and arg_276_1.var_.characterEffect1084ui_story then
				arg_276_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_279_1 = 0
			local var_279_2 = 0.8

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(1108410067).content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 32 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 32)

				if (32 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 32)) > 0 and var_279_2 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_6 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_6 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_6

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_6 and arg_276_1.time_ < var_279_1 + var_279_6 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1108410068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1108410068
		arg_280_1.duration_ = 3.8

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1108410069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1084ui_story"]) and arg_280_1.var_.characterEffect1084ui_story == nil then
				arg_280_1.var_.characterEffect1084ui_story = arg_280_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1084ui_story"]) then
				if arg_280_1.var_.characterEffect1084ui_story and not isNil(arg_280_1.actors_["1084ui_story"]) then
					arg_280_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1084ui_story"]) and arg_280_1.var_.characterEffect1084ui_story then
				arg_280_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action484")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_283_2 = 0
			local var_283_3 = 0.3

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_4 = arg_280_1:GetWordFromCfg(1108410068)
				local var_283_5 = arg_280_1:FormatText(var_283_4.content)

				arg_280_1.text_.text = var_283_5

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_7 = 12 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 12)

				if (12 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 12)) > 0 and var_283_3 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_2
					end
				end

				arg_280_1.text_.text = var_283_5
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410068", "story_v_side_new_1108410.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410068", "story_v_side_new_1108410.awb") / 1000

					if var_283_8 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_2
					end

					if var_283_4.prefab_name ~= "" and arg_280_1.actors_[var_283_4.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_4.prefab_name].transform, "story_v_side_new_1108410", "1108410068", "story_v_side_new_1108410.awb")

						arg_280_1:RecordAudio("1108410068", var_283_9)
						arg_280_1:RecordAudio("1108410068", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410068", "story_v_side_new_1108410.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410068", "story_v_side_new_1108410.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_3, arg_280_1.talkMaxDuration)

			if var_283_2 <= arg_280_1.time_ and arg_280_1.time_ < var_283_2 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_2) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_2 + var_283_10 and arg_280_1.time_ < var_283_2 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1108410069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1108410069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1108410070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1084ui_story"]) and arg_284_1.var_.characterEffect1084ui_story == nil then
				arg_284_1.var_.characterEffect1084ui_story = arg_284_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1084ui_story"]) then
				if arg_284_1.var_.characterEffect1084ui_story and not isNil(arg_284_1.actors_["1084ui_story"]) then
					arg_284_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_0)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1084ui_story"]) and arg_284_1.var_.characterEffect1084ui_story then
				arg_284_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_287_1 = 0
			local var_287_2 = 0.15

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(1108410069).content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 6 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 6)

				if (6 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 6)) > 0 and var_287_2 < var_287_5 then
					arg_284_1.talkMaxDuration = var_287_5

					if var_287_5 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + var_287_1
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_6 = math.max(var_287_2, arg_284_1.talkMaxDuration)

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_6 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_1) / var_287_6

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_1 + var_287_6 and arg_284_1.time_ < var_287_1 + var_287_6 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1108410070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1108410070
		arg_288_1.duration_ = 4.53

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1108410071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1084ui_story"]) and arg_288_1.var_.characterEffect1084ui_story == nil then
				arg_288_1.var_.characterEffect1084ui_story = arg_288_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1084ui_story"]) then
				if arg_288_1.var_.characterEffect1084ui_story and not isNil(arg_288_1.actors_["1084ui_story"]) then
					arg_288_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1084ui_story"]) and arg_288_1.var_.characterEffect1084ui_story then
				arg_288_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_291_2 = 0
			local var_291_3 = 0.55

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_4 = arg_288_1:GetWordFromCfg(1108410070)
				local var_291_5 = arg_288_1:FormatText(var_291_4.content)

				arg_288_1.text_.text = var_291_5

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_7 = 22 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 22)

				if (22 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 22)) > 0 and var_291_3 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_5
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410070", "story_v_side_new_1108410.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410070", "story_v_side_new_1108410.awb") / 1000

					if var_291_8 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_2
					end

					if var_291_4.prefab_name ~= "" and arg_288_1.actors_[var_291_4.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_4.prefab_name].transform, "story_v_side_new_1108410", "1108410070", "story_v_side_new_1108410.awb")

						arg_288_1:RecordAudio("1108410070", var_291_9)
						arg_288_1:RecordAudio("1108410070", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410070", "story_v_side_new_1108410.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410070", "story_v_side_new_1108410.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_10 and arg_288_1.time_ < var_291_2 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1108410071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1108410071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1108410072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1084ui_story"]) and arg_292_1.var_.characterEffect1084ui_story == nil then
				arg_292_1.var_.characterEffect1084ui_story = arg_292_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1084ui_story"]) then
				if arg_292_1.var_.characterEffect1084ui_story and not isNil(arg_292_1.actors_["1084ui_story"]) then
					arg_292_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_0)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1084ui_story"]) and arg_292_1.var_.characterEffect1084ui_story then
				arg_292_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_295_1 = 0
			local var_295_2 = 0.7

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_3 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(1108410071).content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 28 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 28)

				if (28 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 28)) > 0 and var_295_2 < var_295_5 then
					arg_292_1.talkMaxDuration = var_295_5

					if var_295_5 + var_295_1 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + var_295_1
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_6 = math.max(var_295_2, arg_292_1.talkMaxDuration)

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_6 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_1) / var_295_6

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_1 + var_295_6 and arg_292_1.time_ < var_295_1 + var_295_6 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1108410072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1108410072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1108410073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1084ui_story = arg_296_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).z)
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles = arg_296_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1084ui_story"].transform.position).z)
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1084ui_story"].transform.localEulerAngles = arg_296_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_299_1 = 0
			local var_299_2 = 1.475

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_3 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(1108410072).content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 59 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 59)

				if (59 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 59)) > 0 and var_299_2 < var_299_5 then
					arg_296_1.talkMaxDuration = var_299_5

					if var_299_5 + var_299_1 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + var_299_1
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_6 = math.max(var_299_2, arg_296_1.talkMaxDuration)

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_6 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_1) / var_299_6

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_1 + var_299_6 and arg_296_1.time_ < var_299_1 + var_299_6 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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

		arg_296_1:InitPlayNodeList()
	end,
	Play1108410073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1108410073
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1108410074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.225

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_1 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(1108410073).content)

				arg_300_1.text_.text = var_303_1

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_3 = 9 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 9)

				if (9 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 9)) > 0 and var_303_0 < var_303_3 then
					arg_300_1.talkMaxDuration = var_303_3

					if var_303_3 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_3 + 0
					end
				end

				arg_300_1.text_.text = var_303_1
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_4 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_4

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play1108410074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1108410074
		arg_304_1.duration_ = 4.43

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1108410075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1084ui_story = arg_304_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_307_0 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 then
				arg_304_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_304_1.time_ - 0) / var_307_0)
				arg_304_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1084ui_story"].transform.position).z)
				arg_304_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1084ui_story"].transform.localEulerAngles = arg_304_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 then
				arg_304_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_304_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1084ui_story"].transform.position).z)
				arg_304_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1084ui_story"].transform.localEulerAngles = arg_304_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_307_1 = arg_304_1.actors_["1084ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_1) and arg_304_1.var_.characterEffect1084ui_story == nil then
				arg_304_1.var_.characterEffect1084ui_story = var_307_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_2 and not isNil(var_307_1) then
				if arg_304_1.var_.characterEffect1084ui_story and not isNil(var_307_1) then
					arg_304_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_2 and arg_304_1.time_ < 0 + var_307_2 + arg_307_0 and not isNil(var_307_1) and arg_304_1.var_.characterEffect1084ui_story then
				arg_304_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_307_4 = 0
			local var_307_5 = 0.325

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_6 = arg_304_1:GetWordFromCfg(1108410074)
				local var_307_7 = arg_304_1:FormatText(var_307_6.content)

				arg_304_1.text_.text = var_307_7

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_9 = 13 <= 0 and var_307_5 or var_307_5 * (utf8.len(var_307_7) / 13)

				if (13 <= 0 and var_307_5 or var_307_5 * (utf8.len(var_307_7) / 13)) > 0 and var_307_5 < var_307_9 then
					arg_304_1.talkMaxDuration = var_307_9

					if var_307_9 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_9 + var_307_4
					end
				end

				arg_304_1.text_.text = var_307_7
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410074", "story_v_side_new_1108410.awb") ~= 0 then
					local var_307_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410074", "story_v_side_new_1108410.awb") / 1000

					if var_307_10 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_10 + var_307_4
					end

					if var_307_6.prefab_name ~= "" and arg_304_1.actors_[var_307_6.prefab_name] ~= nil then
						local var_307_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_6.prefab_name].transform, "story_v_side_new_1108410", "1108410074", "story_v_side_new_1108410.awb")

						arg_304_1:RecordAudio("1108410074", var_307_11)
						arg_304_1:RecordAudio("1108410074", var_307_11)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410074", "story_v_side_new_1108410.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410074", "story_v_side_new_1108410.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_12 = math.max(var_307_5, arg_304_1.talkMaxDuration)

			if var_307_4 <= arg_304_1.time_ and arg_304_1.time_ < var_307_4 + var_307_12 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_4) / var_307_12

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_4 + var_307_12 and arg_304_1.time_ < var_307_4 + var_307_12 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
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

		arg_304_1:InitPlayNodeList()
	end,
	Play1108410075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1108410075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1108410076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["1084ui_story"]) and arg_308_1.var_.characterEffect1084ui_story == nil then
				arg_308_1.var_.characterEffect1084ui_story = arg_308_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["1084ui_story"]) then
				if arg_308_1.var_.characterEffect1084ui_story and not isNil(arg_308_1.actors_["1084ui_story"]) then
					arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_0)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["1084ui_story"]) and arg_308_1.var_.characterEffect1084ui_story then
				arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_311_1 = 0
			local var_311_2 = 0.475

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_3 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(1108410075).content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 19 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 19)

				if (19 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 19)) > 0 and var_311_2 < var_311_5 then
					arg_308_1.talkMaxDuration = var_311_5

					if var_311_5 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + var_311_1
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_6 = math.max(var_311_2, arg_308_1.talkMaxDuration)

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_6 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_1) / var_311_6

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_1 + var_311_6 and arg_308_1.time_ < var_311_1 + var_311_6 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1108410076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1108410076
		arg_312_1.duration_ = 2

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1108410077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1084ui_story"]) and arg_312_1.var_.characterEffect1084ui_story == nil then
				arg_312_1.var_.characterEffect1084ui_story = arg_312_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_0 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1084ui_story"]) then
				if arg_312_1.var_.characterEffect1084ui_story and not isNil(arg_312_1.actors_["1084ui_story"]) then
					arg_312_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1084ui_story"]) and arg_312_1.var_.characterEffect1084ui_story then
				arg_312_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_315_2 = 0
			local var_315_3 = 0.2

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_2 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_4 = arg_312_1:GetWordFromCfg(1108410076)
				local var_315_5 = arg_312_1:FormatText(var_315_4.content)

				arg_312_1.text_.text = var_315_5

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_7 = 8 <= 0 and var_315_3 or var_315_3 * (utf8.len(var_315_5) / 8)

				if (8 <= 0 and var_315_3 or var_315_3 * (utf8.len(var_315_5) / 8)) > 0 and var_315_3 < var_315_7 then
					arg_312_1.talkMaxDuration = var_315_7

					if var_315_7 + var_315_2 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_2
					end
				end

				arg_312_1.text_.text = var_315_5
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410076", "story_v_side_new_1108410.awb") ~= 0 then
					local var_315_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410076", "story_v_side_new_1108410.awb") / 1000

					if var_315_8 + var_315_2 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_8 + var_315_2
					end

					if var_315_4.prefab_name ~= "" and arg_312_1.actors_[var_315_4.prefab_name] ~= nil then
						local var_315_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_4.prefab_name].transform, "story_v_side_new_1108410", "1108410076", "story_v_side_new_1108410.awb")

						arg_312_1:RecordAudio("1108410076", var_315_9)
						arg_312_1:RecordAudio("1108410076", var_315_9)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410076", "story_v_side_new_1108410.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410076", "story_v_side_new_1108410.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_10 = math.max(var_315_3, arg_312_1.talkMaxDuration)

			if var_315_2 <= arg_312_1.time_ and arg_312_1.time_ < var_315_2 + var_315_10 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_2) / var_315_10

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_2 + var_315_10 and arg_312_1.time_ < var_315_2 + var_315_10 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play1108410077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1108410077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1108410078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["1084ui_story"]) and arg_316_1.var_.characterEffect1084ui_story == nil then
				arg_316_1.var_.characterEffect1084ui_story = arg_316_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["1084ui_story"]) then
				if arg_316_1.var_.characterEffect1084ui_story and not isNil(arg_316_1.actors_["1084ui_story"]) then
					arg_316_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_0)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["1084ui_story"]) and arg_316_1.var_.characterEffect1084ui_story then
				arg_316_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_319_1 = 0
			local var_319_2 = 0.175

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(1108410077).content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 7 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 7)

				if (7 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 7)) > 0 and var_319_2 < var_319_5 then
					arg_316_1.talkMaxDuration = var_319_5

					if var_319_5 + var_319_1 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + var_319_1
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_6 = math.max(var_319_2, arg_316_1.talkMaxDuration)

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_6 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_1) / var_319_6

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_1 + var_319_6 and arg_316_1.time_ < var_319_1 + var_319_6 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1108410078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1108410078
		arg_320_1.duration_ = 7.3

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1108410079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_0 = 2

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 then
				local var_323_1 = Color.New(0, 0, 0)

				var_323_1.a = Mathf.Lerp(0, 1, (arg_320_1.time_ - 0) / var_323_0)
				arg_320_1.mask_.color = var_323_1
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 then
				local var_323_2 = Color.New(0, 0, 0)

				var_323_2.a = 1
				arg_320_1.mask_.color = var_323_2
			end

			local var_323_3 = 2

			if 2 < arg_320_1.time_ and arg_320_1.time_ <= var_323_3 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_4 = 2

			if var_323_3 <= arg_320_1.time_ and arg_320_1.time_ < var_323_3 + var_323_4 then
				local var_323_5 = Color.New(0, 0, 0)

				var_323_5.a = Mathf.Lerp(1, 0, (arg_320_1.time_ - var_323_3) / var_323_4)
				arg_320_1.mask_.color = var_323_5
			end

			if arg_320_1.time_ >= var_323_3 + var_323_4 and arg_320_1.time_ < var_323_3 + var_323_4 + arg_323_0 then
				local var_323_6 = Color.New(0, 0, 0)

				arg_320_1.mask_.enabled = false
				var_323_6.a = 0
				arg_320_1.mask_.color = var_323_6
			end

			local var_323_7 = arg_320_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_320_1.time_ and arg_320_1.time_ <= 1.96599999815226 + arg_323_0 then
				arg_320_1.var_.moveOldPos1084ui_story = var_323_7.localPosition
			end

			local var_323_8 = 0.001

			if 1.96599999815226 <= arg_320_1.time_ and arg_320_1.time_ < 1.96599999815226 + var_323_8 then
				var_323_7.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_320_1.time_ - 1.96599999815226) / var_323_8)
				var_323_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_323_7.position).x, (manager.ui.mainCamera.transform.position - var_323_7.position).y, (manager.ui.mainCamera.transform.position - var_323_7.position).z)
				var_323_7.localEulerAngles.z = 0
				var_323_7.localEulerAngles.x = 0
				var_323_7.localEulerAngles = var_323_7.localEulerAngles
			end

			if arg_320_1.time_ >= 1.96599999815226 + var_323_8 and arg_320_1.time_ < 1.96599999815226 + var_323_8 + arg_323_0 then
				var_323_7.localPosition = Vector3.New(0, 100, 0)
				var_323_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_323_7.position).x, (manager.ui.mainCamera.transform.position - var_323_7.position).y, (manager.ui.mainCamera.transform.position - var_323_7.position).z)
				var_323_7.localEulerAngles.z = 0
				var_323_7.localEulerAngles.x = 0
				var_323_7.localEulerAngles = var_323_7.localEulerAngles
			end

			if arg_320_1.frameCnt_ <= 1 then
				arg_320_1.dialog_:SetActive(false)
			end

			local var_323_9 = 3.999999999999
			local var_323_10 = 0.525

			if 3.999999999999 < arg_320_1.time_ and arg_320_1.time_ <= var_323_9 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_11 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_11:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_4")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_12 = arg_320_1:GetWordFromCfg(1108410078)
				local var_323_13 = arg_320_1:FormatText(var_323_12.content)

				arg_320_1.text_.text = var_323_13

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_15 = 21 <= 0 and var_323_10 or var_323_10 * (utf8.len(var_323_13) / 21)

				if (21 <= 0 and var_323_10 or var_323_10 * (utf8.len(var_323_13) / 21)) > 0 and var_323_10 < var_323_15 then
					arg_320_1.talkMaxDuration = var_323_15
					var_323_9 = var_323_9 + 0.3

					if var_323_15 + var_323_9 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_15 + var_323_9
					end
				end

				arg_320_1.text_.text = var_323_13
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410078", "story_v_side_new_1108410.awb") ~= 0 then
					local var_323_16 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410078", "story_v_side_new_1108410.awb") / 1000

					if var_323_16 + var_323_9 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_16 + var_323_9
					end

					if var_323_12.prefab_name ~= "" and arg_320_1.actors_[var_323_12.prefab_name] ~= nil then
						local var_323_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_12.prefab_name].transform, "story_v_side_new_1108410", "1108410078", "story_v_side_new_1108410.awb")

						arg_320_1:RecordAudio("1108410078", var_323_17)
						arg_320_1:RecordAudio("1108410078", var_323_17)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410078", "story_v_side_new_1108410.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410078", "story_v_side_new_1108410.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_18 = var_323_9 + 0.3
			local var_323_19 = math.max(var_323_10, arg_320_1.talkMaxDuration)

			if var_323_9 + 0.3 <= arg_320_1.time_ and arg_320_1.time_ < var_323_18 + var_323_19 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_18) / var_323_19

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_18 + var_323_19 and arg_320_1.time_ < var_323_18 + var_323_19 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
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

		arg_320_1:InitPlayNodeList()
	end,
	Play1108410079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1108410079
		arg_326_1.duration_ = 3.7

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1108410080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.3

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_1 = arg_326_1:GetWordFromCfg(1108410079)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 12 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 12)

				if (12 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 12)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410079", "story_v_side_new_1108410.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410079", "story_v_side_new_1108410.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_side_new_1108410", "1108410079", "story_v_side_new_1108410.awb")

						arg_326_1:RecordAudio("1108410079", var_329_6)
						arg_326_1:RecordAudio("1108410079", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410079", "story_v_side_new_1108410.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410079", "story_v_side_new_1108410.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1108410080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1108410080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1108410081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1084ui_story"]) and arg_330_1.var_.characterEffect1084ui_story == nil then
				arg_330_1.var_.characterEffect1084ui_story = arg_330_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1084ui_story"]) then
				if arg_330_1.var_.characterEffect1084ui_story and not isNil(arg_330_1.actors_["1084ui_story"]) then
					arg_330_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1084ui_story"]) and arg_330_1.var_.characterEffect1084ui_story then
				arg_330_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_333_1 = 0
			local var_333_2 = 0.85

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(1108410080).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 34 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 34)

				if (34 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 34)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1108410081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1108410081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1108410082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1084ui_story = arg_334_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_337_0 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 then
				arg_334_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_334_1.time_ - 0) / var_337_0)
				arg_334_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).z)
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles = arg_334_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 then
				arg_334_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).z)
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles = arg_334_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_337_1 = 0
			local var_337_2 = 0.75

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_3 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(1108410081).content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 30 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 30)

				if (30 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 30)) > 0 and var_337_2 < var_337_5 then
					arg_334_1.talkMaxDuration = var_337_5

					if var_337_5 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + var_337_1
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_6 = math.max(var_337_2, arg_334_1.talkMaxDuration)

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_6 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_1) / var_337_6

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_1 + var_337_6 and arg_334_1.time_ < var_337_1 + var_337_6 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
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

		arg_334_1:InitPlayNodeList()
	end,
	Play1108410082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1108410082
		arg_338_1.duration_ = 2.43

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1108410083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if arg_338_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_341_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_338_1.stage_.transform)

				var_341_0.name = "10102ui_story"
				var_341_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_338_1.actors_["10102ui_story"] = var_341_0

				local var_341_1 = var_341_0:GetComponentInChildren(typeof(CharacterEffect))

				var_341_1.enabled = true

				local var_341_2 = GameObjectTools.GetOrAddComponent(var_341_0, typeof(DynamicBoneHelper))

				if var_341_2 then
					var_341_2:EnableDynamicBone(false)
				end

				arg_338_1:ShowWeapon(var_341_1.transform, false)

				arg_338_1.var_["10102ui_story" .. "Animator"] = var_341_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_338_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_338_1.var_["10102ui_story" .. "LipSync"] = var_341_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_341_3 = arg_338_1.actors_["10102ui_story"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos10102ui_story = var_341_3.localPosition
			end

			local var_341_4 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				var_341_3.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_338_1.time_ - 0) / var_341_4)
				var_341_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_3.position).x, (manager.ui.mainCamera.transform.position - var_341_3.position).y, (manager.ui.mainCamera.transform.position - var_341_3.position).z)
				var_341_3.localEulerAngles.z = 0
				var_341_3.localEulerAngles.x = 0
				var_341_3.localEulerAngles = var_341_3.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				var_341_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_341_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_3.position).x, (manager.ui.mainCamera.transform.position - var_341_3.position).y, (manager.ui.mainCamera.transform.position - var_341_3.position).z)
				var_341_3.localEulerAngles.z = 0
				var_341_3.localEulerAngles.x = 0
				var_341_3.localEulerAngles = var_341_3.localEulerAngles
			end

			local var_341_5 = arg_338_1.actors_["10102ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_5) and arg_338_1.var_.characterEffect10102ui_story == nil then
				arg_338_1.var_.characterEffect10102ui_story = var_341_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_6 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_6 and not isNil(var_341_5) then
				if arg_338_1.var_.characterEffect10102ui_story and not isNil(var_341_5) then
					arg_338_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_6 and arg_338_1.time_ < 0 + var_341_6 + arg_341_0 and not isNil(var_341_5) and arg_338_1.var_.characterEffect10102ui_story then
				arg_338_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_341_8 = 0
			local var_341_9 = 0.2

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_8 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_10 = arg_338_1:GetWordFromCfg(1108410082)
				local var_341_11 = arg_338_1:FormatText(var_341_10.content)

				arg_338_1.text_.text = var_341_11

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_13 = 8 <= 0 and var_341_9 or var_341_9 * (utf8.len(var_341_11) / 8)

				if (8 <= 0 and var_341_9 or var_341_9 * (utf8.len(var_341_11) / 8)) > 0 and var_341_9 < var_341_13 then
					arg_338_1.talkMaxDuration = var_341_13

					if var_341_13 + var_341_8 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_13 + var_341_8
					end
				end

				arg_338_1.text_.text = var_341_11
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410082", "story_v_side_new_1108410.awb") ~= 0 then
					local var_341_14 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410082", "story_v_side_new_1108410.awb") / 1000

					if var_341_14 + var_341_8 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_14 + var_341_8
					end

					if var_341_10.prefab_name ~= "" and arg_338_1.actors_[var_341_10.prefab_name] ~= nil then
						local var_341_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_10.prefab_name].transform, "story_v_side_new_1108410", "1108410082", "story_v_side_new_1108410.awb")

						arg_338_1:RecordAudio("1108410082", var_341_15)
						arg_338_1:RecordAudio("1108410082", var_341_15)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410082", "story_v_side_new_1108410.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410082", "story_v_side_new_1108410.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_16 = math.max(var_341_9, arg_338_1.talkMaxDuration)

			if var_341_8 <= arg_338_1.time_ and arg_338_1.time_ < var_341_8 + var_341_16 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_8) / var_341_16

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_8 + var_341_16 and arg_338_1.time_ < var_341_8 + var_341_16 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
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

		arg_338_1:InitPlayNodeList()
	end,
	Play1108410083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1108410083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1108410084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos10102ui_story = arg_342_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_345_0 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 then
				arg_342_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_342_1.time_ - 0) / var_345_0)
				arg_342_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["10102ui_story"].transform.position).z)
				arg_342_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["10102ui_story"].transform.localEulerAngles = arg_342_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 then
				arg_342_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_342_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["10102ui_story"].transform.position).z)
				arg_342_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["10102ui_story"].transform.localEulerAngles = arg_342_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_345_1 = arg_342_1.actors_["10102ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_1) and arg_342_1.var_.characterEffect10102ui_story == nil then
				arg_342_1.var_.characterEffect10102ui_story = var_345_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_2 and not isNil(var_345_1) then
				if arg_342_1.var_.characterEffect10102ui_story and not isNil(var_345_1) then
					arg_342_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_342_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_2)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_2 and arg_342_1.time_ < 0 + var_345_2 + arg_345_0 and not isNil(var_345_1) and arg_342_1.var_.characterEffect10102ui_story then
				arg_342_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_342_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_345_3 = 0
			local var_345_4 = 0.7

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_3 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_5 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(1108410083).content)

				arg_342_1.text_.text = var_345_5

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_7 = 28 <= 0 and var_345_4 or var_345_4 * (utf8.len(var_345_5) / 28)

				if (28 <= 0 and var_345_4 or var_345_4 * (utf8.len(var_345_5) / 28)) > 0 and var_345_4 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_3 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_3
					end
				end

				arg_342_1.text_.text = var_345_5
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_8 = math.max(var_345_4, arg_342_1.talkMaxDuration)

			if var_345_3 <= arg_342_1.time_ and arg_342_1.time_ < var_345_3 + var_345_8 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_3) / var_345_8

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_3 + var_345_8 and arg_342_1.time_ < var_345_3 + var_345_8 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
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

		arg_342_1:InitPlayNodeList()
	end,
	Play1108410084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1108410084
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1108410085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0.075

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_1 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(1108410084).content)

				arg_346_1.text_.text = var_349_1

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_3 = 3 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 3)

				if (3 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 3)) > 0 and var_349_0 < var_349_3 then
					arg_346_1.talkMaxDuration = var_349_3

					if var_349_3 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_3 + 0
					end
				end

				arg_346_1.text_.text = var_349_1
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_4 = math.max(var_349_0, arg_346_1.talkMaxDuration)

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - 0) / var_349_4

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1108410085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1108410085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1108410086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 1.75

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_1 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(1108410085).content)

				arg_350_1.text_.text = var_353_1

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_3 = 70 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 70)

				if (70 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 70)) > 0 and var_353_0 < var_353_3 then
					arg_350_1.talkMaxDuration = var_353_3

					if var_353_3 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_3 + 0
					end
				end

				arg_350_1.text_.text = var_353_1
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_4 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_4

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play1108410086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1108410086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1108410087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 1.275

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_1 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(1108410086).content)

				arg_354_1.text_.text = var_357_1

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_3 = 51 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 51)

				if (51 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 51)) > 0 and var_357_0 < var_357_3 then
					arg_354_1.talkMaxDuration = var_357_3

					if var_357_3 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_3 + 0
					end
				end

				arg_354_1.text_.text = var_357_1
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_4 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_4

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1108410087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1108410087
		arg_358_1.duration_ = 9.87

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1108410088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos10102ui_story = arg_358_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_361_0 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 then
				arg_358_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_358_1.time_ - 0) / var_361_0)
				arg_358_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["10102ui_story"].transform.position).z)
				arg_358_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["10102ui_story"].transform.localEulerAngles = arg_358_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 then
				arg_358_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_358_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["10102ui_story"].transform.position).z)
				arg_358_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["10102ui_story"].transform.localEulerAngles = arg_358_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_361_1 = arg_358_1.actors_["10102ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect10102ui_story == nil then
				arg_358_1.var_.characterEffect10102ui_story = var_361_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_2 and not isNil(var_361_1) then
				if arg_358_1.var_.characterEffect10102ui_story and not isNil(var_361_1) then
					arg_358_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_2 and arg_358_1.time_ < 0 + var_361_2 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect10102ui_story then
				arg_358_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_361_4 = 0
			local var_361_5 = 0.975

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_6 = arg_358_1:GetWordFromCfg(1108410087)
				local var_361_7 = arg_358_1:FormatText(var_361_6.content)

				arg_358_1.text_.text = var_361_7

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 39 <= 0 and var_361_5 or var_361_5 * (utf8.len(var_361_7) / 39)

				if (39 <= 0 and var_361_5 or var_361_5 * (utf8.len(var_361_7) / 39)) > 0 and var_361_5 < var_361_9 then
					arg_358_1.talkMaxDuration = var_361_9

					if var_361_9 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_9 + var_361_4
					end
				end

				arg_358_1.text_.text = var_361_7
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410087", "story_v_side_new_1108410.awb") ~= 0 then
					local var_361_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410087", "story_v_side_new_1108410.awb") / 1000

					if var_361_10 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_10 + var_361_4
					end

					if var_361_6.prefab_name ~= "" and arg_358_1.actors_[var_361_6.prefab_name] ~= nil then
						local var_361_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_6.prefab_name].transform, "story_v_side_new_1108410", "1108410087", "story_v_side_new_1108410.awb")

						arg_358_1:RecordAudio("1108410087", var_361_11)
						arg_358_1:RecordAudio("1108410087", var_361_11)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410087", "story_v_side_new_1108410.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410087", "story_v_side_new_1108410.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_12 = math.max(var_361_5, arg_358_1.talkMaxDuration)

			if var_361_4 <= arg_358_1.time_ and arg_358_1.time_ < var_361_4 + var_361_12 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_4) / var_361_12

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_4 + var_361_12 and arg_358_1.time_ < var_361_4 + var_361_12 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
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

		arg_358_1:InitPlayNodeList()
	end,
	Play1108410088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1108410088
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1108410089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["10102ui_story"]) and arg_362_1.var_.characterEffect10102ui_story == nil then
				arg_362_1.var_.characterEffect10102ui_story = arg_362_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["10102ui_story"]) then
				if arg_362_1.var_.characterEffect10102ui_story and not isNil(arg_362_1.actors_["10102ui_story"]) then
					arg_362_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_362_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_0)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["10102ui_story"]) and arg_362_1.var_.characterEffect10102ui_story then
				arg_362_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_362_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_365_1 = 0
			local var_365_2 = 0.575

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(1108410088).content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 23 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 23)

				if (23 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 23)) > 0 and var_365_2 < var_365_5 then
					arg_362_1.talkMaxDuration = var_365_5

					if var_365_5 + var_365_1 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + var_365_1
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_6 = math.max(var_365_2, arg_362_1.talkMaxDuration)

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_6 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_1) / var_365_6

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_1 + var_365_6 and arg_362_1.time_ < var_365_1 + var_365_6 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1108410089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1108410089
		arg_366_1.duration_ = 7.5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1108410090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["10102ui_story"]) and arg_366_1.var_.characterEffect10102ui_story == nil then
				arg_366_1.var_.characterEffect10102ui_story = arg_366_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["10102ui_story"]) then
				if arg_366_1.var_.characterEffect10102ui_story and not isNil(arg_366_1.actors_["10102ui_story"]) then
					arg_366_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["10102ui_story"]) and arg_366_1.var_.characterEffect10102ui_story then
				arg_366_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action10_1")
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_369_2 = 0
			local var_369_3 = 0.9

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_2 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_4 = arg_366_1:GetWordFromCfg(1108410089)
				local var_369_5 = arg_366_1:FormatText(var_369_4.content)

				arg_366_1.text_.text = var_369_5

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_7 = 36 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 36)

				if (36 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 36)) > 0 and var_369_3 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_2
					end
				end

				arg_366_1.text_.text = var_369_5
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410089", "story_v_side_new_1108410.awb") ~= 0 then
					local var_369_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410089", "story_v_side_new_1108410.awb") / 1000

					if var_369_8 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_2
					end

					if var_369_4.prefab_name ~= "" and arg_366_1.actors_[var_369_4.prefab_name] ~= nil then
						local var_369_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_4.prefab_name].transform, "story_v_side_new_1108410", "1108410089", "story_v_side_new_1108410.awb")

						arg_366_1:RecordAudio("1108410089", var_369_9)
						arg_366_1:RecordAudio("1108410089", var_369_9)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410089", "story_v_side_new_1108410.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410089", "story_v_side_new_1108410.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_10 = math.max(var_369_3, arg_366_1.talkMaxDuration)

			if var_369_2 <= arg_366_1.time_ and arg_366_1.time_ < var_369_2 + var_369_10 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_2) / var_369_10

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_2 + var_369_10 and arg_366_1.time_ < var_369_2 + var_369_10 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1108410090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1108410090
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1108410091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["10102ui_story"]) and arg_370_1.var_.characterEffect10102ui_story == nil then
				arg_370_1.var_.characterEffect10102ui_story = arg_370_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["10102ui_story"]) then
				if arg_370_1.var_.characterEffect10102ui_story and not isNil(arg_370_1.actors_["10102ui_story"]) then
					arg_370_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_370_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_0)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["10102ui_story"]) and arg_370_1.var_.characterEffect10102ui_story then
				arg_370_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_370_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_373_1 = 0
			local var_373_2 = 0.5

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
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

				local var_373_3 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(1108410090).content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 20 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 20)

				if (20 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 20)) > 0 and var_373_2 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_6 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_6 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_6

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_6 and arg_370_1.time_ < var_373_1 + var_373_6 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1108410091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1108410091
		arg_374_1.duration_ = 4.07

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1108410092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["10102ui_story"]) and arg_374_1.var_.characterEffect10102ui_story == nil then
				arg_374_1.var_.characterEffect10102ui_story = arg_374_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_0 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["10102ui_story"]) then
				if arg_374_1.var_.characterEffect10102ui_story and not isNil(arg_374_1.actors_["10102ui_story"]) then
					arg_374_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["10102ui_story"]) and arg_374_1.var_.characterEffect10102ui_story then
				arg_374_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action4107")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_377_2 = 0
			local var_377_3 = 0.35

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_2 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_4 = arg_374_1:GetWordFromCfg(1108410091)
				local var_377_5 = arg_374_1:FormatText(var_377_4.content)

				arg_374_1.text_.text = var_377_5

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_7 = 14 <= 0 and var_377_3 or var_377_3 * (utf8.len(var_377_5) / 14)

				if (14 <= 0 and var_377_3 or var_377_3 * (utf8.len(var_377_5) / 14)) > 0 and var_377_3 < var_377_7 then
					arg_374_1.talkMaxDuration = var_377_7

					if var_377_7 + var_377_2 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_2
					end
				end

				arg_374_1.text_.text = var_377_5
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410091", "story_v_side_new_1108410.awb") ~= 0 then
					local var_377_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410091", "story_v_side_new_1108410.awb") / 1000

					if var_377_8 + var_377_2 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_8 + var_377_2
					end

					if var_377_4.prefab_name ~= "" and arg_374_1.actors_[var_377_4.prefab_name] ~= nil then
						local var_377_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_4.prefab_name].transform, "story_v_side_new_1108410", "1108410091", "story_v_side_new_1108410.awb")

						arg_374_1:RecordAudio("1108410091", var_377_9)
						arg_374_1:RecordAudio("1108410091", var_377_9)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410091", "story_v_side_new_1108410.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410091", "story_v_side_new_1108410.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_10 = math.max(var_377_3, arg_374_1.talkMaxDuration)

			if var_377_2 <= arg_374_1.time_ and arg_374_1.time_ < var_377_2 + var_377_10 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_2) / var_377_10

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_2 + var_377_10 and arg_374_1.time_ < var_377_2 + var_377_10 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1108410092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1108410092
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1108410093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["10102ui_story"]) and arg_378_1.var_.characterEffect10102ui_story == nil then
				arg_378_1.var_.characterEffect10102ui_story = arg_378_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["10102ui_story"]) then
				if arg_378_1.var_.characterEffect10102ui_story and not isNil(arg_378_1.actors_["10102ui_story"]) then
					arg_378_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_378_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_0)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["10102ui_story"]) and arg_378_1.var_.characterEffect10102ui_story then
				arg_378_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_378_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_381_1 = 0
			local var_381_2 = 0.175

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_3 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(1108410092).content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 7 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 7)

				if (7 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 7)) > 0 and var_381_2 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_1
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_6 = math.max(var_381_2, arg_378_1.talkMaxDuration)

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_6 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_1) / var_381_6

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_1 + var_381_6 and arg_378_1.time_ < var_381_1 + var_381_6 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1108410093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1108410093
		arg_382_1.duration_ = 1

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"

			SetActive(arg_382_1.choicesGo_, true)

			for iter_383_0, iter_383_1 in ipairs(arg_382_1.choices_) do
				SetActive(iter_383_1.go, iter_383_0 <= 3)
			end

			arg_382_1.choices_[1].txt.text = arg_382_1:FormatText(StoryChoiceCfg[1701].name)
			arg_382_1.choices_[2].txt.text = arg_382_1:FormatText(StoryChoiceCfg[1702].name)
			arg_382_1.choices_[3].txt.text = arg_382_1:FormatText(StoryChoiceCfg[1703].name)
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1108410094(arg_382_1)
			end

			if arg_384_0 == 2 then
				arg_382_0:Play1108410094(arg_382_1)
			end

			if arg_384_0 == 3 then
				arg_382_0:Play1108410094(arg_382_1)
			end

			arg_382_1:RecordChoiceLog(1108410093, 1701, 1702, 1703)
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.allBtn_.enabled = false
			end

			if arg_382_1.time_ >= 0 + 0.6 and arg_382_1.time_ < 0 + 0.6 + arg_385_0 then
				arg_382_1.allBtn_.enabled = true
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1108410094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1108410094
		arg_386_1.duration_ = 4.83

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1108410095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["10102ui_story"]) and arg_386_1.var_.characterEffect10102ui_story == nil then
				arg_386_1.var_.characterEffect10102ui_story = arg_386_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["10102ui_story"]) then
				if arg_386_1.var_.characterEffect10102ui_story and not isNil(arg_386_1.actors_["10102ui_story"]) then
					arg_386_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["10102ui_story"]) and arg_386_1.var_.characterEffect10102ui_story then
				arg_386_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_389_2 = "10102ui_story"

			if arg_386_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_389_3 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_386_1.stage_.transform)

				var_389_3.name = var_389_2
				var_389_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_386_1.actors_[var_389_2] = var_389_3

				local var_389_4 = var_389_3:GetComponentInChildren(typeof(CharacterEffect))

				var_389_4.enabled = true

				local var_389_5 = GameObjectTools.GetOrAddComponent(var_389_3, typeof(DynamicBoneHelper))

				if var_389_5 then
					var_389_5:EnableDynamicBone(false)
				end

				arg_386_1:ShowWeapon(var_389_4.transform, false)

				arg_386_1.var_[var_389_2 .. "Animator"] = var_389_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_386_1.var_[var_389_2 .. "Animator"].applyRootMotion = true
				arg_386_1.var_[var_389_2 .. "LipSync"] = var_389_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action479")
			end

			local var_389_6 = "10102ui_story"

			if arg_386_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_389_7 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_386_1.stage_.transform)

				var_389_7.name = var_389_6
				var_389_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_386_1.actors_[var_389_6] = var_389_7

				local var_389_8 = var_389_7:GetComponentInChildren(typeof(CharacterEffect))

				var_389_8.enabled = true

				local var_389_9 = GameObjectTools.GetOrAddComponent(var_389_7, typeof(DynamicBoneHelper))

				if var_389_9 then
					var_389_9:EnableDynamicBone(false)
				end

				arg_386_1:ShowWeapon(var_389_8.transform, false)

				arg_386_1.var_[var_389_6 .. "Animator"] = var_389_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_386_1.var_[var_389_6 .. "Animator"].applyRootMotion = true
				arg_386_1.var_[var_389_6 .. "LipSync"] = var_389_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_389_10 = 0
			local var_389_11 = 0.475

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_10 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_12 = arg_386_1:GetWordFromCfg(1108410094)
				local var_389_13 = arg_386_1:FormatText(var_389_12.content)

				arg_386_1.text_.text = var_389_13

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_15 = 19 <= 0 and var_389_11 or var_389_11 * (utf8.len(var_389_13) / 19)

				if (19 <= 0 and var_389_11 or var_389_11 * (utf8.len(var_389_13) / 19)) > 0 and var_389_11 < var_389_15 then
					arg_386_1.talkMaxDuration = var_389_15

					if var_389_15 + var_389_10 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_15 + var_389_10
					end
				end

				arg_386_1.text_.text = var_389_13
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410094", "story_v_side_new_1108410.awb") ~= 0 then
					local var_389_16 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410094", "story_v_side_new_1108410.awb") / 1000

					if var_389_16 + var_389_10 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_16 + var_389_10
					end

					if var_389_12.prefab_name ~= "" and arg_386_1.actors_[var_389_12.prefab_name] ~= nil then
						local var_389_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_12.prefab_name].transform, "story_v_side_new_1108410", "1108410094", "story_v_side_new_1108410.awb")

						arg_386_1:RecordAudio("1108410094", var_389_17)
						arg_386_1:RecordAudio("1108410094", var_389_17)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410094", "story_v_side_new_1108410.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410094", "story_v_side_new_1108410.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_18 = math.max(var_389_11, arg_386_1.talkMaxDuration)

			if var_389_10 <= arg_386_1.time_ and arg_386_1.time_ < var_389_10 + var_389_18 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_10) / var_389_18

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_10 + var_389_18 and arg_386_1.time_ < var_389_10 + var_389_18 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1108410095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1108410095
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1108410096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["10102ui_story"]) and arg_390_1.var_.characterEffect10102ui_story == nil then
				arg_390_1.var_.characterEffect10102ui_story = arg_390_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_0 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["10102ui_story"]) then
				if arg_390_1.var_.characterEffect10102ui_story and not isNil(arg_390_1.actors_["10102ui_story"]) then
					arg_390_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_390_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_390_1.time_ - 0) / var_393_0)
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["10102ui_story"]) and arg_390_1.var_.characterEffect10102ui_story then
				arg_390_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_390_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_393_1 = 0
			local var_393_2 = 0.825

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_3 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(1108410095).content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 33 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_3) / 33)

				if (33 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_3) / 33)) > 0 and var_393_2 < var_393_5 then
					arg_390_1.talkMaxDuration = var_393_5

					if var_393_5 + var_393_1 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + var_393_1
					end
				end

				arg_390_1.text_.text = var_393_3
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_6 = math.max(var_393_2, arg_390_1.talkMaxDuration)

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_6 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_1) / var_393_6

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_1 + var_393_6 and arg_390_1.time_ < var_393_1 + var_393_6 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1108410096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1108410096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1108410097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.15

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(1108410096).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 6 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 6)

				if (6 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 6)) > 0 and var_397_0 < var_397_3 then
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
	Play1108410097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1108410097
		arg_398_1.duration_ = 4.3

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1108410098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["10102ui_story"]) and arg_398_1.var_.characterEffect10102ui_story == nil then
				arg_398_1.var_.characterEffect10102ui_story = arg_398_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_0 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["10102ui_story"]) then
				if arg_398_1.var_.characterEffect10102ui_story and not isNil(arg_398_1.actors_["10102ui_story"]) then
					arg_398_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["10102ui_story"]) and arg_398_1.var_.characterEffect10102ui_story then
				arg_398_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action9_2")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_401_2 = 0
			local var_401_3 = 0.35

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_2 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_4 = arg_398_1:GetWordFromCfg(1108410097)
				local var_401_5 = arg_398_1:FormatText(var_401_4.content)

				arg_398_1.text_.text = var_401_5

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_7 = 14 <= 0 and var_401_3 or var_401_3 * (utf8.len(var_401_5) / 14)

				if (14 <= 0 and var_401_3 or var_401_3 * (utf8.len(var_401_5) / 14)) > 0 and var_401_3 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_2
					end
				end

				arg_398_1.text_.text = var_401_5
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410097", "story_v_side_new_1108410.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410097", "story_v_side_new_1108410.awb") / 1000

					if var_401_8 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_2
					end

					if var_401_4.prefab_name ~= "" and arg_398_1.actors_[var_401_4.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_4.prefab_name].transform, "story_v_side_new_1108410", "1108410097", "story_v_side_new_1108410.awb")

						arg_398_1:RecordAudio("1108410097", var_401_9)
						arg_398_1:RecordAudio("1108410097", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410097", "story_v_side_new_1108410.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410097", "story_v_side_new_1108410.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_3, arg_398_1.talkMaxDuration)

			if var_401_2 <= arg_398_1.time_ and arg_398_1.time_ < var_401_2 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_2) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_2 + var_401_10 and arg_398_1.time_ < var_401_2 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1108410098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1108410098
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1108410099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["10102ui_story"]) and arg_402_1.var_.characterEffect10102ui_story == nil then
				arg_402_1.var_.characterEffect10102ui_story = arg_402_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_0 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["10102ui_story"]) then
				if arg_402_1.var_.characterEffect10102ui_story and not isNil(arg_402_1.actors_["10102ui_story"]) then
					arg_402_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_402_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_402_1.time_ - 0) / var_405_0)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["10102ui_story"]) and arg_402_1.var_.characterEffect10102ui_story then
				arg_402_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_402_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_405_1 = 0
			local var_405_2 = 0.725

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(1108410098).content)

				arg_402_1.text_.text = var_405_3

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 29 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_3) / 29)

				if (29 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_3) / 29)) > 0 and var_405_2 < var_405_5 then
					arg_402_1.talkMaxDuration = var_405_5

					if var_405_5 + var_405_1 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + var_405_1
					end
				end

				arg_402_1.text_.text = var_405_3
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_6 = math.max(var_405_2, arg_402_1.talkMaxDuration)

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_6 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_1) / var_405_6

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_1 + var_405_6 and arg_402_1.time_ < var_405_1 + var_405_6 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1108410099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1108410099
		arg_406_1.duration_ = 5.67

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1108410100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["10102ui_story"]) and arg_406_1.var_.characterEffect10102ui_story == nil then
				arg_406_1.var_.characterEffect10102ui_story = arg_406_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["10102ui_story"]) then
				if arg_406_1.var_.characterEffect10102ui_story and not isNil(arg_406_1.actors_["10102ui_story"]) then
					arg_406_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["10102ui_story"]) and arg_406_1.var_.characterEffect10102ui_story then
				arg_406_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_409_2 = 0
			local var_409_3 = 0.8

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_2 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_4 = arg_406_1:GetWordFromCfg(1108410099)
				local var_409_5 = arg_406_1:FormatText(var_409_4.content)

				arg_406_1.text_.text = var_409_5

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_7 = 32 <= 0 and var_409_3 or var_409_3 * (utf8.len(var_409_5) / 32)

				if (32 <= 0 and var_409_3 or var_409_3 * (utf8.len(var_409_5) / 32)) > 0 and var_409_3 < var_409_7 then
					arg_406_1.talkMaxDuration = var_409_7

					if var_409_7 + var_409_2 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_2
					end
				end

				arg_406_1.text_.text = var_409_5
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410099", "story_v_side_new_1108410.awb") ~= 0 then
					local var_409_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410099", "story_v_side_new_1108410.awb") / 1000

					if var_409_8 + var_409_2 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_8 + var_409_2
					end

					if var_409_4.prefab_name ~= "" and arg_406_1.actors_[var_409_4.prefab_name] ~= nil then
						local var_409_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_4.prefab_name].transform, "story_v_side_new_1108410", "1108410099", "story_v_side_new_1108410.awb")

						arg_406_1:RecordAudio("1108410099", var_409_9)
						arg_406_1:RecordAudio("1108410099", var_409_9)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410099", "story_v_side_new_1108410.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410099", "story_v_side_new_1108410.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_10 = math.max(var_409_3, arg_406_1.talkMaxDuration)

			if var_409_2 <= arg_406_1.time_ and arg_406_1.time_ < var_409_2 + var_409_10 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_2) / var_409_10

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_2 + var_409_10 and arg_406_1.time_ < var_409_2 + var_409_10 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1108410100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1108410100
		arg_410_1.duration_ = 9

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1108410101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if arg_410_1.bgs_.ST03a == nil then
				local var_413_0 = Object.Instantiate(arg_410_1.paintGo_)

				var_413_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03a")
				var_413_0.name = "ST03a"
				var_413_0.transform.parent = arg_410_1.stage_.transform
				var_413_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_410_1.bgs_.ST03a = var_413_0
			end

			if 2 < arg_410_1.time_ and arg_410_1.time_ <= 2 + arg_413_0 then
				local var_413_1 = arg_410_1.bgs_.ST03a

				arg_410_1.bgs_.ST03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_413_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_413_2 = var_413_1:GetComponent("SpriteRenderer")

				if var_413_2 and var_413_2.sprite then
					local var_413_3 = 2 * (var_413_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_413_1.transform.localScale = Vector3.New(var_413_3 / var_413_2.sprite.bounds.size.y < var_413_3 * manager.ui.mainCameraCom_.aspect / var_413_2.sprite.bounds.size.x and var_413_3 * manager.ui.mainCameraCom_.aspect / var_413_2.sprite.bounds.size.x or var_413_3 / var_413_2.sprite.bounds.size.y, var_413_3 / var_413_2.sprite.bounds.size.y < var_413_3 * manager.ui.mainCameraCom_.aspect / var_413_2.sprite.bounds.size.x and var_413_3 * manager.ui.mainCameraCom_.aspect / var_413_2.sprite.bounds.size.x or var_413_3 / var_413_2.sprite.bounds.size.y, 0)
				end

				for iter_413_0, iter_413_1 in pairs(arg_410_1.bgs_) do
					if iter_413_0 ~= "ST03a" then
						iter_413_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_413_4 = 4

			if 4 < arg_410_1.time_ and arg_410_1.time_ <= var_413_4 + arg_413_0 then
				arg_410_1.allBtn_.enabled = false
			end

			if arg_410_1.time_ >= var_413_4 + 0.3 and arg_410_1.time_ < var_413_4 + 0.3 + arg_413_0 then
				arg_410_1.allBtn_.enabled = true
			end

			local var_413_5 = 0

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_5 + arg_413_0 then
				arg_410_1.mask_.enabled = true
				arg_410_1.mask_.raycastTarget = true

				arg_410_1:SetGaussion(false)
			end

			local var_413_6 = 2

			if var_413_5 <= arg_410_1.time_ and arg_410_1.time_ < var_413_5 + var_413_6 then
				local var_413_7 = Color.New(0, 0, 0)

				var_413_7.a = Mathf.Lerp(0, 1, (arg_410_1.time_ - var_413_5) / var_413_6)
				arg_410_1.mask_.color = var_413_7
			end

			if arg_410_1.time_ >= var_413_5 + var_413_6 and arg_410_1.time_ < var_413_5 + var_413_6 + arg_413_0 then
				local var_413_8 = Color.New(0, 0, 0)

				var_413_8.a = 1
				arg_410_1.mask_.color = var_413_8
			end

			local var_413_9 = 2

			if 2 < arg_410_1.time_ and arg_410_1.time_ <= var_413_9 + arg_413_0 then
				arg_410_1.mask_.enabled = true
				arg_410_1.mask_.raycastTarget = true

				arg_410_1:SetGaussion(false)
			end

			local var_413_10 = 2

			if var_413_9 <= arg_410_1.time_ and arg_410_1.time_ < var_413_9 + var_413_10 then
				local var_413_11 = Color.New(0, 0, 0)

				var_413_11.a = Mathf.Lerp(1, 0, (arg_410_1.time_ - var_413_9) / var_413_10)
				arg_410_1.mask_.color = var_413_11
			end

			if arg_410_1.time_ >= var_413_9 + var_413_10 and arg_410_1.time_ < var_413_9 + var_413_10 + arg_413_0 then
				local var_413_12 = Color.New(0, 0, 0)

				arg_410_1.mask_.enabled = false
				var_413_12.a = 0
				arg_410_1.mask_.color = var_413_12
			end

			local var_413_13 = arg_410_1.actors_["10102ui_story"].transform

			if 1.96599999815226 < arg_410_1.time_ and arg_410_1.time_ <= 1.96599999815226 + arg_413_0 then
				arg_410_1.var_.moveOldPos10102ui_story = var_413_13.localPosition
			end

			local var_413_14 = 0.001

			if 1.96599999815226 <= arg_410_1.time_ and arg_410_1.time_ < 1.96599999815226 + var_413_14 then
				var_413_13.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_410_1.time_ - 1.96599999815226) / var_413_14)
				var_413_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_413_13.position).x, (manager.ui.mainCamera.transform.position - var_413_13.position).y, (manager.ui.mainCamera.transform.position - var_413_13.position).z)
				var_413_13.localEulerAngles.z = 0
				var_413_13.localEulerAngles.x = 0
				var_413_13.localEulerAngles = var_413_13.localEulerAngles
			end

			if arg_410_1.time_ >= 1.96599999815226 + var_413_14 and arg_410_1.time_ < 1.96599999815226 + var_413_14 + arg_413_0 then
				var_413_13.localPosition = Vector3.New(0, 100, 0)
				var_413_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_413_13.position).x, (manager.ui.mainCamera.transform.position - var_413_13.position).y, (manager.ui.mainCamera.transform.position - var_413_13.position).z)
				var_413_13.localEulerAngles.z = 0
				var_413_13.localEulerAngles.x = 0
				var_413_13.localEulerAngles = var_413_13.localEulerAngles
			end

			local var_413_15 = arg_410_1.actors_["10102ui_story"]

			if 1.96599999815226 < arg_410_1.time_ and arg_410_1.time_ <= 1.96599999815226 + arg_413_0 and not isNil(var_413_15) and arg_410_1.var_.characterEffect10102ui_story == nil then
				arg_410_1.var_.characterEffect10102ui_story = var_413_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_16 = 0.034000001847744

			if 1.96599999815226 <= arg_410_1.time_ and arg_410_1.time_ < 1.96599999815226 + var_413_16 and not isNil(var_413_15) then
				if arg_410_1.var_.characterEffect10102ui_story and not isNil(var_413_15) then
					arg_410_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_410_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_410_1.time_ - 1.96599999815226) / var_413_16)
				end
			end

			if arg_410_1.time_ >= 1.96599999815226 + var_413_16 and arg_410_1.time_ < 1.96599999815226 + var_413_16 + arg_413_0 and not isNil(var_413_15) and arg_410_1.var_.characterEffect10102ui_story then
				arg_410_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_410_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_410_1.time_ and arg_410_1.time_ <= 1.2 + arg_413_0 then
				arg_410_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 0.2 < arg_410_1.time_ and arg_410_1.time_ <= 0.2 + arg_413_0 then
				arg_410_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 1 < arg_410_1.time_ and arg_410_1.time_ <= 1 + arg_413_0 then
				arg_410_1:AudioAction("play", "music", "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_413_21 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

				if "" ~= "" then
					if arg_410_1.bgmTxt_.text ~= var_413_21 and arg_410_1.bgmTxt_.text ~= "" then
						if arg_410_1.bgmTxt2_.text ~= "" then
							arg_410_1.bgmTxt_.text = arg_410_1.bgmTxt2_.text
						end

						arg_410_1.bgmTxt2_.text = var_413_21

						arg_410_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_410_1.bgmTxt_.text = var_413_21
						arg_410_1.bgmTxt2_.text = var_413_21
					end

					if arg_410_1.bgmTimer then
						arg_410_1.bgmTimer:Stop()

						arg_410_1.bgmTimer = nil
					end

					if arg_410_1.settingData.show_music_name == 1 then
						arg_410_1.musicController:SetSelectedState("show")
						arg_410_1.musicAnimator_:Play("open", 0, 0)

						if arg_410_1.settingData.music_time ~= 0 then
							arg_410_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_410_1.settingData.music_time), function()
								if arg_410_1 == nil or isNil(arg_410_1.bgmTxt_) then
									return
								end

								arg_410_1.musicController:SetSelectedState("hide")
								arg_410_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_410_1.frameCnt_ <= 1 then
				arg_410_1.dialog_:SetActive(false)
			end

			local var_413_23 = 4
			local var_413_24 = 1.275

			if 4 < arg_410_1.time_ and arg_410_1.time_ <= var_413_23 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0

				arg_410_1.dialog_:SetActive(true)

				arg_410_1.dialogCg_.alpha = 0

				local var_413_25 = LeanTween.value(arg_410_1.dialog_, 0, 1, 0.3)

				var_413_25:setOnUpdate(LuaHelper.FloatAction(function(arg_415_0)
					arg_410_1.dialogCg_.alpha = arg_415_0
				end))
				var_413_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_410_1.dialog_)
					var_413_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_410_1.duration_ = arg_410_1.duration_ + 0.3

				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_26 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(1108410100).content)

				arg_410_1.text_.text = var_413_26

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_28 = 51 <= 0 and var_413_24 or var_413_24 * (utf8.len(var_413_26) / 51)

				if (51 <= 0 and var_413_24 or var_413_24 * (utf8.len(var_413_26) / 51)) > 0 and var_413_24 < var_413_28 then
					arg_410_1.talkMaxDuration = var_413_28
					var_413_23 = var_413_23 + 0.3

					if var_413_28 + var_413_23 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_28 + var_413_23
					end
				end

				arg_410_1.text_.text = var_413_26
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_29 = var_413_23 + 0.3
			local var_413_30 = math.max(var_413_24, arg_410_1.talkMaxDuration)

			if var_413_23 + 0.3 <= arg_410_1.time_ and arg_410_1.time_ < var_413_29 + var_413_30 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_29) / var_413_30

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_29 + var_413_30 and arg_410_1.time_ < var_413_29 + var_413_30 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
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

		arg_410_1:InitPlayNodeList()
	end,
	Play1108410101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1108410101
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1108410102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.95

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
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

				local var_420_1 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(1108410101).content)

				arg_417_1.text_.text = var_420_1

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_3 = 38 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 38)

				if (38 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 38)) > 0 and var_420_0 < var_420_3 then
					arg_417_1.talkMaxDuration = var_420_3

					if var_420_3 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_3 + 0
					end
				end

				arg_417_1.text_.text = var_420_1
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_4 = math.max(var_420_0, arg_417_1.talkMaxDuration)

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_4 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - 0) / var_420_4

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= 0 + var_420_4 and arg_417_1.time_ < 0 + var_420_4 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1108410102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1108410102
		arg_421_1.duration_ = 1.2

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1108410103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos10102ui_story = arg_421_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10102ui_story"].transform.position).z)
				arg_421_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["10102ui_story"].transform.localEulerAngles = arg_421_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_421_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10102ui_story"].transform.position).z)
				arg_421_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["10102ui_story"].transform.localEulerAngles = arg_421_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_424_1 = arg_421_1.actors_["10102ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect10102ui_story == nil then
				arg_421_1.var_.characterEffect10102ui_story = var_424_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_2 and not isNil(var_424_1) then
				if arg_421_1.var_.characterEffect10102ui_story and not isNil(var_424_1) then
					arg_421_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_2 and arg_421_1.time_ < 0 + var_424_2 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect10102ui_story then
				arg_421_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_424_4 = 0
			local var_424_5 = 0.075

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_4 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_6 = arg_421_1:GetWordFromCfg(1108410102)
				local var_424_7 = arg_421_1:FormatText(var_424_6.content)

				arg_421_1.text_.text = var_424_7

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_9 = 3 <= 0 and var_424_5 or var_424_5 * (utf8.len(var_424_7) / 3)

				if (3 <= 0 and var_424_5 or var_424_5 * (utf8.len(var_424_7) / 3)) > 0 and var_424_5 < var_424_9 then
					arg_421_1.talkMaxDuration = var_424_9

					if var_424_9 + var_424_4 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_9 + var_424_4
					end
				end

				arg_421_1.text_.text = var_424_7
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410102", "story_v_side_new_1108410.awb") ~= 0 then
					local var_424_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410102", "story_v_side_new_1108410.awb") / 1000

					if var_424_10 + var_424_4 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_10 + var_424_4
					end

					if var_424_6.prefab_name ~= "" and arg_421_1.actors_[var_424_6.prefab_name] ~= nil then
						local var_424_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_6.prefab_name].transform, "story_v_side_new_1108410", "1108410102", "story_v_side_new_1108410.awb")

						arg_421_1:RecordAudio("1108410102", var_424_11)
						arg_421_1:RecordAudio("1108410102", var_424_11)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410102", "story_v_side_new_1108410.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410102", "story_v_side_new_1108410.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_12 = math.max(var_424_5, arg_421_1.talkMaxDuration)

			if var_424_4 <= arg_421_1.time_ and arg_421_1.time_ < var_424_4 + var_424_12 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_4) / var_424_12

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_4 + var_424_12 and arg_421_1.time_ < var_424_4 + var_424_12 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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

		arg_421_1:InitPlayNodeList()
	end,
	Play1108410103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1108410103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1108410104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["10102ui_story"]) and arg_425_1.var_.characterEffect10102ui_story == nil then
				arg_425_1.var_.characterEffect10102ui_story = arg_425_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_0 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["10102ui_story"]) then
				if arg_425_1.var_.characterEffect10102ui_story and not isNil(arg_425_1.actors_["10102ui_story"]) then
					arg_425_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_425_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_0)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["10102ui_story"]) and arg_425_1.var_.characterEffect10102ui_story then
				arg_425_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_425_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_428_1 = 0
			local var_428_2 = 0.95

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_3 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(1108410103).content)

				arg_425_1.text_.text = var_428_3

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_5 = 38 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_3) / 38)

				if (38 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_3) / 38)) > 0 and var_428_2 < var_428_5 then
					arg_425_1.talkMaxDuration = var_428_5

					if var_428_5 + var_428_1 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + var_428_1
					end
				end

				arg_425_1.text_.text = var_428_3
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_6 = math.max(var_428_2, arg_425_1.talkMaxDuration)

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_6 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_1) / var_428_6

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_1 + var_428_6 and arg_425_1.time_ < var_428_1 + var_428_6 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1108410104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1108410104
		arg_429_1.duration_ = 2

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1108410105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["10102ui_story"]) and arg_429_1.var_.characterEffect10102ui_story == nil then
				arg_429_1.var_.characterEffect10102ui_story = arg_429_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["10102ui_story"]) then
				if arg_429_1.var_.characterEffect10102ui_story and not isNil(arg_429_1.actors_["10102ui_story"]) then
					arg_429_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["10102ui_story"]) and arg_429_1.var_.characterEffect10102ui_story then
				arg_429_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_432_2 = 0
			local var_432_3 = 0.1

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_2 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_4 = arg_429_1:GetWordFromCfg(1108410104)
				local var_432_5 = arg_429_1:FormatText(var_432_4.content)

				arg_429_1.text_.text = var_432_5

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_7 = 4 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_5) / 4)

				if (4 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_5) / 4)) > 0 and var_432_3 < var_432_7 then
					arg_429_1.talkMaxDuration = var_432_7

					if var_432_7 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_7 + var_432_2
					end
				end

				arg_429_1.text_.text = var_432_5
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410104", "story_v_side_new_1108410.awb") ~= 0 then
					local var_432_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410104", "story_v_side_new_1108410.awb") / 1000

					if var_432_8 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_8 + var_432_2
					end

					if var_432_4.prefab_name ~= "" and arg_429_1.actors_[var_432_4.prefab_name] ~= nil then
						local var_432_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_4.prefab_name].transform, "story_v_side_new_1108410", "1108410104", "story_v_side_new_1108410.awb")

						arg_429_1:RecordAudio("1108410104", var_432_9)
						arg_429_1:RecordAudio("1108410104", var_432_9)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410104", "story_v_side_new_1108410.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410104", "story_v_side_new_1108410.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_10 = math.max(var_432_3, arg_429_1.talkMaxDuration)

			if var_432_2 <= arg_429_1.time_ and arg_429_1.time_ < var_432_2 + var_432_10 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_2) / var_432_10

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_2 + var_432_10 and arg_429_1.time_ < var_432_2 + var_432_10 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1108410105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1108410105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1108410106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["10102ui_story"]) and arg_433_1.var_.characterEffect10102ui_story == nil then
				arg_433_1.var_.characterEffect10102ui_story = arg_433_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["10102ui_story"]) then
				if arg_433_1.var_.characterEffect10102ui_story and not isNil(arg_433_1.actors_["10102ui_story"]) then
					arg_433_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_433_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_0)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["10102ui_story"]) and arg_433_1.var_.characterEffect10102ui_story then
				arg_433_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_433_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_436_1 = 0
			local var_436_2 = 0.775

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_3 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(1108410105).content)

				arg_433_1.text_.text = var_436_3

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 31 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 31)

				if (31 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 31)) > 0 and var_436_2 < var_436_5 then
					arg_433_1.talkMaxDuration = var_436_5

					if var_436_5 + var_436_1 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + var_436_1
					end
				end

				arg_433_1.text_.text = var_436_3
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_6 = math.max(var_436_2, arg_433_1.talkMaxDuration)

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_6 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_1) / var_436_6

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_1 + var_436_6 and arg_433_1.time_ < var_436_1 + var_436_6 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1108410106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1108410106
		arg_437_1.duration_ = 12.07

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1108410107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["10102ui_story"]) and arg_437_1.var_.characterEffect10102ui_story == nil then
				arg_437_1.var_.characterEffect10102ui_story = arg_437_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["10102ui_story"]) then
				if arg_437_1.var_.characterEffect10102ui_story and not isNil(arg_437_1.actors_["10102ui_story"]) then
					arg_437_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["10102ui_story"]) and arg_437_1.var_.characterEffect10102ui_story then
				arg_437_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action454")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_440_2 = 0
			local var_440_3 = 1.325

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_2 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_4 = arg_437_1:GetWordFromCfg(1108410106)
				local var_440_5 = arg_437_1:FormatText(var_440_4.content)

				arg_437_1.text_.text = var_440_5

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_7 = 53 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 53)

				if (53 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 53)) > 0 and var_440_3 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_2
					end
				end

				arg_437_1.text_.text = var_440_5
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410106", "story_v_side_new_1108410.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410106", "story_v_side_new_1108410.awb") / 1000

					if var_440_8 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_2
					end

					if var_440_4.prefab_name ~= "" and arg_437_1.actors_[var_440_4.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_4.prefab_name].transform, "story_v_side_new_1108410", "1108410106", "story_v_side_new_1108410.awb")

						arg_437_1:RecordAudio("1108410106", var_440_9)
						arg_437_1:RecordAudio("1108410106", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410106", "story_v_side_new_1108410.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410106", "story_v_side_new_1108410.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_3, arg_437_1.talkMaxDuration)

			if var_440_2 <= arg_437_1.time_ and arg_437_1.time_ < var_440_2 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_2) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_2 + var_440_10 and arg_437_1.time_ < var_440_2 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1108410107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1108410107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1108410108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["10102ui_story"]) and arg_441_1.var_.characterEffect10102ui_story == nil then
				arg_441_1.var_.characterEffect10102ui_story = arg_441_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["10102ui_story"]) then
				if arg_441_1.var_.characterEffect10102ui_story and not isNil(arg_441_1.actors_["10102ui_story"]) then
					arg_441_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_441_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 0) / var_444_0)
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["10102ui_story"]) and arg_441_1.var_.characterEffect10102ui_story then
				arg_441_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_441_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_444_1 = 0
			local var_444_2 = 0.975

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(1108410107).content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 39 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_3) / 39)

				if (39 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_3) / 39)) > 0 and var_444_2 < var_444_5 then
					arg_441_1.talkMaxDuration = var_444_5

					if var_444_5 + var_444_1 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + var_444_1
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_6 = math.max(var_444_2, arg_441_1.talkMaxDuration)

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_6 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_1) / var_444_6

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_1 + var_444_6 and arg_441_1.time_ < var_444_1 + var_444_6 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1108410108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1108410108
		arg_445_1.duration_ = 7.6

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1108410109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["10102ui_story"]) and arg_445_1.var_.characterEffect10102ui_story == nil then
				arg_445_1.var_.characterEffect10102ui_story = arg_445_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["10102ui_story"]) then
				if arg_445_1.var_.characterEffect10102ui_story and not isNil(arg_445_1.actors_["10102ui_story"]) then
					arg_445_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["10102ui_story"]) and arg_445_1.var_.characterEffect10102ui_story then
				arg_445_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action449")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_448_2 = 0
			local var_448_3 = 0.575

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_2 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_4 = arg_445_1:GetWordFromCfg(1108410108)
				local var_448_5 = arg_445_1:FormatText(var_448_4.content)

				arg_445_1.text_.text = var_448_5

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_7 = 23 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 23)

				if (23 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 23)) > 0 and var_448_3 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_2
					end
				end

				arg_445_1.text_.text = var_448_5
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410108", "story_v_side_new_1108410.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410108", "story_v_side_new_1108410.awb") / 1000

					if var_448_8 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_2
					end

					if var_448_4.prefab_name ~= "" and arg_445_1.actors_[var_448_4.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_4.prefab_name].transform, "story_v_side_new_1108410", "1108410108", "story_v_side_new_1108410.awb")

						arg_445_1:RecordAudio("1108410108", var_448_9)
						arg_445_1:RecordAudio("1108410108", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410108", "story_v_side_new_1108410.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410108", "story_v_side_new_1108410.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_3, arg_445_1.talkMaxDuration)

			if var_448_2 <= arg_445_1.time_ and arg_445_1.time_ < var_448_2 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_2) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_2 + var_448_10 and arg_445_1.time_ < var_448_2 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1108410109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1108410109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1108410110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["10102ui_story"]) and arg_449_1.var_.characterEffect10102ui_story == nil then
				arg_449_1.var_.characterEffect10102ui_story = arg_449_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["10102ui_story"]) then
				if arg_449_1.var_.characterEffect10102ui_story and not isNil(arg_449_1.actors_["10102ui_story"]) then
					arg_449_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_449_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_0)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["10102ui_story"]) and arg_449_1.var_.characterEffect10102ui_story then
				arg_449_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_449_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_452_1 = 0
			local var_452_2 = 0.1

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(1108410109).content)

				arg_449_1.text_.text = var_452_3

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 4 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 4)

				if (4 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 4)) > 0 and var_452_2 < var_452_5 then
					arg_449_1.talkMaxDuration = var_452_5

					if var_452_5 + var_452_1 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + var_452_1
					end
				end

				arg_449_1.text_.text = var_452_3
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_6 = math.max(var_452_2, arg_449_1.talkMaxDuration)

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_6 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_1) / var_452_6

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_1 + var_452_6 and arg_449_1.time_ < var_452_1 + var_452_6 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1108410110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1108410110
		arg_453_1.duration_ = 2

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1108410111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["10102ui_story"]) and arg_453_1.var_.characterEffect10102ui_story == nil then
				arg_453_1.var_.characterEffect10102ui_story = arg_453_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_0 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["10102ui_story"]) then
				if arg_453_1.var_.characterEffect10102ui_story and not isNil(arg_453_1.actors_["10102ui_story"]) then
					arg_453_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["10102ui_story"]) and arg_453_1.var_.characterEffect10102ui_story then
				arg_453_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action9_2")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_456_2 = 0
			local var_456_3 = 0.125

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_2 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_4 = arg_453_1:GetWordFromCfg(1108410110)
				local var_456_5 = arg_453_1:FormatText(var_456_4.content)

				arg_453_1.text_.text = var_456_5

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_7 = 5 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_5) / 5)

				if (5 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_5) / 5)) > 0 and var_456_3 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_2
					end
				end

				arg_453_1.text_.text = var_456_5
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410110", "story_v_side_new_1108410.awb") ~= 0 then
					local var_456_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410110", "story_v_side_new_1108410.awb") / 1000

					if var_456_8 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_8 + var_456_2
					end

					if var_456_4.prefab_name ~= "" and arg_453_1.actors_[var_456_4.prefab_name] ~= nil then
						local var_456_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_4.prefab_name].transform, "story_v_side_new_1108410", "1108410110", "story_v_side_new_1108410.awb")

						arg_453_1:RecordAudio("1108410110", var_456_9)
						arg_453_1:RecordAudio("1108410110", var_456_9)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410110", "story_v_side_new_1108410.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410110", "story_v_side_new_1108410.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_10 = math.max(var_456_3, arg_453_1.talkMaxDuration)

			if var_456_2 <= arg_453_1.time_ and arg_453_1.time_ < var_456_2 + var_456_10 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_2) / var_456_10

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_2 + var_456_10 and arg_453_1.time_ < var_456_2 + var_456_10 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1108410111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1108410111
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1108410112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["10102ui_story"]) and arg_457_1.var_.characterEffect10102ui_story == nil then
				arg_457_1.var_.characterEffect10102ui_story = arg_457_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_0 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["10102ui_story"]) then
				if arg_457_1.var_.characterEffect10102ui_story and not isNil(arg_457_1.actors_["10102ui_story"]) then
					arg_457_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_457_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_0)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["10102ui_story"]) and arg_457_1.var_.characterEffect10102ui_story then
				arg_457_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_457_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_460_1 = 0
			local var_460_2 = 0.975

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1108410111).content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 39 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 39)

				if (39 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 39)) > 0 and var_460_2 < var_460_5 then
					arg_457_1.talkMaxDuration = var_460_5

					if var_460_5 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + var_460_1
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_6 = math.max(var_460_2, arg_457_1.talkMaxDuration)

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_6 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_1) / var_460_6

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_1 + var_460_6 and arg_457_1.time_ < var_460_1 + var_460_6 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1108410112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1108410112
		arg_461_1.duration_ = 3.67

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1108410113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["10102ui_story"]) and arg_461_1.var_.characterEffect10102ui_story == nil then
				arg_461_1.var_.characterEffect10102ui_story = arg_461_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["10102ui_story"]) then
				if arg_461_1.var_.characterEffect10102ui_story and not isNil(arg_461_1.actors_["10102ui_story"]) then
					arg_461_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["10102ui_story"]) and arg_461_1.var_.characterEffect10102ui_story then
				arg_461_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_464_2 = 0
			local var_464_3 = 0.625

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_2 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_4 = arg_461_1:GetWordFromCfg(1108410112)
				local var_464_5 = arg_461_1:FormatText(var_464_4.content)

				arg_461_1.text_.text = var_464_5

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_7 = 25 <= 0 and var_464_3 or var_464_3 * (utf8.len(var_464_5) / 25)

				if (25 <= 0 and var_464_3 or var_464_3 * (utf8.len(var_464_5) / 25)) > 0 and var_464_3 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_2 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_2
					end
				end

				arg_461_1.text_.text = var_464_5
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410112", "story_v_side_new_1108410.awb") ~= 0 then
					local var_464_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410112", "story_v_side_new_1108410.awb") / 1000

					if var_464_8 + var_464_2 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_8 + var_464_2
					end

					if var_464_4.prefab_name ~= "" and arg_461_1.actors_[var_464_4.prefab_name] ~= nil then
						local var_464_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_4.prefab_name].transform, "story_v_side_new_1108410", "1108410112", "story_v_side_new_1108410.awb")

						arg_461_1:RecordAudio("1108410112", var_464_9)
						arg_461_1:RecordAudio("1108410112", var_464_9)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410112", "story_v_side_new_1108410.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410112", "story_v_side_new_1108410.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_10 = math.max(var_464_3, arg_461_1.talkMaxDuration)

			if var_464_2 <= arg_461_1.time_ and arg_461_1.time_ < var_464_2 + var_464_10 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_2) / var_464_10

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_2 + var_464_10 and arg_461_1.time_ < var_464_2 + var_464_10 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1108410113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1108410113
		arg_465_1.duration_ = 1

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"

			SetActive(arg_465_1.choicesGo_, true)

			for iter_466_0, iter_466_1 in ipairs(arg_465_1.choices_) do
				SetActive(iter_466_1.go, iter_466_0 <= 2)
			end

			arg_465_1.choices_[1].txt.text = arg_465_1:FormatText(StoryChoiceCfg[1704].name)
			arg_465_1.choices_[2].txt.text = arg_465_1:FormatText(StoryChoiceCfg[1705].name)
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1108410114(arg_465_1)
			end

			if arg_467_0 == 2 then
				arg_465_0:Play1108410114(arg_465_1)
			end

			arg_465_1:RecordChoiceLog(1108410113, 1704, 1705)
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["10102ui_story"]) and arg_465_1.var_.characterEffect10102ui_story == nil then
				arg_465_1.var_.characterEffect10102ui_story = arg_465_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["10102ui_story"]) then
				if arg_465_1.var_.characterEffect10102ui_story and not isNil(arg_465_1.actors_["10102ui_story"]) then
					arg_465_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_465_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_0)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["10102ui_story"]) and arg_465_1.var_.characterEffect10102ui_story then
				arg_465_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_465_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_468_1 = 0

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.allBtn_.enabled = false
			end

			if arg_465_1.time_ >= var_468_1 + 0.6 and arg_465_1.time_ < var_468_1 + 0.6 + arg_468_0 then
				arg_465_1.allBtn_.enabled = true
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1108410114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1108410114
		arg_469_1.duration_ = 15.53

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1108410115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["10102ui_story"]) and arg_469_1.var_.characterEffect10102ui_story == nil then
				arg_469_1.var_.characterEffect10102ui_story = arg_469_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["10102ui_story"]) then
				if arg_469_1.var_.characterEffect10102ui_story and not isNil(arg_469_1.actors_["10102ui_story"]) then
					arg_469_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["10102ui_story"]) and arg_469_1.var_.characterEffect10102ui_story then
				arg_469_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_472_2 = "10102ui_story"

			if arg_469_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_472_3 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_469_1.stage_.transform)

				var_472_3.name = var_472_2
				var_472_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_469_1.actors_[var_472_2] = var_472_3

				local var_472_4 = var_472_3:GetComponentInChildren(typeof(CharacterEffect))

				var_472_4.enabled = true

				local var_472_5 = GameObjectTools.GetOrAddComponent(var_472_3, typeof(DynamicBoneHelper))

				if var_472_5 then
					var_472_5:EnableDynamicBone(false)
				end

				arg_469_1:ShowWeapon(var_472_4.transform, false)

				arg_469_1.var_[var_472_2 .. "Animator"] = var_472_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_469_1.var_[var_472_2 .. "Animator"].applyRootMotion = true
				arg_469_1.var_[var_472_2 .. "LipSync"] = var_472_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action429")
			end

			local var_472_6 = "10102ui_story"

			if arg_469_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_472_7 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_469_1.stage_.transform)

				var_472_7.name = var_472_6
				var_472_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_469_1.actors_[var_472_6] = var_472_7

				local var_472_8 = var_472_7:GetComponentInChildren(typeof(CharacterEffect))

				var_472_8.enabled = true

				local var_472_9 = GameObjectTools.GetOrAddComponent(var_472_7, typeof(DynamicBoneHelper))

				if var_472_9 then
					var_472_9:EnableDynamicBone(false)
				end

				arg_469_1:ShowWeapon(var_472_8.transform, false)

				arg_469_1.var_[var_472_6 .. "Animator"] = var_472_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_469_1.var_[var_472_6 .. "Animator"].applyRootMotion = true
				arg_469_1.var_[var_472_6 .. "LipSync"] = var_472_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_472_10 = 0
			local var_472_11 = 1.875

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_10 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_12 = arg_469_1:GetWordFromCfg(1108410114)
				local var_472_13 = arg_469_1:FormatText(var_472_12.content)

				arg_469_1.text_.text = var_472_13

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_15 = 75 <= 0 and var_472_11 or var_472_11 * (utf8.len(var_472_13) / 75)

				if (75 <= 0 and var_472_11 or var_472_11 * (utf8.len(var_472_13) / 75)) > 0 and var_472_11 < var_472_15 then
					arg_469_1.talkMaxDuration = var_472_15

					if var_472_15 + var_472_10 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_15 + var_472_10
					end
				end

				arg_469_1.text_.text = var_472_13
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410114", "story_v_side_new_1108410.awb") ~= 0 then
					local var_472_16 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410114", "story_v_side_new_1108410.awb") / 1000

					if var_472_16 + var_472_10 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_16 + var_472_10
					end

					if var_472_12.prefab_name ~= "" and arg_469_1.actors_[var_472_12.prefab_name] ~= nil then
						local var_472_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_12.prefab_name].transform, "story_v_side_new_1108410", "1108410114", "story_v_side_new_1108410.awb")

						arg_469_1:RecordAudio("1108410114", var_472_17)
						arg_469_1:RecordAudio("1108410114", var_472_17)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410114", "story_v_side_new_1108410.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410114", "story_v_side_new_1108410.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_18 = math.max(var_472_11, arg_469_1.talkMaxDuration)

			if var_472_10 <= arg_469_1.time_ and arg_469_1.time_ < var_472_10 + var_472_18 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_10) / var_472_18

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_10 + var_472_18 and arg_469_1.time_ < var_472_10 + var_472_18 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1108410115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1108410115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1108410116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["10102ui_story"]) and arg_473_1.var_.characterEffect10102ui_story == nil then
				arg_473_1.var_.characterEffect10102ui_story = arg_473_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["10102ui_story"]) then
				if arg_473_1.var_.characterEffect10102ui_story and not isNil(arg_473_1.actors_["10102ui_story"]) then
					arg_473_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_473_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_0)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["10102ui_story"]) and arg_473_1.var_.characterEffect10102ui_story then
				arg_473_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_473_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_476_2 = 0
			local var_476_3 = 0.3

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_2 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_4 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(1108410115).content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_6 = 12 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_4) / 12)

				if (12 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_4) / 12)) > 0 and var_476_3 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_2
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_3, arg_473_1.talkMaxDuration)

			if var_476_2 <= arg_473_1.time_ and arg_473_1.time_ < var_476_2 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_2) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_2 + var_476_7 and arg_473_1.time_ < var_476_2 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1108410116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1108410116
		arg_477_1.duration_ = 4.83

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1108410117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_9000

			if arg_477_1.bgs_.R8406 == nil then
				local var_480_0 = Object.Instantiate(arg_477_1.paintGo_)

				var_480_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R8406")
				var_480_0.name = "R8406"
				var_480_0.transform.parent = arg_477_1.stage_.transform
				var_480_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_477_1.bgs_.R8406 = var_480_0
			end

			if 2 < arg_477_1.time_ and arg_477_1.time_ <= 2 + arg_480_0 then
				local var_480_1 = arg_477_1.bgs_.R8406

				arg_477_1.bgs_.R8406.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_480_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_480_2 = var_480_1:GetComponent("SpriteRenderer")

				if var_480_2 and var_480_2.sprite then
					local var_480_3 = 2 * (var_480_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_480_1.transform.localScale = Vector3.New(var_480_3 / var_480_2.sprite.bounds.size.y < var_480_3 * manager.ui.mainCameraCom_.aspect / var_480_2.sprite.bounds.size.x and var_480_3 * manager.ui.mainCameraCom_.aspect / var_480_2.sprite.bounds.size.x or var_480_3 / var_480_2.sprite.bounds.size.y, var_480_3 / var_480_2.sprite.bounds.size.y < var_480_3 * manager.ui.mainCameraCom_.aspect / var_480_2.sprite.bounds.size.x and var_480_3 * manager.ui.mainCameraCom_.aspect / var_480_2.sprite.bounds.size.x or var_480_3 / var_480_2.sprite.bounds.size.y, 0)
				end

				for iter_480_0, iter_480_1 in pairs(arg_477_1.bgs_) do
					if iter_480_0 ~= "R8406" then
						iter_480_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_480_4 = 4

			if 4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.allBtn_.enabled = false
			end

			if arg_477_1.time_ >= var_480_4 + 0.2 and arg_477_1.time_ < var_480_4 + 0.2 + arg_480_0 then
				arg_477_1.allBtn_.enabled = true
			end

			local var_480_5 = 0

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_5 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_6 = 2

			if var_480_5 <= arg_477_1.time_ and arg_477_1.time_ < var_480_5 + var_480_6 then
				local var_480_7 = Color.New(0, 0, 0)

				var_480_7.a = Mathf.Lerp(0, 1, (arg_477_1.time_ - var_480_5) / var_480_6)
				arg_477_1.mask_.color = var_480_7
			end

			if arg_477_1.time_ >= var_480_5 + var_480_6 and arg_477_1.time_ < var_480_5 + var_480_6 + arg_480_0 then
				local var_480_8 = Color.New(0, 0, 0)

				var_480_8.a = 1
				arg_477_1.mask_.color = var_480_8
			end

			local var_480_9 = 2

			if 2 < arg_477_1.time_ and arg_477_1.time_ <= var_480_9 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_10 = 2

			if var_480_9 <= arg_477_1.time_ and arg_477_1.time_ < var_480_9 + var_480_10 then
				local var_480_11 = Color.New(0, 0, 0)

				var_480_11.a = Mathf.Lerp(1, 0, (arg_477_1.time_ - var_480_9) / var_480_10)
				arg_477_1.mask_.color = var_480_11
			end

			if arg_477_1.time_ >= var_480_9 + var_480_10 and arg_477_1.time_ < var_480_9 + var_480_10 + arg_480_0 then
				local var_480_12 = Color.New(0, 0, 0)

				arg_477_1.mask_.enabled = false
				var_480_12.a = 0
				arg_477_1.mask_.color = var_480_12
			end

			local var_480_13 = arg_477_1.actors_["10102ui_story"].transform

			if 2 < arg_477_1.time_ and arg_477_1.time_ <= 2 + arg_480_0 then
				arg_477_1.var_.moveOldPos10102ui_story = var_480_13.localPosition
			end

			local var_480_14 = 0.001

			if 2 <= arg_477_1.time_ and arg_477_1.time_ < 2 + var_480_14 then
				var_480_13.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_477_1.time_ - 2) / var_480_14)
				var_480_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_13.position).x, (manager.ui.mainCamera.transform.position - var_480_13.position).y, (manager.ui.mainCamera.transform.position - var_480_13.position).z)
				var_480_13.localEulerAngles.z = 0
				var_480_13.localEulerAngles.x = 0
				var_480_13.localEulerAngles = var_480_13.localEulerAngles
			end

			if arg_477_1.time_ >= 2 + var_480_14 and arg_477_1.time_ < 2 + var_480_14 + arg_480_0 then
				var_480_13.localPosition = Vector3.New(0, 100, 0)
				var_480_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_13.position).x, (manager.ui.mainCamera.transform.position - var_480_13.position).y, (manager.ui.mainCamera.transform.position - var_480_13.position).z)
				var_480_13.localEulerAngles.z = 0
				var_480_13.localEulerAngles.x = 0
				var_480_13.localEulerAngles = var_480_13.localEulerAngles
			end

			local var_480_15 = arg_477_1.bgs_.R8406.transform

			if 2 < arg_477_1.time_ and arg_477_1.time_ <= 2 + arg_480_0 then
				arg_477_1.var_.moveOldPosR8406 = var_480_15.localPosition
			end

			local var_480_16 = 2.05

			if 2 <= arg_477_1.time_ and arg_477_1.time_ < 2 + var_480_16 then
				var_480_15.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPosR8406, Vector3.New(0, 0.5, 6), (arg_477_1.time_ - 2) / var_480_16)
			end

			if arg_477_1.time_ >= 2 + var_480_16 and arg_477_1.time_ < 2 + var_480_16 + arg_480_0 then
				var_480_15.localPosition = Vector3.New(0, 0.5, 6)
			end

			if 2.01666666666667 < arg_477_1.time_ and arg_477_1.time_ <= 2.01666666666667 + arg_480_0 then
				local var_480_17 = arg_477_1.var_.effectboguang1

				if not arg_477_1.var_.effectboguang1 then
					var_480_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boguang_keep"), manager.ui.mainCamera.transform)
					var_480_17.name = "boguang1"
					arg_477_1.var_.effectboguang1 = var_480_17
				else
					var_480_17.transform:SetParent(var_480_9000)
				end

				var_480_17.transform.localPosition = Vector3.New(3.44, 0.23, -3.68)
				var_480_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:AudioAction("play", "music", "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_480_21 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if "" ~= "" then
					if arg_477_1.bgmTxt_.text ~= var_480_21 and arg_477_1.bgmTxt_.text ~= "" then
						if arg_477_1.bgmTxt2_.text ~= "" then
							arg_477_1.bgmTxt_.text = arg_477_1.bgmTxt2_.text
						end

						arg_477_1.bgmTxt2_.text = var_480_21

						arg_477_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_477_1.bgmTxt_.text = var_480_21
						arg_477_1.bgmTxt2_.text = var_480_21
					end

					if arg_477_1.bgmTimer then
						arg_477_1.bgmTimer:Stop()

						arg_477_1.bgmTimer = nil
					end

					if arg_477_1.settingData.show_music_name == 1 then
						arg_477_1.musicController:SetSelectedState("show")
						arg_477_1.musicAnimator_:Play("open", 0, 0)

						if arg_477_1.settingData.music_time ~= 0 then
							arg_477_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_477_1.settingData.music_time), function()
								if arg_477_1 == nil or isNil(arg_477_1.bgmTxt_) then
									return
								end

								arg_477_1.musicController:SetSelectedState("hide")
								arg_477_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_477_1.frameCnt_ <= 1 then
				arg_477_1.dialog_:SetActive(false)
			end

			local var_480_22 = 4
			local var_480_23 = 0.05

			if 4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_22 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0

				arg_477_1.dialog_:SetActive(true)

				arg_477_1.dialogCg_.alpha = 0

				local var_480_24 = LeanTween.value(arg_477_1.dialog_, 0, 1, 0.3)

				var_480_24:setOnUpdate(LuaHelper.FloatAction(function(arg_482_0)
					arg_477_1.dialogCg_.alpha = arg_482_0
				end))
				var_480_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_477_1.dialog_)
					var_480_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_477_1.duration_ = arg_477_1.duration_ + 0.3

				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_25 = arg_477_1:GetWordFromCfg(1108410116)
				local var_480_26 = arg_477_1:FormatText(var_480_25.content)

				arg_477_1.text_.text = var_480_26

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_28 = 2 <= 0 and var_480_23 or var_480_23 * (utf8.len(var_480_26) / 2)

				if (2 <= 0 and var_480_23 or var_480_23 * (utf8.len(var_480_26) / 2)) > 0 and var_480_23 < var_480_28 then
					arg_477_1.talkMaxDuration = var_480_28
					var_480_22 = var_480_22 + 0.3

					if var_480_28 + var_480_22 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_28 + var_480_22
					end
				end

				arg_477_1.text_.text = var_480_26
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410116", "story_v_side_new_1108410.awb") ~= 0 then
					local var_480_29 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410116", "story_v_side_new_1108410.awb") / 1000

					if var_480_29 + var_480_22 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_29 + var_480_22
					end

					if var_480_25.prefab_name ~= "" and arg_477_1.actors_[var_480_25.prefab_name] ~= nil then
						local var_480_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_25.prefab_name].transform, "story_v_side_new_1108410", "1108410116", "story_v_side_new_1108410.awb")

						arg_477_1:RecordAudio("1108410116", var_480_30)
						arg_477_1:RecordAudio("1108410116", var_480_30)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410116", "story_v_side_new_1108410.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410116", "story_v_side_new_1108410.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_31 = var_480_22 + 0.3
			local var_480_32 = math.max(var_480_23, arg_477_1.talkMaxDuration)

			if var_480_22 + 0.3 <= arg_477_1.time_ and arg_477_1.time_ < var_480_31 + var_480_32 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_31) / var_480_32

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_31 + var_480_32 and arg_477_1.time_ < var_480_31 + var_480_32 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "R8406",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.05,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 6),
					endPos = Vector3.New(0, 0.5, 6),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play1108410117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1108410117
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1108410118(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(arg_484_1.actors_["10102ui_story"]) and arg_484_1.var_.characterEffect10102ui_story == nil then
				arg_484_1.var_.characterEffect10102ui_story = arg_484_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_0 = 0.200000002980232

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_0 and not isNil(arg_484_1.actors_["10102ui_story"]) then
				if arg_484_1.var_.characterEffect10102ui_story and not isNil(arg_484_1.actors_["10102ui_story"]) then
					arg_484_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_484_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_484_1.time_ - 0) / var_487_0)
				end
			end

			if arg_484_1.time_ >= 0 + var_487_0 and arg_484_1.time_ < 0 + var_487_0 + arg_487_0 and not isNil(arg_484_1.actors_["10102ui_story"]) and arg_484_1.var_.characterEffect10102ui_story then
				arg_484_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_484_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_487_1 = 0
			local var_487_2 = 0.7

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_3 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(1108410117).content)

				arg_484_1.text_.text = var_487_3

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 28 <= 0 and var_487_2 or var_487_2 * (utf8.len(var_487_3) / 28)

				if (28 <= 0 and var_487_2 or var_487_2 * (utf8.len(var_487_3) / 28)) > 0 and var_487_2 < var_487_5 then
					arg_484_1.talkMaxDuration = var_487_5

					if var_487_5 + var_487_1 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_5 + var_487_1
					end
				end

				arg_484_1.text_.text = var_487_3
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_6 = math.max(var_487_2, arg_484_1.talkMaxDuration)

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_6 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_1) / var_487_6

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_1 + var_487_6 and arg_484_1.time_ < var_487_1 + var_487_6 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1108410118 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1108410118
		arg_488_1.duration_ = 7.23

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1108410119(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["10102ui_story"]) and arg_488_1.var_.characterEffect10102ui_story == nil then
				arg_488_1.var_.characterEffect10102ui_story = arg_488_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_0 = 0.200000002980232

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["10102ui_story"]) then
				if arg_488_1.var_.characterEffect10102ui_story and not isNil(arg_488_1.actors_["10102ui_story"]) then
					arg_488_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["10102ui_story"]) and arg_488_1.var_.characterEffect10102ui_story then
				arg_488_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_491_2 = 0
			local var_491_3 = 0.7

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_2 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_4 = arg_488_1:GetWordFromCfg(1108410118)
				local var_491_5 = arg_488_1:FormatText(var_491_4.content)

				arg_488_1.text_.text = var_491_5

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_7 = 28 <= 0 and var_491_3 or var_491_3 * (utf8.len(var_491_5) / 28)

				if (28 <= 0 and var_491_3 or var_491_3 * (utf8.len(var_491_5) / 28)) > 0 and var_491_3 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_2 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_2
					end
				end

				arg_488_1.text_.text = var_491_5
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410118", "story_v_side_new_1108410.awb") ~= 0 then
					local var_491_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410118", "story_v_side_new_1108410.awb") / 1000

					if var_491_8 + var_491_2 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_8 + var_491_2
					end

					if var_491_4.prefab_name ~= "" and arg_488_1.actors_[var_491_4.prefab_name] ~= nil then
						local var_491_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_4.prefab_name].transform, "story_v_side_new_1108410", "1108410118", "story_v_side_new_1108410.awb")

						arg_488_1:RecordAudio("1108410118", var_491_9)
						arg_488_1:RecordAudio("1108410118", var_491_9)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410118", "story_v_side_new_1108410.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410118", "story_v_side_new_1108410.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_10 = math.max(var_491_3, arg_488_1.talkMaxDuration)

			if var_491_2 <= arg_488_1.time_ and arg_488_1.time_ < var_491_2 + var_491_10 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_2) / var_491_10

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_2 + var_491_10 and arg_488_1.time_ < var_491_2 + var_491_10 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play1108410119 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1108410119
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1108410120(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(arg_492_1.actors_["10102ui_story"]) and arg_492_1.var_.characterEffect10102ui_story == nil then
				arg_492_1.var_.characterEffect10102ui_story = arg_492_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_0 = 0.200000002980232

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 and not isNil(arg_492_1.actors_["10102ui_story"]) then
				if arg_492_1.var_.characterEffect10102ui_story and not isNil(arg_492_1.actors_["10102ui_story"]) then
					arg_492_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_492_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_492_1.time_ - 0) / var_495_0)
				end
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 and not isNil(arg_492_1.actors_["10102ui_story"]) and arg_492_1.var_.characterEffect10102ui_story then
				arg_492_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_492_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_495_1 = 0
			local var_495_2 = 1.45

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_3 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(1108410119).content)

				arg_492_1.text_.text = var_495_3

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 58 <= 0 and var_495_2 or var_495_2 * (utf8.len(var_495_3) / 58)

				if (58 <= 0 and var_495_2 or var_495_2 * (utf8.len(var_495_3) / 58)) > 0 and var_495_2 < var_495_5 then
					arg_492_1.talkMaxDuration = var_495_5

					if var_495_5 + var_495_1 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_5 + var_495_1
					end
				end

				arg_492_1.text_.text = var_495_3
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_6 = math.max(var_495_2, arg_492_1.talkMaxDuration)

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_6 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_1) / var_495_6

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_1 + var_495_6 and arg_492_1.time_ < var_495_1 + var_495_6 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play1108410120 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1108410120
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1108410121(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 1.5

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_1 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(1108410120).content)

				arg_496_1.text_.text = var_499_1

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_3 = 60 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_1) / 60)

				if (60 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_1) / 60)) > 0 and var_499_0 < var_499_3 then
					arg_496_1.talkMaxDuration = var_499_3

					if var_499_3 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_3 + 0
					end
				end

				arg_496_1.text_.text = var_499_1
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_4 = math.max(var_499_0, arg_496_1.talkMaxDuration)

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_4 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - 0) / var_499_4

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= 0 + var_499_4 and arg_496_1.time_ < 0 + var_499_4 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play1108410121 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1108410121
		arg_500_1.duration_ = 2

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1108410122(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(arg_500_1.actors_["10102ui_story"]) and arg_500_1.var_.characterEffect10102ui_story == nil then
				arg_500_1.var_.characterEffect10102ui_story = arg_500_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_0 = 0.200000002980232

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_0 and not isNil(arg_500_1.actors_["10102ui_story"]) then
				if arg_500_1.var_.characterEffect10102ui_story and not isNil(arg_500_1.actors_["10102ui_story"]) then
					arg_500_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_500_1.time_ >= 0 + var_503_0 and arg_500_1.time_ < 0 + var_503_0 + arg_503_0 and not isNil(arg_500_1.actors_["10102ui_story"]) and arg_500_1.var_.characterEffect10102ui_story then
				arg_500_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_503_2 = 0
			local var_503_3 = 0.125

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_2 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_4 = arg_500_1:GetWordFromCfg(1108410121)
				local var_503_5 = arg_500_1:FormatText(var_503_4.content)

				arg_500_1.text_.text = var_503_5

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_7 = 5 <= 0 and var_503_3 or var_503_3 * (utf8.len(var_503_5) / 5)

				if (5 <= 0 and var_503_3 or var_503_3 * (utf8.len(var_503_5) / 5)) > 0 and var_503_3 < var_503_7 then
					arg_500_1.talkMaxDuration = var_503_7

					if var_503_7 + var_503_2 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_7 + var_503_2
					end
				end

				arg_500_1.text_.text = var_503_5
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410121", "story_v_side_new_1108410.awb") ~= 0 then
					local var_503_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410121", "story_v_side_new_1108410.awb") / 1000

					if var_503_8 + var_503_2 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_8 + var_503_2
					end

					if var_503_4.prefab_name ~= "" and arg_500_1.actors_[var_503_4.prefab_name] ~= nil then
						local var_503_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_4.prefab_name].transform, "story_v_side_new_1108410", "1108410121", "story_v_side_new_1108410.awb")

						arg_500_1:RecordAudio("1108410121", var_503_9)
						arg_500_1:RecordAudio("1108410121", var_503_9)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410121", "story_v_side_new_1108410.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410121", "story_v_side_new_1108410.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_10 = math.max(var_503_3, arg_500_1.talkMaxDuration)

			if var_503_2 <= arg_500_1.time_ and arg_500_1.time_ < var_503_2 + var_503_10 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_2) / var_503_10

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_2 + var_503_10 and arg_500_1.time_ < var_503_2 + var_503_10 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1108410122 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1108410122
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1108410123(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(arg_504_1.actors_["10102ui_story"]) and arg_504_1.var_.characterEffect10102ui_story == nil then
				arg_504_1.var_.characterEffect10102ui_story = arg_504_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_0 = 0.200000002980232

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_0 and not isNil(arg_504_1.actors_["10102ui_story"]) then
				if arg_504_1.var_.characterEffect10102ui_story and not isNil(arg_504_1.actors_["10102ui_story"]) then
					arg_504_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_504_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_504_1.time_ - 0) / var_507_0)
				end
			end

			if arg_504_1.time_ >= 0 + var_507_0 and arg_504_1.time_ < 0 + var_507_0 + arg_507_0 and not isNil(arg_504_1.actors_["10102ui_story"]) and arg_504_1.var_.characterEffect10102ui_story then
				arg_504_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_504_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_507_1 = 0
			local var_507_2 = 0.45

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_3 = arg_504_1:FormatText(arg_504_1:GetWordFromCfg(1108410122).content)

				arg_504_1.text_.text = var_507_3

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 18 <= 0 and var_507_2 or var_507_2 * (utf8.len(var_507_3) / 18)

				if (18 <= 0 and var_507_2 or var_507_2 * (utf8.len(var_507_3) / 18)) > 0 and var_507_2 < var_507_5 then
					arg_504_1.talkMaxDuration = var_507_5

					if var_507_5 + var_507_1 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_5 + var_507_1
					end
				end

				arg_504_1.text_.text = var_507_3
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_6 = math.max(var_507_2, arg_504_1.talkMaxDuration)

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_6 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_1) / var_507_6

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_1 + var_507_6 and arg_504_1.time_ < var_507_1 + var_507_6 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1108410123 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1108410123
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1108410124(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0.575

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, false)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_1 = arg_508_1:FormatText(arg_508_1:GetWordFromCfg(1108410123).content)

				arg_508_1.text_.text = var_511_1

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_3 = 23 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_1) / 23)

				if (23 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_1) / 23)) > 0 and var_511_0 < var_511_3 then
					arg_508_1.talkMaxDuration = var_511_3

					if var_511_3 + 0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_3 + 0
					end
				end

				arg_508_1.text_.text = var_511_1
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_4 = math.max(var_511_0, arg_508_1.talkMaxDuration)

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_4 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - 0) / var_511_4

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= 0 + var_511_4 and arg_508_1.time_ < 0 + var_511_4 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1108410124 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1108410124
		arg_512_1.duration_ = 5.67

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play1108410125(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(arg_512_1.actors_["10102ui_story"]) and arg_512_1.var_.characterEffect10102ui_story == nil then
				arg_512_1.var_.characterEffect10102ui_story = arg_512_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_0 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_0 and not isNil(arg_512_1.actors_["10102ui_story"]) then
				if arg_512_1.var_.characterEffect10102ui_story and not isNil(arg_512_1.actors_["10102ui_story"]) then
					arg_512_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= 0 + var_515_0 and arg_512_1.time_ < 0 + var_515_0 + arg_515_0 and not isNil(arg_512_1.actors_["10102ui_story"]) and arg_512_1.var_.characterEffect10102ui_story then
				arg_512_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action8_1")
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_515_2 = 0
			local var_515_3 = 0.65

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_2 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_4 = arg_512_1:GetWordFromCfg(1108410124)
				local var_515_5 = arg_512_1:FormatText(var_515_4.content)

				arg_512_1.text_.text = var_515_5

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_7 = 26 <= 0 and var_515_3 or var_515_3 * (utf8.len(var_515_5) / 26)

				if (26 <= 0 and var_515_3 or var_515_3 * (utf8.len(var_515_5) / 26)) > 0 and var_515_3 < var_515_7 then
					arg_512_1.talkMaxDuration = var_515_7

					if var_515_7 + var_515_2 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_7 + var_515_2
					end
				end

				arg_512_1.text_.text = var_515_5
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410124", "story_v_side_new_1108410.awb") ~= 0 then
					local var_515_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410124", "story_v_side_new_1108410.awb") / 1000

					if var_515_8 + var_515_2 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_8 + var_515_2
					end

					if var_515_4.prefab_name ~= "" and arg_512_1.actors_[var_515_4.prefab_name] ~= nil then
						local var_515_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_4.prefab_name].transform, "story_v_side_new_1108410", "1108410124", "story_v_side_new_1108410.awb")

						arg_512_1:RecordAudio("1108410124", var_515_9)
						arg_512_1:RecordAudio("1108410124", var_515_9)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410124", "story_v_side_new_1108410.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410124", "story_v_side_new_1108410.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_10 = math.max(var_515_3, arg_512_1.talkMaxDuration)

			if var_515_2 <= arg_512_1.time_ and arg_512_1.time_ < var_515_2 + var_515_10 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_2) / var_515_10

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_2 + var_515_10 and arg_512_1.time_ < var_515_2 + var_515_10 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1108410125 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1108410125
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1108410126(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(arg_516_1.actors_["10102ui_story"]) and arg_516_1.var_.characterEffect10102ui_story == nil then
				arg_516_1.var_.characterEffect10102ui_story = arg_516_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_0 = 0.200000002980232

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_0 and not isNil(arg_516_1.actors_["10102ui_story"]) then
				if arg_516_1.var_.characterEffect10102ui_story and not isNil(arg_516_1.actors_["10102ui_story"]) then
					arg_516_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_516_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_516_1.time_ - 0) / var_519_0)
				end
			end

			if arg_516_1.time_ >= 0 + var_519_0 and arg_516_1.time_ < 0 + var_519_0 + arg_519_0 and not isNil(arg_516_1.actors_["10102ui_story"]) and arg_516_1.var_.characterEffect10102ui_story then
				arg_516_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_516_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_519_1 = 0
			local var_519_2 = 0.875

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_3 = arg_516_1:FormatText(arg_516_1:GetWordFromCfg(1108410125).content)

				arg_516_1.text_.text = var_519_3

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_5 = 35 <= 0 and var_519_2 or var_519_2 * (utf8.len(var_519_3) / 35)

				if (35 <= 0 and var_519_2 or var_519_2 * (utf8.len(var_519_3) / 35)) > 0 and var_519_2 < var_519_5 then
					arg_516_1.talkMaxDuration = var_519_5

					if var_519_5 + var_519_1 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_5 + var_519_1
					end
				end

				arg_516_1.text_.text = var_519_3
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_6 = math.max(var_519_2, arg_516_1.talkMaxDuration)

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_6 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_1) / var_519_6

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_1 + var_519_6 and arg_516_1.time_ < var_519_1 + var_519_6 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play1108410126 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1108410126
		arg_520_1.duration_ = 4.43

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1108410127(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(arg_520_1.actors_["10102ui_story"]) and arg_520_1.var_.characterEffect10102ui_story == nil then
				arg_520_1.var_.characterEffect10102ui_story = arg_520_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_0 = 0.200000002980232

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_0 and not isNil(arg_520_1.actors_["10102ui_story"]) then
				if arg_520_1.var_.characterEffect10102ui_story and not isNil(arg_520_1.actors_["10102ui_story"]) then
					arg_520_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_520_1.time_ >= 0 + var_523_0 and arg_520_1.time_ < 0 + var_523_0 + arg_523_0 and not isNil(arg_520_1.actors_["10102ui_story"]) and arg_520_1.var_.characterEffect10102ui_story then
				arg_520_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action8_2")
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_523_2 = 0
			local var_523_3 = 0.65

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_2 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_4 = arg_520_1:GetWordFromCfg(1108410126)
				local var_523_5 = arg_520_1:FormatText(var_523_4.content)

				arg_520_1.text_.text = var_523_5

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_7 = 26 <= 0 and var_523_3 or var_523_3 * (utf8.len(var_523_5) / 26)

				if (26 <= 0 and var_523_3 or var_523_3 * (utf8.len(var_523_5) / 26)) > 0 and var_523_3 < var_523_7 then
					arg_520_1.talkMaxDuration = var_523_7

					if var_523_7 + var_523_2 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_7 + var_523_2
					end
				end

				arg_520_1.text_.text = var_523_5
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410126", "story_v_side_new_1108410.awb") ~= 0 then
					local var_523_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410126", "story_v_side_new_1108410.awb") / 1000

					if var_523_8 + var_523_2 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_8 + var_523_2
					end

					if var_523_4.prefab_name ~= "" and arg_520_1.actors_[var_523_4.prefab_name] ~= nil then
						local var_523_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_4.prefab_name].transform, "story_v_side_new_1108410", "1108410126", "story_v_side_new_1108410.awb")

						arg_520_1:RecordAudio("1108410126", var_523_9)
						arg_520_1:RecordAudio("1108410126", var_523_9)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410126", "story_v_side_new_1108410.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410126", "story_v_side_new_1108410.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_10 = math.max(var_523_3, arg_520_1.talkMaxDuration)

			if var_523_2 <= arg_520_1.time_ and arg_520_1.time_ < var_523_2 + var_523_10 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_2) / var_523_10

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_2 + var_523_10 and arg_520_1.time_ < var_523_2 + var_523_10 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play1108410127 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1108410127
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play1108410128(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(arg_524_1.actors_["10102ui_story"]) and arg_524_1.var_.characterEffect10102ui_story == nil then
				arg_524_1.var_.characterEffect10102ui_story = arg_524_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_0 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 and not isNil(arg_524_1.actors_["10102ui_story"]) then
				if arg_524_1.var_.characterEffect10102ui_story and not isNil(arg_524_1.actors_["10102ui_story"]) then
					arg_524_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_524_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_524_1.time_ - 0) / var_527_0)
				end
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 and not isNil(arg_524_1.actors_["10102ui_story"]) and arg_524_1.var_.characterEffect10102ui_story then
				arg_524_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_524_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_527_1 = 0
			local var_527_2 = 0.725

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_3 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(1108410127).content)

				arg_524_1.text_.text = var_527_3

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 29 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 29)

				if (29 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 29)) > 0 and var_527_2 < var_527_5 then
					arg_524_1.talkMaxDuration = var_527_5

					if var_527_5 + var_527_1 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_5 + var_527_1
					end
				end

				arg_524_1.text_.text = var_527_3
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_6 = math.max(var_527_2, arg_524_1.talkMaxDuration)

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_6 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_1) / var_527_6

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_1 + var_527_6 and arg_524_1.time_ < var_527_1 + var_527_6 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play1108410128 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1108410128
		arg_528_1.duration_ = 2

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1108410129(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(arg_528_1.actors_["10102ui_story"]) and arg_528_1.var_.characterEffect10102ui_story == nil then
				arg_528_1.var_.characterEffect10102ui_story = arg_528_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_0 = 0.200000002980232

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_0 and not isNil(arg_528_1.actors_["10102ui_story"]) then
				if arg_528_1.var_.characterEffect10102ui_story and not isNil(arg_528_1.actors_["10102ui_story"]) then
					arg_528_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= 0 + var_531_0 and arg_528_1.time_ < 0 + var_531_0 + arg_531_0 and not isNil(arg_528_1.actors_["10102ui_story"]) and arg_528_1.var_.characterEffect10102ui_story then
				arg_528_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganD", "EmotionTimelineAnimator")
			end

			local var_531_2 = 0
			local var_531_3 = 0.075

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_2 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_4 = arg_528_1:GetWordFromCfg(1108410128)
				local var_531_5 = arg_528_1:FormatText(var_531_4.content)

				arg_528_1.text_.text = var_531_5

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_7 = 3 <= 0 and var_531_3 or var_531_3 * (utf8.len(var_531_5) / 3)

				if (3 <= 0 and var_531_3 or var_531_3 * (utf8.len(var_531_5) / 3)) > 0 and var_531_3 < var_531_7 then
					arg_528_1.talkMaxDuration = var_531_7

					if var_531_7 + var_531_2 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_7 + var_531_2
					end
				end

				arg_528_1.text_.text = var_531_5
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410128", "story_v_side_new_1108410.awb") ~= 0 then
					local var_531_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410128", "story_v_side_new_1108410.awb") / 1000

					if var_531_8 + var_531_2 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_8 + var_531_2
					end

					if var_531_4.prefab_name ~= "" and arg_528_1.actors_[var_531_4.prefab_name] ~= nil then
						local var_531_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_4.prefab_name].transform, "story_v_side_new_1108410", "1108410128", "story_v_side_new_1108410.awb")

						arg_528_1:RecordAudio("1108410128", var_531_9)
						arg_528_1:RecordAudio("1108410128", var_531_9)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410128", "story_v_side_new_1108410.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410128", "story_v_side_new_1108410.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_10 = math.max(var_531_3, arg_528_1.talkMaxDuration)

			if var_531_2 <= arg_528_1.time_ and arg_528_1.time_ < var_531_2 + var_531_10 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_2) / var_531_10

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_2 + var_531_10 and arg_528_1.time_ < var_531_2 + var_531_10 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1108410129 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1108410129
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1108410130(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 and not isNil(arg_532_1.actors_["10102ui_story"]) and arg_532_1.var_.characterEffect10102ui_story == nil then
				arg_532_1.var_.characterEffect10102ui_story = arg_532_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_535_0 = 0.200000002980232

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_0 and not isNil(arg_532_1.actors_["10102ui_story"]) then
				if arg_532_1.var_.characterEffect10102ui_story and not isNil(arg_532_1.actors_["10102ui_story"]) then
					arg_532_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_532_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_532_1.time_ - 0) / var_535_0)
				end
			end

			if arg_532_1.time_ >= 0 + var_535_0 and arg_532_1.time_ < 0 + var_535_0 + arg_535_0 and not isNil(arg_532_1.actors_["10102ui_story"]) and arg_532_1.var_.characterEffect10102ui_story then
				arg_532_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_532_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_535_1 = 0
			local var_535_2 = 0.725

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_3 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(1108410129).content)

				arg_532_1.text_.text = var_535_3

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 29 <= 0 and var_535_2 or var_535_2 * (utf8.len(var_535_3) / 29)

				if (29 <= 0 and var_535_2 or var_535_2 * (utf8.len(var_535_3) / 29)) > 0 and var_535_2 < var_535_5 then
					arg_532_1.talkMaxDuration = var_535_5

					if var_535_5 + var_535_1 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_5 + var_535_1
					end
				end

				arg_532_1.text_.text = var_535_3
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_6 = math.max(var_535_2, arg_532_1.talkMaxDuration)

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_6 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_1) / var_535_6

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_1 + var_535_6 and arg_532_1.time_ < var_535_1 + var_535_6 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1108410130 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1108410130
		arg_536_1.duration_ = 3.87

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1108410131(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(arg_536_1.actors_["10102ui_story"]) and arg_536_1.var_.characterEffect10102ui_story == nil then
				arg_536_1.var_.characterEffect10102ui_story = arg_536_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_0 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 and not isNil(arg_536_1.actors_["10102ui_story"]) then
				if arg_536_1.var_.characterEffect10102ui_story and not isNil(arg_536_1.actors_["10102ui_story"]) then
					arg_536_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 and not isNil(arg_536_1.actors_["10102ui_story"]) and arg_536_1.var_.characterEffect10102ui_story then
				arg_536_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_539_2 = 0
			local var_539_3 = 0.475

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_2 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_4 = arg_536_1:GetWordFromCfg(1108410130)
				local var_539_5 = arg_536_1:FormatText(var_539_4.content)

				arg_536_1.text_.text = var_539_5

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_7 = 19 <= 0 and var_539_3 or var_539_3 * (utf8.len(var_539_5) / 19)

				if (19 <= 0 and var_539_3 or var_539_3 * (utf8.len(var_539_5) / 19)) > 0 and var_539_3 < var_539_7 then
					arg_536_1.talkMaxDuration = var_539_7

					if var_539_7 + var_539_2 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_7 + var_539_2
					end
				end

				arg_536_1.text_.text = var_539_5
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410130", "story_v_side_new_1108410.awb") ~= 0 then
					local var_539_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410130", "story_v_side_new_1108410.awb") / 1000

					if var_539_8 + var_539_2 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_8 + var_539_2
					end

					if var_539_4.prefab_name ~= "" and arg_536_1.actors_[var_539_4.prefab_name] ~= nil then
						local var_539_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_4.prefab_name].transform, "story_v_side_new_1108410", "1108410130", "story_v_side_new_1108410.awb")

						arg_536_1:RecordAudio("1108410130", var_539_9)
						arg_536_1:RecordAudio("1108410130", var_539_9)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410130", "story_v_side_new_1108410.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410130", "story_v_side_new_1108410.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_10 = math.max(var_539_3, arg_536_1.talkMaxDuration)

			if var_539_2 <= arg_536_1.time_ and arg_536_1.time_ < var_539_2 + var_539_10 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_2) / var_539_10

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_2 + var_539_10 and arg_536_1.time_ < var_539_2 + var_539_10 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play1108410131 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1108410131
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1108410132(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 and not isNil(arg_540_1.actors_["10102ui_story"]) and arg_540_1.var_.characterEffect10102ui_story == nil then
				arg_540_1.var_.characterEffect10102ui_story = arg_540_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_0 = 0.200000002980232

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_0 and not isNil(arg_540_1.actors_["10102ui_story"]) then
				if arg_540_1.var_.characterEffect10102ui_story and not isNil(arg_540_1.actors_["10102ui_story"]) then
					arg_540_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_540_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_540_1.time_ - 0) / var_543_0)
				end
			end

			if arg_540_1.time_ >= 0 + var_543_0 and arg_540_1.time_ < 0 + var_543_0 + arg_543_0 and not isNil(arg_540_1.actors_["10102ui_story"]) and arg_540_1.var_.characterEffect10102ui_story then
				arg_540_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_540_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_543_1 = 0
			local var_543_2 = 0.35

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_3 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(1108410131).content)

				arg_540_1.text_.text = var_543_3

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 14 <= 0 and var_543_2 or var_543_2 * (utf8.len(var_543_3) / 14)

				if (14 <= 0 and var_543_2 or var_543_2 * (utf8.len(var_543_3) / 14)) > 0 and var_543_2 < var_543_5 then
					arg_540_1.talkMaxDuration = var_543_5

					if var_543_5 + var_543_1 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + var_543_1
					end
				end

				arg_540_1.text_.text = var_543_3
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_6 = math.max(var_543_2, arg_540_1.talkMaxDuration)

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_6 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_1) / var_543_6

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_1 + var_543_6 and arg_540_1.time_ < var_543_1 + var_543_6 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play1108410132 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1108410132
		arg_544_1.duration_ = 1.37

		SetActive(arg_544_1.tipsGo_, true)

		arg_544_1.tipsText_.text = StoryTipsCfg[108401].name

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"

			SetActive(arg_544_1.choicesGo_, true)

			for iter_545_0, iter_545_1 in ipairs(arg_544_1.choices_) do
				SetActive(iter_545_1.go, iter_545_0 <= 3)
			end

			arg_544_1.choices_[1].txt.text = arg_544_1:FormatText(StoryChoiceCfg[1706].name)
			arg_544_1.choices_[2].txt.text = arg_544_1:FormatText(StoryChoiceCfg[1707].name)
			arg_544_1.choices_[3].txt.text = arg_544_1:FormatText(StoryChoiceCfg[1708].name)
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				PlayerAction.UseStoryTrigger(1084015, 210840110, 1108410132, 1)
				arg_544_0:Play1108410133(arg_544_1)
			end

			if arg_546_0 == 2 then
				PlayerAction.UseStoryTrigger(1084015, 210840110, 1108410132, 2)
				arg_544_0:Play1108410133(arg_544_1)
			end

			if arg_546_0 == 3 then
				PlayerAction.UseStoryTrigger(1084015, 210840110, 1108410132, 3)
				arg_544_0:Play1108410133(arg_544_1)
			end

			arg_544_1:RecordChoiceLog(1108410132, 1706, 1707, 1708)
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.allBtn_.enabled = false
			end

			if arg_544_1.time_ >= 0 + 0.666666666666667 and arg_544_1.time_ < 0 + 0.666666666666667 + arg_547_0 then
				arg_544_1.allBtn_.enabled = true
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play1108410133 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 1108410133
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play1108410134(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0.575

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, true)
				arg_548_1.iconController_:SetSelectedState("hero")

				arg_548_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_548_1.callingController_:SetSelectedState("normal")

				arg_548_1.keyicon_.color = Color.New(1, 1, 1)
				arg_548_1.icon_.color = Color.New(1, 1, 1)

				local var_551_1 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(1108410133).content)

				arg_548_1.text_.text = var_551_1

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_3 = 23 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_1) / 23)

				if (23 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_1) / 23)) > 0 and var_551_0 < var_551_3 then
					arg_548_1.talkMaxDuration = var_551_3

					if var_551_3 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_3 + 0
					end
				end

				arg_548_1.text_.text = var_551_1
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_4 = math.max(var_551_0, arg_548_1.talkMaxDuration)

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_4 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - 0) / var_551_4

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= 0 + var_551_4 and arg_548_1.time_ < 0 + var_551_4 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play1108410134 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1108410134
		arg_552_1.duration_ = 1.9

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play1108410135(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.175

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_1 = arg_552_1:GetWordFromCfg(1108410134)
				local var_555_2 = arg_552_1:FormatText(var_555_1.content)

				arg_552_1.text_.text = var_555_2

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_4 = 7 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 7)

				if (7 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 7)) > 0 and var_555_0 < var_555_4 then
					arg_552_1.talkMaxDuration = var_555_4

					if var_555_4 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_4 + 0
					end
				end

				arg_552_1.text_.text = var_555_2
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410134", "story_v_side_new_1108410.awb") ~= 0 then
					local var_555_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410134", "story_v_side_new_1108410.awb") / 1000

					if var_555_5 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + 0
					end

					if var_555_1.prefab_name ~= "" and arg_552_1.actors_[var_555_1.prefab_name] ~= nil then
						local var_555_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_1.prefab_name].transform, "story_v_side_new_1108410", "1108410134", "story_v_side_new_1108410.awb")

						arg_552_1:RecordAudio("1108410134", var_555_6)
						arg_552_1:RecordAudio("1108410134", var_555_6)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410134", "story_v_side_new_1108410.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410134", "story_v_side_new_1108410.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_7 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_7 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_7

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_7 and arg_552_1.time_ < 0 + var_555_7 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play1108410135 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 1108410135
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play1108410136(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(arg_556_1.actors_["10102ui_story"]) and arg_556_1.var_.characterEffect10102ui_story == nil then
				arg_556_1.var_.characterEffect10102ui_story = arg_556_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_0 = 0.200000002980232

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_0 and not isNil(arg_556_1.actors_["10102ui_story"]) then
				if arg_556_1.var_.characterEffect10102ui_story and not isNil(arg_556_1.actors_["10102ui_story"]) then
					arg_556_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_556_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_556_1.time_ - 0) / var_559_0)
				end
			end

			if arg_556_1.time_ >= 0 + var_559_0 and arg_556_1.time_ < 0 + var_559_0 + arg_559_0 and not isNil(arg_556_1.actors_["10102ui_story"]) and arg_556_1.var_.characterEffect10102ui_story then
				arg_556_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_556_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_559_1 = 0
			local var_559_2 = 1.025

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_1 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, true)
				arg_556_1.iconController_:SetSelectedState("hero")

				arg_556_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_556_1.callingController_:SetSelectedState("normal")

				arg_556_1.keyicon_.color = Color.New(1, 1, 1)
				arg_556_1.icon_.color = Color.New(1, 1, 1)

				local var_559_3 = arg_556_1:FormatText(arg_556_1:GetWordFromCfg(1108410135).content)

				arg_556_1.text_.text = var_559_3

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_5 = 41 <= 0 and var_559_2 or var_559_2 * (utf8.len(var_559_3) / 41)

				if (41 <= 0 and var_559_2 or var_559_2 * (utf8.len(var_559_3) / 41)) > 0 and var_559_2 < var_559_5 then
					arg_556_1.talkMaxDuration = var_559_5

					if var_559_5 + var_559_1 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_5 + var_559_1
					end
				end

				arg_556_1.text_.text = var_559_3
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_6 = math.max(var_559_2, arg_556_1.talkMaxDuration)

			if var_559_1 <= arg_556_1.time_ and arg_556_1.time_ < var_559_1 + var_559_6 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_1) / var_559_6

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_1 + var_559_6 and arg_556_1.time_ < var_559_1 + var_559_6 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play1108410136 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 1108410136
		arg_560_1.duration_ = 4.27

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play1108410137(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0.425

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_1 = arg_560_1:GetWordFromCfg(1108410136)
				local var_563_2 = arg_560_1:FormatText(var_563_1.content)

				arg_560_1.text_.text = var_563_2

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_4 = 17 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 17)

				if (17 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 17)) > 0 and var_563_0 < var_563_4 then
					arg_560_1.talkMaxDuration = var_563_4

					if var_563_4 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_4 + 0
					end
				end

				arg_560_1.text_.text = var_563_2
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410136", "story_v_side_new_1108410.awb") ~= 0 then
					local var_563_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410136", "story_v_side_new_1108410.awb") / 1000

					if var_563_5 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + 0
					end

					if var_563_1.prefab_name ~= "" and arg_560_1.actors_[var_563_1.prefab_name] ~= nil then
						local var_563_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_1.prefab_name].transform, "story_v_side_new_1108410", "1108410136", "story_v_side_new_1108410.awb")

						arg_560_1:RecordAudio("1108410136", var_563_6)
						arg_560_1:RecordAudio("1108410136", var_563_6)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410136", "story_v_side_new_1108410.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410136", "story_v_side_new_1108410.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_7 = math.max(var_563_0, arg_560_1.talkMaxDuration)

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_7 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - 0) / var_563_7

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= 0 + var_563_7 and arg_560_1.time_ < 0 + var_563_7 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play1108410137 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 1108410137
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play1108410138(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 and not isNil(arg_564_1.actors_["10102ui_story"]) and arg_564_1.var_.characterEffect10102ui_story == nil then
				arg_564_1.var_.characterEffect10102ui_story = arg_564_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_0 = 0.200000002980232

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_0 and not isNil(arg_564_1.actors_["10102ui_story"]) then
				if arg_564_1.var_.characterEffect10102ui_story and not isNil(arg_564_1.actors_["10102ui_story"]) then
					arg_564_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_564_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_564_1.time_ - 0) / var_567_0)
				end
			end

			if arg_564_1.time_ >= 0 + var_567_0 and arg_564_1.time_ < 0 + var_567_0 + arg_567_0 and not isNil(arg_564_1.actors_["10102ui_story"]) and arg_564_1.var_.characterEffect10102ui_story then
				arg_564_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_564_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_567_1 = 0
			local var_567_2 = 0.425

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_3 = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(1108410137).content)

				arg_564_1.text_.text = var_567_3

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_5 = 17 <= 0 and var_567_2 or var_567_2 * (utf8.len(var_567_3) / 17)

				if (17 <= 0 and var_567_2 or var_567_2 * (utf8.len(var_567_3) / 17)) > 0 and var_567_2 < var_567_5 then
					arg_564_1.talkMaxDuration = var_567_5

					if var_567_5 + var_567_1 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_5 + var_567_1
					end
				end

				arg_564_1.text_.text = var_567_3
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_6 = math.max(var_567_2, arg_564_1.talkMaxDuration)

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_6 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_1) / var_567_6

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_1 + var_567_6 and arg_564_1.time_ < var_567_1 + var_567_6 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play1108410138 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 1108410138
		arg_568_1.duration_ = 2.73

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play1108410139(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.var_.moveOldPosR8406 = arg_568_1.bgs_.R8406.transform.localPosition
			end

			local var_571_0 = 2.05

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_0 then
				arg_568_1.bgs_.R8406.transform.localPosition = Vector3.Lerp(arg_568_1.var_.moveOldPosR8406, Vector3.New(0, 0.5, 5.5), (arg_568_1.time_ - 0) / var_571_0)
			end

			if arg_568_1.time_ >= 0 + var_571_0 and arg_568_1.time_ < 0 + var_571_0 + arg_571_0 then
				arg_568_1.bgs_.R8406.transform.localPosition = Vector3.New(0, 0.5, 5.5)
			end

			local var_571_1 = 0
			local var_571_2 = 0.225

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_1 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				arg_568_1.leftNameTxt_.text = arg_568_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_3 = arg_568_1:GetWordFromCfg(1108410138)
				local var_571_4 = arg_568_1:FormatText(var_571_3.content)

				arg_568_1.text_.text = var_571_4

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_6 = 9 <= 0 and var_571_2 or var_571_2 * (utf8.len(var_571_4) / 9)

				if (9 <= 0 and var_571_2 or var_571_2 * (utf8.len(var_571_4) / 9)) > 0 and var_571_2 < var_571_6 then
					arg_568_1.talkMaxDuration = var_571_6

					if var_571_6 + var_571_1 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_6 + var_571_1
					end
				end

				arg_568_1.text_.text = var_571_4
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410138", "story_v_side_new_1108410.awb") ~= 0 then
					local var_571_7 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410138", "story_v_side_new_1108410.awb") / 1000

					if var_571_7 + var_571_1 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_7 + var_571_1
					end

					if var_571_3.prefab_name ~= "" and arg_568_1.actors_[var_571_3.prefab_name] ~= nil then
						local var_571_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_3.prefab_name].transform, "story_v_side_new_1108410", "1108410138", "story_v_side_new_1108410.awb")

						arg_568_1:RecordAudio("1108410138", var_571_8)
						arg_568_1:RecordAudio("1108410138", var_571_8)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410138", "story_v_side_new_1108410.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410138", "story_v_side_new_1108410.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_9 = math.max(var_571_2, arg_568_1.talkMaxDuration)

			if var_571_1 <= arg_568_1.time_ and arg_568_1.time_ < var_571_1 + var_571_9 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_1) / var_571_9

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_1 + var_571_9 and arg_568_1.time_ < var_571_1 + var_571_9 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R8406",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.05,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0.5, 6),
					endPos = Vector3.New(0, 0.5, 5.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_568_1:InitPlayNodeList()
	end,
	Play1108410139 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 1108410139
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play1108410140(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 and not isNil(arg_572_1.actors_["10102ui_story"]) and arg_572_1.var_.characterEffect10102ui_story == nil then
				arg_572_1.var_.characterEffect10102ui_story = arg_572_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_0 = 0.200000002980232

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_0 and not isNil(arg_572_1.actors_["10102ui_story"]) then
				if arg_572_1.var_.characterEffect10102ui_story and not isNil(arg_572_1.actors_["10102ui_story"]) then
					arg_572_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_572_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_572_1.time_ - 0) / var_575_0)
				end
			end

			if arg_572_1.time_ >= 0 + var_575_0 and arg_572_1.time_ < 0 + var_575_0 + arg_575_0 and not isNil(arg_572_1.actors_["10102ui_story"]) and arg_572_1.var_.characterEffect10102ui_story then
				arg_572_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_572_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_575_1 = 0
			local var_575_2 = 0.125

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_1 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, true)
				arg_572_1.iconController_:SetSelectedState("hero")

				arg_572_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_572_1.callingController_:SetSelectedState("normal")

				arg_572_1.keyicon_.color = Color.New(1, 1, 1)
				arg_572_1.icon_.color = Color.New(1, 1, 1)

				local var_575_3 = arg_572_1:FormatText(arg_572_1:GetWordFromCfg(1108410139).content)

				arg_572_1.text_.text = var_575_3

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_5 = 5 <= 0 and var_575_2 or var_575_2 * (utf8.len(var_575_3) / 5)

				if (5 <= 0 and var_575_2 or var_575_2 * (utf8.len(var_575_3) / 5)) > 0 and var_575_2 < var_575_5 then
					arg_572_1.talkMaxDuration = var_575_5

					if var_575_5 + var_575_1 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_5 + var_575_1
					end
				end

				arg_572_1.text_.text = var_575_3
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_6 = math.max(var_575_2, arg_572_1.talkMaxDuration)

			if var_575_1 <= arg_572_1.time_ and arg_572_1.time_ < var_575_1 + var_575_6 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_1) / var_575_6

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_1 + var_575_6 and arg_572_1.time_ < var_575_1 + var_575_6 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play1108410140 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 1108410140
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play1108410141(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 1.9

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				arg_576_1.leftNameTxt_.text = arg_576_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, true)
				arg_576_1.iconController_:SetSelectedState("hero")

				arg_576_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_576_1.callingController_:SetSelectedState("normal")

				arg_576_1.keyicon_.color = Color.New(1, 1, 1)
				arg_576_1.icon_.color = Color.New(1, 1, 1)

				local var_579_1 = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(1108410140).content)

				arg_576_1.text_.text = var_579_1

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_3 = 76 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_1) / 76)

				if (76 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_1) / 76)) > 0 and var_579_0 < var_579_3 then
					arg_576_1.talkMaxDuration = var_579_3

					if var_579_3 + 0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_3 + 0
					end
				end

				arg_576_1.text_.text = var_579_1
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_4 = math.max(var_579_0, arg_576_1.talkMaxDuration)

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_4 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - 0) / var_579_4

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= 0 + var_579_4 and arg_576_1.time_ < 0 + var_579_4 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play1108410141 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 1108410141
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play1108410142(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = 1.2

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				arg_580_1.leftNameTxt_.text = arg_580_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, true)
				arg_580_1.iconController_:SetSelectedState("hero")

				arg_580_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_580_1.callingController_:SetSelectedState("normal")

				arg_580_1.keyicon_.color = Color.New(1, 1, 1)
				arg_580_1.icon_.color = Color.New(1, 1, 1)

				local var_583_1 = arg_580_1:FormatText(arg_580_1:GetWordFromCfg(1108410141).content)

				arg_580_1.text_.text = var_583_1

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_3 = 48 <= 0 and var_583_0 or var_583_0 * (utf8.len(var_583_1) / 48)

				if (48 <= 0 and var_583_0 or var_583_0 * (utf8.len(var_583_1) / 48)) > 0 and var_583_0 < var_583_3 then
					arg_580_1.talkMaxDuration = var_583_3

					if var_583_3 + 0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_3 + 0
					end
				end

				arg_580_1.text_.text = var_583_1
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_4 = math.max(var_583_0, arg_580_1.talkMaxDuration)

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_4 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - 0) / var_583_4

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= 0 + var_583_4 and arg_580_1.time_ < 0 + var_583_4 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play1108410142 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 1108410142
		arg_584_1.duration_ = 5.7

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play1108410143(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 0.6

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				arg_584_1.leftNameTxt_.text = arg_584_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_1 = arg_584_1:GetWordFromCfg(1108410142)
				local var_587_2 = arg_584_1:FormatText(var_587_1.content)

				arg_584_1.text_.text = var_587_2

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_4 = 24 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_2) / 24)

				if (24 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_2) / 24)) > 0 and var_587_0 < var_587_4 then
					arg_584_1.talkMaxDuration = var_587_4

					if var_587_4 + 0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_4 + 0
					end
				end

				arg_584_1.text_.text = var_587_2
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410142", "story_v_side_new_1108410.awb") ~= 0 then
					local var_587_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410142", "story_v_side_new_1108410.awb") / 1000

					if var_587_5 + 0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_5 + 0
					end

					if var_587_1.prefab_name ~= "" and arg_584_1.actors_[var_587_1.prefab_name] ~= nil then
						local var_587_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_1.prefab_name].transform, "story_v_side_new_1108410", "1108410142", "story_v_side_new_1108410.awb")

						arg_584_1:RecordAudio("1108410142", var_587_6)
						arg_584_1:RecordAudio("1108410142", var_587_6)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410142", "story_v_side_new_1108410.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410142", "story_v_side_new_1108410.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_7 = math.max(var_587_0, arg_584_1.talkMaxDuration)

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_7 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - 0) / var_587_7

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= 0 + var_587_7 and arg_584_1.time_ < 0 + var_587_7 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play1108410143 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 1108410143
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play1108410144(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 and not isNil(arg_588_1.actors_["10102ui_story"]) and arg_588_1.var_.characterEffect10102ui_story == nil then
				arg_588_1.var_.characterEffect10102ui_story = arg_588_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_591_0 = 0.200000002980232

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_0 and not isNil(arg_588_1.actors_["10102ui_story"]) then
				if arg_588_1.var_.characterEffect10102ui_story and not isNil(arg_588_1.actors_["10102ui_story"]) then
					arg_588_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_588_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_588_1.time_ - 0) / var_591_0)
				end
			end

			if arg_588_1.time_ >= 0 + var_591_0 and arg_588_1.time_ < 0 + var_591_0 + arg_591_0 and not isNil(arg_588_1.actors_["10102ui_story"]) and arg_588_1.var_.characterEffect10102ui_story then
				arg_588_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_588_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_591_1 = 0
			local var_591_2 = 1.55

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, true)
				arg_588_1.iconController_:SetSelectedState("hero")

				arg_588_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_588_1.callingController_:SetSelectedState("normal")

				arg_588_1.keyicon_.color = Color.New(1, 1, 1)
				arg_588_1.icon_.color = Color.New(1, 1, 1)

				local var_591_3 = arg_588_1:FormatText(arg_588_1:GetWordFromCfg(1108410143).content)

				arg_588_1.text_.text = var_591_3

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_5 = 62 <= 0 and var_591_2 or var_591_2 * (utf8.len(var_591_3) / 62)

				if (62 <= 0 and var_591_2 or var_591_2 * (utf8.len(var_591_3) / 62)) > 0 and var_591_2 < var_591_5 then
					arg_588_1.talkMaxDuration = var_591_5

					if var_591_5 + var_591_1 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_5 + var_591_1
					end
				end

				arg_588_1.text_.text = var_591_3
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_6 = math.max(var_591_2, arg_588_1.talkMaxDuration)

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_6 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_1) / var_591_6

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_1 + var_591_6 and arg_588_1.time_ < var_591_1 + var_591_6 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play1108410144 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 1108410144
		arg_592_1.duration_ = 1.5

		SetActive(arg_592_1.tipsGo_, true)

		arg_592_1.tipsText_.text = StoryTipsCfg[108401].name

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"

			SetActive(arg_592_1.choicesGo_, true)

			for iter_593_0, iter_593_1 in ipairs(arg_592_1.choices_) do
				SetActive(iter_593_1.go, iter_593_0 <= 2)
			end

			arg_592_1.choices_[1].txt.text = arg_592_1:FormatText(StoryChoiceCfg[1709].name)
			arg_592_1.choices_[2].txt.text = arg_592_1:FormatText(StoryChoiceCfg[1710].name)
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				PlayerAction.UseStoryTrigger(1084016, 210840110, 1108410144, 1)
				arg_592_0:Play1108410145(arg_592_1)
			end

			if arg_594_0 == 2 then
				PlayerAction.UseStoryTrigger(1084016, 210840110, 1108410144, 2)
				arg_592_0:Play1108410145(arg_592_1)
			end

			arg_592_1:RecordChoiceLog(1108410144, 1709, 1710)
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1.allBtn_.enabled = false
			end

			if arg_592_1.time_ >= 0 + 1 and arg_592_1.time_ < 0 + 1 + arg_595_0 then
				arg_592_1.allBtn_.enabled = true
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play1108410145 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 1108410145
		arg_596_1.duration_ = 11

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play1108410146(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_9001
			local var_599_9000

			if arg_596_1.bgs_.R8406a == nil then
				local var_599_0 = Object.Instantiate(arg_596_1.paintGo_)

				var_599_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R8406a")
				var_599_0.name = "R8406a"
				var_599_0.transform.parent = arg_596_1.stage_.transform
				var_599_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_596_1.bgs_.R8406a = var_599_0
			end

			if 1.03333333333333 < arg_596_1.time_ and arg_596_1.time_ <= 1.03333333333333 + arg_599_0 then
				local var_599_1 = arg_596_1.bgs_.R8406a

				arg_596_1.bgs_.R8406a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_599_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_599_2 = var_599_1:GetComponent("SpriteRenderer")

				if var_599_2 and var_599_2.sprite then
					local var_599_3 = 2 * (var_599_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_599_1.transform.localScale = Vector3.New(var_599_3 / var_599_2.sprite.bounds.size.y < var_599_3 * manager.ui.mainCameraCom_.aspect / var_599_2.sprite.bounds.size.x and var_599_3 * manager.ui.mainCameraCom_.aspect / var_599_2.sprite.bounds.size.x or var_599_3 / var_599_2.sprite.bounds.size.y, var_599_3 / var_599_2.sprite.bounds.size.y < var_599_3 * manager.ui.mainCameraCom_.aspect / var_599_2.sprite.bounds.size.x and var_599_3 * manager.ui.mainCameraCom_.aspect / var_599_2.sprite.bounds.size.x or var_599_3 / var_599_2.sprite.bounds.size.y, 0)
				end

				for iter_599_0, iter_599_1 in pairs(arg_596_1.bgs_) do
					if iter_599_0 ~= "R8406a" then
						iter_599_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_599_4 = 3.03333333333333

			if 3.03333333333333 < arg_596_1.time_ and arg_596_1.time_ <= var_599_4 + arg_599_0 then
				arg_596_1.allBtn_.enabled = false
			end

			if arg_596_1.time_ >= var_599_4 + 0.3 and arg_596_1.time_ < var_599_4 + 0.3 + arg_599_0 then
				arg_596_1.allBtn_.enabled = true
			end

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				local var_599_5 = arg_596_1.var_.effectliuleizhuanchang1

				if not arg_596_1.var_.effectliuleizhuanchang1 then
					var_599_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_in_keep"), manager.ui.mainCamera.transform)
					var_599_5.name = "liuleizhuanchang1"
					arg_596_1.var_.effectliuleizhuanchang1 = var_599_5
				else
					var_599_5.transform:SetParent(var_599_9001)
				end

				var_599_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_599_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_596_1.time_ and arg_596_1.time_ <= 1.2 + arg_599_0 then
				if arg_596_1.var_.effectliuleizhuanchang1 then
					Object.Destroy(arg_596_1.var_.effectliuleizhuanchang1)

					arg_596_1.var_.effectliuleizhuanchang1 = nil
				end
			end

			local var_599_8 = arg_596_1.actors_["10102ui_story"].transform

			if 1.96599999815226 < arg_596_1.time_ and arg_596_1.time_ <= 1.96599999815226 + arg_599_0 then
				arg_596_1.var_.moveOldPos10102ui_story = var_599_8.localPosition
			end

			local var_599_9 = 0.001

			if 1.96599999815226 <= arg_596_1.time_ and arg_596_1.time_ < 1.96599999815226 + var_599_9 then
				var_599_8.localPosition = Vector3.Lerp(arg_596_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_596_1.time_ - 1.96599999815226) / var_599_9)
				var_599_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_599_8.position).x, (manager.ui.mainCamera.transform.position - var_599_8.position).y, (manager.ui.mainCamera.transform.position - var_599_8.position).z)
				var_599_8.localEulerAngles.z = 0
				var_599_8.localEulerAngles.x = 0
				var_599_8.localEulerAngles = var_599_8.localEulerAngles
			end

			if arg_596_1.time_ >= 1.96599999815226 + var_599_9 and arg_596_1.time_ < 1.96599999815226 + var_599_9 + arg_599_0 then
				var_599_8.localPosition = Vector3.New(0, 100, 0)
				var_599_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_599_8.position).x, (manager.ui.mainCamera.transform.position - var_599_8.position).y, (manager.ui.mainCamera.transform.position - var_599_8.position).z)
				var_599_8.localEulerAngles.z = 0
				var_599_8.localEulerAngles.x = 0
				var_599_8.localEulerAngles = var_599_8.localEulerAngles
			end

			if 1.2 < arg_596_1.time_ and arg_596_1.time_ <= 1.2 + arg_599_0 then
				local var_599_10 = arg_596_1.var_.effectliuleizhuanchang2

				if not arg_596_1.var_.effectliuleizhuanchang2 then
					var_599_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_out"), manager.ui.mainCamera.transform)
					var_599_10.name = "liuleizhuanchang2"
					arg_596_1.var_.effectliuleizhuanchang2 = var_599_10
				else
					var_599_10.transform:SetParent(var_599_9000)
				end

				var_599_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_599_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.8 < arg_596_1.time_ and arg_596_1.time_ <= 1.8 + arg_599_0 then
				if arg_596_1.var_.effectliuleizhuanchang2 then
					Object.Destroy(arg_596_1.var_.effectliuleizhuanchang2)

					arg_596_1.var_.effectliuleizhuanchang2 = nil
				end
			end

			if 0.6 < arg_596_1.time_ and arg_596_1.time_ <= 0.6 + arg_599_0 then
				if arg_596_1.var_.effectboguang1 then
					Object.Destroy(arg_596_1.var_.effectboguang1)

					arg_596_1.var_.effectboguang1 = nil
				end
			end

			if arg_596_1.frameCnt_ <= 1 then
				arg_596_1.dialog_:SetActive(false)
			end

			local var_599_14 = 3.03333333333333
			local var_599_15 = 0.475

			if 3.03333333333333 < arg_596_1.time_ and arg_596_1.time_ <= var_599_14 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0

				arg_596_1.dialog_:SetActive(true)

				arg_596_1.dialogCg_.alpha = 0

				local var_599_16 = LeanTween.value(arg_596_1.dialog_, 0, 1, 0.3)

				var_599_16:setOnUpdate(LuaHelper.FloatAction(function(arg_600_0)
					arg_596_1.dialogCg_.alpha = arg_600_0
				end))
				var_599_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_596_1.dialog_)
					var_599_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_596_1.duration_ = arg_596_1.duration_ + 0.3

				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_17 = arg_596_1:GetWordFromCfg(1108410145)
				local var_599_18 = arg_596_1:FormatText(var_599_17.content)

				arg_596_1.text_.text = var_599_18

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_20 = 19 <= 0 and var_599_15 or var_599_15 * (utf8.len(var_599_18) / 19)

				if (19 <= 0 and var_599_15 or var_599_15 * (utf8.len(var_599_18) / 19)) > 0 and var_599_15 < var_599_20 then
					arg_596_1.talkMaxDuration = var_599_20
					var_599_14 = var_599_14 + 0.3

					if var_599_20 + var_599_14 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_20 + var_599_14
					end
				end

				arg_596_1.text_.text = var_599_18
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410145", "story_v_side_new_1108410.awb") ~= 0 then
					local var_599_21 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410145", "story_v_side_new_1108410.awb") / 1000

					if var_599_21 + var_599_14 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_21 + var_599_14
					end

					if var_599_17.prefab_name ~= "" and arg_596_1.actors_[var_599_17.prefab_name] ~= nil then
						local var_599_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_17.prefab_name].transform, "story_v_side_new_1108410", "1108410145", "story_v_side_new_1108410.awb")

						arg_596_1:RecordAudio("1108410145", var_599_22)
						arg_596_1:RecordAudio("1108410145", var_599_22)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410145", "story_v_side_new_1108410.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410145", "story_v_side_new_1108410.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_23 = var_599_14 + 0.3
			local var_599_24 = math.max(var_599_15, arg_596_1.talkMaxDuration)

			if var_599_14 + 0.3 <= arg_596_1.time_ and arg_596_1.time_ < var_599_23 + var_599_24 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_23) / var_599_24

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_23 + var_599_24 and arg_596_1.time_ < var_599_23 + var_599_24 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {
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

		arg_596_1:InitPlayNodeList()
	end,
	Play1108410146 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1108410146
		arg_602_1.duration_ = 5

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1108410147(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			local var_605_0 = 0.875

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				arg_602_1.leftNameTxt_.text = arg_602_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, true)
				arg_602_1.iconController_:SetSelectedState("hero")

				arg_602_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_602_1.callingController_:SetSelectedState("normal")

				arg_602_1.keyicon_.color = Color.New(1, 1, 1)
				arg_602_1.icon_.color = Color.New(1, 1, 1)

				local var_605_1 = arg_602_1:FormatText(arg_602_1:GetWordFromCfg(1108410146).content)

				arg_602_1.text_.text = var_605_1

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_3 = 35 <= 0 and var_605_0 or var_605_0 * (utf8.len(var_605_1) / 35)

				if (35 <= 0 and var_605_0 or var_605_0 * (utf8.len(var_605_1) / 35)) > 0 and var_605_0 < var_605_3 then
					arg_602_1.talkMaxDuration = var_605_3

					if var_605_3 + 0 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_3 + 0
					end
				end

				arg_602_1.text_.text = var_605_1
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)
				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_4 = math.max(var_605_0, arg_602_1.talkMaxDuration)

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_4 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - 0) / var_605_4

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= 0 + var_605_4 and arg_602_1.time_ < 0 + var_605_4 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {}

		arg_602_1:InitPlayNodeList()
	end,
	Play1108410147 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1108410147
		arg_606_1.duration_ = 9.3

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1108410148(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = 1.2

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				arg_606_1.leftNameTxt_.text = arg_606_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_1 = arg_606_1:GetWordFromCfg(1108410147)
				local var_609_2 = arg_606_1:FormatText(var_609_1.content)

				arg_606_1.text_.text = var_609_2

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_4 = 48 <= 0 and var_609_0 or var_609_0 * (utf8.len(var_609_2) / 48)

				if (48 <= 0 and var_609_0 or var_609_0 * (utf8.len(var_609_2) / 48)) > 0 and var_609_0 < var_609_4 then
					arg_606_1.talkMaxDuration = var_609_4

					if var_609_4 + 0 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_4 + 0
					end
				end

				arg_606_1.text_.text = var_609_2
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410147", "story_v_side_new_1108410.awb") ~= 0 then
					local var_609_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410147", "story_v_side_new_1108410.awb") / 1000

					if var_609_5 + 0 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_5 + 0
					end

					if var_609_1.prefab_name ~= "" and arg_606_1.actors_[var_609_1.prefab_name] ~= nil then
						local var_609_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_1.prefab_name].transform, "story_v_side_new_1108410", "1108410147", "story_v_side_new_1108410.awb")

						arg_606_1:RecordAudio("1108410147", var_609_6)
						arg_606_1:RecordAudio("1108410147", var_609_6)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410147", "story_v_side_new_1108410.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410147", "story_v_side_new_1108410.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_7 = math.max(var_609_0, arg_606_1.talkMaxDuration)

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_7 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - 0) / var_609_7

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= 0 + var_609_7 and arg_606_1.time_ < 0 + var_609_7 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {}

		arg_606_1:InitPlayNodeList()
	end,
	Play1108410148 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 1108410148
		arg_610_1.duration_ = 5

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play1108410149(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = 0.775

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, false)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_1 = arg_610_1:FormatText(arg_610_1:GetWordFromCfg(1108410148).content)

				arg_610_1.text_.text = var_613_1

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_3 = 31 <= 0 and var_613_0 or var_613_0 * (utf8.len(var_613_1) / 31)

				if (31 <= 0 and var_613_0 or var_613_0 * (utf8.len(var_613_1) / 31)) > 0 and var_613_0 < var_613_3 then
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
	Play1108410149 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1108410149
		arg_614_1.duration_ = 5

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1108410150(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = 0.25

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				arg_614_1.leftNameTxt_.text = arg_614_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, true)
				arg_614_1.iconController_:SetSelectedState("hero")

				arg_614_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_614_1.callingController_:SetSelectedState("normal")

				arg_614_1.keyicon_.color = Color.New(1, 1, 1)
				arg_614_1.icon_.color = Color.New(1, 1, 1)

				local var_617_1 = arg_614_1:FormatText(arg_614_1:GetWordFromCfg(1108410149).content)

				arg_614_1.text_.text = var_617_1

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_3 = 10 <= 0 and var_617_0 or var_617_0 * (utf8.len(var_617_1) / 10)

				if (10 <= 0 and var_617_0 or var_617_0 * (utf8.len(var_617_1) / 10)) > 0 and var_617_0 < var_617_3 then
					arg_614_1.talkMaxDuration = var_617_3

					if var_617_3 + 0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_3 + 0
					end
				end

				arg_614_1.text_.text = var_617_1
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)
				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_4 = math.max(var_617_0, arg_614_1.talkMaxDuration)

			if 0 <= arg_614_1.time_ and arg_614_1.time_ < 0 + var_617_4 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - 0) / var_617_4

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= 0 + var_617_4 and arg_614_1.time_ < 0 + var_617_4 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {}

		arg_614_1:InitPlayNodeList()
	end,
	Play1108410150 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1108410150
		arg_618_1.duration_ = 6.9

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play1108410151(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = 0.85

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				arg_618_1.leftNameTxt_.text = arg_618_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_1 = arg_618_1:GetWordFromCfg(1108410150)
				local var_621_2 = arg_618_1:FormatText(var_621_1.content)

				arg_618_1.text_.text = var_621_2

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_4 = 34 <= 0 and var_621_0 or var_621_0 * (utf8.len(var_621_2) / 34)

				if (34 <= 0 and var_621_0 or var_621_0 * (utf8.len(var_621_2) / 34)) > 0 and var_621_0 < var_621_4 then
					arg_618_1.talkMaxDuration = var_621_4

					if var_621_4 + 0 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_4 + 0
					end
				end

				arg_618_1.text_.text = var_621_2
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410150", "story_v_side_new_1108410.awb") ~= 0 then
					local var_621_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410150", "story_v_side_new_1108410.awb") / 1000

					if var_621_5 + 0 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_5 + 0
					end

					if var_621_1.prefab_name ~= "" and arg_618_1.actors_[var_621_1.prefab_name] ~= nil then
						local var_621_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_1.prefab_name].transform, "story_v_side_new_1108410", "1108410150", "story_v_side_new_1108410.awb")

						arg_618_1:RecordAudio("1108410150", var_621_6)
						arg_618_1:RecordAudio("1108410150", var_621_6)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410150", "story_v_side_new_1108410.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410150", "story_v_side_new_1108410.awb")
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
	Play1108410151 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1108410151
		arg_622_1.duration_ = 5

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1108410152(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = 0.4

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, true)
				arg_622_1.iconController_:SetSelectedState("hero")

				arg_622_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_622_1.callingController_:SetSelectedState("normal")

				arg_622_1.keyicon_.color = Color.New(1, 1, 1)
				arg_622_1.icon_.color = Color.New(1, 1, 1)

				local var_625_1 = arg_622_1:FormatText(arg_622_1:GetWordFromCfg(1108410151).content)

				arg_622_1.text_.text = var_625_1

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_3 = 16 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_1) / 16)

				if (16 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_1) / 16)) > 0 and var_625_0 < var_625_3 then
					arg_622_1.talkMaxDuration = var_625_3

					if var_625_3 + 0 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_3 + 0
					end
				end

				arg_622_1.text_.text = var_625_1
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)
				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_4 = math.max(var_625_0, arg_622_1.talkMaxDuration)

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_4 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - 0) / var_625_4

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= 0 + var_625_4 and arg_622_1.time_ < 0 + var_625_4 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play1108410152 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 1108410152
		arg_626_1.duration_ = 4.77

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play1108410153(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 0.575

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				arg_626_1.leftNameTxt_.text = arg_626_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_1 = arg_626_1:GetWordFromCfg(1108410152)
				local var_629_2 = arg_626_1:FormatText(var_629_1.content)

				arg_626_1.text_.text = var_629_2

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_4 = 23 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_2) / 23)

				if (23 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_2) / 23)) > 0 and var_629_0 < var_629_4 then
					arg_626_1.talkMaxDuration = var_629_4

					if var_629_4 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_4 + 0
					end
				end

				arg_626_1.text_.text = var_629_2
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410152", "story_v_side_new_1108410.awb") ~= 0 then
					local var_629_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410152", "story_v_side_new_1108410.awb") / 1000

					if var_629_5 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_5 + 0
					end

					if var_629_1.prefab_name ~= "" and arg_626_1.actors_[var_629_1.prefab_name] ~= nil then
						local var_629_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_1.prefab_name].transform, "story_v_side_new_1108410", "1108410152", "story_v_side_new_1108410.awb")

						arg_626_1:RecordAudio("1108410152", var_629_6)
						arg_626_1:RecordAudio("1108410152", var_629_6)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410152", "story_v_side_new_1108410.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410152", "story_v_side_new_1108410.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_7 = math.max(var_629_0, arg_626_1.talkMaxDuration)

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_7 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - 0) / var_629_7

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= 0 + var_629_7 and arg_626_1.time_ < 0 + var_629_7 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play1108410153 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 1108410153
		arg_630_1.duration_ = 5

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play1108410154(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = 0.625

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, false)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_1 = arg_630_1:FormatText(arg_630_1:GetWordFromCfg(1108410153).content)

				arg_630_1.text_.text = var_633_1

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_3 = 25 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_1) / 25)

				if (25 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_1) / 25)) > 0 and var_633_0 < var_633_3 then
					arg_630_1.talkMaxDuration = var_633_3

					if var_633_3 + 0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_3 + 0
					end
				end

				arg_630_1.text_.text = var_633_1
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)
				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_4 = math.max(var_633_0, arg_630_1.talkMaxDuration)

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_4 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - 0) / var_633_4

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= 0 + var_633_4 and arg_630_1.time_ < 0 + var_633_4 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play1108410154 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 1108410154
		arg_634_1.duration_ = 5

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play1108410155(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			local var_637_0 = 0.375

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, true)
				arg_634_1.iconController_:SetSelectedState("hero")

				arg_634_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_634_1.callingController_:SetSelectedState("normal")

				arg_634_1.keyicon_.color = Color.New(1, 1, 1)
				arg_634_1.icon_.color = Color.New(1, 1, 1)

				local var_637_1 = arg_634_1:FormatText(arg_634_1:GetWordFromCfg(1108410154).content)

				arg_634_1.text_.text = var_637_1

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_3 = 15 <= 0 and var_637_0 or var_637_0 * (utf8.len(var_637_1) / 15)

				if (15 <= 0 and var_637_0 or var_637_0 * (utf8.len(var_637_1) / 15)) > 0 and var_637_0 < var_637_3 then
					arg_634_1.talkMaxDuration = var_637_3

					if var_637_3 + 0 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_3 + 0
					end
				end

				arg_634_1.text_.text = var_637_1
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)
				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_4 = math.max(var_637_0, arg_634_1.talkMaxDuration)

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_4 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - 0) / var_637_4

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= 0 + var_637_4 and arg_634_1.time_ < 0 + var_637_4 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	Play1108410155 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 1108410155
		arg_638_1.duration_ = 4.6

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play1108410156(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			local var_641_0 = 0.375

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
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

				local var_641_1 = arg_638_1:GetWordFromCfg(1108410155)
				local var_641_2 = arg_638_1:FormatText(var_641_1.content)

				arg_638_1.text_.text = var_641_2

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_4 = 15 <= 0 and var_641_0 or var_641_0 * (utf8.len(var_641_2) / 15)

				if (15 <= 0 and var_641_0 or var_641_0 * (utf8.len(var_641_2) / 15)) > 0 and var_641_0 < var_641_4 then
					arg_638_1.talkMaxDuration = var_641_4

					if var_641_4 + 0 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_4 + 0
					end
				end

				arg_638_1.text_.text = var_641_2
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410155", "story_v_side_new_1108410.awb") ~= 0 then
					local var_641_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410155", "story_v_side_new_1108410.awb") / 1000

					if var_641_5 + 0 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_5 + 0
					end

					if var_641_1.prefab_name ~= "" and arg_638_1.actors_[var_641_1.prefab_name] ~= nil then
						local var_641_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_638_1.actors_[var_641_1.prefab_name].transform, "story_v_side_new_1108410", "1108410155", "story_v_side_new_1108410.awb")

						arg_638_1:RecordAudio("1108410155", var_641_6)
						arg_638_1:RecordAudio("1108410155", var_641_6)
					else
						arg_638_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410155", "story_v_side_new_1108410.awb")
					end

					arg_638_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410155", "story_v_side_new_1108410.awb")
				end

				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_7 = math.max(var_641_0, arg_638_1.talkMaxDuration)

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_7 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - 0) / var_641_7

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= 0 + var_641_7 and arg_638_1.time_ < 0 + var_641_7 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {}

		arg_638_1:InitPlayNodeList()
	end,
	Play1108410156 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 1108410156
		arg_642_1.duration_ = 5

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play1108410157(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			local var_645_0 = 0.575

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				arg_642_1.leftNameTxt_.text = arg_642_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, true)
				arg_642_1.iconController_:SetSelectedState("hero")

				arg_642_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_642_1.callingController_:SetSelectedState("normal")

				arg_642_1.keyicon_.color = Color.New(1, 1, 1)
				arg_642_1.icon_.color = Color.New(1, 1, 1)

				local var_645_1 = arg_642_1:FormatText(arg_642_1:GetWordFromCfg(1108410156).content)

				arg_642_1.text_.text = var_645_1

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_3 = 23 <= 0 and var_645_0 or var_645_0 * (utf8.len(var_645_1) / 23)

				if (23 <= 0 and var_645_0 or var_645_0 * (utf8.len(var_645_1) / 23)) > 0 and var_645_0 < var_645_3 then
					arg_642_1.talkMaxDuration = var_645_3

					if var_645_3 + 0 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_3 + 0
					end
				end

				arg_642_1.text_.text = var_645_1
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)
				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_4 = math.max(var_645_0, arg_642_1.talkMaxDuration)

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_4 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - 0) / var_645_4

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= 0 + var_645_4 and arg_642_1.time_ < 0 + var_645_4 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play1108410157 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 1108410157
		arg_646_1.duration_ = 9

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play1108410158(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			if arg_646_1.bgs_.ST2105a == nil then
				local var_649_0 = Object.Instantiate(arg_646_1.paintGo_)

				var_649_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2105a")
				var_649_0.name = "ST2105a"
				var_649_0.transform.parent = arg_646_1.stage_.transform
				var_649_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_646_1.bgs_.ST2105a = var_649_0
			end

			if 2 < arg_646_1.time_ and arg_646_1.time_ <= 2 + arg_649_0 then
				local var_649_1 = arg_646_1.bgs_.ST2105a

				arg_646_1.bgs_.ST2105a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_649_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_649_2 = var_649_1:GetComponent("SpriteRenderer")

				if var_649_2 and var_649_2.sprite then
					local var_649_3 = 2 * (var_649_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_649_1.transform.localScale = Vector3.New(var_649_3 / var_649_2.sprite.bounds.size.y < var_649_3 * manager.ui.mainCameraCom_.aspect / var_649_2.sprite.bounds.size.x and var_649_3 * manager.ui.mainCameraCom_.aspect / var_649_2.sprite.bounds.size.x or var_649_3 / var_649_2.sprite.bounds.size.y, var_649_3 / var_649_2.sprite.bounds.size.y < var_649_3 * manager.ui.mainCameraCom_.aspect / var_649_2.sprite.bounds.size.x and var_649_3 * manager.ui.mainCameraCom_.aspect / var_649_2.sprite.bounds.size.x or var_649_3 / var_649_2.sprite.bounds.size.y, 0)
				end

				for iter_649_0, iter_649_1 in pairs(arg_646_1.bgs_) do
					if iter_649_0 ~= "ST2105a" then
						iter_649_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_649_4 = 4

			if 4 < arg_646_1.time_ and arg_646_1.time_ <= var_649_4 + arg_649_0 then
				arg_646_1.allBtn_.enabled = false
			end

			if arg_646_1.time_ >= var_649_4 + 0.3 and arg_646_1.time_ < var_649_4 + 0.3 + arg_649_0 then
				arg_646_1.allBtn_.enabled = true
			end

			local var_649_5 = 0

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= var_649_5 + arg_649_0 then
				arg_646_1.mask_.enabled = true
				arg_646_1.mask_.raycastTarget = true

				arg_646_1:SetGaussion(false)
			end

			local var_649_6 = 2

			if var_649_5 <= arg_646_1.time_ and arg_646_1.time_ < var_649_5 + var_649_6 then
				local var_649_7 = Color.New(0, 0, 0)

				var_649_7.a = Mathf.Lerp(0, 1, (arg_646_1.time_ - var_649_5) / var_649_6)
				arg_646_1.mask_.color = var_649_7
			end

			if arg_646_1.time_ >= var_649_5 + var_649_6 and arg_646_1.time_ < var_649_5 + var_649_6 + arg_649_0 then
				local var_649_8 = Color.New(0, 0, 0)

				var_649_8.a = 1
				arg_646_1.mask_.color = var_649_8
			end

			local var_649_9 = 2

			if 2 < arg_646_1.time_ and arg_646_1.time_ <= var_649_9 + arg_649_0 then
				arg_646_1.mask_.enabled = true
				arg_646_1.mask_.raycastTarget = true

				arg_646_1:SetGaussion(false)
			end

			local var_649_10 = 2

			if var_649_9 <= arg_646_1.time_ and arg_646_1.time_ < var_649_9 + var_649_10 then
				local var_649_11 = Color.New(0, 0, 0)

				var_649_11.a = Mathf.Lerp(1, 0, (arg_646_1.time_ - var_649_9) / var_649_10)
				arg_646_1.mask_.color = var_649_11
			end

			if arg_646_1.time_ >= var_649_9 + var_649_10 and arg_646_1.time_ < var_649_9 + var_649_10 + arg_649_0 then
				local var_649_12 = Color.New(0, 0, 0)

				arg_646_1.mask_.enabled = false
				var_649_12.a = 0
				arg_646_1.mask_.color = var_649_12
			end

			if 1.2 < arg_646_1.time_ and arg_646_1.time_ <= 1.2 + arg_649_0 then
				arg_646_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 0.2 < arg_646_1.time_ and arg_646_1.time_ <= 0.2 + arg_649_0 then
				arg_646_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_646_1.frameCnt_ <= 1 then
				arg_646_1.dialog_:SetActive(false)
			end

			local var_649_15 = 4
			local var_649_16 = 1.475

			if 4 < arg_646_1.time_ and arg_646_1.time_ <= var_649_15 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0

				arg_646_1.dialog_:SetActive(true)

				arg_646_1.dialogCg_.alpha = 0

				local var_649_17 = LeanTween.value(arg_646_1.dialog_, 0, 1, 0.3)

				var_649_17:setOnUpdate(LuaHelper.FloatAction(function(arg_650_0)
					arg_646_1.dialogCg_.alpha = arg_650_0
				end))
				var_649_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_646_1.dialog_)
					var_649_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_646_1.duration_ = arg_646_1.duration_ + 0.3

				SetActive(arg_646_1.leftNameGo_, false)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_18 = arg_646_1:FormatText(arg_646_1:GetWordFromCfg(1108410157).content)

				arg_646_1.text_.text = var_649_18

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_20 = 59 <= 0 and var_649_16 or var_649_16 * (utf8.len(var_649_18) / 59)

				if (59 <= 0 and var_649_16 or var_649_16 * (utf8.len(var_649_18) / 59)) > 0 and var_649_16 < var_649_20 then
					arg_646_1.talkMaxDuration = var_649_20
					var_649_15 = var_649_15 + 0.3

					if var_649_20 + var_649_15 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_20 + var_649_15
					end
				end

				arg_646_1.text_.text = var_649_18
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_21 = var_649_15 + 0.3
			local var_649_22 = math.max(var_649_16, arg_646_1.talkMaxDuration)

			if var_649_15 + 0.3 <= arg_646_1.time_ and arg_646_1.time_ < var_649_21 + var_649_22 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_21) / var_649_22

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_21 + var_649_22 and arg_646_1.time_ < var_649_21 + var_649_22 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {}

		arg_646_1:InitPlayNodeList()
	end,
	Play1108410158 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1108410158
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1108410159(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = 1.375

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, false)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_1 = arg_652_1:FormatText(arg_652_1:GetWordFromCfg(1108410158).content)

				arg_652_1.text_.text = var_655_1

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_3 = 55 <= 0 and var_655_0 or var_655_0 * (utf8.len(var_655_1) / 55)

				if (55 <= 0 and var_655_0 or var_655_0 * (utf8.len(var_655_1) / 55)) > 0 and var_655_0 < var_655_3 then
					arg_652_1.talkMaxDuration = var_655_3

					if var_655_3 + 0 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_3 + 0
					end
				end

				arg_652_1.text_.text = var_655_1
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_4 = math.max(var_655_0, arg_652_1.talkMaxDuration)

			if 0 <= arg_652_1.time_ and arg_652_1.time_ < 0 + var_655_4 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - 0) / var_655_4

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= 0 + var_655_4 and arg_652_1.time_ < 0 + var_655_4 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play1108410159 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1108410159
		arg_656_1.duration_ = 8.13

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1108410160(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = 1

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				arg_656_1.leftNameTxt_.text = arg_656_1:FormatText(StoryNameCfg[1546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, true)
				arg_656_1.iconController_:SetSelectedState("hero")

				arg_656_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_656_1.callingController_:SetSelectedState("normal")

				arg_656_1.keyicon_.color = Color.New(1, 1, 1)
				arg_656_1.icon_.color = Color.New(1, 1, 1)

				local var_659_1 = arg_656_1:GetWordFromCfg(1108410159)
				local var_659_2 = arg_656_1:FormatText(var_659_1.content)

				arg_656_1.text_.text = var_659_2

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_4 = 40 <= 0 and var_659_0 or var_659_0 * (utf8.len(var_659_2) / 40)

				if (40 <= 0 and var_659_0 or var_659_0 * (utf8.len(var_659_2) / 40)) > 0 and var_659_0 < var_659_4 then
					arg_656_1.talkMaxDuration = var_659_4

					if var_659_4 + 0 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_4 + 0
					end
				end

				arg_656_1.text_.text = var_659_2
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410159", "story_v_side_new_1108410.awb") ~= 0 then
					local var_659_5 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410159", "story_v_side_new_1108410.awb") / 1000

					if var_659_5 + 0 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_5 + 0
					end

					if var_659_1.prefab_name ~= "" and arg_656_1.actors_[var_659_1.prefab_name] ~= nil then
						local var_659_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_1.prefab_name].transform, "story_v_side_new_1108410", "1108410159", "story_v_side_new_1108410.awb")

						arg_656_1:RecordAudio("1108410159", var_659_6)
						arg_656_1:RecordAudio("1108410159", var_659_6)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410159", "story_v_side_new_1108410.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410159", "story_v_side_new_1108410.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_7 = math.max(var_659_0, arg_656_1.talkMaxDuration)

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_7 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - 0) / var_659_7

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= 0 + var_659_7 and arg_656_1.time_ < 0 + var_659_7 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play1108410160 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1108410160
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1108410161(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 then
				arg_660_1.var_.moveOldPos10102ui_story = arg_660_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_663_0 = 0.001

			if 0 <= arg_660_1.time_ and arg_660_1.time_ < 0 + var_663_0 then
				arg_660_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_660_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_660_1.time_ - 0) / var_663_0)
				arg_660_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_660_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_660_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_660_1.actors_["10102ui_story"].transform.position).z)
				arg_660_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_660_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_660_1.actors_["10102ui_story"].transform.localEulerAngles = arg_660_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_660_1.time_ >= 0 + var_663_0 and arg_660_1.time_ < 0 + var_663_0 + arg_663_0 then
				arg_660_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_660_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_660_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_660_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_660_1.actors_["10102ui_story"].transform.position).z)
				arg_660_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_660_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_660_1.actors_["10102ui_story"].transform.localEulerAngles = arg_660_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_663_1 = arg_660_1.actors_["10102ui_story"]

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 and not isNil(var_663_1) and arg_660_1.var_.characterEffect10102ui_story == nil then
				arg_660_1.var_.characterEffect10102ui_story = var_663_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_663_2 = 0.200000002980232

			if 0 <= arg_660_1.time_ and arg_660_1.time_ < 0 + var_663_2 and not isNil(var_663_1) then
				if arg_660_1.var_.characterEffect10102ui_story and not isNil(var_663_1) then
					arg_660_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_660_1.time_ >= 0 + var_663_2 and arg_660_1.time_ < 0 + var_663_2 + arg_663_0 and not isNil(var_663_1) and arg_660_1.var_.characterEffect10102ui_story then
				arg_660_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 then
				arg_660_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 then
				arg_660_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_663_4 = 0
			local var_663_5 = 0.575

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_4 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				arg_660_1.leftNameTxt_.text = arg_660_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_6 = arg_660_1:FormatText(arg_660_1:GetWordFromCfg(1108410160).content)

				arg_660_1.text_.text = var_663_6

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_8 = 23 <= 0 and var_663_5 or var_663_5 * (utf8.len(var_663_6) / 23)

				if (23 <= 0 and var_663_5 or var_663_5 * (utf8.len(var_663_6) / 23)) > 0 and var_663_5 < var_663_8 then
					arg_660_1.talkMaxDuration = var_663_8

					if var_663_8 + var_663_4 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_8 + var_663_4
					end
				end

				arg_660_1.text_.text = var_663_6
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_9 = math.max(var_663_5, arg_660_1.talkMaxDuration)

			if var_663_4 <= arg_660_1.time_ and arg_660_1.time_ < var_663_4 + var_663_9 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_4) / var_663_9

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_4 + var_663_9 and arg_660_1.time_ < var_663_4 + var_663_9 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {
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

		arg_660_1:InitPlayNodeList()
	end,
	Play1108410161 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1108410161
		arg_664_1.duration_ = 5

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play1108410162(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1.var_.moveOldPos10102ui_story = arg_664_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_667_0 = 0.001

			if 0 <= arg_664_1.time_ and arg_664_1.time_ < 0 + var_667_0 then
				arg_664_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_664_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_664_1.time_ - 0) / var_667_0)
				arg_664_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_664_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_664_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_664_1.actors_["10102ui_story"].transform.position).z)
				arg_664_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_664_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_664_1.actors_["10102ui_story"].transform.localEulerAngles = arg_664_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_664_1.time_ >= 0 + var_667_0 and arg_664_1.time_ < 0 + var_667_0 + arg_667_0 then
				arg_664_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_664_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_664_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_664_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_664_1.actors_["10102ui_story"].transform.position).z)
				arg_664_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_664_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_664_1.actors_["10102ui_story"].transform.localEulerAngles = arg_664_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_667_1 = arg_664_1.actors_["10102ui_story"]

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 and not isNil(var_667_1) and arg_664_1.var_.characterEffect10102ui_story == nil then
				arg_664_1.var_.characterEffect10102ui_story = var_667_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_667_2 = 0.200000002980232

			if 0 <= arg_664_1.time_ and arg_664_1.time_ < 0 + var_667_2 and not isNil(var_667_1) then
				if arg_664_1.var_.characterEffect10102ui_story and not isNil(var_667_1) then
					arg_664_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_664_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_664_1.time_ - 0) / var_667_2)
				end
			end

			if arg_664_1.time_ >= 0 + var_667_2 and arg_664_1.time_ < 0 + var_667_2 + arg_667_0 and not isNil(var_667_1) and arg_664_1.var_.characterEffect10102ui_story then
				arg_664_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_664_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_667_3 = 0
			local var_667_4 = 1.45

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_3 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, false)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_5 = arg_664_1:FormatText(arg_664_1:GetWordFromCfg(1108410161).content)

				arg_664_1.text_.text = var_667_5

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_7 = 58 <= 0 and var_667_4 or var_667_4 * (utf8.len(var_667_5) / 58)

				if (58 <= 0 and var_667_4 or var_667_4 * (utf8.len(var_667_5) / 58)) > 0 and var_667_4 < var_667_7 then
					arg_664_1.talkMaxDuration = var_667_7

					if var_667_7 + var_667_3 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_7 + var_667_3
					end
				end

				arg_664_1.text_.text = var_667_5
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)
				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_8 = math.max(var_667_4, arg_664_1.talkMaxDuration)

			if var_667_3 <= arg_664_1.time_ and arg_664_1.time_ < var_667_3 + var_667_8 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_3) / var_667_8

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_3 + var_667_8 and arg_664_1.time_ < var_667_3 + var_667_8 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {
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

		arg_664_1:InitPlayNodeList()
	end,
	Play1108410162 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1108410162
		arg_668_1.duration_ = 5

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1108410163(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = 0.2

			if 0 < arg_668_1.time_ and arg_668_1.time_ <= 0 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				arg_668_1.leftNameTxt_.text = arg_668_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, true)
				arg_668_1.iconController_:SetSelectedState("hero")

				arg_668_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_668_1.callingController_:SetSelectedState("normal")

				arg_668_1.keyicon_.color = Color.New(1, 1, 1)
				arg_668_1.icon_.color = Color.New(1, 1, 1)

				local var_671_1 = arg_668_1:FormatText(arg_668_1:GetWordFromCfg(1108410162).content)

				arg_668_1.text_.text = var_671_1

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_3 = 8 <= 0 and var_671_0 or var_671_0 * (utf8.len(var_671_1) / 8)

				if (8 <= 0 and var_671_0 or var_671_0 * (utf8.len(var_671_1) / 8)) > 0 and var_671_0 < var_671_3 then
					arg_668_1.talkMaxDuration = var_671_3

					if var_671_3 + 0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_3 + 0
					end
				end

				arg_668_1.text_.text = var_671_1
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)
				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_4 = math.max(var_671_0, arg_668_1.talkMaxDuration)

			if 0 <= arg_668_1.time_ and arg_668_1.time_ < 0 + var_671_4 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - 0) / var_671_4

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= 0 + var_671_4 and arg_668_1.time_ < 0 + var_671_4 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1108410163 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1108410163
		arg_672_1.duration_ = 9

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1108410164(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			if arg_672_1.bgs_.ST0116a == nil then
				local var_675_0 = Object.Instantiate(arg_672_1.paintGo_)

				var_675_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0116a")
				var_675_0.name = "ST0116a"
				var_675_0.transform.parent = arg_672_1.stage_.transform
				var_675_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_672_1.bgs_.ST0116a = var_675_0
			end

			if 2 < arg_672_1.time_ and arg_672_1.time_ <= 2 + arg_675_0 then
				local var_675_1 = arg_672_1.bgs_.ST0116a

				arg_672_1.bgs_.ST0116a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_675_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_675_2 = var_675_1:GetComponent("SpriteRenderer")

				if var_675_2 and var_675_2.sprite then
					local var_675_3 = 2 * (var_675_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_675_1.transform.localScale = Vector3.New(var_675_3 / var_675_2.sprite.bounds.size.y < var_675_3 * manager.ui.mainCameraCom_.aspect / var_675_2.sprite.bounds.size.x and var_675_3 * manager.ui.mainCameraCom_.aspect / var_675_2.sprite.bounds.size.x or var_675_3 / var_675_2.sprite.bounds.size.y, var_675_3 / var_675_2.sprite.bounds.size.y < var_675_3 * manager.ui.mainCameraCom_.aspect / var_675_2.sprite.bounds.size.x and var_675_3 * manager.ui.mainCameraCom_.aspect / var_675_2.sprite.bounds.size.x or var_675_3 / var_675_2.sprite.bounds.size.y, 0)
				end

				for iter_675_0, iter_675_1 in pairs(arg_672_1.bgs_) do
					if iter_675_0 ~= "ST0116a" then
						iter_675_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_675_4 = 4

			if 4 < arg_672_1.time_ and arg_672_1.time_ <= var_675_4 + arg_675_0 then
				arg_672_1.allBtn_.enabled = false
			end

			if arg_672_1.time_ >= var_675_4 + 0.3 and arg_672_1.time_ < var_675_4 + 0.3 + arg_675_0 then
				arg_672_1.allBtn_.enabled = true
			end

			local var_675_5 = 0

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_5 + arg_675_0 then
				arg_672_1.mask_.enabled = true
				arg_672_1.mask_.raycastTarget = true

				arg_672_1:SetGaussion(false)
			end

			local var_675_6 = 2

			if var_675_5 <= arg_672_1.time_ and arg_672_1.time_ < var_675_5 + var_675_6 then
				local var_675_7 = Color.New(0, 0, 0)

				var_675_7.a = Mathf.Lerp(0, 1, (arg_672_1.time_ - var_675_5) / var_675_6)
				arg_672_1.mask_.color = var_675_7
			end

			if arg_672_1.time_ >= var_675_5 + var_675_6 and arg_672_1.time_ < var_675_5 + var_675_6 + arg_675_0 then
				local var_675_8 = Color.New(0, 0, 0)

				var_675_8.a = 1
				arg_672_1.mask_.color = var_675_8
			end

			local var_675_9 = 2

			if 2 < arg_672_1.time_ and arg_672_1.time_ <= var_675_9 + arg_675_0 then
				arg_672_1.mask_.enabled = true
				arg_672_1.mask_.raycastTarget = true

				arg_672_1:SetGaussion(false)
			end

			local var_675_10 = 2

			if var_675_9 <= arg_672_1.time_ and arg_672_1.time_ < var_675_9 + var_675_10 then
				local var_675_11 = Color.New(0, 0, 0)

				var_675_11.a = Mathf.Lerp(1, 0, (arg_672_1.time_ - var_675_9) / var_675_10)
				arg_672_1.mask_.color = var_675_11
			end

			if arg_672_1.time_ >= var_675_9 + var_675_10 and arg_672_1.time_ < var_675_9 + var_675_10 + arg_675_0 then
				local var_675_12 = Color.New(0, 0, 0)

				arg_672_1.mask_.enabled = false
				var_675_12.a = 0
				arg_672_1.mask_.color = var_675_12
			end

			if 1.2 < arg_672_1.time_ and arg_672_1.time_ <= 1.2 + arg_675_0 then
				arg_672_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 0.2 < arg_672_1.time_ and arg_672_1.time_ <= 0.2 + arg_675_0 then
				arg_672_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if arg_672_1.frameCnt_ <= 1 then
				arg_672_1.dialog_:SetActive(false)
			end

			local var_675_15 = 4
			local var_675_16 = 1.45

			if 4 < arg_672_1.time_ and arg_672_1.time_ <= var_675_15 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0

				arg_672_1.dialog_:SetActive(true)

				arg_672_1.dialogCg_.alpha = 0

				local var_675_17 = LeanTween.value(arg_672_1.dialog_, 0, 1, 0.3)

				var_675_17:setOnUpdate(LuaHelper.FloatAction(function(arg_676_0)
					arg_672_1.dialogCg_.alpha = arg_676_0
				end))
				var_675_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_672_1.dialog_)
					var_675_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_672_1.duration_ = arg_672_1.duration_ + 0.3

				SetActive(arg_672_1.leftNameGo_, false)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_18 = arg_672_1:FormatText(arg_672_1:GetWordFromCfg(1108410163).content)

				arg_672_1.text_.text = var_675_18

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_20 = 58 <= 0 and var_675_16 or var_675_16 * (utf8.len(var_675_18) / 58)

				if (58 <= 0 and var_675_16 or var_675_16 * (utf8.len(var_675_18) / 58)) > 0 and var_675_16 < var_675_20 then
					arg_672_1.talkMaxDuration = var_675_20
					var_675_15 = var_675_15 + 0.3

					if var_675_20 + var_675_15 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_20 + var_675_15
					end
				end

				arg_672_1.text_.text = var_675_18
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)
				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_21 = var_675_15 + 0.3
			local var_675_22 = math.max(var_675_16, arg_672_1.talkMaxDuration)

			if var_675_15 + 0.3 <= arg_672_1.time_ and arg_672_1.time_ < var_675_21 + var_675_22 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_21) / var_675_22

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_21 + var_675_22 and arg_672_1.time_ < var_675_21 + var_675_22 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play1108410164 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 1108410164
		arg_678_1.duration_ = 5

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play1108410165(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			local var_681_0 = 0.125

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= 0 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				arg_678_1.leftNameTxt_.text = arg_678_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, true)
				arg_678_1.iconController_:SetSelectedState("hero")

				arg_678_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_678_1.callingController_:SetSelectedState("normal")

				arg_678_1.keyicon_.color = Color.New(1, 1, 1)
				arg_678_1.icon_.color = Color.New(1, 1, 1)

				local var_681_1 = arg_678_1:FormatText(arg_678_1:GetWordFromCfg(1108410164).content)

				arg_678_1.text_.text = var_681_1

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_3 = 5 <= 0 and var_681_0 or var_681_0 * (utf8.len(var_681_1) / 5)

				if (5 <= 0 and var_681_0 or var_681_0 * (utf8.len(var_681_1) / 5)) > 0 and var_681_0 < var_681_3 then
					arg_678_1.talkMaxDuration = var_681_3

					if var_681_3 + 0 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_3 + 0
					end
				end

				arg_678_1.text_.text = var_681_1
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)
				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_4 = math.max(var_681_0, arg_678_1.talkMaxDuration)

			if 0 <= arg_678_1.time_ and arg_678_1.time_ < 0 + var_681_4 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - 0) / var_681_4

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= 0 + var_681_4 and arg_678_1.time_ < 0 + var_681_4 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {}

		arg_678_1:InitPlayNodeList()
	end,
	Play1108410165 = function(arg_682_0, arg_682_1)
		arg_682_1.time_ = 0
		arg_682_1.frameCnt_ = 0
		arg_682_1.state_ = "playing"
		arg_682_1.curTalkId_ = 1108410165
		arg_682_1.duration_ = 4.93

		SetActive(arg_682_1.tipsGo_, false)

		function arg_682_1.onSingleLineFinish_()
			arg_682_1.onSingleLineUpdate_ = nil
			arg_682_1.onSingleLineFinish_ = nil
			arg_682_1.state_ = "waiting"
		end

		function arg_682_1.playNext_(arg_684_0)
			if arg_684_0 == 1 then
				arg_682_0:Play1108410166(arg_682_1)
			end
		end

		function arg_682_1.onSingleLineUpdate_(arg_685_0)
			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1.var_.moveOldPos10102ui_story = arg_682_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_685_0 = 0.001

			if 0 <= arg_682_1.time_ and arg_682_1.time_ < 0 + var_685_0 then
				arg_682_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_682_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_682_1.time_ - 0) / var_685_0)
				arg_682_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_682_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_682_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_682_1.actors_["10102ui_story"].transform.position).z)
				arg_682_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_682_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_682_1.actors_["10102ui_story"].transform.localEulerAngles = arg_682_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_682_1.time_ >= 0 + var_685_0 and arg_682_1.time_ < 0 + var_685_0 + arg_685_0 then
				arg_682_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_682_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_682_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_682_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_682_1.actors_["10102ui_story"].transform.position).z)
				arg_682_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_682_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_682_1.actors_["10102ui_story"].transform.localEulerAngles = arg_682_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_685_1 = arg_682_1.actors_["10102ui_story"]

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 and not isNil(var_685_1) and arg_682_1.var_.characterEffect10102ui_story == nil then
				arg_682_1.var_.characterEffect10102ui_story = var_685_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_685_2 = 0.200000002980232

			if 0 <= arg_682_1.time_ and arg_682_1.time_ < 0 + var_685_2 and not isNil(var_685_1) then
				if arg_682_1.var_.characterEffect10102ui_story and not isNil(var_685_1) then
					arg_682_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_682_1.time_ >= 0 + var_685_2 and arg_682_1.time_ < 0 + var_685_2 + arg_685_0 and not isNil(var_685_1) and arg_682_1.var_.characterEffect10102ui_story then
				arg_682_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_685_4 = 0
			local var_685_5 = 0.6

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= var_685_4 + arg_685_0 then
				arg_682_1.talkMaxDuration = 0
				arg_682_1.dialogCg_.alpha = 1

				arg_682_1.dialog_:SetActive(true)
				SetActive(arg_682_1.leftNameGo_, true)

				arg_682_1.leftNameTxt_.text = arg_682_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_682_1.leftNameTxt_.transform)

				arg_682_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_682_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_682_1:RecordName(arg_682_1.leftNameTxt_.text)
				SetActive(arg_682_1.iconTrs_.gameObject, false)
				arg_682_1.callingController_:SetSelectedState("normal")

				local var_685_6 = arg_682_1:GetWordFromCfg(1108410165)
				local var_685_7 = arg_682_1:FormatText(var_685_6.content)

				arg_682_1.text_.text = var_685_7

				LuaForUtil.ClearLinePrefixSymbol(arg_682_1.text_)

				local var_685_9 = 24 <= 0 and var_685_5 or var_685_5 * (utf8.len(var_685_7) / 24)

				if (24 <= 0 and var_685_5 or var_685_5 * (utf8.len(var_685_7) / 24)) > 0 and var_685_5 < var_685_9 then
					arg_682_1.talkMaxDuration = var_685_9

					if var_685_9 + var_685_4 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_9 + var_685_4
					end
				end

				arg_682_1.text_.text = var_685_7
				arg_682_1.typewritter.percent = 0

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410165", "story_v_side_new_1108410.awb") ~= 0 then
					local var_685_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410165", "story_v_side_new_1108410.awb") / 1000

					if var_685_10 + var_685_4 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_10 + var_685_4
					end

					if var_685_6.prefab_name ~= "" and arg_682_1.actors_[var_685_6.prefab_name] ~= nil then
						local var_685_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_682_1.actors_[var_685_6.prefab_name].transform, "story_v_side_new_1108410", "1108410165", "story_v_side_new_1108410.awb")

						arg_682_1:RecordAudio("1108410165", var_685_11)
						arg_682_1:RecordAudio("1108410165", var_685_11)
					else
						arg_682_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410165", "story_v_side_new_1108410.awb")
					end

					arg_682_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410165", "story_v_side_new_1108410.awb")
				end

				arg_682_1:RecordContent(arg_682_1.text_.text)
			end

			local var_685_12 = math.max(var_685_5, arg_682_1.talkMaxDuration)

			if var_685_4 <= arg_682_1.time_ and arg_682_1.time_ < var_685_4 + var_685_12 then
				arg_682_1.typewritter.percent = (arg_682_1.time_ - var_685_4) / var_685_12

				arg_682_1.typewritter:SetDirty()
			end

			if arg_682_1.time_ >= var_685_4 + var_685_12 and arg_682_1.time_ < var_685_4 + var_685_12 + arg_685_0 then
				arg_682_1.typewritter.percent = 1

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(true)
			end
		end

		arg_682_1.nodeConfigList_ = {
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

		arg_682_1:InitPlayNodeList()
	end,
	Play1108410166 = function(arg_686_0, arg_686_1)
		arg_686_1.time_ = 0
		arg_686_1.frameCnt_ = 0
		arg_686_1.state_ = "playing"
		arg_686_1.curTalkId_ = 1108410166
		arg_686_1.duration_ = 5

		SetActive(arg_686_1.tipsGo_, false)

		function arg_686_1.onSingleLineFinish_()
			arg_686_1.onSingleLineUpdate_ = nil
			arg_686_1.onSingleLineFinish_ = nil
			arg_686_1.state_ = "waiting"
		end

		function arg_686_1.playNext_(arg_688_0)
			if arg_688_0 == 1 then
				arg_686_0:Play1108410167(arg_686_1)
			end
		end

		function arg_686_1.onSingleLineUpdate_(arg_689_0)
			if 0 < arg_686_1.time_ and arg_686_1.time_ <= 0 + arg_689_0 and not isNil(arg_686_1.actors_["10102ui_story"]) and arg_686_1.var_.characterEffect10102ui_story == nil then
				arg_686_1.var_.characterEffect10102ui_story = arg_686_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_689_0 = 0.200000002980232

			if 0 <= arg_686_1.time_ and arg_686_1.time_ < 0 + var_689_0 and not isNil(arg_686_1.actors_["10102ui_story"]) then
				if arg_686_1.var_.characterEffect10102ui_story and not isNil(arg_686_1.actors_["10102ui_story"]) then
					arg_686_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_686_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_686_1.time_ - 0) / var_689_0)
				end
			end

			if arg_686_1.time_ >= 0 + var_689_0 and arg_686_1.time_ < 0 + var_689_0 + arg_689_0 and not isNil(arg_686_1.actors_["10102ui_story"]) and arg_686_1.var_.characterEffect10102ui_story then
				arg_686_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_686_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_689_1 = 0
			local var_689_2 = 0.425

			if 0 < arg_686_1.time_ and arg_686_1.time_ <= var_689_1 + arg_689_0 then
				arg_686_1.talkMaxDuration = 0
				arg_686_1.dialogCg_.alpha = 1

				arg_686_1.dialog_:SetActive(true)
				SetActive(arg_686_1.leftNameGo_, true)

				arg_686_1.leftNameTxt_.text = arg_686_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_686_1.leftNameTxt_.transform)

				arg_686_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_686_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_686_1:RecordName(arg_686_1.leftNameTxt_.text)
				SetActive(arg_686_1.iconTrs_.gameObject, true)
				arg_686_1.iconController_:SetSelectedState("hero")

				arg_686_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_686_1.callingController_:SetSelectedState("normal")

				arg_686_1.keyicon_.color = Color.New(1, 1, 1)
				arg_686_1.icon_.color = Color.New(1, 1, 1)

				local var_689_3 = arg_686_1:FormatText(arg_686_1:GetWordFromCfg(1108410166).content)

				arg_686_1.text_.text = var_689_3

				LuaForUtil.ClearLinePrefixSymbol(arg_686_1.text_)

				local var_689_5 = 17 <= 0 and var_689_2 or var_689_2 * (utf8.len(var_689_3) / 17)

				if (17 <= 0 and var_689_2 or var_689_2 * (utf8.len(var_689_3) / 17)) > 0 and var_689_2 < var_689_5 then
					arg_686_1.talkMaxDuration = var_689_5

					if var_689_5 + var_689_1 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_5 + var_689_1
					end
				end

				arg_686_1.text_.text = var_689_3
				arg_686_1.typewritter.percent = 0

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(false)
				arg_686_1:RecordContent(arg_686_1.text_.text)
			end

			local var_689_6 = math.max(var_689_2, arg_686_1.talkMaxDuration)

			if var_689_1 <= arg_686_1.time_ and arg_686_1.time_ < var_689_1 + var_689_6 then
				arg_686_1.typewritter.percent = (arg_686_1.time_ - var_689_1) / var_689_6

				arg_686_1.typewritter:SetDirty()
			end

			if arg_686_1.time_ >= var_689_1 + var_689_6 and arg_686_1.time_ < var_689_1 + var_689_6 + arg_689_0 then
				arg_686_1.typewritter.percent = 1

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(true)
			end
		end

		arg_686_1.nodeConfigList_ = {}

		arg_686_1:InitPlayNodeList()
	end,
	Play1108410167 = function(arg_690_0, arg_690_1)
		arg_690_1.time_ = 0
		arg_690_1.frameCnt_ = 0
		arg_690_1.state_ = "playing"
		arg_690_1.curTalkId_ = 1108410167
		arg_690_1.duration_ = 9.57

		SetActive(arg_690_1.tipsGo_, false)

		function arg_690_1.onSingleLineFinish_()
			arg_690_1.onSingleLineUpdate_ = nil
			arg_690_1.onSingleLineFinish_ = nil
			arg_690_1.state_ = "waiting"
		end

		function arg_690_1.playNext_(arg_692_0)
			if arg_692_0 == 1 then
				arg_690_0:Play1108410168(arg_690_1)
			end
		end

		function arg_690_1.onSingleLineUpdate_(arg_693_0)
			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 and not isNil(arg_690_1.actors_["10102ui_story"]) and arg_690_1.var_.characterEffect10102ui_story == nil then
				arg_690_1.var_.characterEffect10102ui_story = arg_690_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_693_0 = 0.200000002980232

			if 0 <= arg_690_1.time_ and arg_690_1.time_ < 0 + var_693_0 and not isNil(arg_690_1.actors_["10102ui_story"]) then
				if arg_690_1.var_.characterEffect10102ui_story and not isNil(arg_690_1.actors_["10102ui_story"]) then
					arg_690_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_690_1.time_ >= 0 + var_693_0 and arg_690_1.time_ < 0 + var_693_0 + arg_693_0 and not isNil(arg_690_1.actors_["10102ui_story"]) and arg_690_1.var_.characterEffect10102ui_story then
				arg_690_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 then
				arg_690_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 then
				arg_690_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_693_2 = 0
			local var_693_3 = 1.075

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= var_693_2 + arg_693_0 then
				arg_690_1.talkMaxDuration = 0
				arg_690_1.dialogCg_.alpha = 1

				arg_690_1.dialog_:SetActive(true)
				SetActive(arg_690_1.leftNameGo_, true)

				arg_690_1.leftNameTxt_.text = arg_690_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_690_1.leftNameTxt_.transform)

				arg_690_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_690_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_690_1:RecordName(arg_690_1.leftNameTxt_.text)
				SetActive(arg_690_1.iconTrs_.gameObject, false)
				arg_690_1.callingController_:SetSelectedState("normal")

				local var_693_4 = arg_690_1:GetWordFromCfg(1108410167)
				local var_693_5 = arg_690_1:FormatText(var_693_4.content)

				arg_690_1.text_.text = var_693_5

				LuaForUtil.ClearLinePrefixSymbol(arg_690_1.text_)

				local var_693_7 = 43 <= 0 and var_693_3 or var_693_3 * (utf8.len(var_693_5) / 43)

				if (43 <= 0 and var_693_3 or var_693_3 * (utf8.len(var_693_5) / 43)) > 0 and var_693_3 < var_693_7 then
					arg_690_1.talkMaxDuration = var_693_7

					if var_693_7 + var_693_2 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_7 + var_693_2
					end
				end

				arg_690_1.text_.text = var_693_5
				arg_690_1.typewritter.percent = 0

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410167", "story_v_side_new_1108410.awb") ~= 0 then
					local var_693_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410167", "story_v_side_new_1108410.awb") / 1000

					if var_693_8 + var_693_2 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_8 + var_693_2
					end

					if var_693_4.prefab_name ~= "" and arg_690_1.actors_[var_693_4.prefab_name] ~= nil then
						local var_693_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_690_1.actors_[var_693_4.prefab_name].transform, "story_v_side_new_1108410", "1108410167", "story_v_side_new_1108410.awb")

						arg_690_1:RecordAudio("1108410167", var_693_9)
						arg_690_1:RecordAudio("1108410167", var_693_9)
					else
						arg_690_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410167", "story_v_side_new_1108410.awb")
					end

					arg_690_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410167", "story_v_side_new_1108410.awb")
				end

				arg_690_1:RecordContent(arg_690_1.text_.text)
			end

			local var_693_10 = math.max(var_693_3, arg_690_1.talkMaxDuration)

			if var_693_2 <= arg_690_1.time_ and arg_690_1.time_ < var_693_2 + var_693_10 then
				arg_690_1.typewritter.percent = (arg_690_1.time_ - var_693_2) / var_693_10

				arg_690_1.typewritter:SetDirty()
			end

			if arg_690_1.time_ >= var_693_2 + var_693_10 and arg_690_1.time_ < var_693_2 + var_693_10 + arg_693_0 then
				arg_690_1.typewritter.percent = 1

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(true)
			end
		end

		arg_690_1.nodeConfigList_ = {}

		arg_690_1:InitPlayNodeList()
	end,
	Play1108410168 = function(arg_694_0, arg_694_1)
		arg_694_1.time_ = 0
		arg_694_1.frameCnt_ = 0
		arg_694_1.state_ = "playing"
		arg_694_1.curTalkId_ = 1108410168
		arg_694_1.duration_ = 5

		SetActive(arg_694_1.tipsGo_, false)

		function arg_694_1.onSingleLineFinish_()
			arg_694_1.onSingleLineUpdate_ = nil
			arg_694_1.onSingleLineFinish_ = nil
			arg_694_1.state_ = "waiting"
		end

		function arg_694_1.playNext_(arg_696_0)
			if arg_696_0 == 1 then
				arg_694_0:Play1108410169(arg_694_1)
			end
		end

		function arg_694_1.onSingleLineUpdate_(arg_697_0)
			if 0 < arg_694_1.time_ and arg_694_1.time_ <= 0 + arg_697_0 then
				arg_694_1.var_.moveOldPos10102ui_story = arg_694_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_697_0 = 0.001

			if 0 <= arg_694_1.time_ and arg_694_1.time_ < 0 + var_697_0 then
				arg_694_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_694_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_694_1.time_ - 0) / var_697_0)
				arg_694_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_694_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_694_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_694_1.actors_["10102ui_story"].transform.position).z)
				arg_694_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_694_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_694_1.actors_["10102ui_story"].transform.localEulerAngles = arg_694_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_694_1.time_ >= 0 + var_697_0 and arg_694_1.time_ < 0 + var_697_0 + arg_697_0 then
				arg_694_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_694_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_694_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_694_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_694_1.actors_["10102ui_story"].transform.position).z)
				arg_694_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_694_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_694_1.actors_["10102ui_story"].transform.localEulerAngles = arg_694_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_697_1 = arg_694_1.actors_["10102ui_story"]

			if 0 < arg_694_1.time_ and arg_694_1.time_ <= 0 + arg_697_0 and not isNil(var_697_1) and arg_694_1.var_.characterEffect10102ui_story == nil then
				arg_694_1.var_.characterEffect10102ui_story = var_697_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_697_2 = 0.200000002980232

			if 0 <= arg_694_1.time_ and arg_694_1.time_ < 0 + var_697_2 and not isNil(var_697_1) then
				if arg_694_1.var_.characterEffect10102ui_story and not isNil(var_697_1) then
					arg_694_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_694_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_694_1.time_ - 0) / var_697_2)
				end
			end

			if arg_694_1.time_ >= 0 + var_697_2 and arg_694_1.time_ < 0 + var_697_2 + arg_697_0 and not isNil(var_697_1) and arg_694_1.var_.characterEffect10102ui_story then
				arg_694_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_694_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_697_3 = 0
			local var_697_4 = 0.55

			if 0 < arg_694_1.time_ and arg_694_1.time_ <= var_697_3 + arg_697_0 then
				arg_694_1.talkMaxDuration = 0
				arg_694_1.dialogCg_.alpha = 1

				arg_694_1.dialog_:SetActive(true)
				SetActive(arg_694_1.leftNameGo_, false)

				arg_694_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_694_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_694_1:RecordName(arg_694_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_694_1.iconTrs_.gameObject, false)
				arg_694_1.callingController_:SetSelectedState("normal")

				local var_697_5 = arg_694_1:FormatText(arg_694_1:GetWordFromCfg(1108410168).content)

				arg_694_1.text_.text = var_697_5

				LuaForUtil.ClearLinePrefixSymbol(arg_694_1.text_)

				local var_697_7 = 22 <= 0 and var_697_4 or var_697_4 * (utf8.len(var_697_5) / 22)

				if (22 <= 0 and var_697_4 or var_697_4 * (utf8.len(var_697_5) / 22)) > 0 and var_697_4 < var_697_7 then
					arg_694_1.talkMaxDuration = var_697_7

					if var_697_7 + var_697_3 > arg_694_1.duration_ then
						arg_694_1.duration_ = var_697_7 + var_697_3
					end
				end

				arg_694_1.text_.text = var_697_5
				arg_694_1.typewritter.percent = 0

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(false)
				arg_694_1:RecordContent(arg_694_1.text_.text)
			end

			local var_697_8 = math.max(var_697_4, arg_694_1.talkMaxDuration)

			if var_697_3 <= arg_694_1.time_ and arg_694_1.time_ < var_697_3 + var_697_8 then
				arg_694_1.typewritter.percent = (arg_694_1.time_ - var_697_3) / var_697_8

				arg_694_1.typewritter:SetDirty()
			end

			if arg_694_1.time_ >= var_697_3 + var_697_8 and arg_694_1.time_ < var_697_3 + var_697_8 + arg_697_0 then
				arg_694_1.typewritter.percent = 1

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(true)
			end
		end

		arg_694_1.nodeConfigList_ = {
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

		arg_694_1:InitPlayNodeList()
	end,
	Play1108410169 = function(arg_698_0, arg_698_1)
		arg_698_1.time_ = 0
		arg_698_1.frameCnt_ = 0
		arg_698_1.state_ = "playing"
		arg_698_1.curTalkId_ = 1108410169
		arg_698_1.duration_ = 5

		SetActive(arg_698_1.tipsGo_, false)

		function arg_698_1.onSingleLineFinish_()
			arg_698_1.onSingleLineUpdate_ = nil
			arg_698_1.onSingleLineFinish_ = nil
			arg_698_1.state_ = "waiting"
		end

		function arg_698_1.playNext_(arg_700_0)
			if arg_700_0 == 1 then
				arg_698_0:Play1108410170(arg_698_1)
			end
		end

		function arg_698_1.onSingleLineUpdate_(arg_701_0)
			local var_701_0 = 0.2

			if 0 < arg_698_1.time_ and arg_698_1.time_ <= 0 + arg_701_0 then
				arg_698_1.talkMaxDuration = 0
				arg_698_1.dialogCg_.alpha = 1

				arg_698_1.dialog_:SetActive(true)
				SetActive(arg_698_1.leftNameGo_, true)

				arg_698_1.leftNameTxt_.text = arg_698_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_698_1.leftNameTxt_.transform)

				arg_698_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_698_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_698_1:RecordName(arg_698_1.leftNameTxt_.text)
				SetActive(arg_698_1.iconTrs_.gameObject, true)
				arg_698_1.iconController_:SetSelectedState("hero")

				arg_698_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_698_1.callingController_:SetSelectedState("normal")

				arg_698_1.keyicon_.color = Color.New(1, 1, 1)
				arg_698_1.icon_.color = Color.New(1, 1, 1)

				local var_701_1 = arg_698_1:FormatText(arg_698_1:GetWordFromCfg(1108410169).content)

				arg_698_1.text_.text = var_701_1

				LuaForUtil.ClearLinePrefixSymbol(arg_698_1.text_)

				local var_701_3 = 8 <= 0 and var_701_0 or var_701_0 * (utf8.len(var_701_1) / 8)

				if (8 <= 0 and var_701_0 or var_701_0 * (utf8.len(var_701_1) / 8)) > 0 and var_701_0 < var_701_3 then
					arg_698_1.talkMaxDuration = var_701_3

					if var_701_3 + 0 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_3 + 0
					end
				end

				arg_698_1.text_.text = var_701_1
				arg_698_1.typewritter.percent = 0

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(false)
				arg_698_1:RecordContent(arg_698_1.text_.text)
			end

			local var_701_4 = math.max(var_701_0, arg_698_1.talkMaxDuration)

			if 0 <= arg_698_1.time_ and arg_698_1.time_ < 0 + var_701_4 then
				arg_698_1.typewritter.percent = (arg_698_1.time_ - 0) / var_701_4

				arg_698_1.typewritter:SetDirty()
			end

			if arg_698_1.time_ >= 0 + var_701_4 and arg_698_1.time_ < 0 + var_701_4 + arg_701_0 then
				arg_698_1.typewritter.percent = 1

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(true)
			end
		end

		arg_698_1.nodeConfigList_ = {}

		arg_698_1:InitPlayNodeList()
	end,
	Play1108410170 = function(arg_702_0, arg_702_1)
		arg_702_1.time_ = 0
		arg_702_1.frameCnt_ = 0
		arg_702_1.state_ = "playing"
		arg_702_1.curTalkId_ = 1108410170
		arg_702_1.duration_ = 2

		SetActive(arg_702_1.tipsGo_, false)

		function arg_702_1.onSingleLineFinish_()
			arg_702_1.onSingleLineUpdate_ = nil
			arg_702_1.onSingleLineFinish_ = nil
			arg_702_1.state_ = "waiting"
		end

		function arg_702_1.playNext_(arg_704_0)
			if arg_704_0 == 1 then
				arg_702_0:Play1108410171(arg_702_1)
			end
		end

		function arg_702_1.onSingleLineUpdate_(arg_705_0)
			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 then
				arg_702_1.var_.moveOldPos10102ui_story = arg_702_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_705_0 = 0.001

			if 0 <= arg_702_1.time_ and arg_702_1.time_ < 0 + var_705_0 then
				arg_702_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_702_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_702_1.time_ - 0) / var_705_0)
				arg_702_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_702_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_702_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_702_1.actors_["10102ui_story"].transform.position).z)
				arg_702_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_702_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_702_1.actors_["10102ui_story"].transform.localEulerAngles = arg_702_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_702_1.time_ >= 0 + var_705_0 and arg_702_1.time_ < 0 + var_705_0 + arg_705_0 then
				arg_702_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_702_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_702_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_702_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_702_1.actors_["10102ui_story"].transform.position).z)
				arg_702_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_702_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_702_1.actors_["10102ui_story"].transform.localEulerAngles = arg_702_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_705_1 = arg_702_1.actors_["10102ui_story"]

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 and not isNil(var_705_1) and arg_702_1.var_.characterEffect10102ui_story == nil then
				arg_702_1.var_.characterEffect10102ui_story = var_705_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_705_2 = 0.200000002980232

			if 0 <= arg_702_1.time_ and arg_702_1.time_ < 0 + var_705_2 and not isNil(var_705_1) then
				if arg_702_1.var_.characterEffect10102ui_story and not isNil(var_705_1) then
					arg_702_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_702_1.time_ >= 0 + var_705_2 and arg_702_1.time_ < 0 + var_705_2 + arg_705_0 and not isNil(var_705_1) and arg_702_1.var_.characterEffect10102ui_story then
				arg_702_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 then
				arg_702_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_705_4 = 0
			local var_705_5 = 0.1

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= var_705_4 + arg_705_0 then
				arg_702_1.talkMaxDuration = 0
				arg_702_1.dialogCg_.alpha = 1

				arg_702_1.dialog_:SetActive(true)
				SetActive(arg_702_1.leftNameGo_, true)

				arg_702_1.leftNameTxt_.text = arg_702_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_702_1.leftNameTxt_.transform)

				arg_702_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_702_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_702_1:RecordName(arg_702_1.leftNameTxt_.text)
				SetActive(arg_702_1.iconTrs_.gameObject, false)
				arg_702_1.callingController_:SetSelectedState("normal")

				local var_705_6 = arg_702_1:GetWordFromCfg(1108410170)
				local var_705_7 = arg_702_1:FormatText(var_705_6.content)

				arg_702_1.text_.text = var_705_7

				LuaForUtil.ClearLinePrefixSymbol(arg_702_1.text_)

				local var_705_9 = 4 <= 0 and var_705_5 or var_705_5 * (utf8.len(var_705_7) / 4)

				if (4 <= 0 and var_705_5 or var_705_5 * (utf8.len(var_705_7) / 4)) > 0 and var_705_5 < var_705_9 then
					arg_702_1.talkMaxDuration = var_705_9

					if var_705_9 + var_705_4 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_9 + var_705_4
					end
				end

				arg_702_1.text_.text = var_705_7
				arg_702_1.typewritter.percent = 0

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410170", "story_v_side_new_1108410.awb") ~= 0 then
					local var_705_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410170", "story_v_side_new_1108410.awb") / 1000

					if var_705_10 + var_705_4 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_10 + var_705_4
					end

					if var_705_6.prefab_name ~= "" and arg_702_1.actors_[var_705_6.prefab_name] ~= nil then
						local var_705_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_702_1.actors_[var_705_6.prefab_name].transform, "story_v_side_new_1108410", "1108410170", "story_v_side_new_1108410.awb")

						arg_702_1:RecordAudio("1108410170", var_705_11)
						arg_702_1:RecordAudio("1108410170", var_705_11)
					else
						arg_702_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410170", "story_v_side_new_1108410.awb")
					end

					arg_702_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410170", "story_v_side_new_1108410.awb")
				end

				arg_702_1:RecordContent(arg_702_1.text_.text)
			end

			local var_705_12 = math.max(var_705_5, arg_702_1.talkMaxDuration)

			if var_705_4 <= arg_702_1.time_ and arg_702_1.time_ < var_705_4 + var_705_12 then
				arg_702_1.typewritter.percent = (arg_702_1.time_ - var_705_4) / var_705_12

				arg_702_1.typewritter:SetDirty()
			end

			if arg_702_1.time_ >= var_705_4 + var_705_12 and arg_702_1.time_ < var_705_4 + var_705_12 + arg_705_0 then
				arg_702_1.typewritter.percent = 1

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(true)
			end
		end

		arg_702_1.nodeConfigList_ = {
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

		arg_702_1:InitPlayNodeList()
	end,
	Play1108410171 = function(arg_706_0, arg_706_1)
		arg_706_1.time_ = 0
		arg_706_1.frameCnt_ = 0
		arg_706_1.state_ = "playing"
		arg_706_1.curTalkId_ = 1108410171
		arg_706_1.duration_ = 5

		SetActive(arg_706_1.tipsGo_, false)

		function arg_706_1.onSingleLineFinish_()
			arg_706_1.onSingleLineUpdate_ = nil
			arg_706_1.onSingleLineFinish_ = nil
			arg_706_1.state_ = "waiting"
		end

		function arg_706_1.playNext_(arg_708_0)
			if arg_708_0 == 1 then
				arg_706_0:Play1108410172(arg_706_1)
			end
		end

		function arg_706_1.onSingleLineUpdate_(arg_709_0)
			if 0 < arg_706_1.time_ and arg_706_1.time_ <= 0 + arg_709_0 and not isNil(arg_706_1.actors_["10102ui_story"]) and arg_706_1.var_.characterEffect10102ui_story == nil then
				arg_706_1.var_.characterEffect10102ui_story = arg_706_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_709_0 = 0.200000002980232

			if 0 <= arg_706_1.time_ and arg_706_1.time_ < 0 + var_709_0 and not isNil(arg_706_1.actors_["10102ui_story"]) then
				if arg_706_1.var_.characterEffect10102ui_story and not isNil(arg_706_1.actors_["10102ui_story"]) then
					arg_706_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_706_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_706_1.time_ - 0) / var_709_0)
				end
			end

			if arg_706_1.time_ >= 0 + var_709_0 and arg_706_1.time_ < 0 + var_709_0 + arg_709_0 and not isNil(arg_706_1.actors_["10102ui_story"]) and arg_706_1.var_.characterEffect10102ui_story then
				arg_706_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_706_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_709_1 = 0
			local var_709_2 = 0.3

			if 0 < arg_706_1.time_ and arg_706_1.time_ <= var_709_1 + arg_709_0 then
				arg_706_1.talkMaxDuration = 0
				arg_706_1.dialogCg_.alpha = 1

				arg_706_1.dialog_:SetActive(true)
				SetActive(arg_706_1.leftNameGo_, true)

				arg_706_1.leftNameTxt_.text = arg_706_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_706_1.leftNameTxt_.transform)

				arg_706_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_706_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_706_1:RecordName(arg_706_1.leftNameTxt_.text)
				SetActive(arg_706_1.iconTrs_.gameObject, true)
				arg_706_1.iconController_:SetSelectedState("hero")

				arg_706_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_706_1.callingController_:SetSelectedState("normal")

				arg_706_1.keyicon_.color = Color.New(1, 1, 1)
				arg_706_1.icon_.color = Color.New(1, 1, 1)

				local var_709_3 = arg_706_1:FormatText(arg_706_1:GetWordFromCfg(1108410171).content)

				arg_706_1.text_.text = var_709_3

				LuaForUtil.ClearLinePrefixSymbol(arg_706_1.text_)

				local var_709_5 = 12 <= 0 and var_709_2 or var_709_2 * (utf8.len(var_709_3) / 12)

				if (12 <= 0 and var_709_2 or var_709_2 * (utf8.len(var_709_3) / 12)) > 0 and var_709_2 < var_709_5 then
					arg_706_1.talkMaxDuration = var_709_5

					if var_709_5 + var_709_1 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_5 + var_709_1
					end
				end

				arg_706_1.text_.text = var_709_3
				arg_706_1.typewritter.percent = 0

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(false)
				arg_706_1:RecordContent(arg_706_1.text_.text)
			end

			local var_709_6 = math.max(var_709_2, arg_706_1.talkMaxDuration)

			if var_709_1 <= arg_706_1.time_ and arg_706_1.time_ < var_709_1 + var_709_6 then
				arg_706_1.typewritter.percent = (arg_706_1.time_ - var_709_1) / var_709_6

				arg_706_1.typewritter:SetDirty()
			end

			if arg_706_1.time_ >= var_709_1 + var_709_6 and arg_706_1.time_ < var_709_1 + var_709_6 + arg_709_0 then
				arg_706_1.typewritter.percent = 1

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(true)
			end
		end

		arg_706_1.nodeConfigList_ = {}

		arg_706_1:InitPlayNodeList()
	end,
	Play1108410172 = function(arg_710_0, arg_710_1)
		arg_710_1.time_ = 0
		arg_710_1.frameCnt_ = 0
		arg_710_1.state_ = "playing"
		arg_710_1.curTalkId_ = 1108410172
		arg_710_1.duration_ = 2

		SetActive(arg_710_1.tipsGo_, false)

		function arg_710_1.onSingleLineFinish_()
			arg_710_1.onSingleLineUpdate_ = nil
			arg_710_1.onSingleLineFinish_ = nil
			arg_710_1.state_ = "waiting"
		end

		function arg_710_1.playNext_(arg_712_0)
			if arg_712_0 == 1 then
				arg_710_0:Play1108410173(arg_710_1)
			end
		end

		function arg_710_1.onSingleLineUpdate_(arg_713_0)
			if 0 < arg_710_1.time_ and arg_710_1.time_ <= 0 + arg_713_0 and not isNil(arg_710_1.actors_["10102ui_story"]) and arg_710_1.var_.characterEffect10102ui_story == nil then
				arg_710_1.var_.characterEffect10102ui_story = arg_710_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_713_0 = 0.200000002980232

			if 0 <= arg_710_1.time_ and arg_710_1.time_ < 0 + var_713_0 and not isNil(arg_710_1.actors_["10102ui_story"]) then
				if arg_710_1.var_.characterEffect10102ui_story and not isNil(arg_710_1.actors_["10102ui_story"]) then
					arg_710_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_710_1.time_ >= 0 + var_713_0 and arg_710_1.time_ < 0 + var_713_0 + arg_713_0 and not isNil(arg_710_1.actors_["10102ui_story"]) and arg_710_1.var_.characterEffect10102ui_story then
				arg_710_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_710_1.time_ and arg_710_1.time_ <= 0 + arg_713_0 then
				arg_710_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_710_1.time_ and arg_710_1.time_ <= 0 + arg_713_0 then
				arg_710_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_713_2 = 0
			local var_713_3 = 0.15

			if 0 < arg_710_1.time_ and arg_710_1.time_ <= var_713_2 + arg_713_0 then
				arg_710_1.talkMaxDuration = 0
				arg_710_1.dialogCg_.alpha = 1

				arg_710_1.dialog_:SetActive(true)
				SetActive(arg_710_1.leftNameGo_, true)

				arg_710_1.leftNameTxt_.text = arg_710_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_710_1.leftNameTxt_.transform)

				arg_710_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_710_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_710_1:RecordName(arg_710_1.leftNameTxt_.text)
				SetActive(arg_710_1.iconTrs_.gameObject, false)
				arg_710_1.callingController_:SetSelectedState("normal")

				local var_713_4 = arg_710_1:GetWordFromCfg(1108410172)
				local var_713_5 = arg_710_1:FormatText(var_713_4.content)

				arg_710_1.text_.text = var_713_5

				LuaForUtil.ClearLinePrefixSymbol(arg_710_1.text_)

				local var_713_7 = 6 <= 0 and var_713_3 or var_713_3 * (utf8.len(var_713_5) / 6)

				if (6 <= 0 and var_713_3 or var_713_3 * (utf8.len(var_713_5) / 6)) > 0 and var_713_3 < var_713_7 then
					arg_710_1.talkMaxDuration = var_713_7

					if var_713_7 + var_713_2 > arg_710_1.duration_ then
						arg_710_1.duration_ = var_713_7 + var_713_2
					end
				end

				arg_710_1.text_.text = var_713_5
				arg_710_1.typewritter.percent = 0

				arg_710_1.typewritter:SetDirty()
				arg_710_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410172", "story_v_side_new_1108410.awb") ~= 0 then
					local var_713_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410172", "story_v_side_new_1108410.awb") / 1000

					if var_713_8 + var_713_2 > arg_710_1.duration_ then
						arg_710_1.duration_ = var_713_8 + var_713_2
					end

					if var_713_4.prefab_name ~= "" and arg_710_1.actors_[var_713_4.prefab_name] ~= nil then
						local var_713_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_710_1.actors_[var_713_4.prefab_name].transform, "story_v_side_new_1108410", "1108410172", "story_v_side_new_1108410.awb")

						arg_710_1:RecordAudio("1108410172", var_713_9)
						arg_710_1:RecordAudio("1108410172", var_713_9)
					else
						arg_710_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410172", "story_v_side_new_1108410.awb")
					end

					arg_710_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410172", "story_v_side_new_1108410.awb")
				end

				arg_710_1:RecordContent(arg_710_1.text_.text)
			end

			local var_713_10 = math.max(var_713_3, arg_710_1.talkMaxDuration)

			if var_713_2 <= arg_710_1.time_ and arg_710_1.time_ < var_713_2 + var_713_10 then
				arg_710_1.typewritter.percent = (arg_710_1.time_ - var_713_2) / var_713_10

				arg_710_1.typewritter:SetDirty()
			end

			if arg_710_1.time_ >= var_713_2 + var_713_10 and arg_710_1.time_ < var_713_2 + var_713_10 + arg_713_0 then
				arg_710_1.typewritter.percent = 1

				arg_710_1.typewritter:SetDirty()
				arg_710_1:ShowNextGo(true)
			end
		end

		arg_710_1.nodeConfigList_ = {}

		arg_710_1:InitPlayNodeList()
	end,
	Play1108410173 = function(arg_714_0, arg_714_1)
		arg_714_1.time_ = 0
		arg_714_1.frameCnt_ = 0
		arg_714_1.state_ = "playing"
		arg_714_1.curTalkId_ = 1108410173
		arg_714_1.duration_ = 5

		SetActive(arg_714_1.tipsGo_, false)

		function arg_714_1.onSingleLineFinish_()
			arg_714_1.onSingleLineUpdate_ = nil
			arg_714_1.onSingleLineFinish_ = nil
			arg_714_1.state_ = "waiting"
		end

		function arg_714_1.playNext_(arg_716_0)
			if arg_716_0 == 1 then
				arg_714_0:Play1108410174(arg_714_1)
			end
		end

		function arg_714_1.onSingleLineUpdate_(arg_717_0)
			if 0 < arg_714_1.time_ and arg_714_1.time_ <= 0 + arg_717_0 and not isNil(arg_714_1.actors_["10102ui_story"]) and arg_714_1.var_.characterEffect10102ui_story == nil then
				arg_714_1.var_.characterEffect10102ui_story = arg_714_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_717_0 = 0.200000002980232

			if 0 <= arg_714_1.time_ and arg_714_1.time_ < 0 + var_717_0 and not isNil(arg_714_1.actors_["10102ui_story"]) then
				if arg_714_1.var_.characterEffect10102ui_story and not isNil(arg_714_1.actors_["10102ui_story"]) then
					arg_714_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_714_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_714_1.time_ - 0) / var_717_0)
				end
			end

			if arg_714_1.time_ >= 0 + var_717_0 and arg_714_1.time_ < 0 + var_717_0 + arg_717_0 and not isNil(arg_714_1.actors_["10102ui_story"]) and arg_714_1.var_.characterEffect10102ui_story then
				arg_714_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_714_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_717_1 = 0
			local var_717_2 = 0.1

			if 0 < arg_714_1.time_ and arg_714_1.time_ <= var_717_1 + arg_717_0 then
				arg_714_1.talkMaxDuration = 0
				arg_714_1.dialogCg_.alpha = 1

				arg_714_1.dialog_:SetActive(true)
				SetActive(arg_714_1.leftNameGo_, true)

				arg_714_1.leftNameTxt_.text = arg_714_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_714_1.leftNameTxt_.transform)

				arg_714_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_714_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_714_1:RecordName(arg_714_1.leftNameTxt_.text)
				SetActive(arg_714_1.iconTrs_.gameObject, true)
				arg_714_1.iconController_:SetSelectedState("hero")

				arg_714_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_714_1.callingController_:SetSelectedState("normal")

				arg_714_1.keyicon_.color = Color.New(1, 1, 1)
				arg_714_1.icon_.color = Color.New(1, 1, 1)

				local var_717_3 = arg_714_1:FormatText(arg_714_1:GetWordFromCfg(1108410173).content)

				arg_714_1.text_.text = var_717_3

				LuaForUtil.ClearLinePrefixSymbol(arg_714_1.text_)

				local var_717_5 = 4 <= 0 and var_717_2 or var_717_2 * (utf8.len(var_717_3) / 4)

				if (4 <= 0 and var_717_2 or var_717_2 * (utf8.len(var_717_3) / 4)) > 0 and var_717_2 < var_717_5 then
					arg_714_1.talkMaxDuration = var_717_5

					if var_717_5 + var_717_1 > arg_714_1.duration_ then
						arg_714_1.duration_ = var_717_5 + var_717_1
					end
				end

				arg_714_1.text_.text = var_717_3
				arg_714_1.typewritter.percent = 0

				arg_714_1.typewritter:SetDirty()
				arg_714_1:ShowNextGo(false)
				arg_714_1:RecordContent(arg_714_1.text_.text)
			end

			local var_717_6 = math.max(var_717_2, arg_714_1.talkMaxDuration)

			if var_717_1 <= arg_714_1.time_ and arg_714_1.time_ < var_717_1 + var_717_6 then
				arg_714_1.typewritter.percent = (arg_714_1.time_ - var_717_1) / var_717_6

				arg_714_1.typewritter:SetDirty()
			end

			if arg_714_1.time_ >= var_717_1 + var_717_6 and arg_714_1.time_ < var_717_1 + var_717_6 + arg_717_0 then
				arg_714_1.typewritter.percent = 1

				arg_714_1.typewritter:SetDirty()
				arg_714_1:ShowNextGo(true)
			end
		end

		arg_714_1.nodeConfigList_ = {}

		arg_714_1:InitPlayNodeList()
	end,
	Play1108410174 = function(arg_718_0, arg_718_1)
		arg_718_1.time_ = 0
		arg_718_1.frameCnt_ = 0
		arg_718_1.state_ = "playing"
		arg_718_1.curTalkId_ = 1108410174
		arg_718_1.duration_ = 7.67

		SetActive(arg_718_1.tipsGo_, false)

		function arg_718_1.onSingleLineFinish_()
			arg_718_1.onSingleLineUpdate_ = nil
			arg_718_1.onSingleLineFinish_ = nil
			arg_718_1.state_ = "waiting"
		end

		function arg_718_1.playNext_(arg_720_0)
			if arg_720_0 == 1 then
				arg_718_0:Play1108410175(arg_718_1)
			end
		end

		function arg_718_1.onSingleLineUpdate_(arg_721_0)
			if 0 < arg_718_1.time_ and arg_718_1.time_ <= 0 + arg_721_0 and not isNil(arg_718_1.actors_["10102ui_story"]) and arg_718_1.var_.characterEffect10102ui_story == nil then
				arg_718_1.var_.characterEffect10102ui_story = arg_718_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_721_0 = 0.200000002980232

			if 0 <= arg_718_1.time_ and arg_718_1.time_ < 0 + var_721_0 and not isNil(arg_718_1.actors_["10102ui_story"]) then
				if arg_718_1.var_.characterEffect10102ui_story and not isNil(arg_718_1.actors_["10102ui_story"]) then
					arg_718_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_718_1.time_ >= 0 + var_721_0 and arg_718_1.time_ < 0 + var_721_0 + arg_721_0 and not isNil(arg_718_1.actors_["10102ui_story"]) and arg_718_1.var_.characterEffect10102ui_story then
				arg_718_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_718_1.time_ and arg_718_1.time_ <= 0 + arg_721_0 then
				arg_718_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_718_1.time_ and arg_718_1.time_ <= 0 + arg_721_0 then
				arg_718_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_721_2 = 0
			local var_721_3 = 1.3

			if 0 < arg_718_1.time_ and arg_718_1.time_ <= var_721_2 + arg_721_0 then
				arg_718_1.talkMaxDuration = 0
				arg_718_1.dialogCg_.alpha = 1

				arg_718_1.dialog_:SetActive(true)
				SetActive(arg_718_1.leftNameGo_, true)

				arg_718_1.leftNameTxt_.text = arg_718_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_718_1.leftNameTxt_.transform)

				arg_718_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_718_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_718_1:RecordName(arg_718_1.leftNameTxt_.text)
				SetActive(arg_718_1.iconTrs_.gameObject, false)
				arg_718_1.callingController_:SetSelectedState("normal")

				local var_721_4 = arg_718_1:GetWordFromCfg(1108410174)
				local var_721_5 = arg_718_1:FormatText(var_721_4.content)

				arg_718_1.text_.text = var_721_5

				LuaForUtil.ClearLinePrefixSymbol(arg_718_1.text_)

				local var_721_7 = 52 <= 0 and var_721_3 or var_721_3 * (utf8.len(var_721_5) / 52)

				if (52 <= 0 and var_721_3 or var_721_3 * (utf8.len(var_721_5) / 52)) > 0 and var_721_3 < var_721_7 then
					arg_718_1.talkMaxDuration = var_721_7

					if var_721_7 + var_721_2 > arg_718_1.duration_ then
						arg_718_1.duration_ = var_721_7 + var_721_2
					end
				end

				arg_718_1.text_.text = var_721_5
				arg_718_1.typewritter.percent = 0

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410174", "story_v_side_new_1108410.awb") ~= 0 then
					local var_721_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410174", "story_v_side_new_1108410.awb") / 1000

					if var_721_8 + var_721_2 > arg_718_1.duration_ then
						arg_718_1.duration_ = var_721_8 + var_721_2
					end

					if var_721_4.prefab_name ~= "" and arg_718_1.actors_[var_721_4.prefab_name] ~= nil then
						local var_721_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_718_1.actors_[var_721_4.prefab_name].transform, "story_v_side_new_1108410", "1108410174", "story_v_side_new_1108410.awb")

						arg_718_1:RecordAudio("1108410174", var_721_9)
						arg_718_1:RecordAudio("1108410174", var_721_9)
					else
						arg_718_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410174", "story_v_side_new_1108410.awb")
					end

					arg_718_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410174", "story_v_side_new_1108410.awb")
				end

				arg_718_1:RecordContent(arg_718_1.text_.text)
			end

			local var_721_10 = math.max(var_721_3, arg_718_1.talkMaxDuration)

			if var_721_2 <= arg_718_1.time_ and arg_718_1.time_ < var_721_2 + var_721_10 then
				arg_718_1.typewritter.percent = (arg_718_1.time_ - var_721_2) / var_721_10

				arg_718_1.typewritter:SetDirty()
			end

			if arg_718_1.time_ >= var_721_2 + var_721_10 and arg_718_1.time_ < var_721_2 + var_721_10 + arg_721_0 then
				arg_718_1.typewritter.percent = 1

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(true)
			end
		end

		arg_718_1.nodeConfigList_ = {}

		arg_718_1:InitPlayNodeList()
	end,
	Play1108410175 = function(arg_722_0, arg_722_1)
		arg_722_1.time_ = 0
		arg_722_1.frameCnt_ = 0
		arg_722_1.state_ = "playing"
		arg_722_1.curTalkId_ = 1108410175
		arg_722_1.duration_ = 5

		SetActive(arg_722_1.tipsGo_, false)

		function arg_722_1.onSingleLineFinish_()
			arg_722_1.onSingleLineUpdate_ = nil
			arg_722_1.onSingleLineFinish_ = nil
			arg_722_1.state_ = "waiting"
		end

		function arg_722_1.playNext_(arg_724_0)
			if arg_724_0 == 1 then
				arg_722_0:Play1108410176(arg_722_1)
			end
		end

		function arg_722_1.onSingleLineUpdate_(arg_725_0)
			if 0 < arg_722_1.time_ and arg_722_1.time_ <= 0 + arg_725_0 and not isNil(arg_722_1.actors_["10102ui_story"]) and arg_722_1.var_.characterEffect10102ui_story == nil then
				arg_722_1.var_.characterEffect10102ui_story = arg_722_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_725_0 = 0.200000002980232

			if 0 <= arg_722_1.time_ and arg_722_1.time_ < 0 + var_725_0 and not isNil(arg_722_1.actors_["10102ui_story"]) then
				if arg_722_1.var_.characterEffect10102ui_story and not isNil(arg_722_1.actors_["10102ui_story"]) then
					arg_722_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_722_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_722_1.time_ - 0) / var_725_0)
				end
			end

			if arg_722_1.time_ >= 0 + var_725_0 and arg_722_1.time_ < 0 + var_725_0 + arg_725_0 and not isNil(arg_722_1.actors_["10102ui_story"]) and arg_722_1.var_.characterEffect10102ui_story then
				arg_722_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_722_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_725_1 = 0
			local var_725_2 = 0.75

			if 0 < arg_722_1.time_ and arg_722_1.time_ <= var_725_1 + arg_725_0 then
				arg_722_1.talkMaxDuration = 0
				arg_722_1.dialogCg_.alpha = 1

				arg_722_1.dialog_:SetActive(true)
				SetActive(arg_722_1.leftNameGo_, true)

				arg_722_1.leftNameTxt_.text = arg_722_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_722_1.leftNameTxt_.transform)

				arg_722_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_722_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_722_1:RecordName(arg_722_1.leftNameTxt_.text)
				SetActive(arg_722_1.iconTrs_.gameObject, true)
				arg_722_1.iconController_:SetSelectedState("hero")

				arg_722_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_722_1.callingController_:SetSelectedState("normal")

				arg_722_1.keyicon_.color = Color.New(1, 1, 1)
				arg_722_1.icon_.color = Color.New(1, 1, 1)

				local var_725_3 = arg_722_1:FormatText(arg_722_1:GetWordFromCfg(1108410175).content)

				arg_722_1.text_.text = var_725_3

				LuaForUtil.ClearLinePrefixSymbol(arg_722_1.text_)

				local var_725_5 = 30 <= 0 and var_725_2 or var_725_2 * (utf8.len(var_725_3) / 30)

				if (30 <= 0 and var_725_2 or var_725_2 * (utf8.len(var_725_3) / 30)) > 0 and var_725_2 < var_725_5 then
					arg_722_1.talkMaxDuration = var_725_5

					if var_725_5 + var_725_1 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_5 + var_725_1
					end
				end

				arg_722_1.text_.text = var_725_3
				arg_722_1.typewritter.percent = 0

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(false)
				arg_722_1:RecordContent(arg_722_1.text_.text)
			end

			local var_725_6 = math.max(var_725_2, arg_722_1.talkMaxDuration)

			if var_725_1 <= arg_722_1.time_ and arg_722_1.time_ < var_725_1 + var_725_6 then
				arg_722_1.typewritter.percent = (arg_722_1.time_ - var_725_1) / var_725_6

				arg_722_1.typewritter:SetDirty()
			end

			if arg_722_1.time_ >= var_725_1 + var_725_6 and arg_722_1.time_ < var_725_1 + var_725_6 + arg_725_0 then
				arg_722_1.typewritter.percent = 1

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(true)
			end
		end

		arg_722_1.nodeConfigList_ = {}

		arg_722_1:InitPlayNodeList()
	end,
	Play1108410176 = function(arg_726_0, arg_726_1)
		arg_726_1.time_ = 0
		arg_726_1.frameCnt_ = 0
		arg_726_1.state_ = "playing"
		arg_726_1.curTalkId_ = 1108410176
		arg_726_1.duration_ = 7

		SetActive(arg_726_1.tipsGo_, false)

		function arg_726_1.onSingleLineFinish_()
			arg_726_1.onSingleLineUpdate_ = nil
			arg_726_1.onSingleLineFinish_ = nil
			arg_726_1.state_ = "waiting"
		end

		function arg_726_1.playNext_(arg_728_0)
			if arg_728_0 == 1 then
				arg_726_0:Play1108410177(arg_726_1)
			end
		end

		function arg_726_1.onSingleLineUpdate_(arg_729_0)
			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 and not isNil(arg_726_1.actors_["10102ui_story"]) and arg_726_1.var_.characterEffect10102ui_story == nil then
				arg_726_1.var_.characterEffect10102ui_story = arg_726_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_729_0 = 0.200000002980232

			if 0 <= arg_726_1.time_ and arg_726_1.time_ < 0 + var_729_0 and not isNil(arg_726_1.actors_["10102ui_story"]) then
				if arg_726_1.var_.characterEffect10102ui_story and not isNil(arg_726_1.actors_["10102ui_story"]) then
					arg_726_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_726_1.time_ >= 0 + var_729_0 and arg_726_1.time_ < 0 + var_729_0 + arg_729_0 and not isNil(arg_726_1.actors_["10102ui_story"]) and arg_726_1.var_.characterEffect10102ui_story then
				arg_726_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 then
				arg_726_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 then
				arg_726_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_729_2 = 0
			local var_729_3 = 0.725

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= var_729_2 + arg_729_0 then
				arg_726_1.talkMaxDuration = 0
				arg_726_1.dialogCg_.alpha = 1

				arg_726_1.dialog_:SetActive(true)
				SetActive(arg_726_1.leftNameGo_, true)

				arg_726_1.leftNameTxt_.text = arg_726_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_726_1.leftNameTxt_.transform)

				arg_726_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_726_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_726_1:RecordName(arg_726_1.leftNameTxt_.text)
				SetActive(arg_726_1.iconTrs_.gameObject, false)
				arg_726_1.callingController_:SetSelectedState("normal")

				local var_729_4 = arg_726_1:GetWordFromCfg(1108410176)
				local var_729_5 = arg_726_1:FormatText(var_729_4.content)

				arg_726_1.text_.text = var_729_5

				LuaForUtil.ClearLinePrefixSymbol(arg_726_1.text_)

				local var_729_7 = 29 <= 0 and var_729_3 or var_729_3 * (utf8.len(var_729_5) / 29)

				if (29 <= 0 and var_729_3 or var_729_3 * (utf8.len(var_729_5) / 29)) > 0 and var_729_3 < var_729_7 then
					arg_726_1.talkMaxDuration = var_729_7

					if var_729_7 + var_729_2 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_7 + var_729_2
					end
				end

				arg_726_1.text_.text = var_729_5
				arg_726_1.typewritter.percent = 0

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410176", "story_v_side_new_1108410.awb") ~= 0 then
					local var_729_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410176", "story_v_side_new_1108410.awb") / 1000

					if var_729_8 + var_729_2 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_8 + var_729_2
					end

					if var_729_4.prefab_name ~= "" and arg_726_1.actors_[var_729_4.prefab_name] ~= nil then
						local var_729_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_726_1.actors_[var_729_4.prefab_name].transform, "story_v_side_new_1108410", "1108410176", "story_v_side_new_1108410.awb")

						arg_726_1:RecordAudio("1108410176", var_729_9)
						arg_726_1:RecordAudio("1108410176", var_729_9)
					else
						arg_726_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410176", "story_v_side_new_1108410.awb")
					end

					arg_726_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410176", "story_v_side_new_1108410.awb")
				end

				arg_726_1:RecordContent(arg_726_1.text_.text)
			end

			local var_729_10 = math.max(var_729_3, arg_726_1.talkMaxDuration)

			if var_729_2 <= arg_726_1.time_ and arg_726_1.time_ < var_729_2 + var_729_10 then
				arg_726_1.typewritter.percent = (arg_726_1.time_ - var_729_2) / var_729_10

				arg_726_1.typewritter:SetDirty()
			end

			if arg_726_1.time_ >= var_729_2 + var_729_10 and arg_726_1.time_ < var_729_2 + var_729_10 + arg_729_0 then
				arg_726_1.typewritter.percent = 1

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(true)
			end
		end

		arg_726_1.nodeConfigList_ = {}

		arg_726_1:InitPlayNodeList()
	end,
	Play1108410177 = function(arg_730_0, arg_730_1)
		arg_730_1.time_ = 0
		arg_730_1.frameCnt_ = 0
		arg_730_1.state_ = "playing"
		arg_730_1.curTalkId_ = 1108410177
		arg_730_1.duration_ = 5

		SetActive(arg_730_1.tipsGo_, false)

		function arg_730_1.onSingleLineFinish_()
			arg_730_1.onSingleLineUpdate_ = nil
			arg_730_1.onSingleLineFinish_ = nil
			arg_730_1.state_ = "waiting"
		end

		function arg_730_1.playNext_(arg_732_0)
			if arg_732_0 == 1 then
				arg_730_0:Play1108410178(arg_730_1)
			end
		end

		function arg_730_1.onSingleLineUpdate_(arg_733_0)
			if 0 < arg_730_1.time_ and arg_730_1.time_ <= 0 + arg_733_0 and not isNil(arg_730_1.actors_["10102ui_story"]) and arg_730_1.var_.characterEffect10102ui_story == nil then
				arg_730_1.var_.characterEffect10102ui_story = arg_730_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_733_0 = 0.200000002980232

			if 0 <= arg_730_1.time_ and arg_730_1.time_ < 0 + var_733_0 and not isNil(arg_730_1.actors_["10102ui_story"]) then
				if arg_730_1.var_.characterEffect10102ui_story and not isNil(arg_730_1.actors_["10102ui_story"]) then
					arg_730_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_730_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_730_1.time_ - 0) / var_733_0)
				end
			end

			if arg_730_1.time_ >= 0 + var_733_0 and arg_730_1.time_ < 0 + var_733_0 + arg_733_0 and not isNil(arg_730_1.actors_["10102ui_story"]) and arg_730_1.var_.characterEffect10102ui_story then
				arg_730_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_730_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_733_1 = 0
			local var_733_2 = 0.35

			if 0 < arg_730_1.time_ and arg_730_1.time_ <= var_733_1 + arg_733_0 then
				arg_730_1.talkMaxDuration = 0
				arg_730_1.dialogCg_.alpha = 1

				arg_730_1.dialog_:SetActive(true)
				SetActive(arg_730_1.leftNameGo_, true)

				arg_730_1.leftNameTxt_.text = arg_730_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_730_1.leftNameTxt_.transform)

				arg_730_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_730_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_730_1:RecordName(arg_730_1.leftNameTxt_.text)
				SetActive(arg_730_1.iconTrs_.gameObject, true)
				arg_730_1.iconController_:SetSelectedState("hero")

				arg_730_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_730_1.callingController_:SetSelectedState("normal")

				arg_730_1.keyicon_.color = Color.New(1, 1, 1)
				arg_730_1.icon_.color = Color.New(1, 1, 1)

				local var_733_3 = arg_730_1:FormatText(arg_730_1:GetWordFromCfg(1108410177).content)

				arg_730_1.text_.text = var_733_3

				LuaForUtil.ClearLinePrefixSymbol(arg_730_1.text_)

				local var_733_5 = 14 <= 0 and var_733_2 or var_733_2 * (utf8.len(var_733_3) / 14)

				if (14 <= 0 and var_733_2 or var_733_2 * (utf8.len(var_733_3) / 14)) > 0 and var_733_2 < var_733_5 then
					arg_730_1.talkMaxDuration = var_733_5

					if var_733_5 + var_733_1 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_5 + var_733_1
					end
				end

				arg_730_1.text_.text = var_733_3
				arg_730_1.typewritter.percent = 0

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(false)
				arg_730_1:RecordContent(arg_730_1.text_.text)
			end

			local var_733_6 = math.max(var_733_2, arg_730_1.talkMaxDuration)

			if var_733_1 <= arg_730_1.time_ and arg_730_1.time_ < var_733_1 + var_733_6 then
				arg_730_1.typewritter.percent = (arg_730_1.time_ - var_733_1) / var_733_6

				arg_730_1.typewritter:SetDirty()
			end

			if arg_730_1.time_ >= var_733_1 + var_733_6 and arg_730_1.time_ < var_733_1 + var_733_6 + arg_733_0 then
				arg_730_1.typewritter.percent = 1

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(true)
			end
		end

		arg_730_1.nodeConfigList_ = {}

		arg_730_1:InitPlayNodeList()
	end,
	Play1108410178 = function(arg_734_0, arg_734_1)
		arg_734_1.time_ = 0
		arg_734_1.frameCnt_ = 0
		arg_734_1.state_ = "playing"
		arg_734_1.curTalkId_ = 1108410178
		arg_734_1.duration_ = 6.17

		SetActive(arg_734_1.tipsGo_, false)

		function arg_734_1.onSingleLineFinish_()
			arg_734_1.onSingleLineUpdate_ = nil
			arg_734_1.onSingleLineFinish_ = nil
			arg_734_1.state_ = "waiting"
		end

		function arg_734_1.playNext_(arg_736_0)
			if arg_736_0 == 1 then
				arg_734_0:Play1108410179(arg_734_1)
			end
		end

		function arg_734_1.onSingleLineUpdate_(arg_737_0)
			if 0 < arg_734_1.time_ and arg_734_1.time_ <= 0 + arg_737_0 and not isNil(arg_734_1.actors_["10102ui_story"]) and arg_734_1.var_.characterEffect10102ui_story == nil then
				arg_734_1.var_.characterEffect10102ui_story = arg_734_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_737_0 = 0.200000002980232

			if 0 <= arg_734_1.time_ and arg_734_1.time_ < 0 + var_737_0 and not isNil(arg_734_1.actors_["10102ui_story"]) then
				if arg_734_1.var_.characterEffect10102ui_story and not isNil(arg_734_1.actors_["10102ui_story"]) then
					arg_734_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_734_1.time_ >= 0 + var_737_0 and arg_734_1.time_ < 0 + var_737_0 + arg_737_0 and not isNil(arg_734_1.actors_["10102ui_story"]) and arg_734_1.var_.characterEffect10102ui_story then
				arg_734_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_734_1.time_ and arg_734_1.time_ <= 0 + arg_737_0 then
				arg_734_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_734_1.time_ and arg_734_1.time_ <= 0 + arg_737_0 then
				arg_734_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_737_2 = 0
			local var_737_3 = 0.55

			if 0 < arg_734_1.time_ and arg_734_1.time_ <= var_737_2 + arg_737_0 then
				arg_734_1.talkMaxDuration = 0
				arg_734_1.dialogCg_.alpha = 1

				arg_734_1.dialog_:SetActive(true)
				SetActive(arg_734_1.leftNameGo_, true)

				arg_734_1.leftNameTxt_.text = arg_734_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_734_1.leftNameTxt_.transform)

				arg_734_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_734_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_734_1:RecordName(arg_734_1.leftNameTxt_.text)
				SetActive(arg_734_1.iconTrs_.gameObject, false)
				arg_734_1.callingController_:SetSelectedState("normal")

				local var_737_4 = arg_734_1:GetWordFromCfg(1108410178)
				local var_737_5 = arg_734_1:FormatText(var_737_4.content)

				arg_734_1.text_.text = var_737_5

				LuaForUtil.ClearLinePrefixSymbol(arg_734_1.text_)

				local var_737_7 = 22 <= 0 and var_737_3 or var_737_3 * (utf8.len(var_737_5) / 22)

				if (22 <= 0 and var_737_3 or var_737_3 * (utf8.len(var_737_5) / 22)) > 0 and var_737_3 < var_737_7 then
					arg_734_1.talkMaxDuration = var_737_7

					if var_737_7 + var_737_2 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_7 + var_737_2
					end
				end

				arg_734_1.text_.text = var_737_5
				arg_734_1.typewritter.percent = 0

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410178", "story_v_side_new_1108410.awb") ~= 0 then
					local var_737_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410178", "story_v_side_new_1108410.awb") / 1000

					if var_737_8 + var_737_2 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_8 + var_737_2
					end

					if var_737_4.prefab_name ~= "" and arg_734_1.actors_[var_737_4.prefab_name] ~= nil then
						local var_737_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_734_1.actors_[var_737_4.prefab_name].transform, "story_v_side_new_1108410", "1108410178", "story_v_side_new_1108410.awb")

						arg_734_1:RecordAudio("1108410178", var_737_9)
						arg_734_1:RecordAudio("1108410178", var_737_9)
					else
						arg_734_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410178", "story_v_side_new_1108410.awb")
					end

					arg_734_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410178", "story_v_side_new_1108410.awb")
				end

				arg_734_1:RecordContent(arg_734_1.text_.text)
			end

			local var_737_10 = math.max(var_737_3, arg_734_1.talkMaxDuration)

			if var_737_2 <= arg_734_1.time_ and arg_734_1.time_ < var_737_2 + var_737_10 then
				arg_734_1.typewritter.percent = (arg_734_1.time_ - var_737_2) / var_737_10

				arg_734_1.typewritter:SetDirty()
			end

			if arg_734_1.time_ >= var_737_2 + var_737_10 and arg_734_1.time_ < var_737_2 + var_737_10 + arg_737_0 then
				arg_734_1.typewritter.percent = 1

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(true)
			end
		end

		arg_734_1.nodeConfigList_ = {}

		arg_734_1:InitPlayNodeList()
	end,
	Play1108410179 = function(arg_738_0, arg_738_1)
		arg_738_1.time_ = 0
		arg_738_1.frameCnt_ = 0
		arg_738_1.state_ = "playing"
		arg_738_1.curTalkId_ = 1108410179
		arg_738_1.duration_ = 5

		SetActive(arg_738_1.tipsGo_, false)

		function arg_738_1.onSingleLineFinish_()
			arg_738_1.onSingleLineUpdate_ = nil
			arg_738_1.onSingleLineFinish_ = nil
			arg_738_1.state_ = "waiting"
		end

		function arg_738_1.playNext_(arg_740_0)
			if arg_740_0 == 1 then
				arg_738_0:Play1108410180(arg_738_1)
			end
		end

		function arg_738_1.onSingleLineUpdate_(arg_741_0)
			if 0 < arg_738_1.time_ and arg_738_1.time_ <= 0 + arg_741_0 and not isNil(arg_738_1.actors_["10102ui_story"]) and arg_738_1.var_.characterEffect10102ui_story == nil then
				arg_738_1.var_.characterEffect10102ui_story = arg_738_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_741_0 = 0.200000002980232

			if 0 <= arg_738_1.time_ and arg_738_1.time_ < 0 + var_741_0 and not isNil(arg_738_1.actors_["10102ui_story"]) then
				if arg_738_1.var_.characterEffect10102ui_story and not isNil(arg_738_1.actors_["10102ui_story"]) then
					arg_738_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_738_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_738_1.time_ - 0) / var_741_0)
				end
			end

			if arg_738_1.time_ >= 0 + var_741_0 and arg_738_1.time_ < 0 + var_741_0 + arg_741_0 and not isNil(arg_738_1.actors_["10102ui_story"]) and arg_738_1.var_.characterEffect10102ui_story then
				arg_738_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_738_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_741_1 = 0
			local var_741_2 = 0.225

			if 0 < arg_738_1.time_ and arg_738_1.time_ <= var_741_1 + arg_741_0 then
				arg_738_1.talkMaxDuration = 0
				arg_738_1.dialogCg_.alpha = 1

				arg_738_1.dialog_:SetActive(true)
				SetActive(arg_738_1.leftNameGo_, true)

				arg_738_1.leftNameTxt_.text = arg_738_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_738_1.leftNameTxt_.transform)

				arg_738_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_738_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_738_1:RecordName(arg_738_1.leftNameTxt_.text)
				SetActive(arg_738_1.iconTrs_.gameObject, true)
				arg_738_1.iconController_:SetSelectedState("hero")

				arg_738_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_738_1.callingController_:SetSelectedState("normal")

				arg_738_1.keyicon_.color = Color.New(1, 1, 1)
				arg_738_1.icon_.color = Color.New(1, 1, 1)

				local var_741_3 = arg_738_1:FormatText(arg_738_1:GetWordFromCfg(1108410179).content)

				arg_738_1.text_.text = var_741_3

				LuaForUtil.ClearLinePrefixSymbol(arg_738_1.text_)

				local var_741_5 = 9 <= 0 and var_741_2 or var_741_2 * (utf8.len(var_741_3) / 9)

				if (9 <= 0 and var_741_2 or var_741_2 * (utf8.len(var_741_3) / 9)) > 0 and var_741_2 < var_741_5 then
					arg_738_1.talkMaxDuration = var_741_5

					if var_741_5 + var_741_1 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_5 + var_741_1
					end
				end

				arg_738_1.text_.text = var_741_3
				arg_738_1.typewritter.percent = 0

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(false)
				arg_738_1:RecordContent(arg_738_1.text_.text)
			end

			local var_741_6 = math.max(var_741_2, arg_738_1.talkMaxDuration)

			if var_741_1 <= arg_738_1.time_ and arg_738_1.time_ < var_741_1 + var_741_6 then
				arg_738_1.typewritter.percent = (arg_738_1.time_ - var_741_1) / var_741_6

				arg_738_1.typewritter:SetDirty()
			end

			if arg_738_1.time_ >= var_741_1 + var_741_6 and arg_738_1.time_ < var_741_1 + var_741_6 + arg_741_0 then
				arg_738_1.typewritter.percent = 1

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(true)
			end
		end

		arg_738_1.nodeConfigList_ = {}

		arg_738_1:InitPlayNodeList()
	end,
	Play1108410180 = function(arg_742_0, arg_742_1)
		arg_742_1.time_ = 0
		arg_742_1.frameCnt_ = 0
		arg_742_1.state_ = "playing"
		arg_742_1.curTalkId_ = 1108410180
		arg_742_1.duration_ = 3.9

		SetActive(arg_742_1.tipsGo_, false)

		function arg_742_1.onSingleLineFinish_()
			arg_742_1.onSingleLineUpdate_ = nil
			arg_742_1.onSingleLineFinish_ = nil
			arg_742_1.state_ = "waiting"
		end

		function arg_742_1.playNext_(arg_744_0)
			if arg_744_0 == 1 then
				arg_742_0:Play1108410181(arg_742_1)
			end
		end

		function arg_742_1.onSingleLineUpdate_(arg_745_0)
			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 and not isNil(arg_742_1.actors_["10102ui_story"]) and arg_742_1.var_.characterEffect10102ui_story == nil then
				arg_742_1.var_.characterEffect10102ui_story = arg_742_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_745_0 = 0.200000002980232

			if 0 <= arg_742_1.time_ and arg_742_1.time_ < 0 + var_745_0 and not isNil(arg_742_1.actors_["10102ui_story"]) then
				if arg_742_1.var_.characterEffect10102ui_story and not isNil(arg_742_1.actors_["10102ui_story"]) then
					arg_742_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_742_1.time_ >= 0 + var_745_0 and arg_742_1.time_ < 0 + var_745_0 + arg_745_0 and not isNil(arg_742_1.actors_["10102ui_story"]) and arg_742_1.var_.characterEffect10102ui_story then
				arg_742_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 then
				arg_742_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 then
				arg_742_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_745_2 = 0
			local var_745_3 = 0.35

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= var_745_2 + arg_745_0 then
				arg_742_1.talkMaxDuration = 0
				arg_742_1.dialogCg_.alpha = 1

				arg_742_1.dialog_:SetActive(true)
				SetActive(arg_742_1.leftNameGo_, true)

				arg_742_1.leftNameTxt_.text = arg_742_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_742_1.leftNameTxt_.transform)

				arg_742_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_742_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_742_1:RecordName(arg_742_1.leftNameTxt_.text)
				SetActive(arg_742_1.iconTrs_.gameObject, false)
				arg_742_1.callingController_:SetSelectedState("normal")

				local var_745_4 = arg_742_1:GetWordFromCfg(1108410180)
				local var_745_5 = arg_742_1:FormatText(var_745_4.content)

				arg_742_1.text_.text = var_745_5

				LuaForUtil.ClearLinePrefixSymbol(arg_742_1.text_)

				local var_745_7 = 14 <= 0 and var_745_3 or var_745_3 * (utf8.len(var_745_5) / 14)

				if (14 <= 0 and var_745_3 or var_745_3 * (utf8.len(var_745_5) / 14)) > 0 and var_745_3 < var_745_7 then
					arg_742_1.talkMaxDuration = var_745_7

					if var_745_7 + var_745_2 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_7 + var_745_2
					end
				end

				arg_742_1.text_.text = var_745_5
				arg_742_1.typewritter.percent = 0

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410180", "story_v_side_new_1108410.awb") ~= 0 then
					local var_745_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410180", "story_v_side_new_1108410.awb") / 1000

					if var_745_8 + var_745_2 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_8 + var_745_2
					end

					if var_745_4.prefab_name ~= "" and arg_742_1.actors_[var_745_4.prefab_name] ~= nil then
						local var_745_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_742_1.actors_[var_745_4.prefab_name].transform, "story_v_side_new_1108410", "1108410180", "story_v_side_new_1108410.awb")

						arg_742_1:RecordAudio("1108410180", var_745_9)
						arg_742_1:RecordAudio("1108410180", var_745_9)
					else
						arg_742_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410180", "story_v_side_new_1108410.awb")
					end

					arg_742_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410180", "story_v_side_new_1108410.awb")
				end

				arg_742_1:RecordContent(arg_742_1.text_.text)
			end

			local var_745_10 = math.max(var_745_3, arg_742_1.talkMaxDuration)

			if var_745_2 <= arg_742_1.time_ and arg_742_1.time_ < var_745_2 + var_745_10 then
				arg_742_1.typewritter.percent = (arg_742_1.time_ - var_745_2) / var_745_10

				arg_742_1.typewritter:SetDirty()
			end

			if arg_742_1.time_ >= var_745_2 + var_745_10 and arg_742_1.time_ < var_745_2 + var_745_10 + arg_745_0 then
				arg_742_1.typewritter.percent = 1

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(true)
			end
		end

		arg_742_1.nodeConfigList_ = {}

		arg_742_1:InitPlayNodeList()
	end,
	Play1108410181 = function(arg_746_0, arg_746_1)
		arg_746_1.time_ = 0
		arg_746_1.frameCnt_ = 0
		arg_746_1.state_ = "playing"
		arg_746_1.curTalkId_ = 1108410181
		arg_746_1.duration_ = 5

		SetActive(arg_746_1.tipsGo_, false)

		function arg_746_1.onSingleLineFinish_()
			arg_746_1.onSingleLineUpdate_ = nil
			arg_746_1.onSingleLineFinish_ = nil
			arg_746_1.state_ = "waiting"
		end

		function arg_746_1.playNext_(arg_748_0)
			if arg_748_0 == 1 then
				arg_746_0:Play1108410182(arg_746_1)
			end
		end

		function arg_746_1.onSingleLineUpdate_(arg_749_0)
			if 0 < arg_746_1.time_ and arg_746_1.time_ <= 0 + arg_749_0 and not isNil(arg_746_1.actors_["10102ui_story"]) and arg_746_1.var_.characterEffect10102ui_story == nil then
				arg_746_1.var_.characterEffect10102ui_story = arg_746_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_749_0 = 0.200000002980232

			if 0 <= arg_746_1.time_ and arg_746_1.time_ < 0 + var_749_0 and not isNil(arg_746_1.actors_["10102ui_story"]) then
				if arg_746_1.var_.characterEffect10102ui_story and not isNil(arg_746_1.actors_["10102ui_story"]) then
					arg_746_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_746_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_746_1.time_ - 0) / var_749_0)
				end
			end

			if arg_746_1.time_ >= 0 + var_749_0 and arg_746_1.time_ < 0 + var_749_0 + arg_749_0 and not isNil(arg_746_1.actors_["10102ui_story"]) and arg_746_1.var_.characterEffect10102ui_story then
				arg_746_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_746_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_749_1 = 0
			local var_749_2 = 0.475

			if 0 < arg_746_1.time_ and arg_746_1.time_ <= var_749_1 + arg_749_0 then
				arg_746_1.talkMaxDuration = 0
				arg_746_1.dialogCg_.alpha = 1

				arg_746_1.dialog_:SetActive(true)
				SetActive(arg_746_1.leftNameGo_, true)

				arg_746_1.leftNameTxt_.text = arg_746_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_746_1.leftNameTxt_.transform)

				arg_746_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_746_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_746_1:RecordName(arg_746_1.leftNameTxt_.text)
				SetActive(arg_746_1.iconTrs_.gameObject, true)
				arg_746_1.iconController_:SetSelectedState("hero")

				arg_746_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_746_1.callingController_:SetSelectedState("normal")

				arg_746_1.keyicon_.color = Color.New(1, 1, 1)
				arg_746_1.icon_.color = Color.New(1, 1, 1)

				local var_749_3 = arg_746_1:FormatText(arg_746_1:GetWordFromCfg(1108410181).content)

				arg_746_1.text_.text = var_749_3

				LuaForUtil.ClearLinePrefixSymbol(arg_746_1.text_)

				local var_749_5 = 19 <= 0 and var_749_2 or var_749_2 * (utf8.len(var_749_3) / 19)

				if (19 <= 0 and var_749_2 or var_749_2 * (utf8.len(var_749_3) / 19)) > 0 and var_749_2 < var_749_5 then
					arg_746_1.talkMaxDuration = var_749_5

					if var_749_5 + var_749_1 > arg_746_1.duration_ then
						arg_746_1.duration_ = var_749_5 + var_749_1
					end
				end

				arg_746_1.text_.text = var_749_3
				arg_746_1.typewritter.percent = 0

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(false)
				arg_746_1:RecordContent(arg_746_1.text_.text)
			end

			local var_749_6 = math.max(var_749_2, arg_746_1.talkMaxDuration)

			if var_749_1 <= arg_746_1.time_ and arg_746_1.time_ < var_749_1 + var_749_6 then
				arg_746_1.typewritter.percent = (arg_746_1.time_ - var_749_1) / var_749_6

				arg_746_1.typewritter:SetDirty()
			end

			if arg_746_1.time_ >= var_749_1 + var_749_6 and arg_746_1.time_ < var_749_1 + var_749_6 + arg_749_0 then
				arg_746_1.typewritter.percent = 1

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(true)
			end
		end

		arg_746_1.nodeConfigList_ = {}

		arg_746_1:InitPlayNodeList()
	end,
	Play1108410182 = function(arg_750_0, arg_750_1)
		arg_750_1.time_ = 0
		arg_750_1.frameCnt_ = 0
		arg_750_1.state_ = "playing"
		arg_750_1.curTalkId_ = 1108410182
		arg_750_1.duration_ = 6.43

		SetActive(arg_750_1.tipsGo_, false)

		function arg_750_1.onSingleLineFinish_()
			arg_750_1.onSingleLineUpdate_ = nil
			arg_750_1.onSingleLineFinish_ = nil
			arg_750_1.state_ = "waiting"
		end

		function arg_750_1.playNext_(arg_752_0)
			if arg_752_0 == 1 then
				arg_750_0:Play1108410183(arg_750_1)
			end
		end

		function arg_750_1.onSingleLineUpdate_(arg_753_0)
			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 and not isNil(arg_750_1.actors_["10102ui_story"]) and arg_750_1.var_.characterEffect10102ui_story == nil then
				arg_750_1.var_.characterEffect10102ui_story = arg_750_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_753_0 = 0.200000002980232

			if 0 <= arg_750_1.time_ and arg_750_1.time_ < 0 + var_753_0 and not isNil(arg_750_1.actors_["10102ui_story"]) then
				if arg_750_1.var_.characterEffect10102ui_story and not isNil(arg_750_1.actors_["10102ui_story"]) then
					arg_750_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_750_1.time_ >= 0 + var_753_0 and arg_750_1.time_ < 0 + var_753_0 + arg_753_0 and not isNil(arg_750_1.actors_["10102ui_story"]) and arg_750_1.var_.characterEffect10102ui_story then
				arg_750_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_753_2 = 0
			local var_753_3 = 0.75

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= var_753_2 + arg_753_0 then
				arg_750_1.talkMaxDuration = 0
				arg_750_1.dialogCg_.alpha = 1

				arg_750_1.dialog_:SetActive(true)
				SetActive(arg_750_1.leftNameGo_, true)

				arg_750_1.leftNameTxt_.text = arg_750_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_750_1.leftNameTxt_.transform)

				arg_750_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_750_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_750_1:RecordName(arg_750_1.leftNameTxt_.text)
				SetActive(arg_750_1.iconTrs_.gameObject, false)
				arg_750_1.callingController_:SetSelectedState("normal")

				local var_753_4 = arg_750_1:GetWordFromCfg(1108410182)
				local var_753_5 = arg_750_1:FormatText(var_753_4.content)

				arg_750_1.text_.text = var_753_5

				LuaForUtil.ClearLinePrefixSymbol(arg_750_1.text_)

				local var_753_7 = 30 <= 0 and var_753_3 or var_753_3 * (utf8.len(var_753_5) / 30)

				if (30 <= 0 and var_753_3 or var_753_3 * (utf8.len(var_753_5) / 30)) > 0 and var_753_3 < var_753_7 then
					arg_750_1.talkMaxDuration = var_753_7

					if var_753_7 + var_753_2 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_7 + var_753_2
					end
				end

				arg_750_1.text_.text = var_753_5
				arg_750_1.typewritter.percent = 0

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410182", "story_v_side_new_1108410.awb") ~= 0 then
					local var_753_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410182", "story_v_side_new_1108410.awb") / 1000

					if var_753_8 + var_753_2 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_8 + var_753_2
					end

					if var_753_4.prefab_name ~= "" and arg_750_1.actors_[var_753_4.prefab_name] ~= nil then
						local var_753_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_750_1.actors_[var_753_4.prefab_name].transform, "story_v_side_new_1108410", "1108410182", "story_v_side_new_1108410.awb")

						arg_750_1:RecordAudio("1108410182", var_753_9)
						arg_750_1:RecordAudio("1108410182", var_753_9)
					else
						arg_750_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410182", "story_v_side_new_1108410.awb")
					end

					arg_750_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410182", "story_v_side_new_1108410.awb")
				end

				arg_750_1:RecordContent(arg_750_1.text_.text)
			end

			local var_753_10 = math.max(var_753_3, arg_750_1.talkMaxDuration)

			if var_753_2 <= arg_750_1.time_ and arg_750_1.time_ < var_753_2 + var_753_10 then
				arg_750_1.typewritter.percent = (arg_750_1.time_ - var_753_2) / var_753_10

				arg_750_1.typewritter:SetDirty()
			end

			if arg_750_1.time_ >= var_753_2 + var_753_10 and arg_750_1.time_ < var_753_2 + var_753_10 + arg_753_0 then
				arg_750_1.typewritter.percent = 1

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(true)
			end
		end

		arg_750_1.nodeConfigList_ = {}

		arg_750_1:InitPlayNodeList()
	end,
	Play1108410183 = function(arg_754_0, arg_754_1)
		arg_754_1.time_ = 0
		arg_754_1.frameCnt_ = 0
		arg_754_1.state_ = "playing"
		arg_754_1.curTalkId_ = 1108410183
		arg_754_1.duration_ = 5

		SetActive(arg_754_1.tipsGo_, false)

		function arg_754_1.onSingleLineFinish_()
			arg_754_1.onSingleLineUpdate_ = nil
			arg_754_1.onSingleLineFinish_ = nil
			arg_754_1.state_ = "waiting"
		end

		function arg_754_1.playNext_(arg_756_0)
			if arg_756_0 == 1 then
				arg_754_0:Play1108410184(arg_754_1)
			end
		end

		function arg_754_1.onSingleLineUpdate_(arg_757_0)
			if 0 < arg_754_1.time_ and arg_754_1.time_ <= 0 + arg_757_0 and not isNil(arg_754_1.actors_["10102ui_story"]) and arg_754_1.var_.characterEffect10102ui_story == nil then
				arg_754_1.var_.characterEffect10102ui_story = arg_754_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_757_0 = 0.200000002980232

			if 0 <= arg_754_1.time_ and arg_754_1.time_ < 0 + var_757_0 and not isNil(arg_754_1.actors_["10102ui_story"]) then
				if arg_754_1.var_.characterEffect10102ui_story and not isNil(arg_754_1.actors_["10102ui_story"]) then
					arg_754_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_754_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_754_1.time_ - 0) / var_757_0)
				end
			end

			if arg_754_1.time_ >= 0 + var_757_0 and arg_754_1.time_ < 0 + var_757_0 + arg_757_0 and not isNil(arg_754_1.actors_["10102ui_story"]) and arg_754_1.var_.characterEffect10102ui_story then
				arg_754_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_754_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_757_1 = 0
			local var_757_2 = 0.675

			if 0 < arg_754_1.time_ and arg_754_1.time_ <= var_757_1 + arg_757_0 then
				arg_754_1.talkMaxDuration = 0
				arg_754_1.dialogCg_.alpha = 1

				arg_754_1.dialog_:SetActive(true)
				SetActive(arg_754_1.leftNameGo_, true)

				arg_754_1.leftNameTxt_.text = arg_754_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_754_1.leftNameTxt_.transform)

				arg_754_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_754_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_754_1:RecordName(arg_754_1.leftNameTxt_.text)
				SetActive(arg_754_1.iconTrs_.gameObject, true)
				arg_754_1.iconController_:SetSelectedState("hero")

				arg_754_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_754_1.callingController_:SetSelectedState("normal")

				arg_754_1.keyicon_.color = Color.New(1, 1, 1)
				arg_754_1.icon_.color = Color.New(1, 1, 1)

				local var_757_3 = arg_754_1:FormatText(arg_754_1:GetWordFromCfg(1108410183).content)

				arg_754_1.text_.text = var_757_3

				LuaForUtil.ClearLinePrefixSymbol(arg_754_1.text_)

				local var_757_5 = 27 <= 0 and var_757_2 or var_757_2 * (utf8.len(var_757_3) / 27)

				if (27 <= 0 and var_757_2 or var_757_2 * (utf8.len(var_757_3) / 27)) > 0 and var_757_2 < var_757_5 then
					arg_754_1.talkMaxDuration = var_757_5

					if var_757_5 + var_757_1 > arg_754_1.duration_ then
						arg_754_1.duration_ = var_757_5 + var_757_1
					end
				end

				arg_754_1.text_.text = var_757_3
				arg_754_1.typewritter.percent = 0

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(false)
				arg_754_1:RecordContent(arg_754_1.text_.text)
			end

			local var_757_6 = math.max(var_757_2, arg_754_1.talkMaxDuration)

			if var_757_1 <= arg_754_1.time_ and arg_754_1.time_ < var_757_1 + var_757_6 then
				arg_754_1.typewritter.percent = (arg_754_1.time_ - var_757_1) / var_757_6

				arg_754_1.typewritter:SetDirty()
			end

			if arg_754_1.time_ >= var_757_1 + var_757_6 and arg_754_1.time_ < var_757_1 + var_757_6 + arg_757_0 then
				arg_754_1.typewritter.percent = 1

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(true)
			end
		end

		arg_754_1.nodeConfigList_ = {}

		arg_754_1:InitPlayNodeList()
	end,
	Play1108410184 = function(arg_758_0, arg_758_1)
		arg_758_1.time_ = 0
		arg_758_1.frameCnt_ = 0
		arg_758_1.state_ = "playing"
		arg_758_1.curTalkId_ = 1108410184
		arg_758_1.duration_ = 5

		SetActive(arg_758_1.tipsGo_, false)

		function arg_758_1.onSingleLineFinish_()
			arg_758_1.onSingleLineUpdate_ = nil
			arg_758_1.onSingleLineFinish_ = nil
			arg_758_1.state_ = "waiting"
		end

		function arg_758_1.playNext_(arg_760_0)
			if arg_760_0 == 1 then
				arg_758_0:Play1108410185(arg_758_1)
			end
		end

		function arg_758_1.onSingleLineUpdate_(arg_761_0)
			if 0 < arg_758_1.time_ and arg_758_1.time_ <= 0 + arg_761_0 then
				arg_758_1.var_.moveOldPos10102ui_story = arg_758_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_761_0 = 0.001

			if 0 <= arg_758_1.time_ and arg_758_1.time_ < 0 + var_761_0 then
				arg_758_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_758_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_758_1.time_ - 0) / var_761_0)
				arg_758_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_758_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_758_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_758_1.actors_["10102ui_story"].transform.position).z)
				arg_758_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_758_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_758_1.actors_["10102ui_story"].transform.localEulerAngles = arg_758_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_758_1.time_ >= 0 + var_761_0 and arg_758_1.time_ < 0 + var_761_0 + arg_761_0 then
				arg_758_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_758_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_758_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_758_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_758_1.actors_["10102ui_story"].transform.position).z)
				arg_758_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_758_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_758_1.actors_["10102ui_story"].transform.localEulerAngles = arg_758_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if 0 < arg_758_1.time_ and arg_758_1.time_ <= 0 + arg_761_0 then
				arg_758_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_761_2 = 0
			local var_761_3 = 1.275

			if 0 < arg_758_1.time_ and arg_758_1.time_ <= var_761_2 + arg_761_0 then
				arg_758_1.talkMaxDuration = 0
				arg_758_1.dialogCg_.alpha = 1

				arg_758_1.dialog_:SetActive(true)
				SetActive(arg_758_1.leftNameGo_, false)

				arg_758_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_758_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_758_1:RecordName(arg_758_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_758_1.iconTrs_.gameObject, false)
				arg_758_1.callingController_:SetSelectedState("normal")

				local var_761_4 = arg_758_1:FormatText(arg_758_1:GetWordFromCfg(1108410184).content)

				arg_758_1.text_.text = var_761_4

				LuaForUtil.ClearLinePrefixSymbol(arg_758_1.text_)

				local var_761_6 = 51 <= 0 and var_761_3 or var_761_3 * (utf8.len(var_761_4) / 51)

				if (51 <= 0 and var_761_3 or var_761_3 * (utf8.len(var_761_4) / 51)) > 0 and var_761_3 < var_761_6 then
					arg_758_1.talkMaxDuration = var_761_6

					if var_761_6 + var_761_2 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_6 + var_761_2
					end
				end

				arg_758_1.text_.text = var_761_4
				arg_758_1.typewritter.percent = 0

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(false)
				arg_758_1:RecordContent(arg_758_1.text_.text)
			end

			local var_761_7 = math.max(var_761_3, arg_758_1.talkMaxDuration)

			if var_761_2 <= arg_758_1.time_ and arg_758_1.time_ < var_761_2 + var_761_7 then
				arg_758_1.typewritter.percent = (arg_758_1.time_ - var_761_2) / var_761_7

				arg_758_1.typewritter:SetDirty()
			end

			if arg_758_1.time_ >= var_761_2 + var_761_7 and arg_758_1.time_ < var_761_2 + var_761_7 + arg_761_0 then
				arg_758_1.typewritter.percent = 1

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(true)
			end
		end

		arg_758_1.nodeConfigList_ = {
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

		arg_758_1:InitPlayNodeList()
	end,
	Play1108410185 = function(arg_762_0, arg_762_1)
		arg_762_1.time_ = 0
		arg_762_1.frameCnt_ = 0
		arg_762_1.state_ = "playing"
		arg_762_1.curTalkId_ = 1108410185
		arg_762_1.duration_ = 9.47

		SetActive(arg_762_1.tipsGo_, false)

		function arg_762_1.onSingleLineFinish_()
			arg_762_1.onSingleLineUpdate_ = nil
			arg_762_1.onSingleLineFinish_ = nil
			arg_762_1.state_ = "waiting"
		end

		function arg_762_1.playNext_(arg_764_0)
			if arg_764_0 == 1 then
				arg_762_0:Play1108410186(arg_762_1)
			end
		end

		function arg_762_1.onSingleLineUpdate_(arg_765_0)
			if arg_762_1.bgs_.A00 == nil then
				local var_765_0 = Object.Instantiate(arg_762_1.paintGo_)

				var_765_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_765_0.name = "A00"
				var_765_0.transform.parent = arg_762_1.stage_.transform
				var_765_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_762_1.bgs_.A00 = var_765_0
			end

			if 2 < arg_762_1.time_ and arg_762_1.time_ <= 2 + arg_765_0 then
				local var_765_1 = arg_762_1.bgs_.A00

				arg_762_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_765_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_765_2 = var_765_1:GetComponent("SpriteRenderer")

				if var_765_2 and var_765_2.sprite then
					local var_765_3 = 2 * (var_765_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_765_1.transform.localScale = Vector3.New(var_765_3 / var_765_2.sprite.bounds.size.y < var_765_3 * manager.ui.mainCameraCom_.aspect / var_765_2.sprite.bounds.size.x and var_765_3 * manager.ui.mainCameraCom_.aspect / var_765_2.sprite.bounds.size.x or var_765_3 / var_765_2.sprite.bounds.size.y, var_765_3 / var_765_2.sprite.bounds.size.y < var_765_3 * manager.ui.mainCameraCom_.aspect / var_765_2.sprite.bounds.size.x and var_765_3 * manager.ui.mainCameraCom_.aspect / var_765_2.sprite.bounds.size.x or var_765_3 / var_765_2.sprite.bounds.size.y, 0)
				end

				for iter_765_0, iter_765_1 in pairs(arg_762_1.bgs_) do
					if iter_765_0 ~= "A00" then
						iter_765_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_765_4 = 4

			if 4 < arg_762_1.time_ and arg_762_1.time_ <= var_765_4 + arg_765_0 then
				arg_762_1.allBtn_.enabled = false
			end

			if arg_762_1.time_ >= var_765_4 + 0.3 and arg_762_1.time_ < var_765_4 + 0.3 + arg_765_0 then
				arg_762_1.allBtn_.enabled = true
			end

			local var_765_5 = 0

			if 0 < arg_762_1.time_ and arg_762_1.time_ <= var_765_5 + arg_765_0 then
				arg_762_1.mask_.enabled = true
				arg_762_1.mask_.raycastTarget = true

				arg_762_1:SetGaussion(false)
			end

			local var_765_6 = 2

			if var_765_5 <= arg_762_1.time_ and arg_762_1.time_ < var_765_5 + var_765_6 then
				local var_765_7 = Color.New(0, 0, 0)

				var_765_7.a = Mathf.Lerp(0, 1, (arg_762_1.time_ - var_765_5) / var_765_6)
				arg_762_1.mask_.color = var_765_7
			end

			if arg_762_1.time_ >= var_765_5 + var_765_6 and arg_762_1.time_ < var_765_5 + var_765_6 + arg_765_0 then
				local var_765_8 = Color.New(0, 0, 0)

				var_765_8.a = 1
				arg_762_1.mask_.color = var_765_8
			end

			local var_765_9 = 2

			if 2 < arg_762_1.time_ and arg_762_1.time_ <= var_765_9 + arg_765_0 then
				arg_762_1.mask_.enabled = true
				arg_762_1.mask_.raycastTarget = true

				arg_762_1:SetGaussion(false)
			end

			local var_765_10 = 2

			if var_765_9 <= arg_762_1.time_ and arg_762_1.time_ < var_765_9 + var_765_10 then
				local var_765_11 = Color.New(0, 0, 0)

				var_765_11.a = Mathf.Lerp(1, 0, (arg_762_1.time_ - var_765_9) / var_765_10)
				arg_762_1.mask_.color = var_765_11
			end

			if arg_762_1.time_ >= var_765_9 + var_765_10 and arg_762_1.time_ < var_765_9 + var_765_10 + arg_765_0 then
				local var_765_12 = Color.New(0, 0, 0)

				arg_762_1.mask_.enabled = false
				var_765_12.a = 0
				arg_762_1.mask_.color = var_765_12
			end

			local var_765_13 = arg_762_1.actors_["10102ui_story"]

			if 3.8 < arg_762_1.time_ and arg_762_1.time_ <= 3.8 + arg_765_0 and not isNil(var_765_13) and arg_762_1.var_.characterEffect10102ui_story == nil then
				arg_762_1.var_.characterEffect10102ui_story = var_765_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_765_14 = 0.2

			if 3.8 <= arg_762_1.time_ and arg_762_1.time_ < 3.8 + var_765_14 and not isNil(var_765_13) then
				if arg_762_1.var_.characterEffect10102ui_story and not isNil(var_765_13) then
					arg_762_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_762_1.time_ >= 3.8 + var_765_14 and arg_762_1.time_ < 3.8 + var_765_14 + arg_765_0 and not isNil(var_765_13) and arg_762_1.var_.characterEffect10102ui_story then
				arg_762_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_765_16 = arg_762_1.actors_["10102ui_story"].transform

			if 3.8 < arg_762_1.time_ and arg_762_1.time_ <= 3.8 + arg_765_0 then
				arg_762_1.var_.moveOldPos10102ui_story = var_765_16.localPosition
			end

			local var_765_17 = 0.001

			if 3.8 <= arg_762_1.time_ and arg_762_1.time_ < 3.8 + var_765_17 then
				var_765_16.localPosition = Vector3.Lerp(arg_762_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_762_1.time_ - 3.8) / var_765_17)
				var_765_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_765_16.position).x, (manager.ui.mainCamera.transform.position - var_765_16.position).y, (manager.ui.mainCamera.transform.position - var_765_16.position).z)
				var_765_16.localEulerAngles.z = 0
				var_765_16.localEulerAngles.x = 0
				var_765_16.localEulerAngles = var_765_16.localEulerAngles
			end

			if arg_762_1.time_ >= 3.8 + var_765_17 and arg_762_1.time_ < 3.8 + var_765_17 + arg_765_0 then
				var_765_16.localPosition = Vector3.New(0, -0.985, -6.275)
				var_765_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_765_16.position).x, (manager.ui.mainCamera.transform.position - var_765_16.position).y, (manager.ui.mainCamera.transform.position - var_765_16.position).z)
				var_765_16.localEulerAngles.z = 0
				var_765_16.localEulerAngles.x = 0
				var_765_16.localEulerAngles = var_765_16.localEulerAngles
			end

			if 3.8 < arg_762_1.time_ and arg_762_1.time_ <= 3.8 + arg_765_0 then
				arg_762_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 3.8 < arg_762_1.time_ and arg_762_1.time_ <= 3.8 + arg_765_0 then
				arg_762_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_762_1.time_ and arg_762_1.time_ <= 1.2 + arg_765_0 then
				arg_762_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if 0.2 < arg_762_1.time_ and arg_762_1.time_ <= 0.2 + arg_765_0 then
				arg_762_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_765_20 = arg_762_1.actors_["10102ui_story"].transform

			if 1.98333333333333 < arg_762_1.time_ and arg_762_1.time_ <= 1.98333333333333 + arg_765_0 then
				arg_762_1.var_.moveOldPos10102ui_story = var_765_20.localPosition
			end

			local var_765_21 = 0.001

			if 1.98333333333333 <= arg_762_1.time_ and arg_762_1.time_ < 1.98333333333333 + var_765_21 then
				var_765_20.localPosition = Vector3.Lerp(arg_762_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_762_1.time_ - 1.98333333333333) / var_765_21)
				var_765_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_765_20.position).x, (manager.ui.mainCamera.transform.position - var_765_20.position).y, (manager.ui.mainCamera.transform.position - var_765_20.position).z)
				var_765_20.localEulerAngles.z = 0
				var_765_20.localEulerAngles.x = 0
				var_765_20.localEulerAngles = var_765_20.localEulerAngles
			end

			if arg_762_1.time_ >= 1.98333333333333 + var_765_21 and arg_762_1.time_ < 1.98333333333333 + var_765_21 + arg_765_0 then
				var_765_20.localPosition = Vector3.New(0, 100, 0)
				var_765_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_765_20.position).x, (manager.ui.mainCamera.transform.position - var_765_20.position).y, (manager.ui.mainCamera.transform.position - var_765_20.position).z)
				var_765_20.localEulerAngles.z = 0
				var_765_20.localEulerAngles.x = 0
				var_765_20.localEulerAngles = var_765_20.localEulerAngles
			end

			if 0 < arg_762_1.time_ and arg_762_1.time_ <= 0 + arg_765_0 then
				arg_762_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_765_24 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_762_1.bgmTxt_.text ~= var_765_24 and arg_762_1.bgmTxt_.text ~= "" then
						if arg_762_1.bgmTxt2_.text ~= "" then
							arg_762_1.bgmTxt_.text = arg_762_1.bgmTxt2_.text
						end

						arg_762_1.bgmTxt2_.text = var_765_24

						arg_762_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_762_1.bgmTxt_.text = var_765_24
						arg_762_1.bgmTxt2_.text = var_765_24
					end

					if arg_762_1.bgmTimer then
						arg_762_1.bgmTimer:Stop()

						arg_762_1.bgmTimer = nil
					end

					if arg_762_1.settingData.show_music_name == 1 then
						arg_762_1.musicController:SetSelectedState("show")
						arg_762_1.musicAnimator_:Play("open", 0, 0)

						if arg_762_1.settingData.music_time ~= 0 then
							arg_762_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_762_1.settingData.music_time), function()
								if arg_762_1 == nil or isNil(arg_762_1.bgmTxt_) then
									return
								end

								arg_762_1.musicController:SetSelectedState("hide")
								arg_762_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_762_1.frameCnt_ <= 1 then
				arg_762_1.dialog_:SetActive(false)
			end

			local var_765_25 = 4
			local var_765_26 = 0.375

			if 4 < arg_762_1.time_ and arg_762_1.time_ <= var_765_25 + arg_765_0 then
				arg_762_1.talkMaxDuration = 0

				arg_762_1.dialog_:SetActive(true)

				arg_762_1.dialogCg_.alpha = 0

				local var_765_27 = LeanTween.value(arg_762_1.dialog_, 0, 1, 0.3)

				var_765_27:setOnUpdate(LuaHelper.FloatAction(function(arg_767_0)
					arg_762_1.dialogCg_.alpha = arg_767_0
				end))
				var_765_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_762_1.dialog_)
					var_765_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_762_1.duration_ = arg_762_1.duration_ + 0.3

				SetActive(arg_762_1.leftNameGo_, true)

				arg_762_1.leftNameTxt_.text = arg_762_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_762_1.leftNameTxt_.transform)

				arg_762_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_762_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_762_1:RecordName(arg_762_1.leftNameTxt_.text)
				SetActive(arg_762_1.iconTrs_.gameObject, false)
				arg_762_1.callingController_:SetSelectedState("normal")

				local var_765_28 = arg_762_1:GetWordFromCfg(1108410185)
				local var_765_29 = arg_762_1:FormatText(var_765_28.content)

				arg_762_1.text_.text = var_765_29

				LuaForUtil.ClearLinePrefixSymbol(arg_762_1.text_)

				local var_765_31 = 15 <= 0 and var_765_26 or var_765_26 * (utf8.len(var_765_29) / 15)

				if (15 <= 0 and var_765_26 or var_765_26 * (utf8.len(var_765_29) / 15)) > 0 and var_765_26 < var_765_31 then
					arg_762_1.talkMaxDuration = var_765_31
					var_765_25 = var_765_25 + 0.3

					if var_765_31 + var_765_25 > arg_762_1.duration_ then
						arg_762_1.duration_ = var_765_31 + var_765_25
					end
				end

				arg_762_1.text_.text = var_765_29
				arg_762_1.typewritter.percent = 0

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410185", "story_v_side_new_1108410.awb") ~= 0 then
					local var_765_32 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410185", "story_v_side_new_1108410.awb") / 1000

					if var_765_32 + var_765_25 > arg_762_1.duration_ then
						arg_762_1.duration_ = var_765_32 + var_765_25
					end

					if var_765_28.prefab_name ~= "" and arg_762_1.actors_[var_765_28.prefab_name] ~= nil then
						local var_765_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_762_1.actors_[var_765_28.prefab_name].transform, "story_v_side_new_1108410", "1108410185", "story_v_side_new_1108410.awb")

						arg_762_1:RecordAudio("1108410185", var_765_33)
						arg_762_1:RecordAudio("1108410185", var_765_33)
					else
						arg_762_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410185", "story_v_side_new_1108410.awb")
					end

					arg_762_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410185", "story_v_side_new_1108410.awb")
				end

				arg_762_1:RecordContent(arg_762_1.text_.text)
			end

			local var_765_34 = var_765_25 + 0.3
			local var_765_35 = math.max(var_765_26, arg_762_1.talkMaxDuration)

			if var_765_25 + 0.3 <= arg_762_1.time_ and arg_762_1.time_ < var_765_34 + var_765_35 then
				arg_762_1.typewritter.percent = (arg_762_1.time_ - var_765_34) / var_765_35

				arg_762_1.typewritter:SetDirty()
			end

			if arg_762_1.time_ >= var_765_34 + var_765_35 and arg_762_1.time_ < var_765_34 + var_765_35 + arg_765_0 then
				arg_762_1.typewritter.percent = 1

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(true)
			end
		end

		arg_762_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_762_1:InitPlayNodeList()
	end,
	Play1108410186 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 1108410186
		arg_769_1.duration_ = 5

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play1108410187(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 and not isNil(arg_769_1.actors_["10102ui_story"]) and arg_769_1.var_.characterEffect10102ui_story == nil then
				arg_769_1.var_.characterEffect10102ui_story = arg_769_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_772_0 = 0.200000002980232

			if 0 <= arg_769_1.time_ and arg_769_1.time_ < 0 + var_772_0 and not isNil(arg_769_1.actors_["10102ui_story"]) then
				if arg_769_1.var_.characterEffect10102ui_story and not isNil(arg_769_1.actors_["10102ui_story"]) then
					arg_769_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_769_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_769_1.time_ - 0) / var_772_0)
				end
			end

			if arg_769_1.time_ >= 0 + var_772_0 and arg_769_1.time_ < 0 + var_772_0 + arg_772_0 and not isNil(arg_769_1.actors_["10102ui_story"]) and arg_769_1.var_.characterEffect10102ui_story then
				arg_769_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_769_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_772_1 = 0
			local var_772_2 = 0.65

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= var_772_1 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, true)

				arg_769_1.leftNameTxt_.text = arg_769_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_769_1.leftNameTxt_.transform)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1.leftNameTxt_.text)
				SetActive(arg_769_1.iconTrs_.gameObject, true)
				arg_769_1.iconController_:SetSelectedState("hero")

				arg_769_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_769_1.callingController_:SetSelectedState("normal")

				arg_769_1.keyicon_.color = Color.New(1, 1, 1)
				arg_769_1.icon_.color = Color.New(1, 1, 1)

				local var_772_3 = arg_769_1:FormatText(arg_769_1:GetWordFromCfg(1108410186).content)

				arg_769_1.text_.text = var_772_3

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_5 = 26 <= 0 and var_772_2 or var_772_2 * (utf8.len(var_772_3) / 26)

				if (26 <= 0 and var_772_2 or var_772_2 * (utf8.len(var_772_3) / 26)) > 0 and var_772_2 < var_772_5 then
					arg_769_1.talkMaxDuration = var_772_5

					if var_772_5 + var_772_1 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_5 + var_772_1
					end
				end

				arg_769_1.text_.text = var_772_3
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)
				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_6 = math.max(var_772_2, arg_769_1.talkMaxDuration)

			if var_772_1 <= arg_769_1.time_ and arg_769_1.time_ < var_772_1 + var_772_6 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_1) / var_772_6

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_1 + var_772_6 and arg_769_1.time_ < var_772_1 + var_772_6 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {}

		arg_769_1:InitPlayNodeList()
	end,
	Play1108410187 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 1108410187
		arg_773_1.duration_ = 5

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play1108410188(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			local var_776_0 = 0.925

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, false)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_1 = arg_773_1:FormatText(arg_773_1:GetWordFromCfg(1108410187).content)

				arg_773_1.text_.text = var_776_1

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_3 = 37 <= 0 and var_776_0 or var_776_0 * (utf8.len(var_776_1) / 37)

				if (37 <= 0 and var_776_0 or var_776_0 * (utf8.len(var_776_1) / 37)) > 0 and var_776_0 < var_776_3 then
					arg_773_1.talkMaxDuration = var_776_3

					if var_776_3 + 0 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_3 + 0
					end
				end

				arg_773_1.text_.text = var_776_1
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)
				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_4 = math.max(var_776_0, arg_773_1.talkMaxDuration)

			if 0 <= arg_773_1.time_ and arg_773_1.time_ < 0 + var_776_4 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - 0) / var_776_4

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= 0 + var_776_4 and arg_773_1.time_ < 0 + var_776_4 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {}

		arg_773_1:InitPlayNodeList()
	end,
	Play1108410188 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 1108410188
		arg_777_1.duration_ = 4.3

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play1108410189(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			if arg_777_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_780_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_777_1.stage_.transform)

				var_780_0.name = "1047ui_story"
				var_780_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_777_1.actors_["1047ui_story"] = var_780_0

				local var_780_1 = var_780_0:GetComponentInChildren(typeof(CharacterEffect))

				var_780_1.enabled = true

				local var_780_2 = GameObjectTools.GetOrAddComponent(var_780_0, typeof(DynamicBoneHelper))

				if var_780_2 then
					var_780_2:EnableDynamicBone(false)
				end

				arg_777_1:ShowWeapon(var_780_1.transform, false)

				arg_777_1.var_["1047ui_story" .. "Animator"] = var_780_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_777_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_777_1.var_["1047ui_story" .. "LipSync"] = var_780_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_780_3 = arg_777_1.actors_["1047ui_story"].transform

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 then
				arg_777_1.var_.moveOldPos1047ui_story = var_780_3.localPosition
			end

			local var_780_4 = 0.001

			if 0 <= arg_777_1.time_ and arg_777_1.time_ < 0 + var_780_4 then
				var_780_3.localPosition = Vector3.Lerp(arg_777_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_777_1.time_ - 0) / var_780_4)
				var_780_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_780_3.position).x, (manager.ui.mainCamera.transform.position - var_780_3.position).y, (manager.ui.mainCamera.transform.position - var_780_3.position).z)
				var_780_3.localEulerAngles.z = 0
				var_780_3.localEulerAngles.x = 0
				var_780_3.localEulerAngles = var_780_3.localEulerAngles
			end

			if arg_777_1.time_ >= 0 + var_780_4 and arg_777_1.time_ < 0 + var_780_4 + arg_780_0 then
				var_780_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_780_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_780_3.position).x, (manager.ui.mainCamera.transform.position - var_780_3.position).y, (manager.ui.mainCamera.transform.position - var_780_3.position).z)
				var_780_3.localEulerAngles.z = 0
				var_780_3.localEulerAngles.x = 0
				var_780_3.localEulerAngles = var_780_3.localEulerAngles
			end

			local var_780_5 = arg_777_1.actors_["1047ui_story"]

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 and not isNil(var_780_5) and arg_777_1.var_.characterEffect1047ui_story == nil then
				arg_777_1.var_.characterEffect1047ui_story = var_780_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_780_6 = 0.200000002980232

			if 0 <= arg_777_1.time_ and arg_777_1.time_ < 0 + var_780_6 and not isNil(var_780_5) then
				if arg_777_1.var_.characterEffect1047ui_story and not isNil(var_780_5) then
					arg_777_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_777_1.time_ >= 0 + var_780_6 and arg_777_1.time_ < 0 + var_780_6 + arg_780_0 and not isNil(var_780_5) and arg_777_1.var_.characterEffect1047ui_story then
				arg_777_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 then
				arg_777_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 then
				arg_777_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_780_8 = arg_777_1.actors_["10102ui_story"].transform

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 then
				arg_777_1.var_.moveOldPos10102ui_story = var_780_8.localPosition
			end

			local var_780_9 = 0.001

			if 0 <= arg_777_1.time_ and arg_777_1.time_ < 0 + var_780_9 then
				var_780_8.localPosition = Vector3.Lerp(arg_777_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_777_1.time_ - 0) / var_780_9)
				var_780_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_780_8.position).x, (manager.ui.mainCamera.transform.position - var_780_8.position).y, (manager.ui.mainCamera.transform.position - var_780_8.position).z)
				var_780_8.localEulerAngles.z = 0
				var_780_8.localEulerAngles.x = 0
				var_780_8.localEulerAngles = var_780_8.localEulerAngles
			end

			if arg_777_1.time_ >= 0 + var_780_9 and arg_777_1.time_ < 0 + var_780_9 + arg_780_0 then
				var_780_8.localPosition = Vector3.New(0, 100, 0)
				var_780_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_780_8.position).x, (manager.ui.mainCamera.transform.position - var_780_8.position).y, (manager.ui.mainCamera.transform.position - var_780_8.position).z)
				var_780_8.localEulerAngles.z = 0
				var_780_8.localEulerAngles.x = 0
				var_780_8.localEulerAngles = var_780_8.localEulerAngles
			end

			local var_780_10 = 0
			local var_780_11 = 0.4

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= var_780_10 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				arg_777_1.leftNameTxt_.text = arg_777_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, false)
				arg_777_1.callingController_:SetSelectedState("normal")

				local var_780_12 = arg_777_1:GetWordFromCfg(1108410188)
				local var_780_13 = arg_777_1:FormatText(var_780_12.content)

				arg_777_1.text_.text = var_780_13

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_15 = 16 <= 0 and var_780_11 or var_780_11 * (utf8.len(var_780_13) / 16)

				if (16 <= 0 and var_780_11 or var_780_11 * (utf8.len(var_780_13) / 16)) > 0 and var_780_11 < var_780_15 then
					arg_777_1.talkMaxDuration = var_780_15

					if var_780_15 + var_780_10 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_15 + var_780_10
					end
				end

				arg_777_1.text_.text = var_780_13
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410188", "story_v_side_new_1108410.awb") ~= 0 then
					local var_780_16 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410188", "story_v_side_new_1108410.awb") / 1000

					if var_780_16 + var_780_10 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_16 + var_780_10
					end

					if var_780_12.prefab_name ~= "" and arg_777_1.actors_[var_780_12.prefab_name] ~= nil then
						local var_780_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_777_1.actors_[var_780_12.prefab_name].transform, "story_v_side_new_1108410", "1108410188", "story_v_side_new_1108410.awb")

						arg_777_1:RecordAudio("1108410188", var_780_17)
						arg_777_1:RecordAudio("1108410188", var_780_17)
					else
						arg_777_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410188", "story_v_side_new_1108410.awb")
					end

					arg_777_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410188", "story_v_side_new_1108410.awb")
				end

				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_18 = math.max(var_780_11, arg_777_1.talkMaxDuration)

			if var_780_10 <= arg_777_1.time_ and arg_777_1.time_ < var_780_10 + var_780_18 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - var_780_10) / var_780_18

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= var_780_10 + var_780_18 and arg_777_1.time_ < var_780_10 + var_780_18 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_777_1:InitPlayNodeList()
	end,
	Play1108410189 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 1108410189
		arg_781_1.duration_ = 5

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play1108410190(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			if 0 < arg_781_1.time_ and arg_781_1.time_ <= 0 + arg_784_0 and not isNil(arg_781_1.actors_["1047ui_story"]) and arg_781_1.var_.characterEffect1047ui_story == nil then
				arg_781_1.var_.characterEffect1047ui_story = arg_781_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_784_0 = 0.200000002980232

			if 0 <= arg_781_1.time_ and arg_781_1.time_ < 0 + var_784_0 and not isNil(arg_781_1.actors_["1047ui_story"]) then
				if arg_781_1.var_.characterEffect1047ui_story and not isNil(arg_781_1.actors_["1047ui_story"]) then
					arg_781_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_781_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_781_1.time_ - 0) / var_784_0)
				end
			end

			if arg_781_1.time_ >= 0 + var_784_0 and arg_781_1.time_ < 0 + var_784_0 + arg_784_0 and not isNil(arg_781_1.actors_["1047ui_story"]) and arg_781_1.var_.characterEffect1047ui_story then
				arg_781_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_781_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_784_1 = 0
			local var_784_2 = 0.075

			if 0 < arg_781_1.time_ and arg_781_1.time_ <= var_784_1 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, true)

				arg_781_1.leftNameTxt_.text = arg_781_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_781_1.leftNameTxt_.transform)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1.leftNameTxt_.text)
				SetActive(arg_781_1.iconTrs_.gameObject, true)
				arg_781_1.iconController_:SetSelectedState("hero")

				arg_781_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_781_1.callingController_:SetSelectedState("normal")

				arg_781_1.keyicon_.color = Color.New(1, 1, 1)
				arg_781_1.icon_.color = Color.New(1, 1, 1)

				local var_784_3 = arg_781_1:FormatText(arg_781_1:GetWordFromCfg(1108410189).content)

				arg_781_1.text_.text = var_784_3

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_5 = 3 <= 0 and var_784_2 or var_784_2 * (utf8.len(var_784_3) / 3)

				if (3 <= 0 and var_784_2 or var_784_2 * (utf8.len(var_784_3) / 3)) > 0 and var_784_2 < var_784_5 then
					arg_781_1.talkMaxDuration = var_784_5

					if var_784_5 + var_784_1 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_5 + var_784_1
					end
				end

				arg_781_1.text_.text = var_784_3
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)
				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_6 = math.max(var_784_2, arg_781_1.talkMaxDuration)

			if var_784_1 <= arg_781_1.time_ and arg_781_1.time_ < var_784_1 + var_784_6 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - var_784_1) / var_784_6

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= var_784_1 + var_784_6 and arg_781_1.time_ < var_784_1 + var_784_6 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {}

		arg_781_1:InitPlayNodeList()
	end,
	Play1108410190 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 1108410190
		arg_785_1.duration_ = 12

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play1108410191(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 and not isNil(arg_785_1.actors_["1047ui_story"]) and arg_785_1.var_.characterEffect1047ui_story == nil then
				arg_785_1.var_.characterEffect1047ui_story = arg_785_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_788_0 = 0.200000002980232

			if 0 <= arg_785_1.time_ and arg_785_1.time_ < 0 + var_788_0 and not isNil(arg_785_1.actors_["1047ui_story"]) then
				if arg_785_1.var_.characterEffect1047ui_story and not isNil(arg_785_1.actors_["1047ui_story"]) then
					arg_785_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_785_1.time_ >= 0 + var_788_0 and arg_785_1.time_ < 0 + var_788_0 + arg_788_0 and not isNil(arg_785_1.actors_["1047ui_story"]) and arg_785_1.var_.characterEffect1047ui_story then
				arg_785_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_788_2 = 0
			local var_788_3 = 1.6

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= var_788_2 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, true)

				arg_785_1.leftNameTxt_.text = arg_785_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_785_1.leftNameTxt_.transform)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1.leftNameTxt_.text)
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_4 = arg_785_1:GetWordFromCfg(1108410190)
				local var_788_5 = arg_785_1:FormatText(var_788_4.content)

				arg_785_1.text_.text = var_788_5

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_7 = 64 <= 0 and var_788_3 or var_788_3 * (utf8.len(var_788_5) / 64)

				if (64 <= 0 and var_788_3 or var_788_3 * (utf8.len(var_788_5) / 64)) > 0 and var_788_3 < var_788_7 then
					arg_785_1.talkMaxDuration = var_788_7

					if var_788_7 + var_788_2 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_7 + var_788_2
					end
				end

				arg_785_1.text_.text = var_788_5
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410190", "story_v_side_new_1108410.awb") ~= 0 then
					local var_788_8 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410190", "story_v_side_new_1108410.awb") / 1000

					if var_788_8 + var_788_2 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_8 + var_788_2
					end

					if var_788_4.prefab_name ~= "" and arg_785_1.actors_[var_788_4.prefab_name] ~= nil then
						local var_788_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_785_1.actors_[var_788_4.prefab_name].transform, "story_v_side_new_1108410", "1108410190", "story_v_side_new_1108410.awb")

						arg_785_1:RecordAudio("1108410190", var_788_9)
						arg_785_1:RecordAudio("1108410190", var_788_9)
					else
						arg_785_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410190", "story_v_side_new_1108410.awb")
					end

					arg_785_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410190", "story_v_side_new_1108410.awb")
				end

				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_10 = math.max(var_788_3, arg_785_1.talkMaxDuration)

			if var_788_2 <= arg_785_1.time_ and arg_785_1.time_ < var_788_2 + var_788_10 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_2) / var_788_10

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_2 + var_788_10 and arg_785_1.time_ < var_788_2 + var_788_10 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {}

		arg_785_1:InitPlayNodeList()
	end,
	Play1108410191 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 1108410191
		arg_789_1.duration_ = 4.47

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play1108410192(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 then
				arg_789_1.var_.moveOldPos10102ui_story = arg_789_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_792_0 = 0.001

			if 0 <= arg_789_1.time_ and arg_789_1.time_ < 0 + var_792_0 then
				arg_789_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_789_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_789_1.time_ - 0) / var_792_0)
				arg_789_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_789_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_789_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_789_1.actors_["10102ui_story"].transform.position).z)
				arg_789_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_789_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_789_1.actors_["10102ui_story"].transform.localEulerAngles = arg_789_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_789_1.time_ >= 0 + var_792_0 and arg_789_1.time_ < 0 + var_792_0 + arg_792_0 then
				arg_789_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_789_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_789_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_789_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_789_1.actors_["10102ui_story"].transform.position).z)
				arg_789_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_789_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_789_1.actors_["10102ui_story"].transform.localEulerAngles = arg_789_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_792_1 = arg_789_1.actors_["1047ui_story"].transform

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 then
				arg_789_1.var_.moveOldPos1047ui_story = var_792_1.localPosition
			end

			local var_792_2 = 0.001

			if 0 <= arg_789_1.time_ and arg_789_1.time_ < 0 + var_792_2 then
				var_792_1.localPosition = Vector3.Lerp(arg_789_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_789_1.time_ - 0) / var_792_2)
				var_792_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_792_1.position).x, (manager.ui.mainCamera.transform.position - var_792_1.position).y, (manager.ui.mainCamera.transform.position - var_792_1.position).z)
				var_792_1.localEulerAngles.z = 0
				var_792_1.localEulerAngles.x = 0
				var_792_1.localEulerAngles = var_792_1.localEulerAngles
			end

			if arg_789_1.time_ >= 0 + var_792_2 and arg_789_1.time_ < 0 + var_792_2 + arg_792_0 then
				var_792_1.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_792_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_792_1.position).x, (manager.ui.mainCamera.transform.position - var_792_1.position).y, (manager.ui.mainCamera.transform.position - var_792_1.position).z)
				var_792_1.localEulerAngles.z = 0
				var_792_1.localEulerAngles.x = 0
				var_792_1.localEulerAngles = var_792_1.localEulerAngles
			end

			local var_792_3 = arg_789_1.actors_["10102ui_story"]

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 and not isNil(var_792_3) and arg_789_1.var_.characterEffect10102ui_story == nil then
				arg_789_1.var_.characterEffect10102ui_story = var_792_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_792_4 = 0.200000002980232

			if 0 <= arg_789_1.time_ and arg_789_1.time_ < 0 + var_792_4 and not isNil(var_792_3) then
				if arg_789_1.var_.characterEffect10102ui_story and not isNil(var_792_3) then
					arg_789_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_789_1.time_ >= 0 + var_792_4 and arg_789_1.time_ < 0 + var_792_4 + arg_792_0 and not isNil(var_792_3) and arg_789_1.var_.characterEffect10102ui_story then
				arg_789_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_792_6 = arg_789_1.actors_["1047ui_story"]

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 and not isNil(var_792_6) and arg_789_1.var_.characterEffect1047ui_story == nil then
				arg_789_1.var_.characterEffect1047ui_story = var_792_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_792_7 = 0.200000002980232

			if 0 <= arg_789_1.time_ and arg_789_1.time_ < 0 + var_792_7 and not isNil(var_792_6) then
				if arg_789_1.var_.characterEffect1047ui_story and not isNil(var_792_6) then
					arg_789_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_789_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_789_1.time_ - 0) / var_792_7)
				end
			end

			if arg_789_1.time_ >= 0 + var_792_7 and arg_789_1.time_ < 0 + var_792_7 + arg_792_0 and not isNil(var_792_6) and arg_789_1.var_.characterEffect1047ui_story then
				arg_789_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_789_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 then
				arg_789_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action3_1")
			end

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 then
				arg_789_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_792_8 = 0
			local var_792_9 = 0.825

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= var_792_8 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, true)

				arg_789_1.leftNameTxt_.text = arg_789_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_789_1.leftNameTxt_.transform)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1.leftNameTxt_.text)
				SetActive(arg_789_1.iconTrs_.gameObject, false)
				arg_789_1.callingController_:SetSelectedState("normal")

				local var_792_10 = arg_789_1:GetWordFromCfg(1108410191)
				local var_792_11 = arg_789_1:FormatText(var_792_10.content)

				arg_789_1.text_.text = var_792_11

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_13 = 33 <= 0 and var_792_9 or var_792_9 * (utf8.len(var_792_11) / 33)

				if (33 <= 0 and var_792_9 or var_792_9 * (utf8.len(var_792_11) / 33)) > 0 and var_792_9 < var_792_13 then
					arg_789_1.talkMaxDuration = var_792_13

					if var_792_13 + var_792_8 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_13 + var_792_8
					end
				end

				arg_789_1.text_.text = var_792_11
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410191", "story_v_side_new_1108410.awb") ~= 0 then
					local var_792_14 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410191", "story_v_side_new_1108410.awb") / 1000

					if var_792_14 + var_792_8 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_14 + var_792_8
					end

					if var_792_10.prefab_name ~= "" and arg_789_1.actors_[var_792_10.prefab_name] ~= nil then
						local var_792_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_789_1.actors_[var_792_10.prefab_name].transform, "story_v_side_new_1108410", "1108410191", "story_v_side_new_1108410.awb")

						arg_789_1:RecordAudio("1108410191", var_792_15)
						arg_789_1:RecordAudio("1108410191", var_792_15)
					else
						arg_789_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410191", "story_v_side_new_1108410.awb")
					end

					arg_789_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410191", "story_v_side_new_1108410.awb")
				end

				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_16 = math.max(var_792_9, arg_789_1.talkMaxDuration)

			if var_792_8 <= arg_789_1.time_ and arg_789_1.time_ < var_792_8 + var_792_16 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - var_792_8) / var_792_16

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= var_792_8 + var_792_16 and arg_789_1.time_ < var_792_8 + var_792_16 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_789_1:InitPlayNodeList()
	end,
	Play1108410192 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 1108410192
		arg_793_1.duration_ = 3.07

		SetActive(arg_793_1.tipsGo_, false)

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				arg_793_0:Play1108410193(arg_793_1)
			end
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 then
				arg_793_1.var_.moveOldPos1047ui_story = arg_793_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_796_0 = 0.001

			if 0 <= arg_793_1.time_ and arg_793_1.time_ < 0 + var_796_0 then
				arg_793_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_793_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_793_1.time_ - 0) / var_796_0)
				arg_793_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_793_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_793_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_793_1.actors_["1047ui_story"].transform.position).z)
				arg_793_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_793_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_793_1.actors_["1047ui_story"].transform.localEulerAngles = arg_793_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_793_1.time_ >= 0 + var_796_0 and arg_793_1.time_ < 0 + var_796_0 + arg_796_0 then
				arg_793_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_793_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_793_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_793_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_793_1.actors_["1047ui_story"].transform.position).z)
				arg_793_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_793_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_793_1.actors_["1047ui_story"].transform.localEulerAngles = arg_793_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_796_1 = arg_793_1.actors_["1047ui_story"]

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 and not isNil(var_796_1) and arg_793_1.var_.characterEffect1047ui_story == nil then
				arg_793_1.var_.characterEffect1047ui_story = var_796_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_796_2 = 0.200000002980232

			if 0 <= arg_793_1.time_ and arg_793_1.time_ < 0 + var_796_2 and not isNil(var_796_1) then
				if arg_793_1.var_.characterEffect1047ui_story and not isNil(var_796_1) then
					arg_793_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_793_1.time_ >= 0 + var_796_2 and arg_793_1.time_ < 0 + var_796_2 + arg_796_0 and not isNil(var_796_1) and arg_793_1.var_.characterEffect1047ui_story then
				arg_793_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_796_4 = arg_793_1.actors_["10102ui_story"]

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 and not isNil(var_796_4) and arg_793_1.var_.characterEffect10102ui_story == nil then
				arg_793_1.var_.characterEffect10102ui_story = var_796_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_796_5 = 0.200000002980232

			if 0 <= arg_793_1.time_ and arg_793_1.time_ < 0 + var_796_5 and not isNil(var_796_4) then
				if arg_793_1.var_.characterEffect10102ui_story and not isNil(var_796_4) then
					arg_793_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_793_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_793_1.time_ - 0) / var_796_5)
				end
			end

			if arg_793_1.time_ >= 0 + var_796_5 and arg_793_1.time_ < 0 + var_796_5 + arg_796_0 and not isNil(var_796_4) and arg_793_1.var_.characterEffect10102ui_story then
				arg_793_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_793_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 then
				arg_793_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 then
				arg_793_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_796_6 = 0
			local var_796_7 = 0.35

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= var_796_6 + arg_796_0 then
				arg_793_1.talkMaxDuration = 0
				arg_793_1.dialogCg_.alpha = 1

				arg_793_1.dialog_:SetActive(true)
				SetActive(arg_793_1.leftNameGo_, true)

				arg_793_1.leftNameTxt_.text = arg_793_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_793_1.leftNameTxt_.transform)

				arg_793_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_793_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_793_1:RecordName(arg_793_1.leftNameTxt_.text)
				SetActive(arg_793_1.iconTrs_.gameObject, false)
				arg_793_1.callingController_:SetSelectedState("normal")

				local var_796_8 = arg_793_1:GetWordFromCfg(1108410192)
				local var_796_9 = arg_793_1:FormatText(var_796_8.content)

				arg_793_1.text_.text = var_796_9

				LuaForUtil.ClearLinePrefixSymbol(arg_793_1.text_)

				local var_796_11 = 14 <= 0 and var_796_7 or var_796_7 * (utf8.len(var_796_9) / 14)

				if (14 <= 0 and var_796_7 or var_796_7 * (utf8.len(var_796_9) / 14)) > 0 and var_796_7 < var_796_11 then
					arg_793_1.talkMaxDuration = var_796_11

					if var_796_11 + var_796_6 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_11 + var_796_6
					end
				end

				arg_793_1.text_.text = var_796_9
				arg_793_1.typewritter.percent = 0

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410192", "story_v_side_new_1108410.awb") ~= 0 then
					local var_796_12 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410192", "story_v_side_new_1108410.awb") / 1000

					if var_796_12 + var_796_6 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_12 + var_796_6
					end

					if var_796_8.prefab_name ~= "" and arg_793_1.actors_[var_796_8.prefab_name] ~= nil then
						local var_796_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_793_1.actors_[var_796_8.prefab_name].transform, "story_v_side_new_1108410", "1108410192", "story_v_side_new_1108410.awb")

						arg_793_1:RecordAudio("1108410192", var_796_13)
						arg_793_1:RecordAudio("1108410192", var_796_13)
					else
						arg_793_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410192", "story_v_side_new_1108410.awb")
					end

					arg_793_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410192", "story_v_side_new_1108410.awb")
				end

				arg_793_1:RecordContent(arg_793_1.text_.text)
			end

			local var_796_14 = math.max(var_796_7, arg_793_1.talkMaxDuration)

			if var_796_6 <= arg_793_1.time_ and arg_793_1.time_ < var_796_6 + var_796_14 then
				arg_793_1.typewritter.percent = (arg_793_1.time_ - var_796_6) / var_796_14

				arg_793_1.typewritter:SetDirty()
			end

			if arg_793_1.time_ >= var_796_6 + var_796_14 and arg_793_1.time_ < var_796_6 + var_796_14 + arg_796_0 then
				arg_793_1.typewritter.percent = 1

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(true)
			end
		end

		arg_793_1.nodeConfigList_ = {
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

		arg_793_1:InitPlayNodeList()
	end,
	Play1108410193 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 1108410193
		arg_797_1.duration_ = 5

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play1108410194(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 and not isNil(arg_797_1.actors_["1047ui_story"]) and arg_797_1.var_.characterEffect1047ui_story == nil then
				arg_797_1.var_.characterEffect1047ui_story = arg_797_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_800_0 = 0.200000002980232

			if 0 <= arg_797_1.time_ and arg_797_1.time_ < 0 + var_800_0 and not isNil(arg_797_1.actors_["1047ui_story"]) then
				if arg_797_1.var_.characterEffect1047ui_story and not isNil(arg_797_1.actors_["1047ui_story"]) then
					arg_797_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_797_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_797_1.time_ - 0) / var_800_0)
				end
			end

			if arg_797_1.time_ >= 0 + var_800_0 and arg_797_1.time_ < 0 + var_800_0 + arg_800_0 and not isNil(arg_797_1.actors_["1047ui_story"]) and arg_797_1.var_.characterEffect1047ui_story then
				arg_797_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_797_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_800_1 = 0
			local var_800_2 = 0.2

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= var_800_1 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, true)

				arg_797_1.leftNameTxt_.text = arg_797_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_797_1.leftNameTxt_.transform)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1.leftNameTxt_.text)
				SetActive(arg_797_1.iconTrs_.gameObject, true)
				arg_797_1.iconController_:SetSelectedState("hero")

				arg_797_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_797_1.callingController_:SetSelectedState("normal")

				arg_797_1.keyicon_.color = Color.New(1, 1, 1)
				arg_797_1.icon_.color = Color.New(1, 1, 1)

				local var_800_3 = arg_797_1:FormatText(arg_797_1:GetWordFromCfg(1108410193).content)

				arg_797_1.text_.text = var_800_3

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_5 = 8 <= 0 and var_800_2 or var_800_2 * (utf8.len(var_800_3) / 8)

				if (8 <= 0 and var_800_2 or var_800_2 * (utf8.len(var_800_3) / 8)) > 0 and var_800_2 < var_800_5 then
					arg_797_1.talkMaxDuration = var_800_5

					if var_800_5 + var_800_1 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_5 + var_800_1
					end
				end

				arg_797_1.text_.text = var_800_3
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)
				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_6 = math.max(var_800_2, arg_797_1.talkMaxDuration)

			if var_800_1 <= arg_797_1.time_ and arg_797_1.time_ < var_800_1 + var_800_6 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - var_800_1) / var_800_6

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= var_800_1 + var_800_6 and arg_797_1.time_ < var_800_1 + var_800_6 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {}

		arg_797_1:InitPlayNodeList()
	end,
	Play1108410194 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 1108410194
		arg_801_1.duration_ = 5

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
		end

		function arg_801_1.playNext_(arg_803_0)
			if arg_803_0 == 1 then
				arg_801_0:Play1108410195(arg_801_1)
			end
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			local var_804_0 = 0.8

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 then
				arg_801_1.talkMaxDuration = 0
				arg_801_1.dialogCg_.alpha = 1

				arg_801_1.dialog_:SetActive(true)
				SetActive(arg_801_1.leftNameGo_, true)

				arg_801_1.leftNameTxt_.text = arg_801_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_801_1.leftNameTxt_.transform)

				arg_801_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_801_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_801_1:RecordName(arg_801_1.leftNameTxt_.text)
				SetActive(arg_801_1.iconTrs_.gameObject, true)
				arg_801_1.iconController_:SetSelectedState("hero")

				arg_801_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_801_1.callingController_:SetSelectedState("normal")

				arg_801_1.keyicon_.color = Color.New(1, 1, 1)
				arg_801_1.icon_.color = Color.New(1, 1, 1)

				local var_804_1 = arg_801_1:FormatText(arg_801_1:GetWordFromCfg(1108410194).content)

				arg_801_1.text_.text = var_804_1

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_3 = 32 <= 0 and var_804_0 or var_804_0 * (utf8.len(var_804_1) / 32)

				if (32 <= 0 and var_804_0 or var_804_0 * (utf8.len(var_804_1) / 32)) > 0 and var_804_0 < var_804_3 then
					arg_801_1.talkMaxDuration = var_804_3

					if var_804_3 + 0 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_3 + 0
					end
				end

				arg_801_1.text_.text = var_804_1
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)
				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_4 = math.max(var_804_0, arg_801_1.talkMaxDuration)

			if 0 <= arg_801_1.time_ and arg_801_1.time_ < 0 + var_804_4 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - 0) / var_804_4

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= 0 + var_804_4 and arg_801_1.time_ < 0 + var_804_4 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {}

		arg_801_1:InitPlayNodeList()
	end,
	Play1108410195 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 1108410195
		arg_805_1.duration_ = 3.2

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play1108410196(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1.var_.moveOldPos10102ui_story = arg_805_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_808_0 = 0.001

			if 0 <= arg_805_1.time_ and arg_805_1.time_ < 0 + var_808_0 then
				arg_805_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_805_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_805_1.time_ - 0) / var_808_0)
				arg_805_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_805_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["10102ui_story"].transform.position).z)
				arg_805_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_805_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_805_1.actors_["10102ui_story"].transform.localEulerAngles = arg_805_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_805_1.time_ >= 0 + var_808_0 and arg_805_1.time_ < 0 + var_808_0 + arg_808_0 then
				arg_805_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.275)
				arg_805_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_805_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_805_1.actors_["10102ui_story"].transform.position).z)
				arg_805_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_805_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_805_1.actors_["10102ui_story"].transform.localEulerAngles = arg_805_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_808_1 = arg_805_1.actors_["10102ui_story"]

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 and not isNil(var_808_1) and arg_805_1.var_.characterEffect10102ui_story == nil then
				arg_805_1.var_.characterEffect10102ui_story = var_808_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_808_2 = 0.200000002980232

			if 0 <= arg_805_1.time_ and arg_805_1.time_ < 0 + var_808_2 and not isNil(var_808_1) then
				if arg_805_1.var_.characterEffect10102ui_story and not isNil(var_808_1) then
					arg_805_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_805_1.time_ >= 0 + var_808_2 and arg_805_1.time_ < 0 + var_808_2 + arg_808_0 and not isNil(var_808_1) and arg_805_1.var_.characterEffect10102ui_story then
				arg_805_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action435")
			end

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_808_4 = 0
			local var_808_5 = 0.325

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= var_808_4 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, true)

				arg_805_1.leftNameTxt_.text = arg_805_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_805_1.leftNameTxt_.transform)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1.leftNameTxt_.text)
				SetActive(arg_805_1.iconTrs_.gameObject, false)
				arg_805_1.callingController_:SetSelectedState("normal")

				local var_808_6 = arg_805_1:GetWordFromCfg(1108410195)
				local var_808_7 = arg_805_1:FormatText(var_808_6.content)

				arg_805_1.text_.text = var_808_7

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_9 = 13 <= 0 and var_808_5 or var_808_5 * (utf8.len(var_808_7) / 13)

				if (13 <= 0 and var_808_5 or var_808_5 * (utf8.len(var_808_7) / 13)) > 0 and var_808_5 < var_808_9 then
					arg_805_1.talkMaxDuration = var_808_9

					if var_808_9 + var_808_4 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_9 + var_808_4
					end
				end

				arg_805_1.text_.text = var_808_7
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410195", "story_v_side_new_1108410.awb") ~= 0 then
					local var_808_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410195", "story_v_side_new_1108410.awb") / 1000

					if var_808_10 + var_808_4 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_10 + var_808_4
					end

					if var_808_6.prefab_name ~= "" and arg_805_1.actors_[var_808_6.prefab_name] ~= nil then
						local var_808_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_805_1.actors_[var_808_6.prefab_name].transform, "story_v_side_new_1108410", "1108410195", "story_v_side_new_1108410.awb")

						arg_805_1:RecordAudio("1108410195", var_808_11)
						arg_805_1:RecordAudio("1108410195", var_808_11)
					else
						arg_805_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410195", "story_v_side_new_1108410.awb")
					end

					arg_805_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410195", "story_v_side_new_1108410.awb")
				end

				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_12 = math.max(var_808_5, arg_805_1.talkMaxDuration)

			if var_808_4 <= arg_805_1.time_ and arg_805_1.time_ < var_808_4 + var_808_12 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - var_808_4) / var_808_12

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= var_808_4 + var_808_12 and arg_805_1.time_ < var_808_4 + var_808_12 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {
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

		arg_805_1:InitPlayNodeList()
	end,
	Play1108410196 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 1108410196
		arg_809_1.duration_ = 5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play1108410197(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			if 0 < arg_809_1.time_ and arg_809_1.time_ <= 0 + arg_812_0 then
				arg_809_1.var_.moveOldPos10102ui_story = arg_809_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_812_0 = 0.001

			if 0 <= arg_809_1.time_ and arg_809_1.time_ < 0 + var_812_0 then
				arg_809_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_809_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_809_1.time_ - 0) / var_812_0)
				arg_809_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_809_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_809_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_809_1.actors_["10102ui_story"].transform.position).z)
				arg_809_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_809_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_809_1.actors_["10102ui_story"].transform.localEulerAngles = arg_809_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_809_1.time_ >= 0 + var_812_0 and arg_809_1.time_ < 0 + var_812_0 + arg_812_0 then
				arg_809_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_809_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_809_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_809_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_809_1.actors_["10102ui_story"].transform.position).z)
				arg_809_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_809_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_809_1.actors_["10102ui_story"].transform.localEulerAngles = arg_809_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_812_1 = arg_809_1.actors_["1047ui_story"].transform

			if 0 < arg_809_1.time_ and arg_809_1.time_ <= 0 + arg_812_0 then
				arg_809_1.var_.moveOldPos1047ui_story = var_812_1.localPosition
			end

			local var_812_2 = 0.001

			if 0 <= arg_809_1.time_ and arg_809_1.time_ < 0 + var_812_2 then
				var_812_1.localPosition = Vector3.Lerp(arg_809_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_809_1.time_ - 0) / var_812_2)
				var_812_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_812_1.position).x, (manager.ui.mainCamera.transform.position - var_812_1.position).y, (manager.ui.mainCamera.transform.position - var_812_1.position).z)
				var_812_1.localEulerAngles.z = 0
				var_812_1.localEulerAngles.x = 0
				var_812_1.localEulerAngles = var_812_1.localEulerAngles
			end

			if arg_809_1.time_ >= 0 + var_812_2 and arg_809_1.time_ < 0 + var_812_2 + arg_812_0 then
				var_812_1.localPosition = Vector3.New(0, 100, 0)
				var_812_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_812_1.position).x, (manager.ui.mainCamera.transform.position - var_812_1.position).y, (manager.ui.mainCamera.transform.position - var_812_1.position).z)
				var_812_1.localEulerAngles.z = 0
				var_812_1.localEulerAngles.x = 0
				var_812_1.localEulerAngles = var_812_1.localEulerAngles
			end

			local var_812_3 = arg_809_1.actors_["10102ui_story"]

			if 0 < arg_809_1.time_ and arg_809_1.time_ <= 0 + arg_812_0 and not isNil(var_812_3) and arg_809_1.var_.characterEffect10102ui_story == nil then
				arg_809_1.var_.characterEffect10102ui_story = var_812_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_812_4 = 0.200000002980232

			if 0 <= arg_809_1.time_ and arg_809_1.time_ < 0 + var_812_4 and not isNil(var_812_3) then
				if arg_809_1.var_.characterEffect10102ui_story and not isNil(var_812_3) then
					arg_809_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_809_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_809_1.time_ - 0) / var_812_4)
				end
			end

			if arg_809_1.time_ >= 0 + var_812_4 and arg_809_1.time_ < 0 + var_812_4 + arg_812_0 and not isNil(var_812_3) and arg_809_1.var_.characterEffect10102ui_story then
				arg_809_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_809_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_812_5 = 0
			local var_812_6 = 0.675

			if 0 < arg_809_1.time_ and arg_809_1.time_ <= var_812_5 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, false)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_809_1.iconTrs_.gameObject, false)
				arg_809_1.callingController_:SetSelectedState("normal")

				local var_812_7 = arg_809_1:FormatText(arg_809_1:GetWordFromCfg(1108410196).content)

				arg_809_1.text_.text = var_812_7

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_9 = 27 <= 0 and var_812_6 or var_812_6 * (utf8.len(var_812_7) / 27)

				if (27 <= 0 and var_812_6 or var_812_6 * (utf8.len(var_812_7) / 27)) > 0 and var_812_6 < var_812_9 then
					arg_809_1.talkMaxDuration = var_812_9

					if var_812_9 + var_812_5 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_9 + var_812_5
					end
				end

				arg_809_1.text_.text = var_812_7
				arg_809_1.typewritter.percent = 0

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(false)
				arg_809_1:RecordContent(arg_809_1.text_.text)
			end

			local var_812_10 = math.max(var_812_6, arg_809_1.talkMaxDuration)

			if var_812_5 <= arg_809_1.time_ and arg_809_1.time_ < var_812_5 + var_812_10 then
				arg_809_1.typewritter.percent = (arg_809_1.time_ - var_812_5) / var_812_10

				arg_809_1.typewritter:SetDirty()
			end

			if arg_809_1.time_ >= var_812_5 + var_812_10 and arg_809_1.time_ < var_812_5 + var_812_10 + arg_812_0 then
				arg_809_1.typewritter.percent = 1

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(true)
			end
		end

		arg_809_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_809_1:InitPlayNodeList()
	end,
	Play1108410197 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 1108410197
		arg_813_1.duration_ = 5

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play1108410198(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			local var_816_0 = 0.125

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, true)

				arg_813_1.leftNameTxt_.text = arg_813_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_813_1.leftNameTxt_.transform)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1.leftNameTxt_.text)
				SetActive(arg_813_1.iconTrs_.gameObject, true)
				arg_813_1.iconController_:SetSelectedState("hero")

				arg_813_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_813_1.callingController_:SetSelectedState("normal")

				arg_813_1.keyicon_.color = Color.New(1, 1, 1)
				arg_813_1.icon_.color = Color.New(1, 1, 1)

				local var_816_1 = arg_813_1:FormatText(arg_813_1:GetWordFromCfg(1108410197).content)

				arg_813_1.text_.text = var_816_1

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_3 = 5 <= 0 and var_816_0 or var_816_0 * (utf8.len(var_816_1) / 5)

				if (5 <= 0 and var_816_0 or var_816_0 * (utf8.len(var_816_1) / 5)) > 0 and var_816_0 < var_816_3 then
					arg_813_1.talkMaxDuration = var_816_3

					if var_816_3 + 0 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_3 + 0
					end
				end

				arg_813_1.text_.text = var_816_1
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)
				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_4 = math.max(var_816_0, arg_813_1.talkMaxDuration)

			if 0 <= arg_813_1.time_ and arg_813_1.time_ < 0 + var_816_4 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - 0) / var_816_4

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= 0 + var_816_4 and arg_813_1.time_ < 0 + var_816_4 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {}

		arg_813_1:InitPlayNodeList()
	end,
	Play1108410198 = function(arg_817_0, arg_817_1)
		arg_817_1.time_ = 0
		arg_817_1.frameCnt_ = 0
		arg_817_1.state_ = "playing"
		arg_817_1.curTalkId_ = 1108410198
		arg_817_1.duration_ = 4.6

		SetActive(arg_817_1.tipsGo_, false)

		function arg_817_1.onSingleLineFinish_()
			arg_817_1.onSingleLineUpdate_ = nil
			arg_817_1.onSingleLineFinish_ = nil
			arg_817_1.state_ = "waiting"
		end

		function arg_817_1.playNext_(arg_819_0)
			if arg_819_0 == 1 then
				arg_817_0:Play1108410199(arg_817_1)
			end
		end

		function arg_817_1.onSingleLineUpdate_(arg_820_0)
			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 then
				arg_817_1.var_.moveOldPos10102ui_story = arg_817_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_820_0 = 0.001

			if 0 <= arg_817_1.time_ and arg_817_1.time_ < 0 + var_820_0 then
				arg_817_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_817_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_817_1.time_ - 0) / var_820_0)
				arg_817_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_817_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_817_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_817_1.actors_["10102ui_story"].transform.position).z)
				arg_817_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_817_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_817_1.actors_["10102ui_story"].transform.localEulerAngles = arg_817_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_817_1.time_ >= 0 + var_820_0 and arg_817_1.time_ < 0 + var_820_0 + arg_820_0 then
				arg_817_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_817_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_817_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_817_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_817_1.actors_["10102ui_story"].transform.position).z)
				arg_817_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_817_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_817_1.actors_["10102ui_story"].transform.localEulerAngles = arg_817_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_820_1 = arg_817_1.actors_["10102ui_story"]

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 and not isNil(var_820_1) and arg_817_1.var_.characterEffect10102ui_story == nil then
				arg_817_1.var_.characterEffect10102ui_story = var_820_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_820_2 = 0.200000002980232

			if 0 <= arg_817_1.time_ and arg_817_1.time_ < 0 + var_820_2 and not isNil(var_820_1) then
				if arg_817_1.var_.characterEffect10102ui_story and not isNil(var_820_1) then
					arg_817_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_817_1.time_ >= 0 + var_820_2 and arg_817_1.time_ < 0 + var_820_2 + arg_820_0 and not isNil(var_820_1) and arg_817_1.var_.characterEffect10102ui_story then
				arg_817_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 then
				arg_817_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 then
				arg_817_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_820_4 = 0
			local var_820_5 = 0.4

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= var_820_4 + arg_820_0 then
				arg_817_1.talkMaxDuration = 0
				arg_817_1.dialogCg_.alpha = 1

				arg_817_1.dialog_:SetActive(true)
				SetActive(arg_817_1.leftNameGo_, true)

				arg_817_1.leftNameTxt_.text = arg_817_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_817_1.leftNameTxt_.transform)

				arg_817_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_817_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_817_1:RecordName(arg_817_1.leftNameTxt_.text)
				SetActive(arg_817_1.iconTrs_.gameObject, false)
				arg_817_1.callingController_:SetSelectedState("normal")

				local var_820_6 = arg_817_1:GetWordFromCfg(1108410198)
				local var_820_7 = arg_817_1:FormatText(var_820_6.content)

				arg_817_1.text_.text = var_820_7

				LuaForUtil.ClearLinePrefixSymbol(arg_817_1.text_)

				local var_820_9 = 16 <= 0 and var_820_5 or var_820_5 * (utf8.len(var_820_7) / 16)

				if (16 <= 0 and var_820_5 or var_820_5 * (utf8.len(var_820_7) / 16)) > 0 and var_820_5 < var_820_9 then
					arg_817_1.talkMaxDuration = var_820_9

					if var_820_9 + var_820_4 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_9 + var_820_4
					end
				end

				arg_817_1.text_.text = var_820_7
				arg_817_1.typewritter.percent = 0

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410198", "story_v_side_new_1108410.awb") ~= 0 then
					local var_820_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410198", "story_v_side_new_1108410.awb") / 1000

					if var_820_10 + var_820_4 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_10 + var_820_4
					end

					if var_820_6.prefab_name ~= "" and arg_817_1.actors_[var_820_6.prefab_name] ~= nil then
						local var_820_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_817_1.actors_[var_820_6.prefab_name].transform, "story_v_side_new_1108410", "1108410198", "story_v_side_new_1108410.awb")

						arg_817_1:RecordAudio("1108410198", var_820_11)
						arg_817_1:RecordAudio("1108410198", var_820_11)
					else
						arg_817_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410198", "story_v_side_new_1108410.awb")
					end

					arg_817_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410198", "story_v_side_new_1108410.awb")
				end

				arg_817_1:RecordContent(arg_817_1.text_.text)
			end

			local var_820_12 = math.max(var_820_5, arg_817_1.talkMaxDuration)

			if var_820_4 <= arg_817_1.time_ and arg_817_1.time_ < var_820_4 + var_820_12 then
				arg_817_1.typewritter.percent = (arg_817_1.time_ - var_820_4) / var_820_12

				arg_817_1.typewritter:SetDirty()
			end

			if arg_817_1.time_ >= var_820_4 + var_820_12 and arg_817_1.time_ < var_820_4 + var_820_12 + arg_820_0 then
				arg_817_1.typewritter.percent = 1

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(true)
			end
		end

		arg_817_1.nodeConfigList_ = {
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

		arg_817_1:InitPlayNodeList()
	end,
	Play1108410199 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 1108410199
		arg_821_1.duration_ = 5

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play1108410200(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			if 0 < arg_821_1.time_ and arg_821_1.time_ <= 0 + arg_824_0 then
				arg_821_1.var_.moveOldPos10102ui_story = arg_821_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_824_0 = 0.001

			if 0 <= arg_821_1.time_ and arg_821_1.time_ < 0 + var_824_0 then
				arg_821_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_821_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_821_1.time_ - 0) / var_824_0)
				arg_821_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_821_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_821_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_821_1.actors_["10102ui_story"].transform.position).z)
				arg_821_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_821_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_821_1.actors_["10102ui_story"].transform.localEulerAngles = arg_821_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_821_1.time_ >= 0 + var_824_0 and arg_821_1.time_ < 0 + var_824_0 + arg_824_0 then
				arg_821_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_821_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_821_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_821_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_821_1.actors_["10102ui_story"].transform.position).z)
				arg_821_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_821_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_821_1.actors_["10102ui_story"].transform.localEulerAngles = arg_821_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_824_1 = arg_821_1.actors_["10102ui_story"]

			if 0 < arg_821_1.time_ and arg_821_1.time_ <= 0 + arg_824_0 and not isNil(var_824_1) and arg_821_1.var_.characterEffect10102ui_story == nil then
				arg_821_1.var_.characterEffect10102ui_story = var_824_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_824_2 = 0.200000002980232

			if 0 <= arg_821_1.time_ and arg_821_1.time_ < 0 + var_824_2 and not isNil(var_824_1) then
				if arg_821_1.var_.characterEffect10102ui_story and not isNil(var_824_1) then
					arg_821_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_821_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_821_1.time_ - 0) / var_824_2)
				end
			end

			if arg_821_1.time_ >= 0 + var_824_2 and arg_821_1.time_ < 0 + var_824_2 + arg_824_0 and not isNil(var_824_1) and arg_821_1.var_.characterEffect10102ui_story then
				arg_821_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_821_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_824_3 = 0
			local var_824_4 = 1.375

			if 0 < arg_821_1.time_ and arg_821_1.time_ <= var_824_3 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0
				arg_821_1.dialogCg_.alpha = 1

				arg_821_1.dialog_:SetActive(true)
				SetActive(arg_821_1.leftNameGo_, false)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_821_1.iconTrs_.gameObject, false)
				arg_821_1.callingController_:SetSelectedState("normal")

				local var_824_5 = arg_821_1:FormatText(arg_821_1:GetWordFromCfg(1108410199).content)

				arg_821_1.text_.text = var_824_5

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_7 = 55 <= 0 and var_824_4 or var_824_4 * (utf8.len(var_824_5) / 55)

				if (55 <= 0 and var_824_4 or var_824_4 * (utf8.len(var_824_5) / 55)) > 0 and var_824_4 < var_824_7 then
					arg_821_1.talkMaxDuration = var_824_7

					if var_824_7 + var_824_3 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_7 + var_824_3
					end
				end

				arg_821_1.text_.text = var_824_5
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)
				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_8 = math.max(var_824_4, arg_821_1.talkMaxDuration)

			if var_824_3 <= arg_821_1.time_ and arg_821_1.time_ < var_824_3 + var_824_8 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - var_824_3) / var_824_8

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= var_824_3 + var_824_8 and arg_821_1.time_ < var_824_3 + var_824_8 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {
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

		arg_821_1:InitPlayNodeList()
	end,
	Play1108410200 = function(arg_825_0, arg_825_1)
		arg_825_1.time_ = 0
		arg_825_1.frameCnt_ = 0
		arg_825_1.state_ = "playing"
		arg_825_1.curTalkId_ = 1108410200
		arg_825_1.duration_ = 5

		SetActive(arg_825_1.tipsGo_, false)

		function arg_825_1.onSingleLineFinish_()
			arg_825_1.onSingleLineUpdate_ = nil
			arg_825_1.onSingleLineFinish_ = nil
			arg_825_1.state_ = "waiting"
		end

		function arg_825_1.playNext_(arg_827_0)
			if arg_827_0 == 1 then
				arg_825_0:Play1108410201(arg_825_1)
			end
		end

		function arg_825_1.onSingleLineUpdate_(arg_828_0)
			local var_828_0 = 0.1

			if 0 < arg_825_1.time_ and arg_825_1.time_ <= 0 + arg_828_0 then
				arg_825_1.talkMaxDuration = 0
				arg_825_1.dialogCg_.alpha = 1

				arg_825_1.dialog_:SetActive(true)
				SetActive(arg_825_1.leftNameGo_, true)

				arg_825_1.leftNameTxt_.text = arg_825_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_825_1.leftNameTxt_.transform)

				arg_825_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_825_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_825_1:RecordName(arg_825_1.leftNameTxt_.text)
				SetActive(arg_825_1.iconTrs_.gameObject, true)
				arg_825_1.iconController_:SetSelectedState("hero")

				arg_825_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_825_1.callingController_:SetSelectedState("normal")

				arg_825_1.keyicon_.color = Color.New(1, 1, 1)
				arg_825_1.icon_.color = Color.New(1, 1, 1)

				local var_828_1 = arg_825_1:FormatText(arg_825_1:GetWordFromCfg(1108410200).content)

				arg_825_1.text_.text = var_828_1

				LuaForUtil.ClearLinePrefixSymbol(arg_825_1.text_)

				local var_828_3 = 4 <= 0 and var_828_0 or var_828_0 * (utf8.len(var_828_1) / 4)

				if (4 <= 0 and var_828_0 or var_828_0 * (utf8.len(var_828_1) / 4)) > 0 and var_828_0 < var_828_3 then
					arg_825_1.talkMaxDuration = var_828_3

					if var_828_3 + 0 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_3 + 0
					end
				end

				arg_825_1.text_.text = var_828_1
				arg_825_1.typewritter.percent = 0

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(false)
				arg_825_1:RecordContent(arg_825_1.text_.text)
			end

			local var_828_4 = math.max(var_828_0, arg_825_1.talkMaxDuration)

			if 0 <= arg_825_1.time_ and arg_825_1.time_ < 0 + var_828_4 then
				arg_825_1.typewritter.percent = (arg_825_1.time_ - 0) / var_828_4

				arg_825_1.typewritter:SetDirty()
			end

			if arg_825_1.time_ >= 0 + var_828_4 and arg_825_1.time_ < 0 + var_828_4 + arg_828_0 then
				arg_825_1.typewritter.percent = 1

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(true)
			end
		end

		arg_825_1.nodeConfigList_ = {}

		arg_825_1:InitPlayNodeList()
	end,
	Play1108410201 = function(arg_829_0, arg_829_1)
		arg_829_1.time_ = 0
		arg_829_1.frameCnt_ = 0
		arg_829_1.state_ = "playing"
		arg_829_1.curTalkId_ = 1108410201
		arg_829_1.duration_ = 3.9

		SetActive(arg_829_1.tipsGo_, false)

		function arg_829_1.onSingleLineFinish_()
			arg_829_1.onSingleLineUpdate_ = nil
			arg_829_1.onSingleLineFinish_ = nil
			arg_829_1.state_ = "waiting"
		end

		function arg_829_1.playNext_(arg_831_0)
			if arg_831_0 == 1 then
				arg_829_0:Play1108410202(arg_829_1)
			end
		end

		function arg_829_1.onSingleLineUpdate_(arg_832_0)
			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 then
				arg_829_1.var_.moveOldPos10102ui_story = arg_829_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_832_0 = 0.001

			if 0 <= arg_829_1.time_ and arg_829_1.time_ < 0 + var_832_0 then
				arg_829_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_829_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_829_1.time_ - 0) / var_832_0)
				arg_829_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).z)
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles = arg_829_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_829_1.time_ >= 0 + var_832_0 and arg_829_1.time_ < 0 + var_832_0 + arg_832_0 then
				arg_829_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_829_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).z)
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles = arg_829_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_832_1 = arg_829_1.actors_["10102ui_story"]

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 and not isNil(var_832_1) and arg_829_1.var_.characterEffect10102ui_story == nil then
				arg_829_1.var_.characterEffect10102ui_story = var_832_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_832_2 = 0.200000002980232

			if 0 <= arg_829_1.time_ and arg_829_1.time_ < 0 + var_832_2 and not isNil(var_832_1) then
				if arg_829_1.var_.characterEffect10102ui_story and not isNil(var_832_1) then
					arg_829_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_829_1.time_ >= 0 + var_832_2 and arg_829_1.time_ < 0 + var_832_2 + arg_832_0 and not isNil(var_832_1) and arg_829_1.var_.characterEffect10102ui_story then
				arg_829_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 then
				arg_829_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action8_1")
			end

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 then
				arg_829_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_832_4 = 0
			local var_832_5 = 0.35

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= var_832_4 + arg_832_0 then
				arg_829_1.talkMaxDuration = 0
				arg_829_1.dialogCg_.alpha = 1

				arg_829_1.dialog_:SetActive(true)
				SetActive(arg_829_1.leftNameGo_, true)

				arg_829_1.leftNameTxt_.text = arg_829_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_829_1.leftNameTxt_.transform)

				arg_829_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_829_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_829_1:RecordName(arg_829_1.leftNameTxt_.text)
				SetActive(arg_829_1.iconTrs_.gameObject, false)
				arg_829_1.callingController_:SetSelectedState("normal")

				local var_832_6 = arg_829_1:GetWordFromCfg(1108410201)
				local var_832_7 = arg_829_1:FormatText(var_832_6.content)

				arg_829_1.text_.text = var_832_7

				LuaForUtil.ClearLinePrefixSymbol(arg_829_1.text_)

				local var_832_9 = 17 <= 0 and var_832_5 or var_832_5 * (utf8.len(var_832_7) / 17)

				if (17 <= 0 and var_832_5 or var_832_5 * (utf8.len(var_832_7) / 17)) > 0 and var_832_5 < var_832_9 then
					arg_829_1.talkMaxDuration = var_832_9

					if var_832_9 + var_832_4 > arg_829_1.duration_ then
						arg_829_1.duration_ = var_832_9 + var_832_4
					end
				end

				arg_829_1.text_.text = var_832_7
				arg_829_1.typewritter.percent = 0

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410201", "story_v_side_new_1108410.awb") ~= 0 then
					local var_832_10 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410201", "story_v_side_new_1108410.awb") / 1000

					if var_832_10 + var_832_4 > arg_829_1.duration_ then
						arg_829_1.duration_ = var_832_10 + var_832_4
					end

					if var_832_6.prefab_name ~= "" and arg_829_1.actors_[var_832_6.prefab_name] ~= nil then
						local var_832_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_829_1.actors_[var_832_6.prefab_name].transform, "story_v_side_new_1108410", "1108410201", "story_v_side_new_1108410.awb")

						arg_829_1:RecordAudio("1108410201", var_832_11)
						arg_829_1:RecordAudio("1108410201", var_832_11)
					else
						arg_829_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410201", "story_v_side_new_1108410.awb")
					end

					arg_829_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410201", "story_v_side_new_1108410.awb")
				end

				arg_829_1:RecordContent(arg_829_1.text_.text)
			end

			local var_832_12 = math.max(var_832_5, arg_829_1.talkMaxDuration)

			if var_832_4 <= arg_829_1.time_ and arg_829_1.time_ < var_832_4 + var_832_12 then
				arg_829_1.typewritter.percent = (arg_829_1.time_ - var_832_4) / var_832_12

				arg_829_1.typewritter:SetDirty()
			end

			if arg_829_1.time_ >= var_832_4 + var_832_12 and arg_829_1.time_ < var_832_4 + var_832_12 + arg_832_0 then
				arg_829_1.typewritter.percent = 1

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(true)
			end
		end

		arg_829_1.nodeConfigList_ = {
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

		arg_829_1:InitPlayNodeList()
	end,
	Play1108410202 = function(arg_833_0, arg_833_1)
		arg_833_1.time_ = 0
		arg_833_1.frameCnt_ = 0
		arg_833_1.state_ = "playing"
		arg_833_1.curTalkId_ = 1108410202
		arg_833_1.duration_ = 8.97

		SetActive(arg_833_1.tipsGo_, false)

		function arg_833_1.onSingleLineFinish_()
			arg_833_1.onSingleLineUpdate_ = nil
			arg_833_1.onSingleLineFinish_ = nil
			arg_833_1.state_ = "waiting"
		end

		function arg_833_1.playNext_(arg_835_0)
			if arg_835_0 == 1 then
				arg_833_0:Play1108410203(arg_833_1)
			end
		end

		function arg_833_1.onSingleLineUpdate_(arg_836_0)
			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 then
				arg_833_1.var_.moveOldPos1047ui_story = arg_833_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_836_0 = 0.001

			if 0 <= arg_833_1.time_ and arg_833_1.time_ < 0 + var_836_0 then
				arg_833_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_833_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_833_1.time_ - 0) / var_836_0)
				arg_833_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_833_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1047ui_story"].transform.position).z)
				arg_833_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_833_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_833_1.actors_["1047ui_story"].transform.localEulerAngles = arg_833_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_833_1.time_ >= 0 + var_836_0 and arg_833_1.time_ < 0 + var_836_0 + arg_836_0 then
				arg_833_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_833_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_833_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_833_1.actors_["1047ui_story"].transform.position).z)
				arg_833_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_833_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_833_1.actors_["1047ui_story"].transform.localEulerAngles = arg_833_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_836_1 = arg_833_1.actors_["1047ui_story"]

			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 and not isNil(var_836_1) and arg_833_1.var_.characterEffect1047ui_story == nil then
				arg_833_1.var_.characterEffect1047ui_story = var_836_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_836_2 = 0.200000002980232

			if 0 <= arg_833_1.time_ and arg_833_1.time_ < 0 + var_836_2 and not isNil(var_836_1) then
				if arg_833_1.var_.characterEffect1047ui_story and not isNil(var_836_1) then
					arg_833_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_833_1.time_ >= 0 + var_836_2 and arg_833_1.time_ < 0 + var_836_2 + arg_836_0 and not isNil(var_836_1) and arg_833_1.var_.characterEffect1047ui_story then
				arg_833_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_836_4 = arg_833_1.actors_["10102ui_story"]

			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 and not isNil(var_836_4) and arg_833_1.var_.characterEffect10102ui_story == nil then
				arg_833_1.var_.characterEffect10102ui_story = var_836_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_836_5 = 0.200000002980232

			if 0 <= arg_833_1.time_ and arg_833_1.time_ < 0 + var_836_5 and not isNil(var_836_4) then
				if arg_833_1.var_.characterEffect10102ui_story and not isNil(var_836_4) then
					arg_833_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_833_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_833_1.time_ - 0) / var_836_5)
				end
			end

			if arg_833_1.time_ >= 0 + var_836_5 and arg_833_1.time_ < 0 + var_836_5 + arg_836_0 and not isNil(var_836_4) and arg_833_1.var_.characterEffect10102ui_story then
				arg_833_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_833_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 then
				arg_833_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_833_1.time_ and arg_833_1.time_ <= 0 + arg_836_0 then
				arg_833_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_836_6 = 0
			local var_836_7 = 0.975

			if 0 < arg_833_1.time_ and arg_833_1.time_ <= var_836_6 + arg_836_0 then
				arg_833_1.talkMaxDuration = 0
				arg_833_1.dialogCg_.alpha = 1

				arg_833_1.dialog_:SetActive(true)
				SetActive(arg_833_1.leftNameGo_, true)

				arg_833_1.leftNameTxt_.text = arg_833_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_833_1.leftNameTxt_.transform)

				arg_833_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_833_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_833_1:RecordName(arg_833_1.leftNameTxt_.text)
				SetActive(arg_833_1.iconTrs_.gameObject, false)
				arg_833_1.callingController_:SetSelectedState("normal")

				local var_836_8 = arg_833_1:GetWordFromCfg(1108410202)
				local var_836_9 = arg_833_1:FormatText(var_836_8.content)

				arg_833_1.text_.text = var_836_9

				LuaForUtil.ClearLinePrefixSymbol(arg_833_1.text_)

				local var_836_11 = 39 <= 0 and var_836_7 or var_836_7 * (utf8.len(var_836_9) / 39)

				if (39 <= 0 and var_836_7 or var_836_7 * (utf8.len(var_836_9) / 39)) > 0 and var_836_7 < var_836_11 then
					arg_833_1.talkMaxDuration = var_836_11

					if var_836_11 + var_836_6 > arg_833_1.duration_ then
						arg_833_1.duration_ = var_836_11 + var_836_6
					end
				end

				arg_833_1.text_.text = var_836_9
				arg_833_1.typewritter.percent = 0

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410202", "story_v_side_new_1108410.awb") ~= 0 then
					local var_836_12 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410202", "story_v_side_new_1108410.awb") / 1000

					if var_836_12 + var_836_6 > arg_833_1.duration_ then
						arg_833_1.duration_ = var_836_12 + var_836_6
					end

					if var_836_8.prefab_name ~= "" and arg_833_1.actors_[var_836_8.prefab_name] ~= nil then
						local var_836_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_833_1.actors_[var_836_8.prefab_name].transform, "story_v_side_new_1108410", "1108410202", "story_v_side_new_1108410.awb")

						arg_833_1:RecordAudio("1108410202", var_836_13)
						arg_833_1:RecordAudio("1108410202", var_836_13)
					else
						arg_833_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410202", "story_v_side_new_1108410.awb")
					end

					arg_833_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410202", "story_v_side_new_1108410.awb")
				end

				arg_833_1:RecordContent(arg_833_1.text_.text)
			end

			local var_836_14 = math.max(var_836_7, arg_833_1.talkMaxDuration)

			if var_836_6 <= arg_833_1.time_ and arg_833_1.time_ < var_836_6 + var_836_14 then
				arg_833_1.typewritter.percent = (arg_833_1.time_ - var_836_6) / var_836_14

				arg_833_1.typewritter:SetDirty()
			end

			if arg_833_1.time_ >= var_836_6 + var_836_14 and arg_833_1.time_ < var_836_6 + var_836_14 + arg_836_0 then
				arg_833_1.typewritter.percent = 1

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(true)
			end
		end

		arg_833_1.nodeConfigList_ = {
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

		arg_833_1:InitPlayNodeList()
	end,
	Play1108410203 = function(arg_837_0, arg_837_1)
		arg_837_1.time_ = 0
		arg_837_1.frameCnt_ = 0
		arg_837_1.state_ = "playing"
		arg_837_1.curTalkId_ = 1108410203
		arg_837_1.duration_ = 6.93

		SetActive(arg_837_1.tipsGo_, false)

		function arg_837_1.onSingleLineFinish_()
			arg_837_1.onSingleLineUpdate_ = nil
			arg_837_1.onSingleLineFinish_ = nil
			arg_837_1.state_ = "waiting"
		end

		function arg_837_1.playNext_(arg_839_0)
			if arg_839_0 == 1 then
				arg_837_0:Play1108410204(arg_837_1)
			end
		end

		function arg_837_1.onSingleLineUpdate_(arg_840_0)
			if 0 < arg_837_1.time_ and arg_837_1.time_ <= 0 + arg_840_0 then
				arg_837_1.var_.moveOldPos10102ui_story = arg_837_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_840_0 = 0.001

			if 0 <= arg_837_1.time_ and arg_837_1.time_ < 0 + var_840_0 then
				arg_837_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_837_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_837_1.time_ - 0) / var_840_0)
				arg_837_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_837_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_837_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_837_1.actors_["10102ui_story"].transform.position).z)
				arg_837_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_837_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_837_1.actors_["10102ui_story"].transform.localEulerAngles = arg_837_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_837_1.time_ >= 0 + var_840_0 and arg_837_1.time_ < 0 + var_840_0 + arg_840_0 then
				arg_837_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_837_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_837_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_837_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_837_1.actors_["10102ui_story"].transform.position).z)
				arg_837_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_837_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_837_1.actors_["10102ui_story"].transform.localEulerAngles = arg_837_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_840_1 = arg_837_1.actors_["10102ui_story"]

			if 0 < arg_837_1.time_ and arg_837_1.time_ <= 0 + arg_840_0 and not isNil(var_840_1) and arg_837_1.var_.characterEffect10102ui_story == nil then
				arg_837_1.var_.characterEffect10102ui_story = var_840_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_840_2 = 0.200000002980232

			if 0 <= arg_837_1.time_ and arg_837_1.time_ < 0 + var_840_2 and not isNil(var_840_1) then
				if arg_837_1.var_.characterEffect10102ui_story and not isNil(var_840_1) then
					arg_837_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_837_1.time_ >= 0 + var_840_2 and arg_837_1.time_ < 0 + var_840_2 + arg_840_0 and not isNil(var_840_1) and arg_837_1.var_.characterEffect10102ui_story then
				arg_837_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_840_4 = arg_837_1.actors_["1047ui_story"]

			if 0 < arg_837_1.time_ and arg_837_1.time_ <= 0 + arg_840_0 and not isNil(var_840_4) and arg_837_1.var_.characterEffect1047ui_story == nil then
				arg_837_1.var_.characterEffect1047ui_story = var_840_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_840_5 = 0.200000002980232

			if 0 <= arg_837_1.time_ and arg_837_1.time_ < 0 + var_840_5 and not isNil(var_840_4) then
				if arg_837_1.var_.characterEffect1047ui_story and not isNil(var_840_4) then
					arg_837_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_837_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_837_1.time_ - 0) / var_840_5)
				end
			end

			if arg_837_1.time_ >= 0 + var_840_5 and arg_837_1.time_ < 0 + var_840_5 + arg_840_0 and not isNil(var_840_4) and arg_837_1.var_.characterEffect1047ui_story then
				arg_837_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_837_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_837_1.time_ and arg_837_1.time_ <= 0 + arg_840_0 then
				arg_837_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action489")
			end

			if 0 < arg_837_1.time_ and arg_837_1.time_ <= 0 + arg_840_0 then
				arg_837_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_840_6 = 0
			local var_840_7 = 0.575

			if 0 < arg_837_1.time_ and arg_837_1.time_ <= var_840_6 + arg_840_0 then
				arg_837_1.talkMaxDuration = 0
				arg_837_1.dialogCg_.alpha = 1

				arg_837_1.dialog_:SetActive(true)
				SetActive(arg_837_1.leftNameGo_, true)

				arg_837_1.leftNameTxt_.text = arg_837_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_837_1.leftNameTxt_.transform)

				arg_837_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_837_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_837_1:RecordName(arg_837_1.leftNameTxt_.text)
				SetActive(arg_837_1.iconTrs_.gameObject, false)
				arg_837_1.callingController_:SetSelectedState("normal")

				local var_840_8 = arg_837_1:GetWordFromCfg(1108410203)
				local var_840_9 = arg_837_1:FormatText(var_840_8.content)

				arg_837_1.text_.text = var_840_9

				LuaForUtil.ClearLinePrefixSymbol(arg_837_1.text_)

				local var_840_11 = 23 <= 0 and var_840_7 or var_840_7 * (utf8.len(var_840_9) / 23)

				if (23 <= 0 and var_840_7 or var_840_7 * (utf8.len(var_840_9) / 23)) > 0 and var_840_7 < var_840_11 then
					arg_837_1.talkMaxDuration = var_840_11

					if var_840_11 + var_840_6 > arg_837_1.duration_ then
						arg_837_1.duration_ = var_840_11 + var_840_6
					end
				end

				arg_837_1.text_.text = var_840_9
				arg_837_1.typewritter.percent = 0

				arg_837_1.typewritter:SetDirty()
				arg_837_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410203", "story_v_side_new_1108410.awb") ~= 0 then
					local var_840_12 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410203", "story_v_side_new_1108410.awb") / 1000

					if var_840_12 + var_840_6 > arg_837_1.duration_ then
						arg_837_1.duration_ = var_840_12 + var_840_6
					end

					if var_840_8.prefab_name ~= "" and arg_837_1.actors_[var_840_8.prefab_name] ~= nil then
						local var_840_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_837_1.actors_[var_840_8.prefab_name].transform, "story_v_side_new_1108410", "1108410203", "story_v_side_new_1108410.awb")

						arg_837_1:RecordAudio("1108410203", var_840_13)
						arg_837_1:RecordAudio("1108410203", var_840_13)
					else
						arg_837_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410203", "story_v_side_new_1108410.awb")
					end

					arg_837_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410203", "story_v_side_new_1108410.awb")
				end

				arg_837_1:RecordContent(arg_837_1.text_.text)
			end

			local var_840_14 = math.max(var_840_7, arg_837_1.talkMaxDuration)

			if var_840_6 <= arg_837_1.time_ and arg_837_1.time_ < var_840_6 + var_840_14 then
				arg_837_1.typewritter.percent = (arg_837_1.time_ - var_840_6) / var_840_14

				arg_837_1.typewritter:SetDirty()
			end

			if arg_837_1.time_ >= var_840_6 + var_840_14 and arg_837_1.time_ < var_840_6 + var_840_14 + arg_840_0 then
				arg_837_1.typewritter.percent = 1

				arg_837_1.typewritter:SetDirty()
				arg_837_1:ShowNextGo(true)
			end
		end

		arg_837_1.nodeConfigList_ = {
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

		arg_837_1:InitPlayNodeList()
	end,
	Play1108410204 = function(arg_841_0, arg_841_1)
		arg_841_1.time_ = 0
		arg_841_1.frameCnt_ = 0
		arg_841_1.state_ = "playing"
		arg_841_1.curTalkId_ = 1108410204
		arg_841_1.duration_ = 4.5

		SetActive(arg_841_1.tipsGo_, false)

		function arg_841_1.onSingleLineFinish_()
			arg_841_1.onSingleLineUpdate_ = nil
			arg_841_1.onSingleLineFinish_ = nil
			arg_841_1.state_ = "waiting"
		end

		function arg_841_1.playNext_(arg_843_0)
			if arg_843_0 == 1 then
				arg_841_0:Play1108410205(arg_841_1)
			end
		end

		function arg_841_1.onSingleLineUpdate_(arg_844_0)
			if 0 < arg_841_1.time_ and arg_841_1.time_ <= 0 + arg_844_0 then
				arg_841_1.var_.moveOldPos1047ui_story = arg_841_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_844_0 = 0.001

			if 0 <= arg_841_1.time_ and arg_841_1.time_ < 0 + var_844_0 then
				arg_841_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_841_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_841_1.time_ - 0) / var_844_0)
				arg_841_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_841_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_841_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_841_1.actors_["1047ui_story"].transform.position).z)
				arg_841_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_841_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_841_1.actors_["1047ui_story"].transform.localEulerAngles = arg_841_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_841_1.time_ >= 0 + var_844_0 and arg_841_1.time_ < 0 + var_844_0 + arg_844_0 then
				arg_841_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_841_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_841_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_841_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_841_1.actors_["1047ui_story"].transform.position).z)
				arg_841_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_841_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_841_1.actors_["1047ui_story"].transform.localEulerAngles = arg_841_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_844_1 = arg_841_1.actors_["1047ui_story"]

			if 0 < arg_841_1.time_ and arg_841_1.time_ <= 0 + arg_844_0 and not isNil(var_844_1) and arg_841_1.var_.characterEffect1047ui_story == nil then
				arg_841_1.var_.characterEffect1047ui_story = var_844_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_844_2 = 0.200000002980232

			if 0 <= arg_841_1.time_ and arg_841_1.time_ < 0 + var_844_2 and not isNil(var_844_1) then
				if arg_841_1.var_.characterEffect1047ui_story and not isNil(var_844_1) then
					arg_841_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_841_1.time_ >= 0 + var_844_2 and arg_841_1.time_ < 0 + var_844_2 + arg_844_0 and not isNil(var_844_1) and arg_841_1.var_.characterEffect1047ui_story then
				arg_841_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_844_4 = arg_841_1.actors_["10102ui_story"]

			if 0 < arg_841_1.time_ and arg_841_1.time_ <= 0 + arg_844_0 and not isNil(var_844_4) and arg_841_1.var_.characterEffect10102ui_story == nil then
				arg_841_1.var_.characterEffect10102ui_story = var_844_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_844_5 = 0.200000002980232

			if 0 <= arg_841_1.time_ and arg_841_1.time_ < 0 + var_844_5 and not isNil(var_844_4) then
				if arg_841_1.var_.characterEffect10102ui_story and not isNil(var_844_4) then
					arg_841_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_841_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_841_1.time_ - 0) / var_844_5)
				end
			end

			if arg_841_1.time_ >= 0 + var_844_5 and arg_841_1.time_ < 0 + var_844_5 + arg_844_0 and not isNil(var_844_4) and arg_841_1.var_.characterEffect10102ui_story then
				arg_841_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_841_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_841_1.time_ and arg_841_1.time_ <= 0 + arg_844_0 then
				arg_841_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			if 0 < arg_841_1.time_ and arg_841_1.time_ <= 0 + arg_844_0 then
				arg_841_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_844_6 = 0
			local var_844_7 = 0.425

			if 0 < arg_841_1.time_ and arg_841_1.time_ <= var_844_6 + arg_844_0 then
				arg_841_1.talkMaxDuration = 0
				arg_841_1.dialogCg_.alpha = 1

				arg_841_1.dialog_:SetActive(true)
				SetActive(arg_841_1.leftNameGo_, true)

				arg_841_1.leftNameTxt_.text = arg_841_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_841_1.leftNameTxt_.transform)

				arg_841_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_841_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_841_1:RecordName(arg_841_1.leftNameTxt_.text)
				SetActive(arg_841_1.iconTrs_.gameObject, false)
				arg_841_1.callingController_:SetSelectedState("normal")

				local var_844_8 = arg_841_1:GetWordFromCfg(1108410204)
				local var_844_9 = arg_841_1:FormatText(var_844_8.content)

				arg_841_1.text_.text = var_844_9

				LuaForUtil.ClearLinePrefixSymbol(arg_841_1.text_)

				local var_844_11 = 17 <= 0 and var_844_7 or var_844_7 * (utf8.len(var_844_9) / 17)

				if (17 <= 0 and var_844_7 or var_844_7 * (utf8.len(var_844_9) / 17)) > 0 and var_844_7 < var_844_11 then
					arg_841_1.talkMaxDuration = var_844_11

					if var_844_11 + var_844_6 > arg_841_1.duration_ then
						arg_841_1.duration_ = var_844_11 + var_844_6
					end
				end

				arg_841_1.text_.text = var_844_9
				arg_841_1.typewritter.percent = 0

				arg_841_1.typewritter:SetDirty()
				arg_841_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410204", "story_v_side_new_1108410.awb") ~= 0 then
					local var_844_12 = manager.audio:GetVoiceLength("story_v_side_new_1108410", "1108410204", "story_v_side_new_1108410.awb") / 1000

					if var_844_12 + var_844_6 > arg_841_1.duration_ then
						arg_841_1.duration_ = var_844_12 + var_844_6
					end

					if var_844_8.prefab_name ~= "" and arg_841_1.actors_[var_844_8.prefab_name] ~= nil then
						local var_844_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_841_1.actors_[var_844_8.prefab_name].transform, "story_v_side_new_1108410", "1108410204", "story_v_side_new_1108410.awb")

						arg_841_1:RecordAudio("1108410204", var_844_13)
						arg_841_1:RecordAudio("1108410204", var_844_13)
					else
						arg_841_1:AudioAction("play", "voice", "story_v_side_new_1108410", "1108410204", "story_v_side_new_1108410.awb")
					end

					arg_841_1:RecordHistoryTalkVoice("story_v_side_new_1108410", "1108410204", "story_v_side_new_1108410.awb")
				end

				arg_841_1:RecordContent(arg_841_1.text_.text)
			end

			local var_844_14 = math.max(var_844_7, arg_841_1.talkMaxDuration)

			if var_844_6 <= arg_841_1.time_ and arg_841_1.time_ < var_844_6 + var_844_14 then
				arg_841_1.typewritter.percent = (arg_841_1.time_ - var_844_6) / var_844_14

				arg_841_1.typewritter:SetDirty()
			end

			if arg_841_1.time_ >= var_844_6 + var_844_14 and arg_841_1.time_ < var_844_6 + var_844_14 + arg_844_0 then
				arg_841_1.typewritter.percent = 1

				arg_841_1.typewritter:SetDirty()
				arg_841_1:ShowNextGo(true)
			end
		end

		arg_841_1.nodeConfigList_ = {
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

		arg_841_1:InitPlayNodeList()
	end,
	Play1108410205 = function(arg_845_0, arg_845_1)
		arg_845_1.time_ = 0
		arg_845_1.frameCnt_ = 0
		arg_845_1.state_ = "playing"
		arg_845_1.curTalkId_ = 1108410205
		arg_845_1.duration_ = 5

		SetActive(arg_845_1.tipsGo_, false)

		function arg_845_1.onSingleLineFinish_()
			arg_845_1.onSingleLineUpdate_ = nil
			arg_845_1.onSingleLineFinish_ = nil
			arg_845_1.state_ = "waiting"
		end

		function arg_845_1.playNext_(arg_847_0)
			if arg_847_0 == 1 then
				arg_845_0:Play1108410206(arg_845_1)
			end
		end

		function arg_845_1.onSingleLineUpdate_(arg_848_0)
			if 0 < arg_845_1.time_ and arg_845_1.time_ <= 0 + arg_848_0 then
				arg_845_1.var_.moveOldPos1047ui_story = arg_845_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_848_0 = 0.001

			if 0 <= arg_845_1.time_ and arg_845_1.time_ < 0 + var_848_0 then
				arg_845_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_845_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_845_1.time_ - 0) / var_848_0)
				arg_845_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_845_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_845_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_845_1.actors_["1047ui_story"].transform.position).z)
				arg_845_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_845_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_845_1.actors_["1047ui_story"].transform.localEulerAngles = arg_845_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_845_1.time_ >= 0 + var_848_0 and arg_845_1.time_ < 0 + var_848_0 + arg_848_0 then
				arg_845_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_845_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_845_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_845_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_845_1.actors_["1047ui_story"].transform.position).z)
				arg_845_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_845_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_845_1.actors_["1047ui_story"].transform.localEulerAngles = arg_845_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_848_1 = arg_845_1.actors_["10102ui_story"].transform

			if 0 < arg_845_1.time_ and arg_845_1.time_ <= 0 + arg_848_0 then
				arg_845_1.var_.moveOldPos10102ui_story = var_848_1.localPosition
			end

			local var_848_2 = 0.001

			if 0 <= arg_845_1.time_ and arg_845_1.time_ < 0 + var_848_2 then
				var_848_1.localPosition = Vector3.Lerp(arg_845_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_845_1.time_ - 0) / var_848_2)
				var_848_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_848_1.position).x, (manager.ui.mainCamera.transform.position - var_848_1.position).y, (manager.ui.mainCamera.transform.position - var_848_1.position).z)
				var_848_1.localEulerAngles.z = 0
				var_848_1.localEulerAngles.x = 0
				var_848_1.localEulerAngles = var_848_1.localEulerAngles
			end

			if arg_845_1.time_ >= 0 + var_848_2 and arg_845_1.time_ < 0 + var_848_2 + arg_848_0 then
				var_848_1.localPosition = Vector3.New(0, 100, 0)
				var_848_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_848_1.position).x, (manager.ui.mainCamera.transform.position - var_848_1.position).y, (manager.ui.mainCamera.transform.position - var_848_1.position).z)
				var_848_1.localEulerAngles.z = 0
				var_848_1.localEulerAngles.x = 0
				var_848_1.localEulerAngles = var_848_1.localEulerAngles
			end

			local var_848_3 = arg_845_1.actors_["1047ui_story"]

			if 0 < arg_845_1.time_ and arg_845_1.time_ <= 0 + arg_848_0 and not isNil(var_848_3) and arg_845_1.var_.characterEffect1047ui_story == nil then
				arg_845_1.var_.characterEffect1047ui_story = var_848_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_848_4 = 0.200000002980232

			if 0 <= arg_845_1.time_ and arg_845_1.time_ < 0 + var_848_4 and not isNil(var_848_3) then
				if arg_845_1.var_.characterEffect1047ui_story and not isNil(var_848_3) then
					arg_845_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_845_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_845_1.time_ - 0) / var_848_4)
				end
			end

			if arg_845_1.time_ >= 0 + var_848_4 and arg_845_1.time_ < 0 + var_848_4 + arg_848_0 and not isNil(var_848_3) and arg_845_1.var_.characterEffect1047ui_story then
				arg_845_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_845_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_848_5 = 0
			local var_848_6 = 1.275

			if 0 < arg_845_1.time_ and arg_845_1.time_ <= var_848_5 + arg_848_0 then
				arg_845_1.talkMaxDuration = 0
				arg_845_1.dialogCg_.alpha = 1

				arg_845_1.dialog_:SetActive(true)
				SetActive(arg_845_1.leftNameGo_, false)

				arg_845_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_845_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_845_1:RecordName(arg_845_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_845_1.iconTrs_.gameObject, false)
				arg_845_1.callingController_:SetSelectedState("normal")

				local var_848_7 = arg_845_1:FormatText(arg_845_1:GetWordFromCfg(1108410205).content)

				arg_845_1.text_.text = var_848_7

				LuaForUtil.ClearLinePrefixSymbol(arg_845_1.text_)

				local var_848_9 = 51 <= 0 and var_848_6 or var_848_6 * (utf8.len(var_848_7) / 51)

				if (51 <= 0 and var_848_6 or var_848_6 * (utf8.len(var_848_7) / 51)) > 0 and var_848_6 < var_848_9 then
					arg_845_1.talkMaxDuration = var_848_9

					if var_848_9 + var_848_5 > arg_845_1.duration_ then
						arg_845_1.duration_ = var_848_9 + var_848_5
					end
				end

				arg_845_1.text_.text = var_848_7
				arg_845_1.typewritter.percent = 0

				arg_845_1.typewritter:SetDirty()
				arg_845_1:ShowNextGo(false)
				arg_845_1:RecordContent(arg_845_1.text_.text)
			end

			local var_848_10 = math.max(var_848_6, arg_845_1.talkMaxDuration)

			if var_848_5 <= arg_845_1.time_ and arg_845_1.time_ < var_848_5 + var_848_10 then
				arg_845_1.typewritter.percent = (arg_845_1.time_ - var_848_5) / var_848_10

				arg_845_1.typewritter:SetDirty()
			end

			if arg_845_1.time_ >= var_848_5 + var_848_10 and arg_845_1.time_ < var_848_5 + var_848_10 + arg_848_0 then
				arg_845_1.typewritter.percent = 1

				arg_845_1.typewritter:SetDirty()
				arg_845_1:ShowNextGo(true)
			end
		end

		arg_845_1.nodeConfigList_ = {
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_845_1:InitPlayNodeList()
	end,
	Play1108410206 = function(arg_849_0, arg_849_1)
		arg_849_1.time_ = 0
		arg_849_1.frameCnt_ = 0
		arg_849_1.state_ = "playing"
		arg_849_1.curTalkId_ = 1108410206
		arg_849_1.duration_ = 5

		SetActive(arg_849_1.tipsGo_, false)

		function arg_849_1.onSingleLineFinish_()
			arg_849_1.onSingleLineUpdate_ = nil
			arg_849_1.onSingleLineFinish_ = nil
			arg_849_1.state_ = "waiting"
		end

		function arg_849_1.playNext_(arg_851_0)
			if arg_851_0 == 1 then
				arg_849_0:Play1108410207(arg_849_1)
			end
		end

		function arg_849_1.onSingleLineUpdate_(arg_852_0)
			local var_852_0 = 0.625

			if 0 < arg_849_1.time_ and arg_849_1.time_ <= 0 + arg_852_0 then
				arg_849_1.talkMaxDuration = 0
				arg_849_1.dialogCg_.alpha = 1

				arg_849_1.dialog_:SetActive(true)
				SetActive(arg_849_1.leftNameGo_, true)

				arg_849_1.leftNameTxt_.text = arg_849_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_849_1.leftNameTxt_.transform)

				arg_849_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_849_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_849_1:RecordName(arg_849_1.leftNameTxt_.text)
				SetActive(arg_849_1.iconTrs_.gameObject, true)
				arg_849_1.iconController_:SetSelectedState("hero")

				arg_849_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_849_1.callingController_:SetSelectedState("normal")

				arg_849_1.keyicon_.color = Color.New(1, 1, 1)
				arg_849_1.icon_.color = Color.New(1, 1, 1)

				local var_852_1 = arg_849_1:FormatText(arg_849_1:GetWordFromCfg(1108410206).content)

				arg_849_1.text_.text = var_852_1

				LuaForUtil.ClearLinePrefixSymbol(arg_849_1.text_)

				local var_852_3 = 25 <= 0 and var_852_0 or var_852_0 * (utf8.len(var_852_1) / 25)

				if (25 <= 0 and var_852_0 or var_852_0 * (utf8.len(var_852_1) / 25)) > 0 and var_852_0 < var_852_3 then
					arg_849_1.talkMaxDuration = var_852_3

					if var_852_3 + 0 > arg_849_1.duration_ then
						arg_849_1.duration_ = var_852_3 + 0
					end
				end

				arg_849_1.text_.text = var_852_1
				arg_849_1.typewritter.percent = 0

				arg_849_1.typewritter:SetDirty()
				arg_849_1:ShowNextGo(false)
				arg_849_1:RecordContent(arg_849_1.text_.text)
			end

			local var_852_4 = math.max(var_852_0, arg_849_1.talkMaxDuration)

			if 0 <= arg_849_1.time_ and arg_849_1.time_ < 0 + var_852_4 then
				arg_849_1.typewritter.percent = (arg_849_1.time_ - 0) / var_852_4

				arg_849_1.typewritter:SetDirty()
			end

			if arg_849_1.time_ >= 0 + var_852_4 and arg_849_1.time_ < 0 + var_852_4 + arg_852_0 then
				arg_849_1.typewritter.percent = 1

				arg_849_1.typewritter:SetDirty()
				arg_849_1:ShowNextGo(true)
			end
		end

		arg_849_1.nodeConfigList_ = {}

		arg_849_1:InitPlayNodeList()
	end,
	Play1108410207 = function(arg_853_0, arg_853_1)
		arg_853_1.time_ = 0
		arg_853_1.frameCnt_ = 0
		arg_853_1.state_ = "playing"
		arg_853_1.curTalkId_ = 1108410207
		arg_853_1.duration_ = 5

		SetActive(arg_853_1.tipsGo_, false)

		function arg_853_1.onSingleLineFinish_()
			arg_853_1.onSingleLineUpdate_ = nil
			arg_853_1.onSingleLineFinish_ = nil
			arg_853_1.state_ = "waiting"
		end

		function arg_853_1.playNext_(arg_855_0)
			if arg_855_0 == 1 then
				arg_853_0:Play1108410208(arg_853_1)
			end
		end

		function arg_853_1.onSingleLineUpdate_(arg_856_0)
			local var_856_0 = 0.725

			if 0 < arg_853_1.time_ and arg_853_1.time_ <= 0 + arg_856_0 then
				arg_853_1.talkMaxDuration = 0
				arg_853_1.dialogCg_.alpha = 1

				arg_853_1.dialog_:SetActive(true)
				SetActive(arg_853_1.leftNameGo_, false)

				arg_853_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_853_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_853_1:RecordName(arg_853_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_853_1.iconTrs_.gameObject, false)
				arg_853_1.callingController_:SetSelectedState("normal")

				local var_856_1 = arg_853_1:FormatText(arg_853_1:GetWordFromCfg(1108410207).content)

				arg_853_1.text_.text = var_856_1

				LuaForUtil.ClearLinePrefixSymbol(arg_853_1.text_)

				local var_856_3 = 29 <= 0 and var_856_0 or var_856_0 * (utf8.len(var_856_1) / 29)

				if (29 <= 0 and var_856_0 or var_856_0 * (utf8.len(var_856_1) / 29)) > 0 and var_856_0 < var_856_3 then
					arg_853_1.talkMaxDuration = var_856_3

					if var_856_3 + 0 > arg_853_1.duration_ then
						arg_853_1.duration_ = var_856_3 + 0
					end
				end

				arg_853_1.text_.text = var_856_1
				arg_853_1.typewritter.percent = 0

				arg_853_1.typewritter:SetDirty()
				arg_853_1:ShowNextGo(false)
				arg_853_1:RecordContent(arg_853_1.text_.text)
			end

			local var_856_4 = math.max(var_856_0, arg_853_1.talkMaxDuration)

			if 0 <= arg_853_1.time_ and arg_853_1.time_ < 0 + var_856_4 then
				arg_853_1.typewritter.percent = (arg_853_1.time_ - 0) / var_856_4

				arg_853_1.typewritter:SetDirty()
			end

			if arg_853_1.time_ >= 0 + var_856_4 and arg_853_1.time_ < 0 + var_856_4 + arg_856_0 then
				arg_853_1.typewritter.percent = 1

				arg_853_1.typewritter:SetDirty()
				arg_853_1:ShowNextGo(true)
			end
		end

		arg_853_1.nodeConfigList_ = {}

		arg_853_1:InitPlayNodeList()
	end,
	Play1108410208 = function(arg_857_0, arg_857_1)
		arg_857_1.time_ = 0
		arg_857_1.frameCnt_ = 0
		arg_857_1.state_ = "playing"
		arg_857_1.curTalkId_ = 1108410208
		arg_857_1.duration_ = 5

		SetActive(arg_857_1.tipsGo_, false)

		function arg_857_1.onSingleLineFinish_()
			arg_857_1.onSingleLineUpdate_ = nil
			arg_857_1.onSingleLineFinish_ = nil
			arg_857_1.state_ = "waiting"
			arg_857_1.auto_ = false
		end

		function arg_857_1.playNext_(arg_859_0)
			arg_857_1.onStoryFinished_()
		end

		function arg_857_1.onSingleLineUpdate_(arg_860_0)
			if 0 < arg_857_1.time_ and arg_857_1.time_ <= 0 + arg_860_0 then
				arg_857_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_860_1 = 0
			local var_860_2 = 0.55

			if 0 < arg_857_1.time_ and arg_857_1.time_ <= var_860_1 + arg_860_0 then
				arg_857_1.talkMaxDuration = 0
				arg_857_1.dialogCg_.alpha = 1

				arg_857_1.dialog_:SetActive(true)
				SetActive(arg_857_1.leftNameGo_, false)

				arg_857_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_857_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_857_1:RecordName(arg_857_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_857_1.iconTrs_.gameObject, false)
				arg_857_1.callingController_:SetSelectedState("normal")

				local var_860_3 = arg_857_1:FormatText(arg_857_1:GetWordFromCfg(1108410208).content)

				arg_857_1.text_.text = var_860_3

				LuaForUtil.ClearLinePrefixSymbol(arg_857_1.text_)

				local var_860_5 = 22 <= 0 and var_860_2 or var_860_2 * (utf8.len(var_860_3) / 22)

				if (22 <= 0 and var_860_2 or var_860_2 * (utf8.len(var_860_3) / 22)) > 0 and var_860_2 < var_860_5 then
					arg_857_1.talkMaxDuration = var_860_5

					if var_860_5 + var_860_1 > arg_857_1.duration_ then
						arg_857_1.duration_ = var_860_5 + var_860_1
					end
				end

				arg_857_1.text_.text = var_860_3
				arg_857_1.typewritter.percent = 0

				arg_857_1.typewritter:SetDirty()
				arg_857_1:ShowNextGo(false)
				arg_857_1:RecordContent(arg_857_1.text_.text)
			end

			local var_860_6 = math.max(var_860_2, arg_857_1.talkMaxDuration)

			if var_860_1 <= arg_857_1.time_ and arg_857_1.time_ < var_860_1 + var_860_6 then
				arg_857_1.typewritter.percent = (arg_857_1.time_ - var_860_1) / var_860_6

				arg_857_1.typewritter:SetDirty()
			end

			if arg_857_1.time_ >= var_860_1 + var_860_6 and arg_857_1.time_ < var_860_1 + var_860_6 + arg_860_0 then
				arg_857_1.typewritter.percent = 1

				arg_857_1.typewritter:SetDirty()
				arg_857_1:ShowNextGo(true)
			end
		end

		arg_857_1.nodeConfigList_ = {}

		arg_857_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/F02a_1",
		"TextureConfig/Background/ST03a",
		"TextureConfig/Background/R8406",
		"TextureConfig/Background/R8406a",
		"TextureConfig/Background/ST2105a",
		"TextureConfig/Background/ST0116a",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_side_new_1108410.awb"
	}
}
