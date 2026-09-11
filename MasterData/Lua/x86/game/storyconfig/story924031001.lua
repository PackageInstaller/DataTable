return {
	Play924031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 924031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play924031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H07j == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07j")
				var_4_0.name = "H07j"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H07j = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H07j

				arg_1_1.bgs_.H07j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H07j" then
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

			if 0.125 < arg_1_1.time_ and arg_1_1.time_ <= 0.125 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_dream", "")
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
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

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(924031001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 11 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 11)

				if (11 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 11)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play924031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 924031002
		arg_8_1.duration_ = 7.83

		local var_8_0 = {
			zh = 6.766,
			ja = 7.833
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
				arg_8_0:Play924031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["102003ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102003ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "102003ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "102003ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["102003ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["102003ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["102003ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["102003ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["102003ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos102003ui_story = var_11_3.localPosition
			end

			local var_11_4 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_8_1.time_ - 0) / var_11_4)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0, -0.85, -6.21)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			local var_11_5 = arg_8_1.actors_["102003ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect102003ui_story == nil then
				arg_8_1.var_.characterEffect102003ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect102003ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect102003ui_story then
				arg_8_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_11_8 = 0
			local var_11_9 = 0.575

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(924031002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 23 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 23)

				if (23 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 23)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031002", "story_v_side_old_924031.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031002", "story_v_side_old_924031.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_side_old_924031", "924031002", "story_v_side_old_924031.awb")

						arg_8_1:RecordAudio("924031002", var_11_15)
						arg_8_1:RecordAudio("924031002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031002", "story_v_side_old_924031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031002", "story_v_side_old_924031.awb")
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
				actorName = "102003ui_story",
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
	Play924031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 924031003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play924031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["102003ui_story"]) and arg_12_1.var_.characterEffect102003ui_story == nil then
				arg_12_1.var_.characterEffect102003ui_story = arg_12_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["102003ui_story"]) then
				if arg_12_1.var_.characterEffect102003ui_story and not isNil(arg_12_1.actors_["102003ui_story"]) then
					arg_12_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_12_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["102003ui_story"]) and arg_12_1.var_.characterEffect102003ui_story then
				arg_12_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_12_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.35

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

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(924031003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 14 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 14)

				if (14 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 14)) > 0 and var_15_2 < var_15_5 then
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
	Play924031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 924031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play924031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos102003ui_story = arg_16_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["102003ui_story"].transform.position).z)
				arg_16_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["102003ui_story"].transform.localEulerAngles = arg_16_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["102003ui_story"].transform.position).z)
				arg_16_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["102003ui_story"].transform.localEulerAngles = arg_16_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_19_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_3 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_3

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_3
						arg_16_1.bgmTxt2_.text = var_19_3
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_16_1.time_ and arg_16_1.time_ <= 0.4 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_19_6 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_6 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_6

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_6
						arg_16_1.bgmTxt2_.text = var_19_6
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.125 < arg_16_1.time_ and arg_16_1.time_ <= 0.125 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_141", "se_story_141_clap02", "")
			end

			if 0.4 < arg_16_1.time_ and arg_16_1.time_ <= 0.4 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_141", "se_story_141_action_bgm_jivitabad_slum", "")
			end

			local var_19_9 = 0
			local var_19_10 = 1.35

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_11 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(924031004).content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 54 <= 0 and var_19_10 or var_19_10 * (utf8.len(var_19_11) / 54)

				if (54 <= 0 and var_19_10 or var_19_10 * (utf8.len(var_19_11) / 54)) > 0 and var_19_10 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_9 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_9
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_10, arg_16_1.talkMaxDuration)

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_9) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_9 + var_19_14 and arg_16_1.time_ < var_19_9 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 924031005
		arg_22_1.duration_ = 2.17

		local var_22_0 = {
			zh = 1.999999999999,
			ja = 2.166
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play924031006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos102003ui_story = arg_22_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_25_0 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 then
				arg_22_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_22_1.time_ - 0) / var_25_0)
				arg_22_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_22_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["102003ui_story"].transform.position).z)
				arg_22_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_22_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_22_1.actors_["102003ui_story"].transform.localEulerAngles = arg_22_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 then
				arg_22_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_22_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_22_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["102003ui_story"].transform.position).z)
				arg_22_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_22_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_22_1.actors_["102003ui_story"].transform.localEulerAngles = arg_22_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_25_1 = arg_22_1.actors_["102003ui_story"]

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(var_25_1) and arg_22_1.var_.characterEffect102003ui_story == nil then
				arg_22_1.var_.characterEffect102003ui_story = var_25_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.200000002980232

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_2 and not isNil(var_25_1) then
				if arg_22_1.var_.characterEffect102003ui_story and not isNil(var_25_1) then
					arg_22_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= 0 + var_25_2 and arg_22_1.time_ < 0 + var_25_2 + arg_25_0 and not isNil(var_25_1) and arg_22_1.var_.characterEffect102003ui_story then
				arg_22_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_2")
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_25_4 = 0
			local var_25_5 = 0.2

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_6 = arg_22_1:GetWordFromCfg(924031005)
				local var_25_7 = arg_22_1:FormatText(var_25_6.content)

				arg_22_1.text_.text = var_25_7

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_9 = 8 <= 0 and var_25_5 or var_25_5 * (utf8.len(var_25_7) / 8)

				if (8 <= 0 and var_25_5 or var_25_5 * (utf8.len(var_25_7) / 8)) > 0 and var_25_5 < var_25_9 then
					arg_22_1.talkMaxDuration = var_25_9

					if var_25_9 + var_25_4 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_9 + var_25_4
					end
				end

				arg_22_1.text_.text = var_25_7
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031005", "story_v_side_old_924031.awb") ~= 0 then
					local var_25_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031005", "story_v_side_old_924031.awb") / 1000

					if var_25_10 + var_25_4 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_10 + var_25_4
					end

					if var_25_6.prefab_name ~= "" and arg_22_1.actors_[var_25_6.prefab_name] ~= nil then
						local var_25_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_6.prefab_name].transform, "story_v_side_old_924031", "924031005", "story_v_side_old_924031.awb")

						arg_22_1:RecordAudio("924031005", var_25_11)
						arg_22_1:RecordAudio("924031005", var_25_11)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031005", "story_v_side_old_924031.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031005", "story_v_side_old_924031.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_12 = math.max(var_25_5, arg_22_1.talkMaxDuration)

			if var_25_4 <= arg_22_1.time_ and arg_22_1.time_ < var_25_4 + var_25_12 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_4) / var_25_12

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_4 + var_25_12 and arg_22_1.time_ < var_25_4 + var_25_12 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play924031006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 924031006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play924031007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["102003ui_story"]) and arg_26_1.var_.characterEffect102003ui_story == nil then
				arg_26_1.var_.characterEffect102003ui_story = arg_26_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_0 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["102003ui_story"]) then
				if arg_26_1.var_.characterEffect102003ui_story and not isNil(arg_26_1.actors_["102003ui_story"]) then
					arg_26_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_26_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_26_1.time_ - 0) / var_29_0)
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["102003ui_story"]) and arg_26_1.var_.characterEffect102003ui_story then
				arg_26_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_26_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_29_1 = 0
			local var_29_2 = 0.675

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_3 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(924031006).content)

				arg_26_1.text_.text = var_29_3

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 27 <= 0 and var_29_2 or var_29_2 * (utf8.len(var_29_3) / 27)

				if (27 <= 0 and var_29_2 or var_29_2 * (utf8.len(var_29_3) / 27)) > 0 and var_29_2 < var_29_5 then
					arg_26_1.talkMaxDuration = var_29_5

					if var_29_5 + var_29_1 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + var_29_1
					end
				end

				arg_26_1.text_.text = var_29_3
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_6 = math.max(var_29_2, arg_26_1.talkMaxDuration)

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_6 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_1) / var_29_6

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_1 + var_29_6 and arg_26_1.time_ < var_29_1 + var_29_6 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play924031007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 924031007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play924031008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.725

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(924031007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 29 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 29)

				if (29 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 29)) > 0 and var_33_0 < var_33_3 then
					arg_30_1.talkMaxDuration = var_33_3

					if var_33_3 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_3 + 0
					end
				end

				arg_30_1.text_.text = var_33_1
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_4 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_4

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play924031008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 924031008
		arg_34_1.duration_ = 6.07

		local var_34_0 = {
			zh = 3.833,
			ja = 6.066
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play924031009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos102003ui_story = arg_34_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_37_0 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 then
				arg_34_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_34_1.time_ - 0) / var_37_0)
				arg_34_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["102003ui_story"].transform.position).z)
				arg_34_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["102003ui_story"].transform.localEulerAngles = arg_34_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 then
				arg_34_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_34_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["102003ui_story"].transform.position).z)
				arg_34_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["102003ui_story"].transform.localEulerAngles = arg_34_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_37_1 = arg_34_1.actors_["102003ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_1) and arg_34_1.var_.characterEffect102003ui_story == nil then
				arg_34_1.var_.characterEffect102003ui_story = var_37_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_2 and not isNil(var_37_1) then
				if arg_34_1.var_.characterEffect102003ui_story and not isNil(var_37_1) then
					arg_34_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_2 and arg_34_1.time_ < 0 + var_37_2 + arg_37_0 and not isNil(var_37_1) and arg_34_1.var_.characterEffect102003ui_story then
				arg_34_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action4_1")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_37_4 = 0
			local var_37_5 = 0.525

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_6 = arg_34_1:GetWordFromCfg(924031008)
				local var_37_7 = arg_34_1:FormatText(var_37_6.content)

				arg_34_1.text_.text = var_37_7

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_9 = 21 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 21)

				if (21 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 21)) > 0 and var_37_5 < var_37_9 then
					arg_34_1.talkMaxDuration = var_37_9

					if var_37_9 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_4
					end
				end

				arg_34_1.text_.text = var_37_7
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031008", "story_v_side_old_924031.awb") ~= 0 then
					local var_37_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031008", "story_v_side_old_924031.awb") / 1000

					if var_37_10 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_4
					end

					if var_37_6.prefab_name ~= "" and arg_34_1.actors_[var_37_6.prefab_name] ~= nil then
						local var_37_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_6.prefab_name].transform, "story_v_side_old_924031", "924031008", "story_v_side_old_924031.awb")

						arg_34_1:RecordAudio("924031008", var_37_11)
						arg_34_1:RecordAudio("924031008", var_37_11)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031008", "story_v_side_old_924031.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031008", "story_v_side_old_924031.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_12 = math.max(var_37_5, arg_34_1.talkMaxDuration)

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_12 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_4) / var_37_12

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_4 + var_37_12 and arg_34_1.time_ < var_37_4 + var_37_12 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play924031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 924031009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play924031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos102003ui_story = arg_38_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_41_0 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 then
				arg_38_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_38_1.time_ - 0) / var_41_0)
				arg_38_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["102003ui_story"].transform.position).z)
				arg_38_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["102003ui_story"].transform.localEulerAngles = arg_38_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 then
				arg_38_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["102003ui_story"].transform.position).z)
				arg_38_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["102003ui_story"].transform.localEulerAngles = arg_38_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_41_1 = arg_38_1.actors_["102003ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect102003ui_story == nil then
				arg_38_1.var_.characterEffect102003ui_story = var_41_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_2 and not isNil(var_41_1) then
				if arg_38_1.var_.characterEffect102003ui_story and not isNil(var_41_1) then
					arg_38_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_38_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_2)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_2 and arg_38_1.time_ < 0 + var_41_2 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect102003ui_story then
				arg_38_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_38_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_41_3 = 0
			local var_41_4 = 0.975

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_5 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(924031009).content)

				arg_38_1.text_.text = var_41_5

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_7 = 39 <= 0 and var_41_4 or var_41_4 * (utf8.len(var_41_5) / 39)

				if (39 <= 0 and var_41_4 or var_41_4 * (utf8.len(var_41_5) / 39)) > 0 and var_41_4 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_3 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_3
					end
				end

				arg_38_1.text_.text = var_41_5
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_8 = math.max(var_41_4, arg_38_1.talkMaxDuration)

			if var_41_3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_3 + var_41_8 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_3) / var_41_8

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_3 + var_41_8 and arg_38_1.time_ < var_41_3 + var_41_8 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 924031010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play924031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.675

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(924031010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 27 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 27)

				if (27 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 27)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play924031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 924031011
		arg_46_1.duration_ = 8.9

		local var_46_0 = {
			zh = 6.366,
			ja = 8.9
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
				arg_46_0:Play924031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos102003ui_story = arg_46_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_49_0 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 then
				arg_46_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_46_1.time_ - 0) / var_49_0)
				arg_46_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["102003ui_story"].transform.position).z)
				arg_46_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["102003ui_story"].transform.localEulerAngles = arg_46_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 then
				arg_46_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_46_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["102003ui_story"].transform.position).z)
				arg_46_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["102003ui_story"].transform.localEulerAngles = arg_46_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_49_1 = arg_46_1.actors_["102003ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_1) and arg_46_1.var_.characterEffect102003ui_story == nil then
				arg_46_1.var_.characterEffect102003ui_story = var_49_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_2 and not isNil(var_49_1) then
				if arg_46_1.var_.characterEffect102003ui_story and not isNil(var_49_1) then
					arg_46_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_2 and arg_46_1.time_ < 0 + var_49_2 + arg_49_0 and not isNil(var_49_1) and arg_46_1.var_.characterEffect102003ui_story then
				arg_46_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action4412")
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			if 0.034000001847744 < arg_46_1.time_ and arg_46_1.time_ <= 0.034000001847744 + arg_49_0 then
				arg_46_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_49_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_46_1.bgmTxt_.text ~= var_49_6 and arg_46_1.bgmTxt_.text ~= "" then
						if arg_46_1.bgmTxt2_.text ~= "" then
							arg_46_1.bgmTxt_.text = arg_46_1.bgmTxt2_.text
						end

						arg_46_1.bgmTxt2_.text = var_49_6

						arg_46_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_46_1.bgmTxt_.text = var_49_6
						arg_46_1.bgmTxt2_.text = var_49_6
					end

					if arg_46_1.bgmTimer then
						arg_46_1.bgmTimer:Stop()

						arg_46_1.bgmTimer = nil
					end

					if arg_46_1.settingData.show_music_name == 1 then
						arg_46_1.musicController:SetSelectedState("show")
						arg_46_1.musicAnimator_:Play("open", 0, 0)

						if arg_46_1.settingData.music_time ~= 0 then
							arg_46_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_46_1.settingData.music_time), function()
								if arg_46_1 == nil or isNil(arg_46_1.bgmTxt_) then
									return
								end

								arg_46_1.musicController:SetSelectedState("hide")
								arg_46_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_49_7 = 0
			local var_49_8 = 0.575

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_7 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_9 = arg_46_1:GetWordFromCfg(924031011)
				local var_49_10 = arg_46_1:FormatText(var_49_9.content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_12 = 23 <= 0 and var_49_8 or var_49_8 * (utf8.len(var_49_10) / 23)

				if (23 <= 0 and var_49_8 or var_49_8 * (utf8.len(var_49_10) / 23)) > 0 and var_49_8 < var_49_12 then
					arg_46_1.talkMaxDuration = var_49_12

					if var_49_12 + var_49_7 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_7
					end
				end

				arg_46_1.text_.text = var_49_10
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031011", "story_v_side_old_924031.awb") ~= 0 then
					local var_49_13 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031011", "story_v_side_old_924031.awb") / 1000

					if var_49_13 + var_49_7 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_7
					end

					if var_49_9.prefab_name ~= "" and arg_46_1.actors_[var_49_9.prefab_name] ~= nil then
						local var_49_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_9.prefab_name].transform, "story_v_side_old_924031", "924031011", "story_v_side_old_924031.awb")

						arg_46_1:RecordAudio("924031011", var_49_14)
						arg_46_1:RecordAudio("924031011", var_49_14)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031011", "story_v_side_old_924031.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031011", "story_v_side_old_924031.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_15 = math.max(var_49_8, arg_46_1.talkMaxDuration)

			if var_49_7 <= arg_46_1.time_ and arg_46_1.time_ < var_49_7 + var_49_15 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_7) / var_49_15

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_7 + var_49_15 and arg_46_1.time_ < var_49_7 + var_49_15 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play924031012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 924031012
		arg_51_1.duration_ = 1

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"

			SetActive(arg_51_1.choicesGo_, true)

			for iter_52_0, iter_52_1 in ipairs(arg_51_1.choices_) do
				SetActive(iter_52_1.go, iter_52_0 <= 1)
			end

			arg_51_1.choices_[1].txt.text = arg_51_1:FormatText(StoryChoiceCfg[1203].name)
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play924031013(arg_51_1)
			end

			arg_51_1:RecordChoiceLog(924031012, 1203)
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["102003ui_story"]) and arg_51_1.var_.characterEffect102003ui_story == nil then
				arg_51_1.var_.characterEffect102003ui_story = arg_51_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["102003ui_story"]) then
				if arg_51_1.var_.characterEffect102003ui_story and not isNil(arg_51_1.actors_["102003ui_story"]) then
					arg_51_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_51_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["102003ui_story"]) and arg_51_1.var_.characterEffect102003ui_story then
				arg_51_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_51_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.allBtn_.enabled = false
			end

			if arg_51_1.time_ >= var_54_1 + 0.6 and arg_51_1.time_ < var_54_1 + 0.6 + arg_54_0 then
				arg_51_1.allBtn_.enabled = true
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play924031013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 924031013
		arg_55_1.duration_ = 5.5

		local var_55_0 = {
			zh = 3,
			ja = 5.5
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
				arg_55_0:Play924031014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos102003ui_story = arg_55_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["102003ui_story"].transform.position).z)
				arg_55_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["102003ui_story"].transform.localEulerAngles = arg_55_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_55_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["102003ui_story"].transform.position).z)
				arg_55_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["102003ui_story"].transform.localEulerAngles = arg_55_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["102003ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect102003ui_story == nil then
				arg_55_1.var_.characterEffect102003ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect102003ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect102003ui_story then
				arg_55_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action4128")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_58_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_55_1.bgmTxt_.text ~= var_58_6 and arg_55_1.bgmTxt_.text ~= "" then
						if arg_55_1.bgmTxt2_.text ~= "" then
							arg_55_1.bgmTxt_.text = arg_55_1.bgmTxt2_.text
						end

						arg_55_1.bgmTxt2_.text = var_58_6

						arg_55_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_55_1.bgmTxt_.text = var_58_6
						arg_55_1.bgmTxt2_.text = var_58_6
					end

					if arg_55_1.bgmTimer then
						arg_55_1.bgmTimer:Stop()

						arg_55_1.bgmTimer = nil
					end

					if arg_55_1.settingData.show_music_name == 1 then
						arg_55_1.musicController:SetSelectedState("show")
						arg_55_1.musicAnimator_:Play("open", 0, 0)

						if arg_55_1.settingData.music_time ~= 0 then
							arg_55_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_55_1.settingData.music_time), function()
								if arg_55_1 == nil or isNil(arg_55_1.bgmTxt_) then
									return
								end

								arg_55_1.musicController:SetSelectedState("hide")
								arg_55_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_55_1.time_ and arg_55_1.time_ <= 0.4 + arg_58_0 then
				arg_55_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_58_9 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_55_1.bgmTxt_.text ~= var_58_9 and arg_55_1.bgmTxt_.text ~= "" then
						if arg_55_1.bgmTxt2_.text ~= "" then
							arg_55_1.bgmTxt_.text = arg_55_1.bgmTxt2_.text
						end

						arg_55_1.bgmTxt2_.text = var_58_9

						arg_55_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_55_1.bgmTxt_.text = var_58_9
						arg_55_1.bgmTxt2_.text = var_58_9
					end

					if arg_55_1.bgmTimer then
						arg_55_1.bgmTimer:Stop()

						arg_55_1.bgmTimer = nil
					end

					if arg_55_1.settingData.show_music_name == 1 then
						arg_55_1.musicController:SetSelectedState("show")
						arg_55_1.musicAnimator_:Play("open", 0, 0)

						if arg_55_1.settingData.music_time ~= 0 then
							arg_55_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_55_1.settingData.music_time), function()
								if arg_55_1 == nil or isNil(arg_55_1.bgmTxt_) then
									return
								end

								arg_55_1.musicController:SetSelectedState("hide")
								arg_55_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_58_10 = 0
			local var_58_11 = 0.425

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_12 = arg_55_1:GetWordFromCfg(924031013)
				local var_58_13 = arg_55_1:FormatText(var_58_12.content)

				arg_55_1.text_.text = var_58_13

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_15 = 17 <= 0 and var_58_11 or var_58_11 * (utf8.len(var_58_13) / 17)

				if (17 <= 0 and var_58_11 or var_58_11 * (utf8.len(var_58_13) / 17)) > 0 and var_58_11 < var_58_15 then
					arg_55_1.talkMaxDuration = var_58_15

					if var_58_15 + var_58_10 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_15 + var_58_10
					end
				end

				arg_55_1.text_.text = var_58_13
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031013", "story_v_side_old_924031.awb") ~= 0 then
					local var_58_16 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031013", "story_v_side_old_924031.awb") / 1000

					if var_58_16 + var_58_10 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_16 + var_58_10
					end

					if var_58_12.prefab_name ~= "" and arg_55_1.actors_[var_58_12.prefab_name] ~= nil then
						local var_58_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_12.prefab_name].transform, "story_v_side_old_924031", "924031013", "story_v_side_old_924031.awb")

						arg_55_1:RecordAudio("924031013", var_58_17)
						arg_55_1:RecordAudio("924031013", var_58_17)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031013", "story_v_side_old_924031.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031013", "story_v_side_old_924031.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_18 = math.max(var_58_11, arg_55_1.talkMaxDuration)

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_18 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_10) / var_58_18

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_10 + var_58_18 and arg_55_1.time_ < var_58_10 + var_58_18 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 924031014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play924031015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["102003ui_story"]) and arg_61_1.var_.characterEffect102003ui_story == nil then
				arg_61_1.var_.characterEffect102003ui_story = arg_61_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["102003ui_story"]) then
				if arg_61_1.var_.characterEffect102003ui_story and not isNil(arg_61_1.actors_["102003ui_story"]) then
					arg_61_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_61_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["102003ui_story"]) and arg_61_1.var_.characterEffect102003ui_story then
				arg_61_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_61_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.525

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(924031014).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 25 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 25)

				if (25 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 25)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play924031015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 924031015
		arg_65_1.duration_ = 6.33

		local var_65_0 = {
			zh = 5.333,
			ja = 6.333
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
				arg_65_0:Play924031016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos102003ui_story = arg_65_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).z)
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles = arg_65_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_65_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).z)
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles = arg_65_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["102003ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect102003ui_story == nil then
				arg_65_1.var_.characterEffect102003ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect102003ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect102003ui_story then
				arg_65_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action483")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_68_4 = 0
			local var_68_5 = 0.425

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(924031015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 17 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 17)

				if (17 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 17)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031015", "story_v_side_old_924031.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031015", "story_v_side_old_924031.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_side_old_924031", "924031015", "story_v_side_old_924031.awb")

						arg_65_1:RecordAudio("924031015", var_68_11)
						arg_65_1:RecordAudio("924031015", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031015", "story_v_side_old_924031.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031015", "story_v_side_old_924031.awb")
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
				actorName = "102003ui_story",
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
	Play924031016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 924031016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play924031017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["102003ui_story"]) and arg_69_1.var_.characterEffect102003ui_story == nil then
				arg_69_1.var_.characterEffect102003ui_story = arg_69_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["102003ui_story"]) then
				if arg_69_1.var_.characterEffect102003ui_story and not isNil(arg_69_1.actors_["102003ui_story"]) then
					arg_69_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_69_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["102003ui_story"]) and arg_69_1.var_.characterEffect102003ui_story then
				arg_69_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_69_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.75

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(924031016).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 30 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 30)

				if (30 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 30)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play924031017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 924031017
		arg_73_1.duration_ = 5.83

		local var_73_0 = {
			zh = 4.1,
			ja = 5.833
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
				arg_73_0:Play924031018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["102003ui_story"]) and arg_73_1.var_.characterEffect102003ui_story == nil then
				arg_73_1.var_.characterEffect102003ui_story = arg_73_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["102003ui_story"]) then
				if arg_73_1.var_.characterEffect102003ui_story and not isNil(arg_73_1.actors_["102003ui_story"]) then
					arg_73_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["102003ui_story"]) and arg_73_1.var_.characterEffect102003ui_story then
				arg_73_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_76_2 = 0
			local var_76_3 = 0.375

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(924031017)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 15 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 15)

				if (15 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 15)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031017", "story_v_side_old_924031.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031017", "story_v_side_old_924031.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_side_old_924031", "924031017", "story_v_side_old_924031.awb")

						arg_73_1:RecordAudio("924031017", var_76_9)
						arg_73_1:RecordAudio("924031017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031017", "story_v_side_old_924031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031017", "story_v_side_old_924031.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play924031018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 924031018
		arg_77_1.duration_ = 6.9

		local var_77_0 = {
			zh = 6.2,
			ja = 6.9
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
				arg_77_0:Play924031019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_80_0 = 0
			local var_80_1 = 0.575

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(924031018)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 23 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_3) / 23)

				if (23 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_3) / 23)) > 0 and var_80_1 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031018", "story_v_side_old_924031.awb") ~= 0 then
					local var_80_6 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031018", "story_v_side_old_924031.awb") / 1000

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end

					if var_80_2.prefab_name ~= "" and arg_77_1.actors_[var_80_2.prefab_name] ~= nil then
						local var_80_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_2.prefab_name].transform, "story_v_side_old_924031", "924031018", "story_v_side_old_924031.awb")

						arg_77_1:RecordAudio("924031018", var_80_7)
						arg_77_1:RecordAudio("924031018", var_80_7)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031018", "story_v_side_old_924031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031018", "story_v_side_old_924031.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_8 and arg_77_1.time_ < var_80_0 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play924031019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 924031019
		arg_81_1.duration_ = 6.8

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play924031020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_9000

			if 0.965999998152256 < arg_81_1.time_ and arg_81_1.time_ <= 0.965999998152256 + arg_84_0 then
				arg_81_1.var_.moveOldPos102003ui_story = arg_81_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0.965999998152256 <= arg_81_1.time_ and arg_81_1.time_ < 0.965999998152256 + var_84_0 then
				arg_81_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0.965999998152256) / var_84_0)
				arg_81_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).z)
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles = arg_81_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0.965999998152256 + var_84_0 and arg_81_1.time_ < 0.965999998152256 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).z)
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles = arg_81_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["102003ui_story"]

			if 0.965999998152256 < arg_81_1.time_ and arg_81_1.time_ <= 0.965999998152256 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect102003ui_story == nil then
				arg_81_1.var_.characterEffect102003ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.034000001847744

			if 0.965999998152256 <= arg_81_1.time_ and arg_81_1.time_ < 0.965999998152256 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect102003ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_81_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0.965999998152256) / var_84_2)
				end
			end

			if arg_81_1.time_ >= 0.965999998152256 + var_84_2 and arg_81_1.time_ < 0.965999998152256 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect102003ui_story then
				arg_81_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_81_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_84_3 = 0

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_4 = 1

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_4 then
				local var_84_5 = Color.New(1, 1, 1)

				var_84_5.a = Mathf.Lerp(0, 1, (arg_81_1.time_ - var_84_3) / var_84_4)
				arg_81_1.mask_.color = var_84_5
			end

			if arg_81_1.time_ >= var_84_3 + var_84_4 and arg_81_1.time_ < var_84_3 + var_84_4 + arg_84_0 then
				local var_84_6 = Color.New(1, 1, 1)

				var_84_6.a = 1
				arg_81_1.mask_.color = var_84_6
			end

			local var_84_7 = 1

			if 1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_8 = 1

			if var_84_7 <= arg_81_1.time_ and arg_81_1.time_ < var_84_7 + var_84_8 then
				local var_84_9 = Color.New(1, 1, 1)

				var_84_9.a = Mathf.Lerp(1, 0, (arg_81_1.time_ - var_84_7) / var_84_8)
				arg_81_1.mask_.color = var_84_9
			end

			if arg_81_1.time_ >= var_84_7 + var_84_8 and arg_81_1.time_ < var_84_7 + var_84_8 + arg_84_0 then
				local var_84_10 = Color.New(1, 1, 1)

				arg_81_1.mask_.enabled = false
				var_84_10.a = 0
				arg_81_1.mask_.color = var_84_10
			end

			if 1 < arg_81_1.time_ and arg_81_1.time_ <= 1 + arg_84_0 then
				local var_84_11 = arg_81_1.var_.effectcaihongqiao1

				if not arg_81_1.var_.effectcaihongqiao1 then
					var_84_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), manager.ui.mainCamera.transform)
					var_84_11.name = "caihongqiao1"
					arg_81_1.var_.effectcaihongqiao1 = var_84_11
				else
					var_84_11.transform:SetParent(var_84_9000)
				end

				var_84_11.transform.localPosition = Vector3.New(0, 0, -5.51)
				var_84_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.566666666666667 < arg_81_1.time_ and arg_81_1.time_ <= 0.566666666666667 + arg_84_0 then
				arg_81_1:AudioAction("play", "effect", "se_story_10", "se_story_10_cheer", "")
			end

			local var_84_14 = 1.8
			local var_84_15 = 1.525

			if 1.8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_16 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(924031019).content)

				arg_81_1.text_.text = var_84_16

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_18 = 61 <= 0 and var_84_15 or var_84_15 * (utf8.len(var_84_16) / 61)

				if (61 <= 0 and var_84_15 or var_84_15 * (utf8.len(var_84_16) / 61)) > 0 and var_84_15 < var_84_18 then
					arg_81_1.talkMaxDuration = var_84_18

					if var_84_18 + var_84_14 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_14
					end
				end

				arg_81_1.text_.text = var_84_16
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_19 = math.max(var_84_15, arg_81_1.talkMaxDuration)

			if var_84_14 <= arg_81_1.time_ and arg_81_1.time_ < var_84_14 + var_84_19 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_14) / var_84_19

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_14 + var_84_19 and arg_81_1.time_ < var_84_14 + var_84_19 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play924031020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 924031020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play924031021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.275

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(924031020).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 11 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 11)

				if (11 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 11)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play924031021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 924031021
		arg_89_1.duration_ = 3.87

		local var_89_0 = {
			zh = 2.433,
			ja = 3.866
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play924031022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos102003ui_story = arg_89_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["102003ui_story"].transform.position).z)
				arg_89_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["102003ui_story"].transform.localEulerAngles = arg_89_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_89_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["102003ui_story"].transform.position).z)
				arg_89_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["102003ui_story"].transform.localEulerAngles = arg_89_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["102003ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect102003ui_story == nil then
				arg_89_1.var_.characterEffect102003ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect102003ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect102003ui_story then
				arg_89_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_92_4 = 0
			local var_92_5 = 0.225

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(924031021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 9 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 9)

				if (9 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 9)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031021", "story_v_side_old_924031.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031021", "story_v_side_old_924031.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_side_old_924031", "924031021", "story_v_side_old_924031.awb")

						arg_89_1:RecordAudio("924031021", var_92_11)
						arg_89_1:RecordAudio("924031021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031021", "story_v_side_old_924031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031021", "story_v_side_old_924031.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play924031022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 924031022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play924031023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["102003ui_story"]) and arg_93_1.var_.characterEffect102003ui_story == nil then
				arg_93_1.var_.characterEffect102003ui_story = arg_93_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["102003ui_story"]) then
				if arg_93_1.var_.characterEffect102003ui_story and not isNil(arg_93_1.actors_["102003ui_story"]) then
					arg_93_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_93_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["102003ui_story"]) and arg_93_1.var_.characterEffect102003ui_story then
				arg_93_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_93_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.325

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(924031022).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 13 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 13)

				if (13 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 13)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play924031023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 924031023
		arg_97_1.duration_ = 7.5

		local var_97_0 = {
			zh = 5.866,
			ja = 7.5
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play924031024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos102003ui_story = arg_97_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).z)
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles = arg_97_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_97_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).z)
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles = arg_97_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["102003ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect102003ui_story == nil then
				arg_97_1.var_.characterEffect102003ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect102003ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect102003ui_story then
				arg_97_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action438")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_100_4 = 0
			local var_100_5 = 0.375

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(924031023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 15 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 15)

				if (15 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 15)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031023", "story_v_side_old_924031.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031023", "story_v_side_old_924031.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_side_old_924031", "924031023", "story_v_side_old_924031.awb")

						arg_97_1:RecordAudio("924031023", var_100_11)
						arg_97_1:RecordAudio("924031023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031023", "story_v_side_old_924031.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031023", "story_v_side_old_924031.awb")
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
				actorName = "102003ui_story",
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
	Play924031024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 924031024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play924031025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos102003ui_story = arg_101_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["102003ui_story"].transform.position).z)
				arg_101_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["102003ui_story"].transform.localEulerAngles = arg_101_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["102003ui_story"].transform.position).z)
				arg_101_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["102003ui_story"].transform.localEulerAngles = arg_101_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["102003ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect102003ui_story == nil then
				arg_101_1.var_.characterEffect102003ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect102003ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_101_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_2)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect102003ui_story then
				arg_101_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_101_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_104_3 = 0
			local var_104_4 = 0.525

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_5 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(924031024).content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 21 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_5) / 21)

				if (21 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_5) / 21)) > 0 and var_104_4 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_3 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_3
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_4, arg_101_1.talkMaxDuration)

			if var_104_3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_3 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_3) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_3 + var_104_8 and arg_101_1.time_ < var_104_3 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play924031025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 924031025
		arg_105_1.duration_ = 1

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"

			SetActive(arg_105_1.choicesGo_, true)

			for iter_106_0, iter_106_1 in ipairs(arg_105_1.choices_) do
				SetActive(iter_106_1.go, iter_106_0 <= 1)
			end

			arg_105_1.choices_[1].txt.text = arg_105_1:FormatText(StoryChoiceCfg[1204].name)
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play924031026(arg_105_1)
			end

			arg_105_1:RecordChoiceLog(924031025, 1204)
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			if arg_105_1.time_ >= 0 + 0.6 and arg_105_1.time_ < 0 + 0.6 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play924031026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 924031026
		arg_109_1.duration_ = 2.8

		local var_109_0 = {
			zh = 2.266,
			ja = 2.8
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
				arg_109_0:Play924031027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos102003ui_story = arg_109_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).z)
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles = arg_109_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_109_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).z)
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles = arg_109_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["102003ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect102003ui_story == nil then
				arg_109_1.var_.characterEffect102003ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect102003ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect102003ui_story then
				arg_109_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_112_4 = 0
			local var_112_5 = 0.225

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(924031026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 9 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 9)

				if (9 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 9)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031026", "story_v_side_old_924031.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031026", "story_v_side_old_924031.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_side_old_924031", "924031026", "story_v_side_old_924031.awb")

						arg_109_1:RecordAudio("924031026", var_112_11)
						arg_109_1:RecordAudio("924031026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031026", "story_v_side_old_924031.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031026", "story_v_side_old_924031.awb")
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
				actorName = "102003ui_story",
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
	Play924031027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 924031027
		arg_113_1.duration_ = 9.13

		local var_113_0 = {
			zh = 4.8,
			ja = 9.133
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
				arg_113_0:Play924031028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos102003ui_story = arg_113_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["102003ui_story"].transform.position).z)
				arg_113_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["102003ui_story"].transform.localEulerAngles = arg_113_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_113_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["102003ui_story"].transform.position).z)
				arg_113_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["102003ui_story"].transform.localEulerAngles = arg_113_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_116_1 = 0
			local var_116_2 = 0.45

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(924031027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 18 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 18)

				if (18 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 18)) > 0 and var_116_2 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031027", "story_v_side_old_924031.awb") ~= 0 then
					local var_116_7 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031027", "story_v_side_old_924031.awb") / 1000

					if var_116_7 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_1
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_side_old_924031", "924031027", "story_v_side_old_924031.awb")

						arg_113_1:RecordAudio("924031027", var_116_8)
						arg_113_1:RecordAudio("924031027", var_116_8)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031027", "story_v_side_old_924031.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031027", "story_v_side_old_924031.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_9 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_9

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_9 and arg_113_1.time_ < var_116_1 + var_116_9 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 924031028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play924031029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos102003ui_story = arg_117_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["102003ui_story"].transform.position).z)
				arg_117_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["102003ui_story"].transform.localEulerAngles = arg_117_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["102003ui_story"].transform.position).z)
				arg_117_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["102003ui_story"].transform.localEulerAngles = arg_117_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["102003ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect102003ui_story == nil then
				arg_117_1.var_.characterEffect102003ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect102003ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_117_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_2)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect102003ui_story then
				arg_117_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_117_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_120_3 = 0
			local var_120_4 = 0.825

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_5 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(924031028).content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 33 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_5) / 33)

				if (33 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_5) / 33)) > 0 and var_120_4 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_3 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_3
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_4, arg_117_1.talkMaxDuration)

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_3) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_3 + var_120_8 and arg_117_1.time_ < var_120_3 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 924031029
		arg_121_1.duration_ = 3.73

		local var_121_0 = {
			zh = 3.1,
			ja = 3.733
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
				arg_121_0:Play924031030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos102003ui_story = arg_121_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).z)
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles = arg_121_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_121_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).z)
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles = arg_121_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["102003ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect102003ui_story == nil then
				arg_121_1.var_.characterEffect102003ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect102003ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect102003ui_story then
				arg_121_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_124_4 = 0
			local var_124_5 = 0.3

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(924031029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 12 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 12)

				if (12 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 12)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031029", "story_v_side_old_924031.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031029", "story_v_side_old_924031.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_side_old_924031", "924031029", "story_v_side_old_924031.awb")

						arg_121_1:RecordAudio("924031029", var_124_11)
						arg_121_1:RecordAudio("924031029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031029", "story_v_side_old_924031.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031029", "story_v_side_old_924031.awb")
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

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play924031030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 924031030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play924031031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["102003ui_story"]) and arg_125_1.var_.characterEffect102003ui_story == nil then
				arg_125_1.var_.characterEffect102003ui_story = arg_125_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["102003ui_story"]) then
				if arg_125_1.var_.characterEffect102003ui_story and not isNil(arg_125_1.actors_["102003ui_story"]) then
					arg_125_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_125_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["102003ui_story"]) and arg_125_1.var_.characterEffect102003ui_story then
				arg_125_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_125_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 0.525

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(924031030).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 21 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 21)

				if (21 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 21)) > 0 and var_128_2 < var_128_5 then
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
	Play924031031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 924031031
		arg_129_1.duration_ = 4.37

		local var_129_0 = {
			zh = 4.133,
			ja = 4.366
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play924031032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos102003ui_story = arg_129_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["102003ui_story"].transform.position).z)
				arg_129_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["102003ui_story"].transform.localEulerAngles = arg_129_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_129_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["102003ui_story"].transform.position).z)
				arg_129_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["102003ui_story"].transform.localEulerAngles = arg_129_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["102003ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect102003ui_story == nil then
				arg_129_1.var_.characterEffect102003ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect102003ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect102003ui_story then
				arg_129_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			local var_132_4 = 0
			local var_132_5 = 0.4

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(924031031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 16 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 16)

				if (16 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 16)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031031", "story_v_side_old_924031.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031031", "story_v_side_old_924031.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_side_old_924031", "924031031", "story_v_side_old_924031.awb")

						arg_129_1:RecordAudio("924031031", var_132_11)
						arg_129_1:RecordAudio("924031031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031031", "story_v_side_old_924031.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031031", "story_v_side_old_924031.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 924031032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play924031033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["102003ui_story"]) and arg_133_1.var_.characterEffect102003ui_story == nil then
				arg_133_1.var_.characterEffect102003ui_story = arg_133_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["102003ui_story"]) then
				if arg_133_1.var_.characterEffect102003ui_story and not isNil(arg_133_1.actors_["102003ui_story"]) then
					arg_133_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_133_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["102003ui_story"]) and arg_133_1.var_.characterEffect102003ui_story then
				arg_133_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_133_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.225

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(924031032).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 9 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 9)

				if (9 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 9)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play924031033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 924031033
		arg_137_1.duration_ = 14.27

		local var_137_0 = {
			zh = 8.4,
			ja = 14.266
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play924031034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["102003ui_story"]) and arg_137_1.var_.characterEffect102003ui_story == nil then
				arg_137_1.var_.characterEffect102003ui_story = arg_137_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["102003ui_story"]) then
				if arg_137_1.var_.characterEffect102003ui_story and not isNil(arg_137_1.actors_["102003ui_story"]) then
					arg_137_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["102003ui_story"]) and arg_137_1.var_.characterEffect102003ui_story then
				arg_137_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_2")
			end

			local var_140_2 = 0
			local var_140_3 = 0.9

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(924031033)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 36 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 36)

				if (36 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 36)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031033", "story_v_side_old_924031.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031033", "story_v_side_old_924031.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_side_old_924031", "924031033", "story_v_side_old_924031.awb")

						arg_137_1:RecordAudio("924031033", var_140_9)
						arg_137_1:RecordAudio("924031033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031033", "story_v_side_old_924031.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031033", "story_v_side_old_924031.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_10 and arg_137_1.time_ < var_140_2 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play924031034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 924031034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play924031035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["102003ui_story"]) and arg_141_1.var_.characterEffect102003ui_story == nil then
				arg_141_1.var_.characterEffect102003ui_story = arg_141_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["102003ui_story"]) then
				if arg_141_1.var_.characterEffect102003ui_story and not isNil(arg_141_1.actors_["102003ui_story"]) then
					arg_141_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_141_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["102003ui_story"]) and arg_141_1.var_.characterEffect102003ui_story then
				arg_141_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_141_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.3

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(924031034).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 12 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 12)

				if (12 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 12)) > 0 and var_144_2 < var_144_5 then
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
	Play924031035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 924031035
		arg_145_1.duration_ = 8.3

		local var_145_0 = {
			zh = 8.133,
			ja = 8.3
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play924031036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.bgs_.STblack == nil then
				local var_148_0 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_148_0.name = "STblack"
				var_148_0.transform.parent = arg_145_1.stage_.transform
				var_148_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_.STblack = var_148_0
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				local var_148_1 = arg_145_1.bgs_.STblack

				arg_145_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_148_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_2 = var_148_1:GetComponent("SpriteRenderer")

				if var_148_2 and var_148_2.sprite then
					local var_148_3 = 2 * (var_148_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_148_1.transform.localScale = Vector3.New(var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "STblack" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_4 = 4

			if 4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			if arg_145_1.time_ >= var_148_4 + 0.3 and arg_145_1.time_ < var_148_4 + 0.3 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			local var_148_5 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_6 = 2

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_6 then
				local var_148_7 = Color.New(0, 0, 0)

				var_148_7.a = Mathf.Lerp(0, 1, (arg_145_1.time_ - var_148_5) / var_148_6)
				arg_145_1.mask_.color = var_148_7
			end

			if arg_145_1.time_ >= var_148_5 + var_148_6 and arg_145_1.time_ < var_148_5 + var_148_6 + arg_148_0 then
				local var_148_8 = Color.New(0, 0, 0)

				var_148_8.a = 1
				arg_145_1.mask_.color = var_148_8
			end

			local var_148_9 = 2

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_10 = 2

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_10 then
				local var_148_11 = Color.New(0, 0, 0)

				var_148_11.a = Mathf.Lerp(1, 0, (arg_145_1.time_ - var_148_9) / var_148_10)
				arg_145_1.mask_.color = var_148_11
			end

			if arg_145_1.time_ >= var_148_9 + var_148_10 and arg_145_1.time_ < var_148_9 + var_148_10 + arg_148_0 then
				local var_148_12 = Color.New(0, 0, 0)

				arg_145_1.mask_.enabled = false
				var_148_12.a = 0
				arg_145_1.mask_.color = var_148_12
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				if arg_145_1.var_.effectcaihongqiao1 then
					Object.Destroy(arg_145_1.var_.effectcaihongqiao1)

					arg_145_1.var_.effectcaihongqiao1 = nil
				end
			end

			local var_148_14 = arg_145_1.actors_["102003ui_story"].transform

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1.var_.moveOldPos102003ui_story = var_148_14.localPosition
			end

			local var_148_15 = 0.001

			if 2 <= arg_145_1.time_ and arg_145_1.time_ < 2 + var_148_15 then
				var_148_14.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 2) / var_148_15)
				var_148_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_14.position).x, (manager.ui.mainCamera.transform.position - var_148_14.position).y, (manager.ui.mainCamera.transform.position - var_148_14.position).z)
				var_148_14.localEulerAngles.z = 0
				var_148_14.localEulerAngles.x = 0
				var_148_14.localEulerAngles = var_148_14.localEulerAngles
			end

			if arg_145_1.time_ >= 2 + var_148_15 and arg_145_1.time_ < 2 + var_148_15 + arg_148_0 then
				var_148_14.localPosition = Vector3.New(0, 100, 0)
				var_148_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_14.position).x, (manager.ui.mainCamera.transform.position - var_148_14.position).y, (manager.ui.mainCamera.transform.position - var_148_14.position).z)
				var_148_14.localEulerAngles.z = 0
				var_148_14.localEulerAngles.x = 0
				var_148_14.localEulerAngles = var_148_14.localEulerAngles
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_16 = 4
			local var_148_17 = 0.325

			if 4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_18 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_18:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102003")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_19 = arg_145_1:GetWordFromCfg(924031035)
				local var_148_20 = arg_145_1:FormatText(var_148_19.content)

				arg_145_1.text_.text = var_148_20

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_22 = 13 <= 0 and var_148_17 or var_148_17 * (utf8.len(var_148_20) / 13)

				if (13 <= 0 and var_148_17 or var_148_17 * (utf8.len(var_148_20) / 13)) > 0 and var_148_17 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22
					var_148_16 = var_148_16 + 0.3

					if var_148_22 + var_148_16 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_16
					end
				end

				arg_145_1.text_.text = var_148_20
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031035", "story_v_side_old_924031.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031035", "story_v_side_old_924031.awb") / 1000

					if var_148_23 + var_148_16 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_16
					end

					if var_148_19.prefab_name ~= "" and arg_145_1.actors_[var_148_19.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_19.prefab_name].transform, "story_v_side_old_924031", "924031035", "story_v_side_old_924031.awb")

						arg_145_1:RecordAudio("924031035", var_148_24)
						arg_145_1:RecordAudio("924031035", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031035", "story_v_side_old_924031.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031035", "story_v_side_old_924031.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = var_148_16 + 0.3
			local var_148_26 = math.max(var_148_17, arg_145_1.talkMaxDuration)

			if var_148_16 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_25 + var_148_26 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_25) / var_148_26

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_25 + var_148_26 and arg_145_1.time_ < var_148_25 + var_148_26 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play924031036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 924031036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play924031037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["102003ui_story"]) and arg_151_1.var_.characterEffect102003ui_story == nil then
				arg_151_1.var_.characterEffect102003ui_story = arg_151_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["102003ui_story"]) then
				if arg_151_1.var_.characterEffect102003ui_story and not isNil(arg_151_1.actors_["102003ui_story"]) then
					arg_151_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_151_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["102003ui_story"]) and arg_151_1.var_.characterEffect102003ui_story then
				arg_151_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_151_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_154_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_151_1.bgmTxt_.text ~= var_154_3 and arg_151_1.bgmTxt_.text ~= "" then
						if arg_151_1.bgmTxt2_.text ~= "" then
							arg_151_1.bgmTxt_.text = arg_151_1.bgmTxt2_.text
						end

						arg_151_1.bgmTxt2_.text = var_154_3

						arg_151_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_151_1.bgmTxt_.text = var_154_3
						arg_151_1.bgmTxt2_.text = var_154_3
					end

					if arg_151_1.bgmTimer then
						arg_151_1.bgmTimer:Stop()

						arg_151_1.bgmTimer = nil
					end

					if arg_151_1.settingData.show_music_name == 1 then
						arg_151_1.musicController:SetSelectedState("show")
						arg_151_1.musicAnimator_:Play("open", 0, 0)

						if arg_151_1.settingData.music_time ~= 0 then
							arg_151_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_151_1.settingData.music_time), function()
								if arg_151_1 == nil or isNil(arg_151_1.bgmTxt_) then
									return
								end

								arg_151_1.musicController:SetSelectedState("hide")
								arg_151_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_154_4 = 0
			local var_154_5 = 0.1

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_6 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(924031036).content)

				arg_151_1.text_.text = var_154_6

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_8 = 4 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_6) / 4)

				if (4 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_6) / 4)) > 0 and var_154_5 < var_154_8 then
					arg_151_1.talkMaxDuration = var_154_8

					if var_154_8 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_6
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_9 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_9 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_9

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_9 and arg_151_1.time_ < var_154_4 + var_154_9 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play924031037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 924031037
		arg_156_1.duration_ = 8

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play924031038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if arg_156_1.bgs_.H02 == nil then
				local var_159_0 = Object.Instantiate(arg_156_1.paintGo_)

				var_159_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02")
				var_159_0.name = "H02"
				var_159_0.transform.parent = arg_156_1.stage_.transform
				var_159_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_.H02 = var_159_0
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				local var_159_1 = arg_156_1.bgs_.H02

				arg_156_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_2 = var_159_1:GetComponent("SpriteRenderer")

				if var_159_2 and var_159_2.sprite then
					local var_159_3 = 2 * (var_159_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_1.transform.localScale = Vector3.New(var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "H02" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_4 = 3

			if 3 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			if arg_156_1.time_ >= var_159_4 + 0.3 and arg_156_1.time_ < var_159_4 + 0.3 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_5 = 0

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_6 = 3

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 then
				local var_159_7 = Color.New(0, 0, 0)

				var_159_7.a = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_5) / var_159_6)
				arg_156_1.mask_.color = var_159_7
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 then
				local var_159_8 = Color.New(0, 0, 0)

				arg_156_1.mask_.enabled = false
				var_159_8.a = 0
				arg_156_1.mask_.color = var_159_8
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_159_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_156_1.bgmTxt_.text ~= var_159_11 and arg_156_1.bgmTxt_.text ~= "" then
						if arg_156_1.bgmTxt2_.text ~= "" then
							arg_156_1.bgmTxt_.text = arg_156_1.bgmTxt2_.text
						end

						arg_156_1.bgmTxt2_.text = var_159_11

						arg_156_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_156_1.bgmTxt_.text = var_159_11
						arg_156_1.bgmTxt2_.text = var_159_11
					end

					if arg_156_1.bgmTimer then
						arg_156_1.bgmTimer:Stop()

						arg_156_1.bgmTimer = nil
					end

					if arg_156_1.settingData.show_music_name == 1 then
						arg_156_1.musicController:SetSelectedState("show")
						arg_156_1.musicAnimator_:Play("open", 0, 0)

						if arg_156_1.settingData.music_time ~= 0 then
							arg_156_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_156_1.settingData.music_time), function()
								if arg_156_1 == nil or isNil(arg_156_1.bgmTxt_) then
									return
								end

								arg_156_1.musicController:SetSelectedState("hide")
								arg_156_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_156_1.time_ and arg_156_1.time_ <= 0.4 + arg_159_0 then
				arg_156_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_159_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if "" ~= "" then
					if arg_156_1.bgmTxt_.text ~= var_159_14 and arg_156_1.bgmTxt_.text ~= "" then
						if arg_156_1.bgmTxt2_.text ~= "" then
							arg_156_1.bgmTxt_.text = arg_156_1.bgmTxt2_.text
						end

						arg_156_1.bgmTxt2_.text = var_159_14

						arg_156_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_156_1.bgmTxt_.text = var_159_14
						arg_156_1.bgmTxt2_.text = var_159_14
					end

					if arg_156_1.bgmTimer then
						arg_156_1.bgmTimer:Stop()

						arg_156_1.bgmTimer = nil
					end

					if arg_156_1.settingData.show_music_name == 1 then
						arg_156_1.musicController:SetSelectedState("show")
						arg_156_1.musicAnimator_:Play("open", 0, 0)

						if arg_156_1.settingData.music_time ~= 0 then
							arg_156_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_156_1.settingData.music_time), function()
								if arg_156_1 == nil or isNil(arg_156_1.bgmTxt_) then
									return
								end

								arg_156_1.musicController:SetSelectedState("hide")
								arg_156_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.125 < arg_156_1.time_ and arg_156_1.time_ <= 0.125 + arg_159_0 then
				arg_156_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_sea", "")
			end

			if 0.125 < arg_156_1.time_ and arg_156_1.time_ <= 0.125 + arg_159_0 then
				arg_156_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_dream", "")
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_17 = 3
			local var_159_18 = 1.125

			if 3 < arg_156_1.time_ and arg_156_1.time_ <= var_159_17 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_19 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_19:setOnUpdate(LuaHelper.FloatAction(function(arg_162_0)
					arg_156_1.dialogCg_.alpha = arg_162_0
				end))
				var_159_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_20 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(924031037).content)

				arg_156_1.text_.text = var_159_20

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_22 = 45 <= 0 and var_159_18 or var_159_18 * (utf8.len(var_159_20) / 45)

				if (45 <= 0 and var_159_18 or var_159_18 * (utf8.len(var_159_20) / 45)) > 0 and var_159_18 < var_159_22 then
					arg_156_1.talkMaxDuration = var_159_22
					var_159_17 = var_159_17 + 0.3

					if var_159_22 + var_159_17 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_17
					end
				end

				arg_156_1.text_.text = var_159_20
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_23 = var_159_17 + 0.3
			local var_159_24 = math.max(var_159_18, arg_156_1.talkMaxDuration)

			if var_159_17 + 0.3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_23 + var_159_24 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_23) / var_159_24

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_23 + var_159_24 and arg_156_1.time_ < var_159_23 + var_159_24 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play924031038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 924031038
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play924031039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.95

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

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(924031038).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 38 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 38)

				if (38 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 38)) > 0 and var_167_0 < var_167_3 then
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
	Play924031039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 924031039
		arg_168_1.duration_ = 3.77

		local var_168_0 = {
			zh = 3.766,
			ja = 3.166
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
				arg_168_0:Play924031040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos102003ui_story = arg_168_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["102003ui_story"].transform.position).z)
				arg_168_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["102003ui_story"].transform.localEulerAngles = arg_168_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_168_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["102003ui_story"].transform.position).z)
				arg_168_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["102003ui_story"].transform.localEulerAngles = arg_168_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["102003ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect102003ui_story == nil then
				arg_168_1.var_.characterEffect102003ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect102003ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect102003ui_story then
				arg_168_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action11_1")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_171_4 = 0
			local var_171_5 = 0.25

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_6 = arg_168_1:GetWordFromCfg(924031039)
				local var_171_7 = arg_168_1:FormatText(var_171_6.content)

				arg_168_1.text_.text = var_171_7

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_9 = 10 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 10)

				if (10 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 10)) > 0 and var_171_5 < var_171_9 then
					arg_168_1.talkMaxDuration = var_171_9

					if var_171_9 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_4
					end
				end

				arg_168_1.text_.text = var_171_7
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031039", "story_v_side_old_924031.awb") ~= 0 then
					local var_171_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031039", "story_v_side_old_924031.awb") / 1000

					if var_171_10 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_4
					end

					if var_171_6.prefab_name ~= "" and arg_168_1.actors_[var_171_6.prefab_name] ~= nil then
						local var_171_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_6.prefab_name].transform, "story_v_side_old_924031", "924031039", "story_v_side_old_924031.awb")

						arg_168_1:RecordAudio("924031039", var_171_11)
						arg_168_1:RecordAudio("924031039", var_171_11)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031039", "story_v_side_old_924031.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031039", "story_v_side_old_924031.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_12 = math.max(var_171_5, arg_168_1.talkMaxDuration)

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_12 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_4) / var_171_12

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_4 + var_171_12 and arg_168_1.time_ < var_171_4 + var_171_12 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play924031040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 924031040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play924031041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos102003ui_story = arg_172_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_175_0 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 then
				arg_172_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 0) / var_175_0)
				arg_172_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["102003ui_story"].transform.position).z)
				arg_172_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["102003ui_story"].transform.localEulerAngles = arg_172_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 then
				arg_172_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["102003ui_story"].transform.position).z)
				arg_172_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["102003ui_story"].transform.localEulerAngles = arg_172_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_175_1 = arg_172_1.actors_["102003ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect102003ui_story == nil then
				arg_172_1.var_.characterEffect102003ui_story = var_175_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_2 and not isNil(var_175_1) then
				if arg_172_1.var_.characterEffect102003ui_story and not isNil(var_175_1) then
					arg_172_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_172_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_2)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_2 and arg_172_1.time_ < 0 + var_175_2 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect102003ui_story then
				arg_172_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_172_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 0.466666666666667 < arg_172_1.time_ and arg_172_1.time_ <= 0.466666666666667 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_141", "se_story_141_watergun", "")
			end

			local var_175_4 = 0
			local var_175_5 = 0.925

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_6 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(924031040).content)

				arg_172_1.text_.text = var_175_6

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_8 = 37 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_6) / 37)

				if (37 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_6) / 37)) > 0 and var_175_5 < var_175_8 then
					arg_172_1.talkMaxDuration = var_175_8

					if var_175_8 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_6
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_9 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_9 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_9

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_9 and arg_172_1.time_ < var_175_4 + var_175_9 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play924031041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 924031041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play924031042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.75

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(924031041).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 30 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 30)

				if (30 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 30)) > 0 and var_179_0 < var_179_3 then
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
	Play924031042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 924031042
		arg_180_1.duration_ = 6.93

		local var_180_0 = {
			zh = 5.666,
			ja = 6.933
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play924031043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos102003ui_story = arg_180_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_183_0 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_180_1.time_ - 0) / var_183_0)
				arg_180_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["102003ui_story"].transform.position).z)
				arg_180_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["102003ui_story"].transform.localEulerAngles = arg_180_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_180_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["102003ui_story"].transform.position).z)
				arg_180_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["102003ui_story"].transform.localEulerAngles = arg_180_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_183_1 = arg_180_1.actors_["102003ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect102003ui_story == nil then
				arg_180_1.var_.characterEffect102003ui_story = var_183_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_2 and not isNil(var_183_1) then
				if arg_180_1.var_.characterEffect102003ui_story and not isNil(var_183_1) then
					arg_180_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_2 and arg_180_1.time_ < 0 + var_183_2 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect102003ui_story then
				arg_180_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action4113")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_183_4 = 0
			local var_183_5 = 0.4

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_6 = arg_180_1:GetWordFromCfg(924031042)
				local var_183_7 = arg_180_1:FormatText(var_183_6.content)

				arg_180_1.text_.text = var_183_7

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_9 = 16 <= 0 and var_183_5 or var_183_5 * (utf8.len(var_183_7) / 16)

				if (16 <= 0 and var_183_5 or var_183_5 * (utf8.len(var_183_7) / 16)) > 0 and var_183_5 < var_183_9 then
					arg_180_1.talkMaxDuration = var_183_9

					if var_183_9 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_4
					end
				end

				arg_180_1.text_.text = var_183_7
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031042", "story_v_side_old_924031.awb") ~= 0 then
					local var_183_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031042", "story_v_side_old_924031.awb") / 1000

					if var_183_10 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_4
					end

					if var_183_6.prefab_name ~= "" and arg_180_1.actors_[var_183_6.prefab_name] ~= nil then
						local var_183_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_6.prefab_name].transform, "story_v_side_old_924031", "924031042", "story_v_side_old_924031.awb")

						arg_180_1:RecordAudio("924031042", var_183_11)
						arg_180_1:RecordAudio("924031042", var_183_11)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031042", "story_v_side_old_924031.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031042", "story_v_side_old_924031.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_12 = math.max(var_183_5, arg_180_1.talkMaxDuration)

			if var_183_4 <= arg_180_1.time_ and arg_180_1.time_ < var_183_4 + var_183_12 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_4) / var_183_12

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_4 + var_183_12 and arg_180_1.time_ < var_183_4 + var_183_12 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play924031043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 924031043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play924031044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos102003ui_story = arg_184_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_187_0 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 then
				arg_184_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_184_1.time_ - 0) / var_187_0)
				arg_184_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["102003ui_story"].transform.position).z)
				arg_184_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["102003ui_story"].transform.localEulerAngles = arg_184_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 then
				arg_184_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_184_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["102003ui_story"].transform.position).z)
				arg_184_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["102003ui_story"].transform.localEulerAngles = arg_184_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_187_1 = arg_184_1.actors_["102003ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect102003ui_story == nil then
				arg_184_1.var_.characterEffect102003ui_story = var_187_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_2 and not isNil(var_187_1) then
				if arg_184_1.var_.characterEffect102003ui_story and not isNil(var_187_1) then
					arg_184_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_184_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_2)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_2 and arg_184_1.time_ < 0 + var_187_2 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect102003ui_story then
				arg_184_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_184_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 0.125 < arg_184_1.time_ and arg_184_1.time_ <= 0.125 + arg_187_0 then
				arg_184_1:AudioAction("play", "effect", "se_story_141", "se_story_141_watermagic", "")
			end

			local var_187_4 = 0
			local var_187_5 = 1.075

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_6 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(924031043).content)

				arg_184_1.text_.text = var_187_6

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_8 = 43 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_6) / 43)

				if (43 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_6) / 43)) > 0 and var_187_5 < var_187_8 then
					arg_184_1.talkMaxDuration = var_187_8

					if var_187_8 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_6
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_9 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_9 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_9

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_9 and arg_184_1.time_ < var_187_4 + var_187_9 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play924031044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 924031044
		arg_188_1.duration_ = 1

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"

			SetActive(arg_188_1.choicesGo_, true)

			for iter_189_0, iter_189_1 in ipairs(arg_188_1.choices_) do
				SetActive(iter_189_1.go, iter_189_0 <= 1)
			end

			arg_188_1.choices_[1].txt.text = arg_188_1:FormatText(StoryChoiceCfg[1205].name)
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play924031045(arg_188_1)
			end

			arg_188_1:RecordChoiceLog(924031044, 1205)
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			if arg_188_1.time_ >= 0 + 0.6 and arg_188_1.time_ < 0 + 0.6 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play924031045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 924031045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play924031046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.7

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_1 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(924031045).content)

				arg_192_1.text_.text = var_195_1

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_3 = 28 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 28)

				if (28 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 28)) > 0 and var_195_0 < var_195_3 then
					arg_192_1.talkMaxDuration = var_195_3

					if var_195_3 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_3 + 0
					end
				end

				arg_192_1.text_.text = var_195_1
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_4 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_4

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play924031046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 924031046
		arg_196_1.duration_ = 7

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play924031047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_0 = 1

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 then
				local var_199_1 = Color.New(0, 0, 0)

				var_199_1.a = Mathf.Lerp(0, 1, (arg_196_1.time_ - 0) / var_199_0)
				arg_196_1.mask_.color = var_199_1
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 then
				local var_199_2 = Color.New(0, 0, 0)

				var_199_2.a = 1
				arg_196_1.mask_.color = var_199_2
			end

			local var_199_3 = 1

			if 1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_3 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_4 = 1

			if var_199_3 <= arg_196_1.time_ and arg_196_1.time_ < var_199_3 + var_199_4 then
				local var_199_5 = Color.New(0, 0, 0)

				var_199_5.a = Mathf.Lerp(1, 0, (arg_196_1.time_ - var_199_3) / var_199_4)
				arg_196_1.mask_.color = var_199_5
			end

			if arg_196_1.time_ >= var_199_3 + var_199_4 and arg_196_1.time_ < var_199_3 + var_199_4 + arg_199_0 then
				local var_199_6 = Color.New(0, 0, 0)

				arg_196_1.mask_.enabled = false
				var_199_6.a = 0
				arg_196_1.mask_.color = var_199_6
			end

			local var_199_7 = 2
			local var_199_8 = 0.125

			if 2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_7 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_9 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(924031046).content)

				arg_196_1.text_.text = var_199_9

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 5 <= 0 and var_199_8 or var_199_8 * (utf8.len(var_199_9) / 5)

				if (5 <= 0 and var_199_8 or var_199_8 * (utf8.len(var_199_9) / 5)) > 0 and var_199_8 < var_199_11 then
					arg_196_1.talkMaxDuration = var_199_11

					if var_199_11 + var_199_7 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_7
					end
				end

				arg_196_1.text_.text = var_199_9
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_8, arg_196_1.talkMaxDuration)

			if var_199_7 <= arg_196_1.time_ and arg_196_1.time_ < var_199_7 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_7) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_7 + var_199_12 and arg_196_1.time_ < var_199_7 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play924031047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 924031047
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play924031048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 1.4

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(924031047).content)

				arg_200_1.text_.text = var_203_1

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_3 = 56 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 56)

				if (56 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 56)) > 0 and var_203_0 < var_203_3 then
					arg_200_1.talkMaxDuration = var_203_3

					if var_203_3 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_3 + 0
					end
				end

				arg_200_1.text_.text = var_203_1
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_4 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_4

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play924031048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 924031048
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play924031049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.95

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(924031048).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 38 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 38)

				if (38 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 38)) > 0 and var_207_0 < var_207_3 then
					arg_204_1.talkMaxDuration = var_207_3

					if var_207_3 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_3 + 0
					end
				end

				arg_204_1.text_.text = var_207_1
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_4 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_4

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play924031049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 924031049
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play924031050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.7

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
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

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(924031049).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 28 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 28)

				if (28 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 28)) > 0 and var_211_0 < var_211_3 then
					arg_208_1.talkMaxDuration = var_211_3

					if var_211_3 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_3 + 0
					end
				end

				arg_208_1.text_.text = var_211_1
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_4 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_4

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play924031050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 924031050
		arg_212_1.duration_ = 5.53

		local var_212_0 = {
			zh = 5.166,
			ja = 5.533
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
				arg_212_0:Play924031051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos102003ui_story = arg_212_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["102003ui_story"].transform.position).z)
				arg_212_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["102003ui_story"].transform.localEulerAngles = arg_212_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_212_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["102003ui_story"].transform.position).z)
				arg_212_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["102003ui_story"].transform.localEulerAngles = arg_212_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_215_1 = arg_212_1.actors_["102003ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect102003ui_story == nil then
				arg_212_1.var_.characterEffect102003ui_story = var_215_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_2 and not isNil(var_215_1) then
				if arg_212_1.var_.characterEffect102003ui_story and not isNil(var_215_1) then
					arg_212_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_2 and arg_212_1.time_ < 0 + var_215_2 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect102003ui_story then
				arg_212_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_215_4 = 0
			local var_215_5 = 0.375

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(924031050)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 15 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 15)

				if (15 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 15)) > 0 and var_215_5 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031050", "story_v_side_old_924031.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031050", "story_v_side_old_924031.awb") / 1000

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end

					if var_215_6.prefab_name ~= "" and arg_212_1.actors_[var_215_6.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_6.prefab_name].transform, "story_v_side_old_924031", "924031050", "story_v_side_old_924031.awb")

						arg_212_1:RecordAudio("924031050", var_215_11)
						arg_212_1:RecordAudio("924031050", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031050", "story_v_side_old_924031.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031050", "story_v_side_old_924031.awb")
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

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 924031051
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play924031052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["102003ui_story"]) and arg_216_1.var_.characterEffect102003ui_story == nil then
				arg_216_1.var_.characterEffect102003ui_story = arg_216_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["102003ui_story"]) then
				if arg_216_1.var_.characterEffect102003ui_story and not isNil(arg_216_1.actors_["102003ui_story"]) then
					arg_216_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_216_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_0)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["102003ui_story"]) and arg_216_1.var_.characterEffect102003ui_story then
				arg_216_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_216_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_219_1 = 0
			local var_219_2 = 0.325

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
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

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_3 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(924031051).content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 13 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 13)

				if (13 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 13)) > 0 and var_219_2 < var_219_5 then
					arg_216_1.talkMaxDuration = var_219_5

					if var_219_5 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_6 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_6 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_6

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_6 and arg_216_1.time_ < var_219_1 + var_219_6 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play924031052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 924031052
		arg_220_1.duration_ = 3.2

		local var_220_0 = {
			zh = 2.7,
			ja = 3.2
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
				arg_220_0:Play924031053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos102003ui_story = arg_220_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["102003ui_story"].transform.position).z)
				arg_220_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["102003ui_story"].transform.localEulerAngles = arg_220_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_220_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["102003ui_story"].transform.position).z)
				arg_220_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["102003ui_story"].transform.localEulerAngles = arg_220_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_223_1 = arg_220_1.actors_["102003ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect102003ui_story == nil then
				arg_220_1.var_.characterEffect102003ui_story = var_223_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_2 and not isNil(var_223_1) then
				if arg_220_1.var_.characterEffect102003ui_story and not isNil(var_223_1) then
					arg_220_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_2 and arg_220_1.time_ < 0 + var_223_2 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect102003ui_story then
				arg_220_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action438")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_223_4 = 0
			local var_223_5 = 0.2

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(924031052)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 8 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 8)

				if (8 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 8)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031052", "story_v_side_old_924031.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031052", "story_v_side_old_924031.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_side_old_924031", "924031052", "story_v_side_old_924031.awb")

						arg_220_1:RecordAudio("924031052", var_223_11)
						arg_220_1:RecordAudio("924031052", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031052", "story_v_side_old_924031.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031052", "story_v_side_old_924031.awb")
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

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play924031053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 924031053
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play924031054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["102003ui_story"]) and arg_224_1.var_.characterEffect102003ui_story == nil then
				arg_224_1.var_.characterEffect102003ui_story = arg_224_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["102003ui_story"]) then
				if arg_224_1.var_.characterEffect102003ui_story and not isNil(arg_224_1.actors_["102003ui_story"]) then
					arg_224_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_224_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_0)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["102003ui_story"]) and arg_224_1.var_.characterEffect102003ui_story then
				arg_224_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_224_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_227_1 = 0
			local var_227_2 = 0.4

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(924031053).content)

				arg_224_1.text_.text = var_227_3

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 16 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 16)

				if (16 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 16)) > 0 and var_227_2 < var_227_5 then
					arg_224_1.talkMaxDuration = var_227_5

					if var_227_5 + var_227_1 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + var_227_1
					end
				end

				arg_224_1.text_.text = var_227_3
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_6 = math.max(var_227_2, arg_224_1.talkMaxDuration)

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_6 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_1) / var_227_6

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_1 + var_227_6 and arg_224_1.time_ < var_227_1 + var_227_6 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play924031054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 924031054
		arg_228_1.duration_ = 6.57

		local var_228_0 = {
			zh = 4.866,
			ja = 6.566
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
				arg_228_0:Play924031055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos102003ui_story = arg_228_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_231_0 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 then
				arg_228_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_228_1.time_ - 0) / var_231_0)
				arg_228_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["102003ui_story"].transform.position).z)
				arg_228_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["102003ui_story"].transform.localEulerAngles = arg_228_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 then
				arg_228_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_228_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["102003ui_story"].transform.position).z)
				arg_228_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["102003ui_story"].transform.localEulerAngles = arg_228_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_231_1 = arg_228_1.actors_["102003ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect102003ui_story == nil then
				arg_228_1.var_.characterEffect102003ui_story = var_231_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_2 and not isNil(var_231_1) then
				if arg_228_1.var_.characterEffect102003ui_story and not isNil(var_231_1) then
					arg_228_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_2 and arg_228_1.time_ < 0 + var_231_2 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect102003ui_story then
				arg_228_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_2")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_231_4 = 0
			local var_231_5 = 0.325

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(924031054)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 13 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 13)

				if (13 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 13)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031054", "story_v_side_old_924031.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031054", "story_v_side_old_924031.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_side_old_924031", "924031054", "story_v_side_old_924031.awb")

						arg_228_1:RecordAudio("924031054", var_231_11)
						arg_228_1:RecordAudio("924031054", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031054", "story_v_side_old_924031.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031054", "story_v_side_old_924031.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play924031055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 924031055
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play924031056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos102003ui_story = arg_232_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["102003ui_story"].transform.position).z)
				arg_232_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["102003ui_story"].transform.localEulerAngles = arg_232_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["102003ui_story"].transform.position).z)
				arg_232_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["102003ui_story"].transform.localEulerAngles = arg_232_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["102003ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect102003ui_story == nil then
				arg_232_1.var_.characterEffect102003ui_story = var_235_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_2 and not isNil(var_235_1) then
				if arg_232_1.var_.characterEffect102003ui_story and not isNil(var_235_1) then
					arg_232_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_232_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_2)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_2 and arg_232_1.time_ < 0 + var_235_2 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect102003ui_story then
				arg_232_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_232_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_235_3 = 0
			local var_235_4 = 1.1

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_3 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_5 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(924031055).content)

				arg_232_1.text_.text = var_235_5

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_7 = 44 <= 0 and var_235_4 or var_235_4 * (utf8.len(var_235_5) / 44)

				if (44 <= 0 and var_235_4 or var_235_4 * (utf8.len(var_235_5) / 44)) > 0 and var_235_4 < var_235_7 then
					arg_232_1.talkMaxDuration = var_235_7

					if var_235_7 + var_235_3 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_3
					end
				end

				arg_232_1.text_.text = var_235_5
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_8 = math.max(var_235_4, arg_232_1.talkMaxDuration)

			if var_235_3 <= arg_232_1.time_ and arg_232_1.time_ < var_235_3 + var_235_8 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_3) / var_235_8

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_3 + var_235_8 and arg_232_1.time_ < var_235_3 + var_235_8 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 924031056
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play924031057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.3

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
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

				local var_239_1 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(924031056).content)

				arg_236_1.text_.text = var_239_1

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_3 = 12 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 12)

				if (12 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 12)) > 0 and var_239_0 < var_239_3 then
					arg_236_1.talkMaxDuration = var_239_3

					if var_239_3 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_3 + 0
					end
				end

				arg_236_1.text_.text = var_239_1
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_4 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_4

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play924031057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 924031057
		arg_240_1.duration_ = 6.8

		local var_240_0 = {
			zh = 6.8,
			ja = 5.566
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play924031058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos102003ui_story = arg_240_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos102003ui_story, Vector3.New(-0.09, -0.8, -7.6), (arg_240_1.time_ - 0) / var_243_0)
				arg_240_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["102003ui_story"].transform.position).z)
				arg_240_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["102003ui_story"].transform.localEulerAngles = arg_240_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(-0.09, -0.8, -7.6)
				arg_240_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["102003ui_story"].transform.position).z)
				arg_240_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["102003ui_story"].transform.localEulerAngles = arg_240_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_243_1 = arg_240_1.actors_["102003ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect102003ui_story == nil then
				arg_240_1.var_.characterEffect102003ui_story = var_243_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_2 and not isNil(var_243_1) then
				if arg_240_1.var_.characterEffect102003ui_story and not isNil(var_243_1) then
					arg_240_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_2 and arg_240_1.time_ < 0 + var_243_2 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect102003ui_story then
				arg_240_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_243_4 = 0
			local var_243_5 = 0.45

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_6 = arg_240_1:GetWordFromCfg(924031057)
				local var_243_7 = arg_240_1:FormatText(var_243_6.content)

				arg_240_1.text_.text = var_243_7

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_9 = 18 <= 0 and var_243_5 or var_243_5 * (utf8.len(var_243_7) / 18)

				if (18 <= 0 and var_243_5 or var_243_5 * (utf8.len(var_243_7) / 18)) > 0 and var_243_5 < var_243_9 then
					arg_240_1.talkMaxDuration = var_243_9

					if var_243_9 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_9 + var_243_4
					end
				end

				arg_240_1.text_.text = var_243_7
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031057", "story_v_side_old_924031.awb") ~= 0 then
					local var_243_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031057", "story_v_side_old_924031.awb") / 1000

					if var_243_10 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_4
					end

					if var_243_6.prefab_name ~= "" and arg_240_1.actors_[var_243_6.prefab_name] ~= nil then
						local var_243_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_6.prefab_name].transform, "story_v_side_old_924031", "924031057", "story_v_side_old_924031.awb")

						arg_240_1:RecordAudio("924031057", var_243_11)
						arg_240_1:RecordAudio("924031057", var_243_11)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031057", "story_v_side_old_924031.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031057", "story_v_side_old_924031.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_12 = math.max(var_243_5, arg_240_1.talkMaxDuration)

			if var_243_4 <= arg_240_1.time_ and arg_240_1.time_ < var_243_4 + var_243_12 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_4) / var_243_12

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_4 + var_243_12 and arg_240_1.time_ < var_243_4 + var_243_12 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play924031058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 924031058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play924031059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos102003ui_story = arg_244_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["102003ui_story"].transform.position).z)
				arg_244_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["102003ui_story"].transform.localEulerAngles = arg_244_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_244_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["102003ui_story"].transform.position).z)
				arg_244_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["102003ui_story"].transform.localEulerAngles = arg_244_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["102003ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect102003ui_story == nil then
				arg_244_1.var_.characterEffect102003ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.characterEffect102003ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_244_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_2)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect102003ui_story then
				arg_244_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_244_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_247_3 = 0
			local var_247_4 = 1.025

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_3 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_5 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(924031058).content)

				arg_244_1.text_.text = var_247_5

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_7 = 41 <= 0 and var_247_4 or var_247_4 * (utf8.len(var_247_5) / 41)

				if (41 <= 0 and var_247_4 or var_247_4 * (utf8.len(var_247_5) / 41)) > 0 and var_247_4 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_3 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_3
					end
				end

				arg_244_1.text_.text = var_247_5
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_8 = math.max(var_247_4, arg_244_1.talkMaxDuration)

			if var_247_3 <= arg_244_1.time_ and arg_244_1.time_ < var_247_3 + var_247_8 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_3) / var_247_8

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_3 + var_247_8 and arg_244_1.time_ < var_247_3 + var_247_8 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 924031059
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play924031060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 1.25

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(924031059).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 50 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 50)

				if (50 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 50)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play924031060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 924031060
		arg_252_1.duration_ = 4.3

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play924031061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 3.999999999999 < arg_252_1.time_ and arg_252_1.time_ <= 3.999999999999 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			if arg_252_1.time_ >= 3.999999999999 + 0.3 and arg_252_1.time_ < 3.999999999999 + 0.3 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			local var_255_0 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_1 = 2

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_1 then
				local var_255_2 = Color.New(0, 0, 0)

				var_255_2.a = Mathf.Lerp(0, 1, (arg_252_1.time_ - var_255_0) / var_255_1)
				arg_252_1.mask_.color = var_255_2
			end

			if arg_252_1.time_ >= var_255_0 + var_255_1 and arg_252_1.time_ < var_255_0 + var_255_1 + arg_255_0 then
				local var_255_3 = Color.New(0, 0, 0)

				var_255_3.a = 1
				arg_252_1.mask_.color = var_255_3
			end

			local var_255_4 = 2

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_5 = 2

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_5 then
				local var_255_6 = Color.New(0, 0, 0)

				var_255_6.a = Mathf.Lerp(1, 0, (arg_252_1.time_ - var_255_4) / var_255_5)
				arg_252_1.mask_.color = var_255_6
			end

			if arg_252_1.time_ >= var_255_4 + var_255_5 and arg_252_1.time_ < var_255_4 + var_255_5 + arg_255_0 then
				local var_255_7 = Color.New(0, 0, 0)

				arg_252_1.mask_.enabled = false
				var_255_7.a = 0
				arg_252_1.mask_.color = var_255_7
			end

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= 2 + arg_255_0 then
				arg_252_1.fswbg_:SetActive(true)
				arg_252_1.dialog_:SetActive(false)

				arg_252_1.fswtw_.percent = 0
				arg_252_1.fswt_.text = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(924031060).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.fswt_)

				arg_252_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_252_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_252_1.fswtw_:SetDirty()

				arg_252_1.typewritterCharCountI18N = 0

				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_252_1:ShowNextGo(false)
			end

			local var_255_8 = 2.06666666666667

			if 2.06666666666667 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.var_.oldValueTypewriter = arg_252_1.fswtw_.percent

				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_252_1:ShowNextGo(false)
			end

			local var_255_9 = 21
			local var_255_10 = 1.4
			local var_255_11, var_255_12 = arg_252_1:GetPercentByPara(arg_252_1:FormatText(arg_252_1:GetWordFromCfg(924031060).content), 1)

			if var_255_8 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				local var_255_13 = var_255_9 <= 0 and var_255_10 or var_255_10 * ((var_255_12 - arg_252_1.typewritterCharCountI18N) / var_255_9)

				if (var_255_9 <= 0 and var_255_10 or var_255_10 * ((var_255_12 - arg_252_1.typewritterCharCountI18N) / var_255_9)) > 0 and var_255_10 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_8
					end
				end
			end

			local var_255_14 = math.max(1.4, arg_252_1.talkMaxDuration)

			if var_255_8 <= arg_252_1.time_ and arg_252_1.time_ < var_255_8 + var_255_14 then
				arg_252_1.fswtw_.percent = Mathf.Lerp(arg_252_1.var_.oldValueTypewriter, var_255_11, (arg_252_1.time_ - var_255_8) / var_255_14)
				arg_252_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_252_1.fswtw_:SetDirty()
			end

			if arg_252_1.time_ >= var_255_8 + var_255_14 and arg_252_1.time_ < var_255_8 + var_255_14 + arg_255_0 then
				arg_252_1.fswtw_.percent = var_255_11

				arg_252_1.fswtw_:SetDirty()
				arg_252_1:ShowNextGo(true)

				arg_252_1.typewritterCharCountI18N = var_255_12
			end

			if 1.999999999999 < arg_252_1.time_ and arg_252_1.time_ <= 1.999999999999 + arg_255_0 then
				local var_255_15 = arg_252_1.bgs_.STblack

				arg_252_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_255_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_16 = var_255_15:GetComponent("SpriteRenderer")

				if var_255_16 and var_255_16.sprite then
					local var_255_17 = 2 * (var_255_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_255_15.transform.localScale = Vector3.New(var_255_17 / var_255_16.sprite.bounds.size.y < var_255_17 * manager.ui.mainCameraCom_.aspect / var_255_16.sprite.bounds.size.x and var_255_17 * manager.ui.mainCameraCom_.aspect / var_255_16.sprite.bounds.size.x or var_255_17 / var_255_16.sprite.bounds.size.y, var_255_17 / var_255_16.sprite.bounds.size.y < var_255_17 * manager.ui.mainCameraCom_.aspect / var_255_16.sprite.bounds.size.x and var_255_17 * manager.ui.mainCameraCom_.aspect / var_255_16.sprite.bounds.size.x or var_255_17 / var_255_16.sprite.bounds.size.y, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "STblack" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.999999999999 < arg_252_1.time_ and arg_252_1.time_ <= 1.999999999999 + arg_255_0 then
				local var_255_18 = arg_252_1.fswbg_.transform:Find("textbox/adapt/content") or arg_252_1.fswbg_.transform:Find("textbox/content")
				local var_255_19 = arg_252_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_255_20 = var_255_18:GetComponent("RectTransform")

				var_255_18:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_255_20.offsetMin = Vector2.New(0, 0)
				var_255_20.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play924031061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 924031061
		arg_256_1.duration_ = 2

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play924031062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_0 = 2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 then
				local var_259_1 = Color.New(0, 0, 0)

				var_259_1.a = Mathf.Lerp(1, 0, (arg_256_1.time_ - 0) / var_259_0)
				arg_256_1.mask_.color = var_259_1
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 then
				local var_259_2 = Color.New(0, 0, 0)

				arg_256_1.mask_.enabled = false
				var_259_2.a = 0
				arg_256_1.mask_.color = var_259_2
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.fswbg_:SetActive(true)
				arg_256_1.dialog_:SetActive(false)

				arg_256_1.fswtw_.percent = 0
				arg_256_1.fswt_.text = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(924031061).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.fswt_)

				arg_256_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_256_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_256_1.fswtw_:SetDirty()

				arg_256_1.typewritterCharCountI18N = 0

				SetActive(arg_256_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_256_1:ShowNextGo(false)
			end

			local var_259_3 = 0.0666666666666669

			if 0.0666666666666669 < arg_256_1.time_ and arg_256_1.time_ <= var_259_3 + arg_259_0 then
				arg_256_1.var_.oldValueTypewriter = arg_256_1.fswtw_.percent

				SetActive(arg_256_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_256_1:ShowNextGo(false)
			end

			local var_259_4 = 29
			local var_259_5 = 1.8
			local var_259_6, var_259_7 = arg_256_1:GetPercentByPara(arg_256_1:FormatText(arg_256_1:GetWordFromCfg(924031061).content), 1)

			if var_259_3 < arg_256_1.time_ and arg_256_1.time_ <= var_259_3 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				local var_259_8 = var_259_4 <= 0 and var_259_5 or var_259_5 * ((var_259_7 - arg_256_1.typewritterCharCountI18N) / var_259_4)

				if (var_259_4 <= 0 and var_259_5 or var_259_5 * ((var_259_7 - arg_256_1.typewritterCharCountI18N) / var_259_4)) > 0 and var_259_5 < var_259_8 then
					arg_256_1.talkMaxDuration = var_259_8

					if var_259_8 + var_259_3 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_3
					end
				end
			end

			local var_259_9 = math.max(1.8, arg_256_1.talkMaxDuration)

			if var_259_3 <= arg_256_1.time_ and arg_256_1.time_ < var_259_3 + var_259_9 then
				arg_256_1.fswtw_.percent = Mathf.Lerp(arg_256_1.var_.oldValueTypewriter, var_259_6, (arg_256_1.time_ - var_259_3) / var_259_9)
				arg_256_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_256_1.fswtw_:SetDirty()
			end

			if arg_256_1.time_ >= var_259_3 + var_259_9 and arg_256_1.time_ < var_259_3 + var_259_9 + arg_259_0 then
				arg_256_1.fswtw_.percent = var_259_6

				arg_256_1.fswtw_:SetDirty()
				arg_256_1:ShowNextGo(true)

				arg_256_1.typewritterCharCountI18N = var_259_7
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play924031062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 924031062
		arg_260_1.duration_ = 7

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play924031063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				local var_263_0 = arg_260_1.bgs_.STblack

				arg_260_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_263_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_1 = var_263_0:GetComponent("SpriteRenderer")

				if var_263_1 and var_263_1.sprite then
					local var_263_2 = 2 * (var_263_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_263_0.transform.localScale = Vector3.New(var_263_2 / var_263_1.sprite.bounds.size.y < var_263_2 * manager.ui.mainCameraCom_.aspect / var_263_1.sprite.bounds.size.x and var_263_2 * manager.ui.mainCameraCom_.aspect / var_263_1.sprite.bounds.size.x or var_263_2 / var_263_1.sprite.bounds.size.y, var_263_2 / var_263_1.sprite.bounds.size.y < var_263_2 * manager.ui.mainCameraCom_.aspect / var_263_1.sprite.bounds.size.x and var_263_2 * manager.ui.mainCameraCom_.aspect / var_263_1.sprite.bounds.size.x or var_263_2 / var_263_1.sprite.bounds.size.y, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "STblack" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_3 = 2

			if 2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_3 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			if arg_260_1.time_ >= var_263_3 + 0.3 and arg_260_1.time_ < var_263_3 + 0.3 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end

			local var_263_4 = 0

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_5 = 2

			if var_263_4 <= arg_260_1.time_ and arg_260_1.time_ < var_263_4 + var_263_5 then
				local var_263_6 = Color.New(0, 0, 0)

				var_263_6.a = Mathf.Lerp(1, 0, (arg_260_1.time_ - var_263_4) / var_263_5)
				arg_260_1.mask_.color = var_263_6
			end

			if arg_260_1.time_ >= var_263_4 + var_263_5 and arg_260_1.time_ < var_263_4 + var_263_5 + arg_263_0 then
				local var_263_7 = Color.New(0, 0, 0)

				arg_260_1.mask_.enabled = false
				var_263_7.a = 0
				arg_260_1.mask_.color = var_263_7
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.fswbg_:SetActive(false)
				arg_260_1.dialog_:SetActive(false)
				SetActive(arg_260_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_260_1:ShowNextGo(false)
			end

			if 0.166666666666667 < arg_260_1.time_ and arg_260_1.time_ <= 0.166666666666667 + arg_263_0 then
				arg_260_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_sea", "")
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_9 = 2
			local var_263_10 = 0.85

			if 2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_9 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_11 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_11:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_260_1.dialogCg_.alpha = arg_264_0
				end))
				var_263_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_12 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(924031062).content)

				arg_260_1.text_.text = var_263_12

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_14 = 34 <= 0 and var_263_10 or var_263_10 * (utf8.len(var_263_12) / 34)

				if (34 <= 0 and var_263_10 or var_263_10 * (utf8.len(var_263_12) / 34)) > 0 and var_263_10 < var_263_14 then
					arg_260_1.talkMaxDuration = var_263_14
					var_263_9 = var_263_9 + 0.3

					if var_263_14 + var_263_9 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_14 + var_263_9
					end
				end

				arg_260_1.text_.text = var_263_12
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_15 = var_263_9 + 0.3
			local var_263_16 = math.max(var_263_10, arg_260_1.talkMaxDuration)

			if var_263_9 + 0.3 <= arg_260_1.time_ and arg_260_1.time_ < var_263_15 + var_263_16 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_15) / var_263_16

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_15 + var_263_16 and arg_260_1.time_ < var_263_15 + var_263_16 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play924031063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 924031063
		arg_266_1.duration_ = 9.7

		local var_266_0 = {
			zh = 7.599999999999,
			ja = 9.699999999999
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play924031064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if arg_266_1.bgs_.I17i == nil then
				local var_269_0 = Object.Instantiate(arg_266_1.paintGo_)

				var_269_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I17i")
				var_269_0.name = "I17i"
				var_269_0.transform.parent = arg_266_1.stage_.transform
				var_269_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.bgs_.I17i = var_269_0
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				local var_269_1 = arg_266_1.bgs_.I17i

				arg_266_1.bgs_.I17i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_269_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_269_2 = var_269_1:GetComponent("SpriteRenderer")

				if var_269_2 and var_269_2.sprite then
					local var_269_3 = 2 * (var_269_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_269_1.transform.localScale = Vector3.New(var_269_3 / var_269_2.sprite.bounds.size.y < var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x and var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x or var_269_3 / var_269_2.sprite.bounds.size.y, var_269_3 / var_269_2.sprite.bounds.size.y < var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x and var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x or var_269_3 / var_269_2.sprite.bounds.size.y, 0)
				end

				for iter_269_0, iter_269_1 in pairs(arg_266_1.bgs_) do
					if iter_269_0 ~= "I17i" then
						iter_269_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_269_4 = 1.999999999999

			if 1.999999999999 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.allBtn_.enabled = false
			end

			if arg_266_1.time_ >= var_269_4 + 0.3 and arg_266_1.time_ < var_269_4 + 0.3 + arg_269_0 then
				arg_266_1.allBtn_.enabled = true
			end

			local var_269_5 = 0

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.mask_.enabled = true
				arg_266_1.mask_.raycastTarget = true

				arg_266_1:SetGaussion(false)
			end

			local var_269_6 = 2

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_6 then
				local var_269_7 = Color.New(0, 0, 0)

				var_269_7.a = Mathf.Lerp(1, 0, (arg_266_1.time_ - var_269_5) / var_269_6)
				arg_266_1.mask_.color = var_269_7
			end

			if arg_266_1.time_ >= var_269_5 + var_269_6 and arg_266_1.time_ < var_269_5 + var_269_6 + arg_269_0 then
				local var_269_8 = Color.New(0, 0, 0)

				arg_266_1.mask_.enabled = false
				var_269_8.a = 0
				arg_266_1.mask_.color = var_269_8
			end

			local var_269_9 = arg_266_1.actors_["102003ui_story"].transform

			if 1.8 < arg_266_1.time_ and arg_266_1.time_ <= 1.8 + arg_269_0 then
				arg_266_1.var_.moveOldPos102003ui_story = var_269_9.localPosition
			end

			local var_269_10 = 0.001

			if 1.8 <= arg_266_1.time_ and arg_266_1.time_ < 1.8 + var_269_10 then
				var_269_9.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_266_1.time_ - 1.8) / var_269_10)
				var_269_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_9.position).x, (manager.ui.mainCamera.transform.position - var_269_9.position).y, (manager.ui.mainCamera.transform.position - var_269_9.position).z)
				var_269_9.localEulerAngles.z = 0
				var_269_9.localEulerAngles.x = 0
				var_269_9.localEulerAngles = var_269_9.localEulerAngles
			end

			if arg_266_1.time_ >= 1.8 + var_269_10 and arg_266_1.time_ < 1.8 + var_269_10 + arg_269_0 then
				var_269_9.localPosition = Vector3.New(0, -0.85, -6.21)
				var_269_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_9.position).x, (manager.ui.mainCamera.transform.position - var_269_9.position).y, (manager.ui.mainCamera.transform.position - var_269_9.position).z)
				var_269_9.localEulerAngles.z = 0
				var_269_9.localEulerAngles.x = 0
				var_269_9.localEulerAngles = var_269_9.localEulerAngles
			end

			local var_269_11 = arg_266_1.actors_["102003ui_story"]

			if 1.8 < arg_266_1.time_ and arg_266_1.time_ <= 1.8 + arg_269_0 and not isNil(var_269_11) and arg_266_1.var_.characterEffect102003ui_story == nil then
				arg_266_1.var_.characterEffect102003ui_story = var_269_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_12 = 0.200000002980232

			if 1.8 <= arg_266_1.time_ and arg_266_1.time_ < 1.8 + var_269_12 and not isNil(var_269_11) then
				if arg_266_1.var_.characterEffect102003ui_story and not isNil(var_269_11) then
					arg_266_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 1.8 + var_269_12 and arg_266_1.time_ < 1.8 + var_269_12 + arg_269_0 and not isNil(var_269_11) and arg_266_1.var_.characterEffect102003ui_story then
				arg_266_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 1.8 < arg_266_1.time_ and arg_266_1.time_ <= 1.8 + arg_269_0 then
				arg_266_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 1.8 < arg_266_1.time_ and arg_266_1.time_ <= 1.8 + arg_269_0 then
				arg_266_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0.125 < arg_266_1.time_ and arg_266_1.time_ <= 0.125 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_266_1.frameCnt_ <= 1 then
				arg_266_1.dialog_:SetActive(false)
			end

			local var_269_15 = 1.999999999999
			local var_269_16 = 0.725

			if 1.999999999999 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0

				arg_266_1.dialog_:SetActive(true)

				arg_266_1.dialogCg_.alpha = 0

				local var_269_17 = LeanTween.value(arg_266_1.dialog_, 0, 1, 0.3)

				var_269_17:setOnUpdate(LuaHelper.FloatAction(function(arg_270_0)
					arg_266_1.dialogCg_.alpha = arg_270_0
				end))
				var_269_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_266_1.dialog_)
					var_269_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_266_1.duration_ = arg_266_1.duration_ + 0.3

				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_18 = arg_266_1:GetWordFromCfg(924031063)
				local var_269_19 = arg_266_1:FormatText(var_269_18.content)

				arg_266_1.text_.text = var_269_19

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_21 = 29 <= 0 and var_269_16 or var_269_16 * (utf8.len(var_269_19) / 29)

				if (29 <= 0 and var_269_16 or var_269_16 * (utf8.len(var_269_19) / 29)) > 0 and var_269_16 < var_269_21 then
					arg_266_1.talkMaxDuration = var_269_21
					var_269_15 = var_269_15 + 0.3

					if var_269_21 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_21 + var_269_15
					end
				end

				arg_266_1.text_.text = var_269_19
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031063", "story_v_side_old_924031.awb") ~= 0 then
					local var_269_22 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031063", "story_v_side_old_924031.awb") / 1000

					if var_269_22 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_22 + var_269_15
					end

					if var_269_18.prefab_name ~= "" and arg_266_1.actors_[var_269_18.prefab_name] ~= nil then
						local var_269_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_18.prefab_name].transform, "story_v_side_old_924031", "924031063", "story_v_side_old_924031.awb")

						arg_266_1:RecordAudio("924031063", var_269_23)
						arg_266_1:RecordAudio("924031063", var_269_23)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031063", "story_v_side_old_924031.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031063", "story_v_side_old_924031.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_24 = var_269_15 + 0.3
			local var_269_25 = math.max(var_269_16, arg_266_1.talkMaxDuration)

			if var_269_15 + 0.3 <= arg_266_1.time_ and arg_266_1.time_ < var_269_24 + var_269_25 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_24) / var_269_25

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_24 + var_269_25 and arg_266_1.time_ < var_269_24 + var_269_25 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play924031064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 924031064
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play924031065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["102003ui_story"]) and arg_272_1.var_.characterEffect102003ui_story == nil then
				arg_272_1.var_.characterEffect102003ui_story = arg_272_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["102003ui_story"]) then
				if arg_272_1.var_.characterEffect102003ui_story and not isNil(arg_272_1.actors_["102003ui_story"]) then
					arg_272_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_272_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_272_1.time_ - 0) / var_275_0)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["102003ui_story"]) and arg_272_1.var_.characterEffect102003ui_story then
				arg_272_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_272_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_275_1 = 0
			local var_275_2 = 0.7

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(924031064).content)

				arg_272_1.text_.text = var_275_3

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 28 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_3) / 28)

				if (28 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_3) / 28)) > 0 and var_275_2 < var_275_5 then
					arg_272_1.talkMaxDuration = var_275_5

					if var_275_5 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + var_275_1
					end
				end

				arg_272_1.text_.text = var_275_3
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_6 = math.max(var_275_2, arg_272_1.talkMaxDuration)

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_6 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_1) / var_275_6

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_1 + var_275_6 and arg_272_1.time_ < var_275_1 + var_275_6 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play924031065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 924031065
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play924031066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos102003ui_story = arg_276_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_279_0 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 then
				arg_276_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_276_1.time_ - 0) / var_279_0)
				arg_276_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["102003ui_story"].transform.position).z)
				arg_276_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["102003ui_story"].transform.localEulerAngles = arg_276_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 then
				arg_276_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_276_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["102003ui_story"].transform.position).z)
				arg_276_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["102003ui_story"].transform.localEulerAngles = arg_276_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_279_1 = 0
			local var_279_2 = 1.15

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_3 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(924031065).content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 46 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 46)

				if (46 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 46)) > 0 and var_279_2 < var_279_5 then
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

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play924031066 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 924031066
		arg_280_1.duration_ = 6.53

		local var_280_0 = {
			zh = 5.066,
			ja = 6.533
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play924031067(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos102003ui_story = arg_280_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_283_0 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 then
				arg_280_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_280_1.time_ - 0) / var_283_0)
				arg_280_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).z)
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles = arg_280_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 then
				arg_280_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_280_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).z)
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles = arg_280_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_283_1 = arg_280_1.actors_["102003ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect102003ui_story == nil then
				arg_280_1.var_.characterEffect102003ui_story = var_283_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_2 and not isNil(var_283_1) then
				if arg_280_1.var_.characterEffect102003ui_story and not isNil(var_283_1) then
					arg_280_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_2 and arg_280_1.time_ < 0 + var_283_2 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect102003ui_story then
				arg_280_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_1")
			end

			local var_283_4 = 0
			local var_283_5 = 0.525

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_6 = arg_280_1:GetWordFromCfg(924031066)
				local var_283_7 = arg_280_1:FormatText(var_283_6.content)

				arg_280_1.text_.text = var_283_7

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 22 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 22)

				if (22 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 22)) > 0 and var_283_5 < var_283_9 then
					arg_280_1.talkMaxDuration = var_283_9

					if var_283_9 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_9 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_7
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031066", "story_v_side_old_924031.awb") ~= 0 then
					local var_283_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031066", "story_v_side_old_924031.awb") / 1000

					if var_283_10 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_10 + var_283_4
					end

					if var_283_6.prefab_name ~= "" and arg_280_1.actors_[var_283_6.prefab_name] ~= nil then
						local var_283_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_6.prefab_name].transform, "story_v_side_old_924031", "924031066", "story_v_side_old_924031.awb")

						arg_280_1:RecordAudio("924031066", var_283_11)
						arg_280_1:RecordAudio("924031066", var_283_11)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031066", "story_v_side_old_924031.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031066", "story_v_side_old_924031.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_12 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_4 <= arg_280_1.time_ and arg_280_1.time_ < var_283_4 + var_283_12 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_4) / var_283_12

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_4 + var_283_12 and arg_280_1.time_ < var_283_4 + var_283_12 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play924031067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 924031067
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play924031068(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos102003ui_story = arg_284_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_287_0 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 then
				arg_284_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_284_1.time_ - 0) / var_287_0)
				arg_284_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["102003ui_story"].transform.position).z)
				arg_284_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["102003ui_story"].transform.localEulerAngles = arg_284_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 then
				arg_284_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_284_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["102003ui_story"].transform.position).z)
				arg_284_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["102003ui_story"].transform.localEulerAngles = arg_284_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_287_1 = arg_284_1.actors_["102003ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect102003ui_story == nil then
				arg_284_1.var_.characterEffect102003ui_story = var_287_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_2 and not isNil(var_287_1) then
				if arg_284_1.var_.characterEffect102003ui_story and not isNil(var_287_1) then
					arg_284_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_284_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_2)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_2 and arg_284_1.time_ < 0 + var_287_2 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect102003ui_story then
				arg_284_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_284_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_287_3 = 0
			local var_287_4 = 0.7

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_3 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_5 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(924031067).content)

				arg_284_1.text_.text = var_287_5

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 28 <= 0 and var_287_4 or var_287_4 * (utf8.len(var_287_5) / 28)

				if (28 <= 0 and var_287_4 or var_287_4 * (utf8.len(var_287_5) / 28)) > 0 and var_287_4 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_3 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_3
					end
				end

				arg_284_1.text_.text = var_287_5
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_8 = math.max(var_287_4, arg_284_1.talkMaxDuration)

			if var_287_3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_3 + var_287_8 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_3) / var_287_8

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_3 + var_287_8 and arg_284_1.time_ < var_287_3 + var_287_8 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play924031068 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 924031068
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play924031069(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0.4

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_1 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(924031068).content)

				arg_288_1.text_.text = var_291_1

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_3 = 16 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_1) / 16)

				if (16 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_1) / 16)) > 0 and var_291_0 < var_291_3 then
					arg_288_1.talkMaxDuration = var_291_3

					if var_291_3 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_3 + 0
					end
				end

				arg_288_1.text_.text = var_291_1
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_4 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_4 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_4

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_4 and arg_288_1.time_ < 0 + var_291_4 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play924031069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 924031069
		arg_292_1.duration_ = 3.4

		local var_292_0 = {
			zh = 1.566,
			ja = 3.4
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play924031070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos102003ui_story = arg_292_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_295_0 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 then
				arg_292_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_292_1.time_ - 0) / var_295_0)
				arg_292_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["102003ui_story"].transform.position).z)
				arg_292_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["102003ui_story"].transform.localEulerAngles = arg_292_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 then
				arg_292_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_292_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["102003ui_story"].transform.position).z)
				arg_292_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["102003ui_story"].transform.localEulerAngles = arg_292_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_295_1 = arg_292_1.actors_["102003ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect102003ui_story == nil then
				arg_292_1.var_.characterEffect102003ui_story = var_295_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_2 and not isNil(var_295_1) then
				if arg_292_1.var_.characterEffect102003ui_story and not isNil(var_295_1) then
					arg_292_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_2 and arg_292_1.time_ < 0 + var_295_2 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect102003ui_story then
				arg_292_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_295_4 = 0
			local var_295_5 = 0.175

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_6 = arg_292_1:GetWordFromCfg(924031069)
				local var_295_7 = arg_292_1:FormatText(var_295_6.content)

				arg_292_1.text_.text = var_295_7

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_9 = 7 <= 0 and var_295_5 or var_295_5 * (utf8.len(var_295_7) / 7)

				if (7 <= 0 and var_295_5 or var_295_5 * (utf8.len(var_295_7) / 7)) > 0 and var_295_5 < var_295_9 then
					arg_292_1.talkMaxDuration = var_295_9

					if var_295_9 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_9 + var_295_4
					end
				end

				arg_292_1.text_.text = var_295_7
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031069", "story_v_side_old_924031.awb") ~= 0 then
					local var_295_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031069", "story_v_side_old_924031.awb") / 1000

					if var_295_10 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_4
					end

					if var_295_6.prefab_name ~= "" and arg_292_1.actors_[var_295_6.prefab_name] ~= nil then
						local var_295_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_6.prefab_name].transform, "story_v_side_old_924031", "924031069", "story_v_side_old_924031.awb")

						arg_292_1:RecordAudio("924031069", var_295_11)
						arg_292_1:RecordAudio("924031069", var_295_11)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031069", "story_v_side_old_924031.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031069", "story_v_side_old_924031.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_12 = math.max(var_295_5, arg_292_1.talkMaxDuration)

			if var_295_4 <= arg_292_1.time_ and arg_292_1.time_ < var_295_4 + var_295_12 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_4) / var_295_12

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_4 + var_295_12 and arg_292_1.time_ < var_295_4 + var_295_12 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play924031070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 924031070
		arg_296_1.duration_ = 9

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play924031071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_9000

			if arg_296_1.bgs_["I17f "] == nil then
				local var_299_0 = Object.Instantiate(arg_296_1.paintGo_)

				var_299_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I17f ")
				var_299_0.name = "I17f "
				var_299_0.transform.parent = arg_296_1.stage_.transform
				var_299_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.bgs_["I17f "] = var_299_0
			end

			if 2 < arg_296_1.time_ and arg_296_1.time_ <= 2 + arg_299_0 then
				local var_299_1 = arg_296_1.bgs_["I17f "]

				arg_296_1.bgs_["I17f "].transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_299_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_299_2 = var_299_1:GetComponent("SpriteRenderer")

				if var_299_2 and var_299_2.sprite then
					local var_299_3 = 2 * (var_299_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_299_1.transform.localScale = Vector3.New(var_299_3 / var_299_2.sprite.bounds.size.y < var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x and var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x or var_299_3 / var_299_2.sprite.bounds.size.y, var_299_3 / var_299_2.sprite.bounds.size.y < var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x and var_299_3 * manager.ui.mainCameraCom_.aspect / var_299_2.sprite.bounds.size.x or var_299_3 / var_299_2.sprite.bounds.size.y, 0)
				end

				for iter_299_0, iter_299_1 in pairs(arg_296_1.bgs_) do
					if iter_299_0 ~= "I17f " then
						iter_299_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_299_4 = 4

			if 4 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			if arg_296_1.time_ >= var_299_4 + 0.3 and arg_296_1.time_ < var_299_4 + 0.3 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end

			local var_299_5 = 0

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_6 = 2

			if var_299_5 <= arg_296_1.time_ and arg_296_1.time_ < var_299_5 + var_299_6 then
				local var_299_7 = Color.New(0, 0, 0)

				var_299_7.a = Mathf.Lerp(0, 1, (arg_296_1.time_ - var_299_5) / var_299_6)
				arg_296_1.mask_.color = var_299_7
			end

			if arg_296_1.time_ >= var_299_5 + var_299_6 and arg_296_1.time_ < var_299_5 + var_299_6 + arg_299_0 then
				local var_299_8 = Color.New(0, 0, 0)

				var_299_8.a = 1
				arg_296_1.mask_.color = var_299_8
			end

			local var_299_9 = 2

			if 2 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_10 = 2

			if var_299_9 <= arg_296_1.time_ and arg_296_1.time_ < var_299_9 + var_299_10 then
				local var_299_11 = Color.New(0, 0, 0)

				var_299_11.a = Mathf.Lerp(1, 0, (arg_296_1.time_ - var_299_9) / var_299_10)
				arg_296_1.mask_.color = var_299_11
			end

			if arg_296_1.time_ >= var_299_9 + var_299_10 and arg_296_1.time_ < var_299_9 + var_299_10 + arg_299_0 then
				local var_299_12 = Color.New(0, 0, 0)

				arg_296_1.mask_.enabled = false
				var_299_12.a = 0
				arg_296_1.mask_.color = var_299_12
			end

			local var_299_13 = arg_296_1.actors_["102003ui_story"].transform

			if 1.96599999815226 < arg_296_1.time_ and arg_296_1.time_ <= 1.96599999815226 + arg_299_0 then
				arg_296_1.var_.moveOldPos102003ui_story = var_299_13.localPosition
			end

			local var_299_14 = 0.001

			if 1.96599999815226 <= arg_296_1.time_ and arg_296_1.time_ < 1.96599999815226 + var_299_14 then
				var_299_13.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 1.96599999815226) / var_299_14)
				var_299_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_13.position).x, (manager.ui.mainCamera.transform.position - var_299_13.position).y, (manager.ui.mainCamera.transform.position - var_299_13.position).z)
				var_299_13.localEulerAngles.z = 0
				var_299_13.localEulerAngles.x = 0
				var_299_13.localEulerAngles = var_299_13.localEulerAngles
			end

			if arg_296_1.time_ >= 1.96599999815226 + var_299_14 and arg_296_1.time_ < 1.96599999815226 + var_299_14 + arg_299_0 then
				var_299_13.localPosition = Vector3.New(0, 100, 0)
				var_299_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_13.position).x, (manager.ui.mainCamera.transform.position - var_299_13.position).y, (manager.ui.mainCamera.transform.position - var_299_13.position).z)
				var_299_13.localEulerAngles.z = 0
				var_299_13.localEulerAngles.x = 0
				var_299_13.localEulerAngles = var_299_13.localEulerAngles
			end

			local var_299_15 = arg_296_1.actors_["102003ui_story"]

			if 1.96599999815226 < arg_296_1.time_ and arg_296_1.time_ <= 1.96599999815226 + arg_299_0 and not isNil(var_299_15) and arg_296_1.var_.characterEffect102003ui_story == nil then
				arg_296_1.var_.characterEffect102003ui_story = var_299_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_16 = 0.034000001847744

			if 1.96599999815226 <= arg_296_1.time_ and arg_296_1.time_ < 1.96599999815226 + var_299_16 and not isNil(var_299_15) then
				if arg_296_1.var_.characterEffect102003ui_story and not isNil(var_299_15) then
					arg_296_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_296_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 1.96599999815226) / var_299_16)
				end
			end

			if arg_296_1.time_ >= 1.96599999815226 + var_299_16 and arg_296_1.time_ < 1.96599999815226 + var_299_16 + arg_299_0 and not isNil(var_299_15) and arg_296_1.var_.characterEffect102003ui_story then
				arg_296_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_296_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 2 < arg_296_1.time_ and arg_296_1.time_ <= 2 + arg_299_0 then
				local var_299_17 = arg_296_1.var_.effectbingjing1

				if not arg_296_1.var_.effectbingjing1 then
					var_299_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), manager.ui.mainCamera.transform)
					var_299_17.name = "bingjing1"
					arg_296_1.var_.effectbingjing1 = var_299_17
				else
					var_299_17.transform:SetParent(var_299_9000)
				end

				var_299_17.transform.localPosition = Vector3.New(0, 0, -8)
				var_299_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_296_1.frameCnt_ <= 1 then
				arg_296_1.dialog_:SetActive(false)
			end

			local var_299_19 = 4
			local var_299_20 = 1.225

			if 4 < arg_296_1.time_ and arg_296_1.time_ <= var_299_19 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0

				arg_296_1.dialog_:SetActive(true)

				arg_296_1.dialogCg_.alpha = 0

				local var_299_21 = LeanTween.value(arg_296_1.dialog_, 0, 1, 0.3)

				var_299_21:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_296_1.dialogCg_.alpha = arg_300_0
				end))
				var_299_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_296_1.dialog_)
					var_299_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_296_1.duration_ = arg_296_1.duration_ + 0.3

				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_22 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(924031070).content)

				arg_296_1.text_.text = var_299_22

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_24 = 49 <= 0 and var_299_20 or var_299_20 * (utf8.len(var_299_22) / 49)

				if (49 <= 0 and var_299_20 or var_299_20 * (utf8.len(var_299_22) / 49)) > 0 and var_299_20 < var_299_24 then
					arg_296_1.talkMaxDuration = var_299_24
					var_299_19 = var_299_19 + 0.3

					if var_299_24 + var_299_19 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_24 + var_299_19
					end
				end

				arg_296_1.text_.text = var_299_22
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_25 = var_299_19 + 0.3
			local var_299_26 = math.max(var_299_20, arg_296_1.talkMaxDuration)

			if var_299_19 + 0.3 <= arg_296_1.time_ and arg_296_1.time_ < var_299_25 + var_299_26 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_25) / var_299_26

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_25 + var_299_26 and arg_296_1.time_ < var_299_25 + var_299_26 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play924031071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 924031071
		arg_302_1.duration_ = 9

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play924031072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if arg_302_1.bgs_.I17l == nil then
				local var_305_0 = Object.Instantiate(arg_302_1.paintGo_)

				var_305_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I17l")
				var_305_0.name = "I17l"
				var_305_0.transform.parent = arg_302_1.stage_.transform
				var_305_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_302_1.bgs_.I17l = var_305_0
			end

			if 2 < arg_302_1.time_ and arg_302_1.time_ <= 2 + arg_305_0 then
				local var_305_1 = arg_302_1.bgs_.I17l

				arg_302_1.bgs_.I17l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_305_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_305_2 = var_305_1:GetComponent("SpriteRenderer")

				if var_305_2 and var_305_2.sprite then
					local var_305_3 = 2 * (var_305_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_305_1.transform.localScale = Vector3.New(var_305_3 / var_305_2.sprite.bounds.size.y < var_305_3 * manager.ui.mainCameraCom_.aspect / var_305_2.sprite.bounds.size.x and var_305_3 * manager.ui.mainCameraCom_.aspect / var_305_2.sprite.bounds.size.x or var_305_3 / var_305_2.sprite.bounds.size.y, var_305_3 / var_305_2.sprite.bounds.size.y < var_305_3 * manager.ui.mainCameraCom_.aspect / var_305_2.sprite.bounds.size.x and var_305_3 * manager.ui.mainCameraCom_.aspect / var_305_2.sprite.bounds.size.x or var_305_3 / var_305_2.sprite.bounds.size.y, 0)
				end

				for iter_305_0, iter_305_1 in pairs(arg_302_1.bgs_) do
					if iter_305_0 ~= "I17l" then
						iter_305_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_305_4 = 4

			if 4 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.allBtn_.enabled = false
			end

			if arg_302_1.time_ >= var_305_4 + 0.3 and arg_302_1.time_ < var_305_4 + 0.3 + arg_305_0 then
				arg_302_1.allBtn_.enabled = true
			end

			local var_305_5 = 0

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1.mask_.enabled = true
				arg_302_1.mask_.raycastTarget = true

				arg_302_1:SetGaussion(false)
			end

			local var_305_6 = 2

			if var_305_5 <= arg_302_1.time_ and arg_302_1.time_ < var_305_5 + var_305_6 then
				local var_305_7 = Color.New(0, 0, 0)

				var_305_7.a = Mathf.Lerp(0, 1, (arg_302_1.time_ - var_305_5) / var_305_6)
				arg_302_1.mask_.color = var_305_7
			end

			if arg_302_1.time_ >= var_305_5 + var_305_6 and arg_302_1.time_ < var_305_5 + var_305_6 + arg_305_0 then
				local var_305_8 = Color.New(0, 0, 0)

				var_305_8.a = 1
				arg_302_1.mask_.color = var_305_8
			end

			local var_305_9 = 2

			if 2 < arg_302_1.time_ and arg_302_1.time_ <= var_305_9 + arg_305_0 then
				arg_302_1.mask_.enabled = true
				arg_302_1.mask_.raycastTarget = true

				arg_302_1:SetGaussion(false)
			end

			local var_305_10 = 2

			if var_305_9 <= arg_302_1.time_ and arg_302_1.time_ < var_305_9 + var_305_10 then
				local var_305_11 = Color.New(0, 0, 0)

				var_305_11.a = Mathf.Lerp(1, 0, (arg_302_1.time_ - var_305_9) / var_305_10)
				arg_302_1.mask_.color = var_305_11
			end

			if arg_302_1.time_ >= var_305_9 + var_305_10 and arg_302_1.time_ < var_305_9 + var_305_10 + arg_305_0 then
				local var_305_12 = Color.New(0, 0, 0)

				arg_302_1.mask_.enabled = false
				var_305_12.a = 0
				arg_302_1.mask_.color = var_305_12
			end

			if 1.9 < arg_302_1.time_ and arg_302_1.time_ <= 1.9 + arg_305_0 then
				if arg_302_1.var_.effectbingjing1 then
					Object.Destroy(arg_302_1.var_.effectbingjing1)

					arg_302_1.var_.effectbingjing1 = nil
				end
			end

			if arg_302_1.frameCnt_ <= 1 then
				arg_302_1.dialog_:SetActive(false)
			end

			local var_305_14 = 4
			local var_305_15 = 1.125

			if 4 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				arg_302_1.dialog_:SetActive(true)

				arg_302_1.dialogCg_.alpha = 0

				local var_305_16 = LeanTween.value(arg_302_1.dialog_, 0, 1, 0.3)

				var_305_16:setOnUpdate(LuaHelper.FloatAction(function(arg_306_0)
					arg_302_1.dialogCg_.alpha = arg_306_0
				end))
				var_305_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_302_1.dialog_)
					var_305_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_302_1.duration_ = arg_302_1.duration_ + 0.3

				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_17 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(924031071).content)

				arg_302_1.text_.text = var_305_17

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_19 = 45 <= 0 and var_305_15 or var_305_15 * (utf8.len(var_305_17) / 45)

				if (45 <= 0 and var_305_15 or var_305_15 * (utf8.len(var_305_17) / 45)) > 0 and var_305_15 < var_305_19 then
					arg_302_1.talkMaxDuration = var_305_19
					var_305_14 = var_305_14 + 0.3

					if var_305_19 + var_305_14 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_19 + var_305_14
					end
				end

				arg_302_1.text_.text = var_305_17
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_20 = var_305_14 + 0.3
			local var_305_21 = math.max(var_305_15, arg_302_1.talkMaxDuration)

			if var_305_14 + 0.3 <= arg_302_1.time_ and arg_302_1.time_ < var_305_20 + var_305_21 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_20) / var_305_21

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_20 + var_305_21 and arg_302_1.time_ < var_305_20 + var_305_21 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play924031072 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 924031072
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play924031073(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0.625

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
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

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_1 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(924031072).content)

				arg_308_1.text_.text = var_311_1

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_3 = 25 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 25)

				if (25 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 25)) > 0 and var_311_0 < var_311_3 then
					arg_308_1.talkMaxDuration = var_311_3

					if var_311_3 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_3 + 0
					end
				end

				arg_308_1.text_.text = var_311_1
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_4 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_4

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play924031073 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 924031073
		arg_312_1.duration_ = 4.87

		local var_312_0 = {
			zh = 2.8,
			ja = 4.866
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play924031074(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.225

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102003")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_1 = arg_312_1:GetWordFromCfg(924031073)
				local var_315_2 = arg_312_1:FormatText(var_315_1.content)

				arg_312_1.text_.text = var_315_2

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 9 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 9)

				if (9 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 9)) > 0 and var_315_0 < var_315_4 then
					arg_312_1.talkMaxDuration = var_315_4

					if var_315_4 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_4 + 0
					end
				end

				arg_312_1.text_.text = var_315_2
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031073", "story_v_side_old_924031.awb") ~= 0 then
					local var_315_5 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031073", "story_v_side_old_924031.awb") / 1000

					if var_315_5 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + 0
					end

					if var_315_1.prefab_name ~= "" and arg_312_1.actors_[var_315_1.prefab_name] ~= nil then
						local var_315_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_1.prefab_name].transform, "story_v_side_old_924031", "924031073", "story_v_side_old_924031.awb")

						arg_312_1:RecordAudio("924031073", var_315_6)
						arg_312_1:RecordAudio("924031073", var_315_6)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031073", "story_v_side_old_924031.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031073", "story_v_side_old_924031.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_7 and arg_312_1.time_ < 0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play924031074 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 924031074
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play924031075(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["102003ui_story"]) and arg_316_1.var_.characterEffect102003ui_story == nil then
				arg_316_1.var_.characterEffect102003ui_story = arg_316_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["102003ui_story"]) then
				if arg_316_1.var_.characterEffect102003ui_story and not isNil(arg_316_1.actors_["102003ui_story"]) then
					arg_316_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_316_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_0)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["102003ui_story"]) and arg_316_1.var_.characterEffect102003ui_story then
				arg_316_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_316_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_319_1 = 0
			local var_319_2 = 0.15

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

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(924031074).content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 6 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 6)

				if (6 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 6)) > 0 and var_319_2 < var_319_5 then
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
	Play924031075 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 924031075
		arg_320_1.duration_ = 8.1

		local var_320_0 = {
			zh = 3.8,
			ja = 8.1
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play924031076(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.425

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102003")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_1 = arg_320_1:GetWordFromCfg(924031075)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 17 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 17)

				if (17 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 17)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031075", "story_v_side_old_924031.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031075", "story_v_side_old_924031.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_side_old_924031", "924031075", "story_v_side_old_924031.awb")

						arg_320_1:RecordAudio("924031075", var_323_6)
						arg_320_1:RecordAudio("924031075", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031075", "story_v_side_old_924031.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031075", "story_v_side_old_924031.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play924031076 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 924031076
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play924031077(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.85

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(924031076).content)

				arg_324_1.text_.text = var_327_1

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_3 = 34 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 34)

				if (34 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 34)) > 0 and var_327_0 < var_327_3 then
					arg_324_1.talkMaxDuration = var_327_3

					if var_327_3 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_3 + 0
					end
				end

				arg_324_1.text_.text = var_327_1
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_4 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_4

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play924031077 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 924031077
		arg_328_1.duration_ = 11.1

		local var_328_0 = {
			zh = 8.8,
			ja = 11.1
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play924031078(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.7

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102003")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_1 = arg_328_1:GetWordFromCfg(924031077)
				local var_331_2 = arg_328_1:FormatText(var_331_1.content)

				arg_328_1.text_.text = var_331_2

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_4 = 28 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 28)

				if (28 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 28)) > 0 and var_331_0 < var_331_4 then
					arg_328_1.talkMaxDuration = var_331_4

					if var_331_4 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_4 + 0
					end
				end

				arg_328_1.text_.text = var_331_2
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031077", "story_v_side_old_924031.awb") ~= 0 then
					local var_331_5 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031077", "story_v_side_old_924031.awb") / 1000

					if var_331_5 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + 0
					end

					if var_331_1.prefab_name ~= "" and arg_328_1.actors_[var_331_1.prefab_name] ~= nil then
						local var_331_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_1.prefab_name].transform, "story_v_side_old_924031", "924031077", "story_v_side_old_924031.awb")

						arg_328_1:RecordAudio("924031077", var_331_6)
						arg_328_1:RecordAudio("924031077", var_331_6)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031077", "story_v_side_old_924031.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031077", "story_v_side_old_924031.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_7 and arg_328_1.time_ < 0 + var_331_7 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play924031078 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 924031078
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play924031079(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos102003ui_story = arg_332_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_335_0 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 then
				arg_332_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_332_1.time_ - 0) / var_335_0)
				arg_332_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["102003ui_story"].transform.position).z)
				arg_332_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["102003ui_story"].transform.localEulerAngles = arg_332_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 then
				arg_332_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_332_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["102003ui_story"].transform.position).z)
				arg_332_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["102003ui_story"].transform.localEulerAngles = arg_332_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_335_1 = arg_332_1.actors_["102003ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect102003ui_story == nil then
				arg_332_1.var_.characterEffect102003ui_story = var_335_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_2 and not isNil(var_335_1) then
				if arg_332_1.var_.characterEffect102003ui_story and not isNil(var_335_1) then
					arg_332_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_332_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_332_1.time_ - 0) / var_335_2)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_2 and arg_332_1.time_ < 0 + var_335_2 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect102003ui_story then
				arg_332_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_332_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_335_3 = 0
			local var_335_4 = 0.725

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_3 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_5 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(924031078).content)

				arg_332_1.text_.text = var_335_5

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_7 = 29 <= 0 and var_335_4 or var_335_4 * (utf8.len(var_335_5) / 29)

				if (29 <= 0 and var_335_4 or var_335_4 * (utf8.len(var_335_5) / 29)) > 0 and var_335_4 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_3 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_3
					end
				end

				arg_332_1.text_.text = var_335_5
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_8 = math.max(var_335_4, arg_332_1.talkMaxDuration)

			if var_335_3 <= arg_332_1.time_ and arg_332_1.time_ < var_335_3 + var_335_8 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_3) / var_335_8

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_3 + var_335_8 and arg_332_1.time_ < var_335_3 + var_335_8 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play924031079 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 924031079
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play924031080(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.1

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_1 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(924031079).content)

				arg_336_1.text_.text = var_339_1

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_3 = 4 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_1) / 4)

				if (4 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_1) / 4)) > 0 and var_339_0 < var_339_3 then
					arg_336_1.talkMaxDuration = var_339_3

					if var_339_3 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_3 + 0
					end
				end

				arg_336_1.text_.text = var_339_1
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_4 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_4

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play924031080 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 924031080
		arg_340_1.duration_ = 7.47

		local var_340_0 = {
			zh = 5.333,
			ja = 7.466
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play924031081(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.5

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102003")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_1 = arg_340_1:GetWordFromCfg(924031080)
				local var_343_2 = arg_340_1:FormatText(var_343_1.content)

				arg_340_1.text_.text = var_343_2

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 20 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 20)

				if (20 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 20)) > 0 and var_343_0 < var_343_4 then
					arg_340_1.talkMaxDuration = var_343_4

					if var_343_4 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_4 + 0
					end
				end

				arg_340_1.text_.text = var_343_2
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031080", "story_v_side_old_924031.awb") ~= 0 then
					local var_343_5 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031080", "story_v_side_old_924031.awb") / 1000

					if var_343_5 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + 0
					end

					if var_343_1.prefab_name ~= "" and arg_340_1.actors_[var_343_1.prefab_name] ~= nil then
						local var_343_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_1.prefab_name].transform, "story_v_side_old_924031", "924031080", "story_v_side_old_924031.awb")

						arg_340_1:RecordAudio("924031080", var_343_6)
						arg_340_1:RecordAudio("924031080", var_343_6)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031080", "story_v_side_old_924031.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031080", "story_v_side_old_924031.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_7 and arg_340_1.time_ < 0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play924031081 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 924031081
		arg_344_1.duration_ = 1

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"

			SetActive(arg_344_1.choicesGo_, true)

			for iter_345_0, iter_345_1 in ipairs(arg_344_1.choices_) do
				SetActive(iter_345_1.go, iter_345_0 <= 2)
			end

			arg_344_1.choices_[1].txt.text = arg_344_1:FormatText(StoryChoiceCfg[1206].name)
			arg_344_1.choices_[2].txt.text = arg_344_1:FormatText(StoryChoiceCfg[1207].name)
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play924031082(arg_344_1)
			end

			if arg_346_0 == 2 then
				arg_344_0:Play924031082(arg_344_1)
			end

			arg_344_1:RecordChoiceLog(924031081, 1206, 1207)
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.allBtn_.enabled = false
			end

			if arg_344_1.time_ >= 0 + 0.6 and arg_344_1.time_ < 0 + 0.6 + arg_347_0 then
				arg_344_1.allBtn_.enabled = true
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play924031082 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 924031082
		arg_348_1.duration_ = 5.1

		local var_348_0 = {
			zh = 5.1,
			ja = 4.4
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play924031083(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.425

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102003")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_1 = arg_348_1:GetWordFromCfg(924031082)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 17 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 17)

				if (17 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 17)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031082", "story_v_side_old_924031.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031082", "story_v_side_old_924031.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_side_old_924031", "924031082", "story_v_side_old_924031.awb")

						arg_348_1:RecordAudio("924031082", var_351_6)
						arg_348_1:RecordAudio("924031082", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031082", "story_v_side_old_924031.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031082", "story_v_side_old_924031.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play924031083 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 924031083
		arg_352_1.duration_ = 9

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play924031084(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if arg_352_1.bgs_.I17f == nil then
				local var_355_0 = Object.Instantiate(arg_352_1.paintGo_)

				var_355_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I17f")
				var_355_0.name = "I17f"
				var_355_0.transform.parent = arg_352_1.stage_.transform
				var_355_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_352_1.bgs_.I17f = var_355_0
			end

			if 2 < arg_352_1.time_ and arg_352_1.time_ <= 2 + arg_355_0 then
				local var_355_1 = arg_352_1.bgs_.I17f

				arg_352_1.bgs_.I17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_355_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_355_2 = var_355_1:GetComponent("SpriteRenderer")

				if var_355_2 and var_355_2.sprite then
					local var_355_3 = 2 * (var_355_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_355_1.transform.localScale = Vector3.New(var_355_3 / var_355_2.sprite.bounds.size.y < var_355_3 * manager.ui.mainCameraCom_.aspect / var_355_2.sprite.bounds.size.x and var_355_3 * manager.ui.mainCameraCom_.aspect / var_355_2.sprite.bounds.size.x or var_355_3 / var_355_2.sprite.bounds.size.y, var_355_3 / var_355_2.sprite.bounds.size.y < var_355_3 * manager.ui.mainCameraCom_.aspect / var_355_2.sprite.bounds.size.x and var_355_3 * manager.ui.mainCameraCom_.aspect / var_355_2.sprite.bounds.size.x or var_355_3 / var_355_2.sprite.bounds.size.y, 0)
				end

				for iter_355_0, iter_355_1 in pairs(arg_352_1.bgs_) do
					if iter_355_0 ~= "I17f" then
						iter_355_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_355_4 = 4

			if 4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1.allBtn_.enabled = false
			end

			if arg_352_1.time_ >= var_355_4 + 0.3 and arg_352_1.time_ < var_355_4 + 0.3 + arg_355_0 then
				arg_352_1.allBtn_.enabled = true
			end

			local var_355_5 = 0

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1.mask_.enabled = true
				arg_352_1.mask_.raycastTarget = true

				arg_352_1:SetGaussion(false)
			end

			local var_355_6 = 2

			if var_355_5 <= arg_352_1.time_ and arg_352_1.time_ < var_355_5 + var_355_6 then
				local var_355_7 = Color.New(0, 0, 0)

				var_355_7.a = Mathf.Lerp(0, 1, (arg_352_1.time_ - var_355_5) / var_355_6)
				arg_352_1.mask_.color = var_355_7
			end

			if arg_352_1.time_ >= var_355_5 + var_355_6 and arg_352_1.time_ < var_355_5 + var_355_6 + arg_355_0 then
				local var_355_8 = Color.New(0, 0, 0)

				var_355_8.a = 1
				arg_352_1.mask_.color = var_355_8
			end

			local var_355_9 = 2

			if 2 < arg_352_1.time_ and arg_352_1.time_ <= var_355_9 + arg_355_0 then
				arg_352_1.mask_.enabled = true
				arg_352_1.mask_.raycastTarget = true

				arg_352_1:SetGaussion(false)
			end

			local var_355_10 = 2

			if var_355_9 <= arg_352_1.time_ and arg_352_1.time_ < var_355_9 + var_355_10 then
				local var_355_11 = Color.New(0, 0, 0)

				var_355_11.a = Mathf.Lerp(1, 0, (arg_352_1.time_ - var_355_9) / var_355_10)
				arg_352_1.mask_.color = var_355_11
			end

			if arg_352_1.time_ >= var_355_9 + var_355_10 and arg_352_1.time_ < var_355_9 + var_355_10 + arg_355_0 then
				local var_355_12 = Color.New(0, 0, 0)

				arg_352_1.mask_.enabled = false
				var_355_12.a = 0
				arg_352_1.mask_.color = var_355_12
			end

			if arg_352_1.frameCnt_ <= 1 then
				arg_352_1.dialog_:SetActive(false)
			end

			local var_355_13 = 4
			local var_355_14 = 0.925

			if 4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_13 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0

				arg_352_1.dialog_:SetActive(true)

				arg_352_1.dialogCg_.alpha = 0

				local var_355_15 = LeanTween.value(arg_352_1.dialog_, 0, 1, 0.3)

				var_355_15:setOnUpdate(LuaHelper.FloatAction(function(arg_356_0)
					arg_352_1.dialogCg_.alpha = arg_356_0
				end))
				var_355_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_352_1.dialog_)
					var_355_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_352_1.duration_ = arg_352_1.duration_ + 0.3

				SetActive(arg_352_1.leftNameGo_, false)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_16 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(924031083).content)

				arg_352_1.text_.text = var_355_16

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_18 = 37 <= 0 and var_355_14 or var_355_14 * (utf8.len(var_355_16) / 37)

				if (37 <= 0 and var_355_14 or var_355_14 * (utf8.len(var_355_16) / 37)) > 0 and var_355_14 < var_355_18 then
					arg_352_1.talkMaxDuration = var_355_18
					var_355_13 = var_355_13 + 0.3

					if var_355_18 + var_355_13 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_18 + var_355_13
					end
				end

				arg_352_1.text_.text = var_355_16
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_19 = var_355_13 + 0.3
			local var_355_20 = math.max(var_355_14, arg_352_1.talkMaxDuration)

			if var_355_13 + 0.3 <= arg_352_1.time_ and arg_352_1.time_ < var_355_19 + var_355_20 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_19) / var_355_20

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_19 + var_355_20 and arg_352_1.time_ < var_355_19 + var_355_20 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play924031084 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 924031084
		arg_358_1.duration_ = 2.4

		local var_358_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play924031085(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos102003ui_story = arg_358_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_361_0 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 then
				arg_358_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_358_1.time_ - 0) / var_361_0)
				arg_358_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["102003ui_story"].transform.position).z)
				arg_358_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["102003ui_story"].transform.localEulerAngles = arg_358_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 then
				arg_358_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_358_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["102003ui_story"].transform.position).z)
				arg_358_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["102003ui_story"].transform.localEulerAngles = arg_358_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_361_1 = arg_358_1.actors_["102003ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect102003ui_story == nil then
				arg_358_1.var_.characterEffect102003ui_story = var_361_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_2 and not isNil(var_361_1) then
				if arg_358_1.var_.characterEffect102003ui_story and not isNil(var_361_1) then
					arg_358_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_2 and arg_358_1.time_ < 0 + var_361_2 + arg_361_0 and not isNil(var_361_1) and arg_358_1.var_.characterEffect102003ui_story then
				arg_358_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_361_4 = 0
			local var_361_5 = 0.075

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_6 = arg_358_1:GetWordFromCfg(924031084)
				local var_361_7 = arg_358_1:FormatText(var_361_6.content)

				arg_358_1.text_.text = var_361_7

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 3 <= 0 and var_361_5 or var_361_5 * (utf8.len(var_361_7) / 3)

				if (3 <= 0 and var_361_5 or var_361_5 * (utf8.len(var_361_7) / 3)) > 0 and var_361_5 < var_361_9 then
					arg_358_1.talkMaxDuration = var_361_9

					if var_361_9 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_9 + var_361_4
					end
				end

				arg_358_1.text_.text = var_361_7
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031084", "story_v_side_old_924031.awb") ~= 0 then
					local var_361_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031084", "story_v_side_old_924031.awb") / 1000

					if var_361_10 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_10 + var_361_4
					end

					if var_361_6.prefab_name ~= "" and arg_358_1.actors_[var_361_6.prefab_name] ~= nil then
						local var_361_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_6.prefab_name].transform, "story_v_side_old_924031", "924031084", "story_v_side_old_924031.awb")

						arg_358_1:RecordAudio("924031084", var_361_11)
						arg_358_1:RecordAudio("924031084", var_361_11)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031084", "story_v_side_old_924031.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031084", "story_v_side_old_924031.awb")
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
				actorName = "102003ui_story",
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
	Play924031085 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 924031085
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play924031086(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos102003ui_story = arg_362_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_365_0 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 then
				arg_362_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_362_1.time_ - 0) / var_365_0)
				arg_362_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["102003ui_story"].transform.position).z)
				arg_362_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["102003ui_story"].transform.localEulerAngles = arg_362_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 then
				arg_362_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_362_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["102003ui_story"].transform.position).z)
				arg_362_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["102003ui_story"].transform.localEulerAngles = arg_362_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_365_1 = arg_362_1.actors_["102003ui_story"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect102003ui_story == nil then
				arg_362_1.var_.characterEffect102003ui_story = var_365_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_2 and not isNil(var_365_1) then
				if arg_362_1.var_.characterEffect102003ui_story and not isNil(var_365_1) then
					arg_362_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_362_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_2)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_2 and arg_362_1.time_ < 0 + var_365_2 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect102003ui_story then
				arg_362_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_362_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_365_3 = 0
			local var_365_4 = 0.725

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_3 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, false)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_5 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(924031085).content)

				arg_362_1.text_.text = var_365_5

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_7 = 29 <= 0 and var_365_4 or var_365_4 * (utf8.len(var_365_5) / 29)

				if (29 <= 0 and var_365_4 or var_365_4 * (utf8.len(var_365_5) / 29)) > 0 and var_365_4 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_3 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_3
					end
				end

				arg_362_1.text_.text = var_365_5
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_8 = math.max(var_365_4, arg_362_1.talkMaxDuration)

			if var_365_3 <= arg_362_1.time_ and arg_362_1.time_ < var_365_3 + var_365_8 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_3) / var_365_8

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_3 + var_365_8 and arg_362_1.time_ < var_365_3 + var_365_8 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play924031086 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 924031086
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play924031087(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.05

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_1 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(924031086).content)

				arg_366_1.text_.text = var_369_1

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_3 = 2 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 2)

				if (2 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 2)) > 0 and var_369_0 < var_369_3 then
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
	Play924031087 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 924031087
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play924031088(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.625

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_1 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(924031087).content)

				arg_370_1.text_.text = var_373_1

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_3 = 25 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 25)

				if (25 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 25)) > 0 and var_373_0 < var_373_3 then
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
	Play924031088 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 924031088
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play924031089(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_377_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_374_1.bgmTxt_.text ~= var_377_2 and arg_374_1.bgmTxt_.text ~= "" then
						if arg_374_1.bgmTxt2_.text ~= "" then
							arg_374_1.bgmTxt_.text = arg_374_1.bgmTxt2_.text
						end

						arg_374_1.bgmTxt2_.text = var_377_2

						arg_374_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_374_1.bgmTxt_.text = var_377_2
						arg_374_1.bgmTxt2_.text = var_377_2
					end

					if arg_374_1.bgmTimer then
						arg_374_1.bgmTimer:Stop()

						arg_374_1.bgmTimer = nil
					end

					if arg_374_1.settingData.show_music_name == 1 then
						arg_374_1.musicController:SetSelectedState("show")
						arg_374_1.musicAnimator_:Play("open", 0, 0)

						if arg_374_1.settingData.music_time ~= 0 then
							arg_374_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_374_1.settingData.music_time), function()
								if arg_374_1 == nil or isNil(arg_374_1.bgmTxt_) then
									return
								end

								arg_374_1.musicController:SetSelectedState("hide")
								arg_374_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_377_3 = 0
			local var_377_4 = 0.95

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_3 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_5 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(924031088).content)

				arg_374_1.text_.text = var_377_5

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_7 = 38 <= 0 and var_377_4 or var_377_4 * (utf8.len(var_377_5) / 38)

				if (38 <= 0 and var_377_4 or var_377_4 * (utf8.len(var_377_5) / 38)) > 0 and var_377_4 < var_377_7 then
					arg_374_1.talkMaxDuration = var_377_7

					if var_377_7 + var_377_3 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_3
					end
				end

				arg_374_1.text_.text = var_377_5
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_8 = math.max(var_377_4, arg_374_1.talkMaxDuration)

			if var_377_3 <= arg_374_1.time_ and arg_374_1.time_ < var_377_3 + var_377_8 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_3) / var_377_8

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_3 + var_377_8 and arg_374_1.time_ < var_377_3 + var_377_8 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play924031089 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 924031089
		arg_379_1.duration_ = 9

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play924031090(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 2 < arg_379_1.time_ and arg_379_1.time_ <= 2 + arg_382_0 then
				local var_382_0 = arg_379_1.bgs_.STblack

				arg_379_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_382_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_382_1 = var_382_0:GetComponent("SpriteRenderer")

				if var_382_1 and var_382_1.sprite then
					local var_382_2 = 2 * (var_382_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_382_0.transform.localScale = Vector3.New(var_382_2 / var_382_1.sprite.bounds.size.y < var_382_2 * manager.ui.mainCameraCom_.aspect / var_382_1.sprite.bounds.size.x and var_382_2 * manager.ui.mainCameraCom_.aspect / var_382_1.sprite.bounds.size.x or var_382_2 / var_382_1.sprite.bounds.size.y, var_382_2 / var_382_1.sprite.bounds.size.y < var_382_2 * manager.ui.mainCameraCom_.aspect / var_382_1.sprite.bounds.size.x and var_382_2 * manager.ui.mainCameraCom_.aspect / var_382_1.sprite.bounds.size.x or var_382_2 / var_382_1.sprite.bounds.size.y, 0)
				end

				for iter_382_0, iter_382_1 in pairs(arg_379_1.bgs_) do
					if iter_382_0 ~= "STblack" then
						iter_382_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_382_3 = 4

			if 4 < arg_379_1.time_ and arg_379_1.time_ <= var_382_3 + arg_382_0 then
				arg_379_1.allBtn_.enabled = false
			end

			if arg_379_1.time_ >= var_382_3 + 0.3 and arg_379_1.time_ < var_382_3 + 0.3 + arg_382_0 then
				arg_379_1.allBtn_.enabled = true
			end

			local var_382_4 = 0

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1.mask_.enabled = true
				arg_379_1.mask_.raycastTarget = true

				arg_379_1:SetGaussion(false)
			end

			local var_382_5 = 2

			if var_382_4 <= arg_379_1.time_ and arg_379_1.time_ < var_382_4 + var_382_5 then
				local var_382_6 = Color.New(0, 0, 0)

				var_382_6.a = Mathf.Lerp(0, 1, (arg_379_1.time_ - var_382_4) / var_382_5)
				arg_379_1.mask_.color = var_382_6
			end

			if arg_379_1.time_ >= var_382_4 + var_382_5 and arg_379_1.time_ < var_382_4 + var_382_5 + arg_382_0 then
				local var_382_7 = Color.New(0, 0, 0)

				var_382_7.a = 1
				arg_379_1.mask_.color = var_382_7
			end

			local var_382_8 = 2

			if 2 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.mask_.enabled = true
				arg_379_1.mask_.raycastTarget = true

				arg_379_1:SetGaussion(false)
			end

			local var_382_9 = 2

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_9 then
				local var_382_10 = Color.New(0, 0, 0)

				var_382_10.a = Mathf.Lerp(1, 0, (arg_379_1.time_ - var_382_8) / var_382_9)
				arg_379_1.mask_.color = var_382_10
			end

			if arg_379_1.time_ >= var_382_8 + var_382_9 and arg_379_1.time_ < var_382_8 + var_382_9 + arg_382_0 then
				local var_382_11 = Color.New(0, 0, 0)

				arg_379_1.mask_.enabled = false
				var_382_11.a = 0
				arg_379_1.mask_.color = var_382_11
			end

			if arg_379_1.frameCnt_ <= 1 then
				arg_379_1.dialog_:SetActive(false)
			end

			local var_382_12 = 4
			local var_382_13 = 1

			if 4 < arg_379_1.time_ and arg_379_1.time_ <= var_382_12 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				arg_379_1.dialog_:SetActive(true)

				arg_379_1.dialogCg_.alpha = 0

				local var_382_14 = LeanTween.value(arg_379_1.dialog_, 0, 1, 0.3)

				var_382_14:setOnUpdate(LuaHelper.FloatAction(function(arg_383_0)
					arg_379_1.dialogCg_.alpha = arg_383_0
				end))
				var_382_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_379_1.dialog_)
					var_382_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_379_1.duration_ = arg_379_1.duration_ + 0.3

				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_15 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(924031089).content)

				arg_379_1.text_.text = var_382_15

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_17 = 40 <= 0 and var_382_13 or var_382_13 * (utf8.len(var_382_15) / 40)

				if (40 <= 0 and var_382_13 or var_382_13 * (utf8.len(var_382_15) / 40)) > 0 and var_382_13 < var_382_17 then
					arg_379_1.talkMaxDuration = var_382_17
					var_382_12 = var_382_12 + 0.3

					if var_382_17 + var_382_12 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_17 + var_382_12
					end
				end

				arg_379_1.text_.text = var_382_15
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_18 = var_382_12 + 0.3
			local var_382_19 = math.max(var_382_13, arg_379_1.talkMaxDuration)

			if var_382_12 + 0.3 <= arg_379_1.time_ and arg_379_1.time_ < var_382_18 + var_382_19 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_18) / var_382_19

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_18 + var_382_19 and arg_379_1.time_ < var_382_18 + var_382_19 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play924031090 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 924031090
		arg_385_1.duration_ = 7.6

		local var_385_0 = {
			zh = 6.665999999999,
			ja = 7.599999999999
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
				arg_385_0:Play924031091(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if arg_385_1.bgs_.X204_f == nil then
				local var_388_0 = Object.Instantiate(arg_385_1.paintGo_)

				var_388_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X204_f")
				var_388_0.name = "X204_f"
				var_388_0.transform.parent = arg_385_1.stage_.transform
				var_388_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_385_1.bgs_.X204_f = var_388_0
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				local var_388_1 = arg_385_1.bgs_.X204_f

				arg_385_1.bgs_.X204_f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_388_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_388_2 = var_388_1:GetComponent("SpriteRenderer")

				if var_388_2 and var_388_2.sprite then
					local var_388_3 = 2 * (var_388_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_388_1.transform.localScale = Vector3.New(var_388_3 / var_388_2.sprite.bounds.size.y < var_388_3 * manager.ui.mainCameraCom_.aspect / var_388_2.sprite.bounds.size.x and var_388_3 * manager.ui.mainCameraCom_.aspect / var_388_2.sprite.bounds.size.x or var_388_3 / var_388_2.sprite.bounds.size.y, var_388_3 / var_388_2.sprite.bounds.size.y < var_388_3 * manager.ui.mainCameraCom_.aspect / var_388_2.sprite.bounds.size.x and var_388_3 * manager.ui.mainCameraCom_.aspect / var_388_2.sprite.bounds.size.x or var_388_3 / var_388_2.sprite.bounds.size.y, 0)
				end

				for iter_388_0, iter_388_1 in pairs(arg_385_1.bgs_) do
					if iter_388_0 ~= "X204_f" then
						iter_388_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_388_4 = 1.999999999999

			if 1.999999999999 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.allBtn_.enabled = false
			end

			if arg_385_1.time_ >= var_388_4 + 0.3 and arg_385_1.time_ < var_388_4 + 0.3 + arg_388_0 then
				arg_385_1.allBtn_.enabled = true
			end

			local var_388_5 = 0

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1.mask_.enabled = true
				arg_385_1.mask_.raycastTarget = true

				arg_385_1:SetGaussion(false)
			end

			local var_388_6 = 2

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_6 then
				local var_388_7 = Color.New(0, 0, 0)

				var_388_7.a = Mathf.Lerp(1, 0, (arg_385_1.time_ - var_388_5) / var_388_6)
				arg_385_1.mask_.color = var_388_7
			end

			if arg_385_1.time_ >= var_388_5 + var_388_6 and arg_385_1.time_ < var_388_5 + var_388_6 + arg_388_0 then
				local var_388_8 = Color.New(0, 0, 0)

				arg_385_1.mask_.enabled = false
				var_388_8.a = 0
				arg_385_1.mask_.color = var_388_8
			end

			local var_388_9 = arg_385_1.actors_["102003ui_story"].transform

			if 1.8 < arg_385_1.time_ and arg_385_1.time_ <= 1.8 + arg_388_0 then
				arg_385_1.var_.moveOldPos102003ui_story = var_388_9.localPosition
			end

			local var_388_10 = 0.001

			if 1.8 <= arg_385_1.time_ and arg_385_1.time_ < 1.8 + var_388_10 then
				var_388_9.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_385_1.time_ - 1.8) / var_388_10)
				var_388_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_9.position).x, (manager.ui.mainCamera.transform.position - var_388_9.position).y, (manager.ui.mainCamera.transform.position - var_388_9.position).z)
				var_388_9.localEulerAngles.z = 0
				var_388_9.localEulerAngles.x = 0
				var_388_9.localEulerAngles = var_388_9.localEulerAngles
			end

			if arg_385_1.time_ >= 1.8 + var_388_10 and arg_385_1.time_ < 1.8 + var_388_10 + arg_388_0 then
				var_388_9.localPosition = Vector3.New(0, -0.85, -6.21)
				var_388_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_9.position).x, (manager.ui.mainCamera.transform.position - var_388_9.position).y, (manager.ui.mainCamera.transform.position - var_388_9.position).z)
				var_388_9.localEulerAngles.z = 0
				var_388_9.localEulerAngles.x = 0
				var_388_9.localEulerAngles = var_388_9.localEulerAngles
			end

			local var_388_11 = arg_385_1.actors_["102003ui_story"]

			if 1.8 < arg_385_1.time_ and arg_385_1.time_ <= 1.8 + arg_388_0 and not isNil(var_388_11) and arg_385_1.var_.characterEffect102003ui_story == nil then
				arg_385_1.var_.characterEffect102003ui_story = var_388_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_12 = 0.200000002980232

			if 1.8 <= arg_385_1.time_ and arg_385_1.time_ < 1.8 + var_388_12 and not isNil(var_388_11) then
				if arg_385_1.var_.characterEffect102003ui_story and not isNil(var_388_11) then
					arg_385_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 1.8 + var_388_12 and arg_385_1.time_ < 1.8 + var_388_12 + arg_388_0 and not isNil(var_388_11) and arg_385_1.var_.characterEffect102003ui_story then
				arg_385_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 1.8 < arg_385_1.time_ and arg_385_1.time_ <= 1.8 + arg_388_0 then
				arg_385_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 1.8 < arg_385_1.time_ and arg_385_1.time_ <= 1.8 + arg_388_0 then
				arg_385_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			if 1.43333333333333 < arg_385_1.time_ and arg_385_1.time_ <= 1.43333333333333 + arg_388_0 then
				arg_385_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			if 0.133333333333333 < arg_385_1.time_ and arg_385_1.time_ <= 0.133333333333333 + arg_388_0 then
				arg_385_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_388_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_385_1.bgmTxt_.text ~= var_388_18 and arg_385_1.bgmTxt_.text ~= "" then
						if arg_385_1.bgmTxt2_.text ~= "" then
							arg_385_1.bgmTxt_.text = arg_385_1.bgmTxt2_.text
						end

						arg_385_1.bgmTxt2_.text = var_388_18

						arg_385_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_385_1.bgmTxt_.text = var_388_18
						arg_385_1.bgmTxt2_.text = var_388_18
					end

					if arg_385_1.bgmTimer then
						arg_385_1.bgmTimer:Stop()

						arg_385_1.bgmTimer = nil
					end

					if arg_385_1.settingData.show_music_name == 1 then
						arg_385_1.musicController:SetSelectedState("show")
						arg_385_1.musicAnimator_:Play("open", 0, 0)

						if arg_385_1.settingData.music_time ~= 0 then
							arg_385_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_385_1.settingData.music_time), function()
								if arg_385_1 == nil or isNil(arg_385_1.bgmTxt_) then
									return
								end

								arg_385_1.musicController:SetSelectedState("hide")
								arg_385_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_385_1.time_ and arg_385_1.time_ <= 0.433333333333333 + arg_388_0 then
				arg_385_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_388_21 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_385_1.bgmTxt_.text ~= var_388_21 and arg_385_1.bgmTxt_.text ~= "" then
						if arg_385_1.bgmTxt2_.text ~= "" then
							arg_385_1.bgmTxt_.text = arg_385_1.bgmTxt2_.text
						end

						arg_385_1.bgmTxt2_.text = var_388_21

						arg_385_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_385_1.bgmTxt_.text = var_388_21
						arg_385_1.bgmTxt2_.text = var_388_21
					end

					if arg_385_1.bgmTimer then
						arg_385_1.bgmTimer:Stop()

						arg_385_1.bgmTimer = nil
					end

					if arg_385_1.settingData.show_music_name == 1 then
						arg_385_1.musicController:SetSelectedState("show")
						arg_385_1.musicAnimator_:Play("open", 0, 0)

						if arg_385_1.settingData.music_time ~= 0 then
							arg_385_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_385_1.settingData.music_time), function()
								if arg_385_1 == nil or isNil(arg_385_1.bgmTxt_) then
									return
								end

								arg_385_1.musicController:SetSelectedState("hide")
								arg_385_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_385_1.frameCnt_ <= 1 then
				arg_385_1.dialog_:SetActive(false)
			end

			local var_388_22 = 1.999999999999
			local var_388_23 = 0.275

			if 1.999999999999 < arg_385_1.time_ and arg_385_1.time_ <= var_388_22 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0

				arg_385_1.dialog_:SetActive(true)

				arg_385_1.dialogCg_.alpha = 0

				local var_388_24 = LeanTween.value(arg_385_1.dialog_, 0, 1, 0.3)

				var_388_24:setOnUpdate(LuaHelper.FloatAction(function(arg_391_0)
					arg_385_1.dialogCg_.alpha = arg_391_0
				end))
				var_388_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_385_1.dialog_)
					var_388_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_385_1.duration_ = arg_385_1.duration_ + 0.3

				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_25 = arg_385_1:GetWordFromCfg(924031090)
				local var_388_26 = arg_385_1:FormatText(var_388_25.content)

				arg_385_1.text_.text = var_388_26

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_28 = 11 <= 0 and var_388_23 or var_388_23 * (utf8.len(var_388_26) / 11)

				if (11 <= 0 and var_388_23 or var_388_23 * (utf8.len(var_388_26) / 11)) > 0 and var_388_23 < var_388_28 then
					arg_385_1.talkMaxDuration = var_388_28
					var_388_22 = var_388_22 + 0.3

					if var_388_28 + var_388_22 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_28 + var_388_22
					end
				end

				arg_385_1.text_.text = var_388_26
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031090", "story_v_side_old_924031.awb") ~= 0 then
					local var_388_29 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031090", "story_v_side_old_924031.awb") / 1000

					if var_388_29 + var_388_22 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_29 + var_388_22
					end

					if var_388_25.prefab_name ~= "" and arg_385_1.actors_[var_388_25.prefab_name] ~= nil then
						local var_388_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_25.prefab_name].transform, "story_v_side_old_924031", "924031090", "story_v_side_old_924031.awb")

						arg_385_1:RecordAudio("924031090", var_388_30)
						arg_385_1:RecordAudio("924031090", var_388_30)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031090", "story_v_side_old_924031.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031090", "story_v_side_old_924031.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_31 = var_388_22 + 0.3
			local var_388_32 = math.max(var_388_23, arg_385_1.talkMaxDuration)

			if var_388_22 + 0.3 <= arg_385_1.time_ and arg_385_1.time_ < var_388_31 + var_388_32 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_31) / var_388_32

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_31 + var_388_32 and arg_385_1.time_ < var_388_31 + var_388_32 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play924031091 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 924031091
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play924031092(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos102003ui_story = arg_393_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_396_0 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 then
				arg_393_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_393_1.time_ - 0) / var_396_0)
				arg_393_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["102003ui_story"].transform.position).z)
				arg_393_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["102003ui_story"].transform.localEulerAngles = arg_393_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 then
				arg_393_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_393_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["102003ui_story"].transform.position).z)
				arg_393_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["102003ui_story"].transform.localEulerAngles = arg_393_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_396_1 = arg_393_1.actors_["102003ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect102003ui_story == nil then
				arg_393_1.var_.characterEffect102003ui_story = var_396_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_2 and not isNil(var_396_1) then
				if arg_393_1.var_.characterEffect102003ui_story and not isNil(var_396_1) then
					arg_393_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_393_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_2)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_2 and arg_393_1.time_ < 0 + var_396_2 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect102003ui_story then
				arg_393_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_393_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_396_3 = 0
			local var_396_4 = 1.175

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_5 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(924031091).content)

				arg_393_1.text_.text = var_396_5

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_7 = 47 <= 0 and var_396_4 or var_396_4 * (utf8.len(var_396_5) / 47)

				if (47 <= 0 and var_396_4 or var_396_4 * (utf8.len(var_396_5) / 47)) > 0 and var_396_4 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_3 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_3
					end
				end

				arg_393_1.text_.text = var_396_5
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_8 = math.max(var_396_4, arg_393_1.talkMaxDuration)

			if var_396_3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_3 + var_396_8 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_3) / var_396_8

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_3 + var_396_8 and arg_393_1.time_ < var_396_3 + var_396_8 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play924031092 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 924031092
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play924031093(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.425

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(924031092).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 17 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 17)

				if (17 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 17)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play924031093 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 924031093
		arg_401_1.duration_ = 7.1

		local var_401_0 = {
			zh = 6,
			ja = 7.1
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
				arg_401_0:Play924031094(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos102003ui_story = arg_401_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_404_0 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 then
				arg_401_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_401_1.time_ - 0) / var_404_0)
				arg_401_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["102003ui_story"].transform.position).z)
				arg_401_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["102003ui_story"].transform.localEulerAngles = arg_401_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 then
				arg_401_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_401_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["102003ui_story"].transform.position).z)
				arg_401_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["102003ui_story"].transform.localEulerAngles = arg_401_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_404_1 = arg_401_1.actors_["102003ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect102003ui_story == nil then
				arg_401_1.var_.characterEffect102003ui_story = var_404_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_2 and not isNil(var_404_1) then
				if arg_401_1.var_.characterEffect102003ui_story and not isNil(var_404_1) then
					arg_401_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_2 and arg_401_1.time_ < 0 + var_404_2 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect102003ui_story then
				arg_401_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_2")
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_404_4 = 0
			local var_404_5 = 0.625

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_6 = arg_401_1:GetWordFromCfg(924031093)
				local var_404_7 = arg_401_1:FormatText(var_404_6.content)

				arg_401_1.text_.text = var_404_7

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_9 = 25 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 25)

				if (25 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 25)) > 0 and var_404_5 < var_404_9 then
					arg_401_1.talkMaxDuration = var_404_9

					if var_404_9 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_9 + var_404_4
					end
				end

				arg_401_1.text_.text = var_404_7
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031093", "story_v_side_old_924031.awb") ~= 0 then
					local var_404_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031093", "story_v_side_old_924031.awb") / 1000

					if var_404_10 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_4
					end

					if var_404_6.prefab_name ~= "" and arg_401_1.actors_[var_404_6.prefab_name] ~= nil then
						local var_404_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_6.prefab_name].transform, "story_v_side_old_924031", "924031093", "story_v_side_old_924031.awb")

						arg_401_1:RecordAudio("924031093", var_404_11)
						arg_401_1:RecordAudio("924031093", var_404_11)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031093", "story_v_side_old_924031.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031093", "story_v_side_old_924031.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_12 = math.max(var_404_5, arg_401_1.talkMaxDuration)

			if var_404_4 <= arg_401_1.time_ and arg_401_1.time_ < var_404_4 + var_404_12 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_4) / var_404_12

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_4 + var_404_12 and arg_401_1.time_ < var_404_4 + var_404_12 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031094 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 924031094
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play924031095(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["102003ui_story"]) and arg_405_1.var_.characterEffect102003ui_story == nil then
				arg_405_1.var_.characterEffect102003ui_story = arg_405_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_0 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["102003ui_story"]) then
				if arg_405_1.var_.characterEffect102003ui_story and not isNil(arg_405_1.actors_["102003ui_story"]) then
					arg_405_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_405_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_0)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["102003ui_story"]) and arg_405_1.var_.characterEffect102003ui_story then
				arg_405_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_405_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_408_1 = 0
			local var_408_2 = 0.375

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
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

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(924031094).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 15 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 15)

				if (15 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 15)) > 0 and var_408_2 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_1 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_1
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_6 = math.max(var_408_2, arg_405_1.talkMaxDuration)

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_6 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_1) / var_408_6

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_1 + var_408_6 and arg_405_1.time_ < var_408_1 + var_408_6 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play924031095 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 924031095
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play924031096(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos102003ui_story = arg_409_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["102003ui_story"].transform.position).z)
				arg_409_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["102003ui_story"].transform.localEulerAngles = arg_409_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_409_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["102003ui_story"].transform.position).z)
				arg_409_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["102003ui_story"].transform.localEulerAngles = arg_409_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_412_1 = 0
			local var_412_2 = 0.975

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_3 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(924031095).content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 39 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 39)

				if (39 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 39)) > 0 and var_412_2 < var_412_5 then
					arg_409_1.talkMaxDuration = var_412_5

					if var_412_5 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_6 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_6 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_6

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_6 and arg_409_1.time_ < var_412_1 + var_412_6 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031096 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 924031096
		arg_413_1.duration_ = 2

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play924031097(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos102003ui_story = arg_413_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["102003ui_story"].transform.position).z)
				arg_413_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["102003ui_story"].transform.localEulerAngles = arg_413_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_413_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["102003ui_story"].transform.position).z)
				arg_413_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["102003ui_story"].transform.localEulerAngles = arg_413_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["102003ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect102003ui_story == nil then
				arg_413_1.var_.characterEffect102003ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect102003ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect102003ui_story then
				arg_413_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			local var_416_4 = 0
			local var_416_5 = 0.075

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_6 = arg_413_1:GetWordFromCfg(924031096)
				local var_416_7 = arg_413_1:FormatText(var_416_6.content)

				arg_413_1.text_.text = var_416_7

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_9 = 3 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 3)

				if (3 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 3)) > 0 and var_416_5 < var_416_9 then
					arg_413_1.talkMaxDuration = var_416_9

					if var_416_9 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_9 + var_416_4
					end
				end

				arg_413_1.text_.text = var_416_7
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031096", "story_v_side_old_924031.awb") ~= 0 then
					local var_416_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031096", "story_v_side_old_924031.awb") / 1000

					if var_416_10 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_4
					end

					if var_416_6.prefab_name ~= "" and arg_413_1.actors_[var_416_6.prefab_name] ~= nil then
						local var_416_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_6.prefab_name].transform, "story_v_side_old_924031", "924031096", "story_v_side_old_924031.awb")

						arg_413_1:RecordAudio("924031096", var_416_11)
						arg_413_1:RecordAudio("924031096", var_416_11)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031096", "story_v_side_old_924031.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031096", "story_v_side_old_924031.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_12 = math.max(var_416_5, arg_413_1.talkMaxDuration)

			if var_416_4 <= arg_413_1.time_ and arg_413_1.time_ < var_416_4 + var_416_12 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_4) / var_416_12

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_4 + var_416_12 and arg_413_1.time_ < var_416_4 + var_416_12 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031097 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 924031097
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play924031098(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["102003ui_story"]) and arg_417_1.var_.characterEffect102003ui_story == nil then
				arg_417_1.var_.characterEffect102003ui_story = arg_417_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["102003ui_story"]) then
				if arg_417_1.var_.characterEffect102003ui_story and not isNil(arg_417_1.actors_["102003ui_story"]) then
					arg_417_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_417_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["102003ui_story"]) and arg_417_1.var_.characterEffect102003ui_story then
				arg_417_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_417_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_420_1 = 0
			local var_420_2 = 0.375

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_3 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(924031097).content)

				arg_417_1.text_.text = var_420_3

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 15 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 15)

				if (15 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 15)) > 0 and var_420_2 < var_420_5 then
					arg_417_1.talkMaxDuration = var_420_5

					if var_420_5 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + var_420_1
					end
				end

				arg_417_1.text_.text = var_420_3
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_6 = math.max(var_420_2, arg_417_1.talkMaxDuration)

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_6 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_1) / var_420_6

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_1 + var_420_6 and arg_417_1.time_ < var_420_1 + var_420_6 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play924031098 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 924031098
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play924031099(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.1

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_1 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(924031098).content)

				arg_421_1.text_.text = var_424_1

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_3 = 4 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 4)

				if (4 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 4)) > 0 and var_424_0 < var_424_3 then
					arg_421_1.talkMaxDuration = var_424_3

					if var_424_3 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_3 + 0
					end
				end

				arg_421_1.text_.text = var_424_1
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_4 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_4 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_4

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_4 and arg_421_1.time_ < 0 + var_424_4 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play924031099 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 924031099
		arg_425_1.duration_ = 4.27

		local var_425_0 = {
			zh = 3.333,
			ja = 4.266
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
				arg_425_0:Play924031100(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos102003ui_story = arg_425_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["102003ui_story"].transform.position).z)
				arg_425_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["102003ui_story"].transform.localEulerAngles = arg_425_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_425_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["102003ui_story"].transform.position).z)
				arg_425_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["102003ui_story"].transform.localEulerAngles = arg_425_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["102003ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect102003ui_story == nil then
				arg_425_1.var_.characterEffect102003ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect102003ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect102003ui_story then
				arg_425_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_428_4 = 0
			local var_428_5 = 0.35

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_6 = arg_425_1:GetWordFromCfg(924031099)
				local var_428_7 = arg_425_1:FormatText(var_428_6.content)

				arg_425_1.text_.text = var_428_7

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_9 = 14 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_7) / 14)

				if (14 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_7) / 14)) > 0 and var_428_5 < var_428_9 then
					arg_425_1.talkMaxDuration = var_428_9

					if var_428_9 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_9 + var_428_4
					end
				end

				arg_425_1.text_.text = var_428_7
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031099", "story_v_side_old_924031.awb") ~= 0 then
					local var_428_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031099", "story_v_side_old_924031.awb") / 1000

					if var_428_10 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_10 + var_428_4
					end

					if var_428_6.prefab_name ~= "" and arg_425_1.actors_[var_428_6.prefab_name] ~= nil then
						local var_428_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_6.prefab_name].transform, "story_v_side_old_924031", "924031099", "story_v_side_old_924031.awb")

						arg_425_1:RecordAudio("924031099", var_428_11)
						arg_425_1:RecordAudio("924031099", var_428_11)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031099", "story_v_side_old_924031.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031099", "story_v_side_old_924031.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_12 = math.max(var_428_5, arg_425_1.talkMaxDuration)

			if var_428_4 <= arg_425_1.time_ and arg_425_1.time_ < var_428_4 + var_428_12 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_4) / var_428_12

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_4 + var_428_12 and arg_425_1.time_ < var_428_4 + var_428_12 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play924031100 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 924031100
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play924031101(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos102003ui_story = arg_429_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["102003ui_story"].transform.position).z)
				arg_429_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["102003ui_story"].transform.localEulerAngles = arg_429_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["102003ui_story"].transform.position).z)
				arg_429_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["102003ui_story"].transform.localEulerAngles = arg_429_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_432_1 = 0
			local var_432_2 = 0.675

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_3 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(924031100).content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 27 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 27)

				if (27 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 27)) > 0 and var_432_2 < var_432_5 then
					arg_429_1.talkMaxDuration = var_432_5

					if var_432_5 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + var_432_1
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_6 = math.max(var_432_2, arg_429_1.talkMaxDuration)

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_6 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_1) / var_432_6

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_1 + var_432_6 and arg_429_1.time_ < var_432_1 + var_432_6 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play924031101 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 924031101
		arg_433_1.duration_ = 1

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"

			SetActive(arg_433_1.choicesGo_, true)

			for iter_434_0, iter_434_1 in ipairs(arg_433_1.choices_) do
				SetActive(iter_434_1.go, iter_434_0 <= 2)
			end

			arg_433_1.choices_[1].txt.text = arg_433_1:FormatText(StoryChoiceCfg[1208].name)
			arg_433_1.choices_[2].txt.text = arg_433_1:FormatText(StoryChoiceCfg[1209].name)
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play924031102(arg_433_1)
			end

			if arg_435_0 == 2 then
				arg_433_0:Play924031103(arg_433_1)
			end

			arg_433_1:RecordChoiceLog(924031101, 1208, 1209)
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.allBtn_.enabled = false
			end

			if arg_433_1.time_ >= 0 + 0.6 and arg_433_1.time_ < 0 + 0.6 + arg_436_0 then
				arg_433_1.allBtn_.enabled = true
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play924031102 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 924031102
		arg_437_1.duration_ = 4.87

		local var_437_0 = {
			zh = 3.4,
			ja = 4.866
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
				arg_437_0:Play924031104(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos102003ui_story = arg_437_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["102003ui_story"].transform.position).z)
				arg_437_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["102003ui_story"].transform.localEulerAngles = arg_437_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_437_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["102003ui_story"].transform.position).z)
				arg_437_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["102003ui_story"].transform.localEulerAngles = arg_437_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["102003ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect102003ui_story == nil then
				arg_437_1.var_.characterEffect102003ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect102003ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect102003ui_story then
				arg_437_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action12_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_440_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_437_1.bgmTxt_.text ~= var_440_6 and arg_437_1.bgmTxt_.text ~= "" then
						if arg_437_1.bgmTxt2_.text ~= "" then
							arg_437_1.bgmTxt_.text = arg_437_1.bgmTxt2_.text
						end

						arg_437_1.bgmTxt2_.text = var_440_6

						arg_437_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_437_1.bgmTxt_.text = var_440_6
						arg_437_1.bgmTxt2_.text = var_440_6
					end

					if arg_437_1.bgmTimer then
						arg_437_1.bgmTimer:Stop()

						arg_437_1.bgmTimer = nil
					end

					if arg_437_1.settingData.show_music_name == 1 then
						arg_437_1.musicController:SetSelectedState("show")
						arg_437_1.musicAnimator_:Play("open", 0, 0)

						if arg_437_1.settingData.music_time ~= 0 then
							arg_437_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_437_1.settingData.music_time), function()
								if arg_437_1 == nil or isNil(arg_437_1.bgmTxt_) then
									return
								end

								arg_437_1.musicController:SetSelectedState("hide")
								arg_437_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_440_7 = 0
			local var_440_8 = 0.075

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_7 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_9 = arg_437_1:GetWordFromCfg(924031103)
				local var_440_10 = arg_437_1:FormatText(var_440_9.content)

				arg_437_1.text_.text = var_440_10

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_12 = 12 <= 0 and var_440_8 or var_440_8 * (utf8.len(var_440_10) / 12)

				if (12 <= 0 and var_440_8 or var_440_8 * (utf8.len(var_440_10) / 12)) > 0 and var_440_8 < var_440_12 then
					arg_437_1.talkMaxDuration = var_440_12

					if var_440_12 + var_440_7 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_12 + var_440_7
					end
				end

				arg_437_1.text_.text = var_440_10
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031103", "story_v_side_old_924031.awb") ~= 0 then
					local var_440_13 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031103", "story_v_side_old_924031.awb") / 1000

					if var_440_13 + var_440_7 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_13 + var_440_7
					end

					if var_440_9.prefab_name ~= "" and arg_437_1.actors_[var_440_9.prefab_name] ~= nil then
						local var_440_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_9.prefab_name].transform, "story_v_side_old_924031", "924031103", "story_v_side_old_924031.awb")

						arg_437_1:RecordAudio("924031103", var_440_14)
						arg_437_1:RecordAudio("924031103", var_440_14)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031103", "story_v_side_old_924031.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031103", "story_v_side_old_924031.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_15 = math.max(var_440_8, arg_437_1.talkMaxDuration)

			if var_440_7 <= arg_437_1.time_ and arg_437_1.time_ < var_440_7 + var_440_15 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_7) / var_440_15

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_7 + var_440_15 and arg_437_1.time_ < var_440_7 + var_440_15 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play924031104 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 924031104
		arg_442_1.duration_ = 9

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play924031105(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if arg_442_1.bgs_.ST04c == nil then
				local var_445_0 = Object.Instantiate(arg_442_1.paintGo_)

				var_445_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST04c")
				var_445_0.name = "ST04c"
				var_445_0.transform.parent = arg_442_1.stage_.transform
				var_445_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_442_1.bgs_.ST04c = var_445_0
			end

			if 2 < arg_442_1.time_ and arg_442_1.time_ <= 2 + arg_445_0 then
				local var_445_1 = arg_442_1.bgs_.ST04c

				arg_442_1.bgs_.ST04c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_445_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_445_2 = var_445_1:GetComponent("SpriteRenderer")

				if var_445_2 and var_445_2.sprite then
					local var_445_3 = 2 * (var_445_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_445_1.transform.localScale = Vector3.New(var_445_3 / var_445_2.sprite.bounds.size.y < var_445_3 * manager.ui.mainCameraCom_.aspect / var_445_2.sprite.bounds.size.x and var_445_3 * manager.ui.mainCameraCom_.aspect / var_445_2.sprite.bounds.size.x or var_445_3 / var_445_2.sprite.bounds.size.y, var_445_3 / var_445_2.sprite.bounds.size.y < var_445_3 * manager.ui.mainCameraCom_.aspect / var_445_2.sprite.bounds.size.x and var_445_3 * manager.ui.mainCameraCom_.aspect / var_445_2.sprite.bounds.size.x or var_445_3 / var_445_2.sprite.bounds.size.y, 0)
				end

				for iter_445_0, iter_445_1 in pairs(arg_442_1.bgs_) do
					if iter_445_0 ~= "ST04c" then
						iter_445_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_445_4 = 3.999999999999

			if 3.999999999999 < arg_442_1.time_ and arg_442_1.time_ <= var_445_4 + arg_445_0 then
				arg_442_1.allBtn_.enabled = false
			end

			if arg_442_1.time_ >= var_445_4 + 0.3 and arg_442_1.time_ < var_445_4 + 0.3 + arg_445_0 then
				arg_442_1.allBtn_.enabled = true
			end

			local var_445_5 = 0

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_5 + arg_445_0 then
				arg_442_1.mask_.enabled = true
				arg_442_1.mask_.raycastTarget = true

				arg_442_1:SetGaussion(false)
			end

			local var_445_6 = 2

			if var_445_5 <= arg_442_1.time_ and arg_442_1.time_ < var_445_5 + var_445_6 then
				local var_445_7 = Color.New(0, 0, 0)

				var_445_7.a = Mathf.Lerp(0, 1, (arg_442_1.time_ - var_445_5) / var_445_6)
				arg_442_1.mask_.color = var_445_7
			end

			if arg_442_1.time_ >= var_445_5 + var_445_6 and arg_442_1.time_ < var_445_5 + var_445_6 + arg_445_0 then
				local var_445_8 = Color.New(0, 0, 0)

				var_445_8.a = 1
				arg_442_1.mask_.color = var_445_8
			end

			local var_445_9 = 2

			if 2 < arg_442_1.time_ and arg_442_1.time_ <= var_445_9 + arg_445_0 then
				arg_442_1.mask_.enabled = true
				arg_442_1.mask_.raycastTarget = true

				arg_442_1:SetGaussion(false)
			end

			local var_445_10 = 2

			if var_445_9 <= arg_442_1.time_ and arg_442_1.time_ < var_445_9 + var_445_10 then
				local var_445_11 = Color.New(0, 0, 0)

				var_445_11.a = Mathf.Lerp(1, 0, (arg_442_1.time_ - var_445_9) / var_445_10)
				arg_442_1.mask_.color = var_445_11
			end

			if arg_442_1.time_ >= var_445_9 + var_445_10 and arg_442_1.time_ < var_445_9 + var_445_10 + arg_445_0 then
				local var_445_12 = Color.New(0, 0, 0)

				arg_442_1.mask_.enabled = false
				var_445_12.a = 0
				arg_442_1.mask_.color = var_445_12
			end

			local var_445_13 = arg_442_1.actors_["102003ui_story"].transform

			if 1.96599999815226 < arg_442_1.time_ and arg_442_1.time_ <= 1.96599999815226 + arg_445_0 then
				arg_442_1.var_.moveOldPos102003ui_story = var_445_13.localPosition
			end

			local var_445_14 = 0.001

			if 1.96599999815226 <= arg_442_1.time_ and arg_442_1.time_ < 1.96599999815226 + var_445_14 then
				var_445_13.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_442_1.time_ - 1.96599999815226) / var_445_14)
				var_445_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_445_13.position).x, (manager.ui.mainCamera.transform.position - var_445_13.position).y, (manager.ui.mainCamera.transform.position - var_445_13.position).z)
				var_445_13.localEulerAngles.z = 0
				var_445_13.localEulerAngles.x = 0
				var_445_13.localEulerAngles = var_445_13.localEulerAngles
			end

			if arg_442_1.time_ >= 1.96599999815226 + var_445_14 and arg_442_1.time_ < 1.96599999815226 + var_445_14 + arg_445_0 then
				var_445_13.localPosition = Vector3.New(0, 100, 0)
				var_445_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_445_13.position).x, (manager.ui.mainCamera.transform.position - var_445_13.position).y, (manager.ui.mainCamera.transform.position - var_445_13.position).z)
				var_445_13.localEulerAngles.z = 0
				var_445_13.localEulerAngles.x = 0
				var_445_13.localEulerAngles = var_445_13.localEulerAngles
			end

			local var_445_15 = arg_442_1.actors_["102003ui_story"]

			if 1.96599999815226 < arg_442_1.time_ and arg_442_1.time_ <= 1.96599999815226 + arg_445_0 and not isNil(var_445_15) and arg_442_1.var_.characterEffect102003ui_story == nil then
				arg_442_1.var_.characterEffect102003ui_story = var_445_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_16 = 0.034000001847744

			if 1.96599999815226 <= arg_442_1.time_ and arg_442_1.time_ < 1.96599999815226 + var_445_16 and not isNil(var_445_15) then
				if arg_442_1.var_.characterEffect102003ui_story and not isNil(var_445_15) then
					arg_442_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_442_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_442_1.time_ - 1.96599999815226) / var_445_16)
				end
			end

			if arg_442_1.time_ >= 1.96599999815226 + var_445_16 and arg_442_1.time_ < 1.96599999815226 + var_445_16 + arg_445_0 and not isNil(var_445_15) and arg_442_1.var_.characterEffect102003ui_story then
				arg_442_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_442_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_445_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_442_1.bgmTxt_.text ~= var_445_19 and arg_442_1.bgmTxt_.text ~= "" then
						if arg_442_1.bgmTxt2_.text ~= "" then
							arg_442_1.bgmTxt_.text = arg_442_1.bgmTxt2_.text
						end

						arg_442_1.bgmTxt2_.text = var_445_19

						arg_442_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_442_1.bgmTxt_.text = var_445_19
						arg_442_1.bgmTxt2_.text = var_445_19
					end

					if arg_442_1.bgmTimer then
						arg_442_1.bgmTimer:Stop()

						arg_442_1.bgmTimer = nil
					end

					if arg_442_1.settingData.show_music_name == 1 then
						arg_442_1.musicController:SetSelectedState("show")
						arg_442_1.musicAnimator_:Play("open", 0, 0)

						if arg_442_1.settingData.music_time ~= 0 then
							arg_442_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_442_1.settingData.music_time), function()
								if arg_442_1 == nil or isNil(arg_442_1.bgmTxt_) then
									return
								end

								arg_442_1.musicController:SetSelectedState("hide")
								arg_442_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_442_1.time_ and arg_442_1.time_ <= 0.4 + arg_445_0 then
				arg_442_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_445_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_442_1.bgmTxt_.text ~= var_445_22 and arg_442_1.bgmTxt_.text ~= "" then
						if arg_442_1.bgmTxt2_.text ~= "" then
							arg_442_1.bgmTxt_.text = arg_442_1.bgmTxt2_.text
						end

						arg_442_1.bgmTxt2_.text = var_445_22

						arg_442_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_442_1.bgmTxt_.text = var_445_22
						arg_442_1.bgmTxt2_.text = var_445_22
					end

					if arg_442_1.bgmTimer then
						arg_442_1.bgmTimer:Stop()

						arg_442_1.bgmTimer = nil
					end

					if arg_442_1.settingData.show_music_name == 1 then
						arg_442_1.musicController:SetSelectedState("show")
						arg_442_1.musicAnimator_:Play("open", 0, 0)

						if arg_442_1.settingData.music_time ~= 0 then
							arg_442_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_442_1.settingData.music_time), function()
								if arg_442_1 == nil or isNil(arg_442_1.bgmTxt_) then
									return
								end

								arg_442_1.musicController:SetSelectedState("hide")
								arg_442_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.6 < arg_442_1.time_ and arg_442_1.time_ <= 1.6 + arg_445_0 then
				arg_442_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0.125 < arg_442_1.time_ and arg_442_1.time_ <= 0.125 + arg_445_0 then
				arg_442_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			if arg_442_1.frameCnt_ <= 1 then
				arg_442_1.dialog_:SetActive(false)
			end

			local var_445_25 = 3.999999999999
			local var_445_26 = 0.875

			if 3.999999999999 < arg_442_1.time_ and arg_442_1.time_ <= var_445_25 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0

				arg_442_1.dialog_:SetActive(true)

				arg_442_1.dialogCg_.alpha = 0

				local var_445_27 = LeanTween.value(arg_442_1.dialog_, 0, 1, 0.3)

				var_445_27:setOnUpdate(LuaHelper.FloatAction(function(arg_448_0)
					arg_442_1.dialogCg_.alpha = arg_448_0
				end))
				var_445_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_442_1.dialog_)
					var_445_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_442_1.duration_ = arg_442_1.duration_ + 0.3

				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_28 = arg_442_1:FormatText(arg_442_1:GetWordFromCfg(924031104).content)

				arg_442_1.text_.text = var_445_28

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_30 = 35 <= 0 and var_445_26 or var_445_26 * (utf8.len(var_445_28) / 35)

				if (35 <= 0 and var_445_26 or var_445_26 * (utf8.len(var_445_28) / 35)) > 0 and var_445_26 < var_445_30 then
					arg_442_1.talkMaxDuration = var_445_30
					var_445_25 = var_445_25 + 0.3

					if var_445_30 + var_445_25 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_30 + var_445_25
					end
				end

				arg_442_1.text_.text = var_445_28
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_31 = var_445_25 + 0.3
			local var_445_32 = math.max(var_445_26, arg_442_1.talkMaxDuration)

			if var_445_25 + 0.3 <= arg_442_1.time_ and arg_442_1.time_ < var_445_31 + var_445_32 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_31) / var_445_32

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_31 + var_445_32 and arg_442_1.time_ < var_445_31 + var_445_32 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play924031105 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 924031105
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play924031106(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0.9

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, false)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_1 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(924031105).content)

				arg_450_1.text_.text = var_453_1

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_3 = 36 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_1) / 36)

				if (36 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_1) / 36)) > 0 and var_453_0 < var_453_3 then
					arg_450_1.talkMaxDuration = var_453_3

					if var_453_3 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_3 + 0
					end
				end

				arg_450_1.text_.text = var_453_1
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_4 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_4 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_4

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_4 and arg_450_1.time_ < 0 + var_453_4 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play924031106 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 924031106
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play924031107(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0.35

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
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

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_1 = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(924031106).content)

				arg_454_1.text_.text = var_457_1

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_3 = 14 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 14)

				if (14 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 14)) > 0 and var_457_0 < var_457_3 then
					arg_454_1.talkMaxDuration = var_457_3

					if var_457_3 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_3 + 0
					end
				end

				arg_454_1.text_.text = var_457_1
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_4 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_4 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_4

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_4 and arg_454_1.time_ < 0 + var_457_4 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play924031107 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 924031107
		arg_458_1.duration_ = 6.9

		local var_458_0 = {
			zh = 4.1,
			ja = 6.9
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play924031108(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos102003ui_story = arg_458_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_461_0 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 then
				arg_458_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_458_1.time_ - 0) / var_461_0)
				arg_458_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["102003ui_story"].transform.position).z)
				arg_458_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["102003ui_story"].transform.localEulerAngles = arg_458_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 then
				arg_458_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_458_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["102003ui_story"].transform.position).z)
				arg_458_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["102003ui_story"].transform.localEulerAngles = arg_458_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_461_1 = arg_458_1.actors_["102003ui_story"]

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(var_461_1) and arg_458_1.var_.characterEffect102003ui_story == nil then
				arg_458_1.var_.characterEffect102003ui_story = var_461_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_2 and not isNil(var_461_1) then
				if arg_458_1.var_.characterEffect102003ui_story and not isNil(var_461_1) then
					arg_458_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 0 + var_461_2 and arg_458_1.time_ < 0 + var_461_2 + arg_461_0 and not isNil(var_461_1) and arg_458_1.var_.characterEffect102003ui_story then
				arg_458_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_461_4 = 0
			local var_461_5 = 0.475

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_4 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_6 = arg_458_1:GetWordFromCfg(924031107)
				local var_461_7 = arg_458_1:FormatText(var_461_6.content)

				arg_458_1.text_.text = var_461_7

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_9 = 19 <= 0 and var_461_5 or var_461_5 * (utf8.len(var_461_7) / 19)

				if (19 <= 0 and var_461_5 or var_461_5 * (utf8.len(var_461_7) / 19)) > 0 and var_461_5 < var_461_9 then
					arg_458_1.talkMaxDuration = var_461_9

					if var_461_9 + var_461_4 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_9 + var_461_4
					end
				end

				arg_458_1.text_.text = var_461_7
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031107", "story_v_side_old_924031.awb") ~= 0 then
					local var_461_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031107", "story_v_side_old_924031.awb") / 1000

					if var_461_10 + var_461_4 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_10 + var_461_4
					end

					if var_461_6.prefab_name ~= "" and arg_458_1.actors_[var_461_6.prefab_name] ~= nil then
						local var_461_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_6.prefab_name].transform, "story_v_side_old_924031", "924031107", "story_v_side_old_924031.awb")

						arg_458_1:RecordAudio("924031107", var_461_11)
						arg_458_1:RecordAudio("924031107", var_461_11)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031107", "story_v_side_old_924031.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031107", "story_v_side_old_924031.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_12 = math.max(var_461_5, arg_458_1.talkMaxDuration)

			if var_461_4 <= arg_458_1.time_ and arg_458_1.time_ < var_461_4 + var_461_12 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_4) / var_461_12

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_4 + var_461_12 and arg_458_1.time_ < var_461_4 + var_461_12 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031108 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 924031108
		arg_462_1.duration_ = 18.1

		local var_462_0 = {
			zh = 11.866,
			ja = 18.1
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play924031109(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action4_1")
			end

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_465_0 = 0
			local var_465_1 = 1.275

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_2 = arg_462_1:GetWordFromCfg(924031108)
				local var_465_3 = arg_462_1:FormatText(var_465_2.content)

				arg_462_1.text_.text = var_465_3

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_5 = 51 <= 0 and var_465_1 or var_465_1 * (utf8.len(var_465_3) / 51)

				if (51 <= 0 and var_465_1 or var_465_1 * (utf8.len(var_465_3) / 51)) > 0 and var_465_1 < var_465_5 then
					arg_462_1.talkMaxDuration = var_465_5

					if var_465_5 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_5 + var_465_0
					end
				end

				arg_462_1.text_.text = var_465_3
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031108", "story_v_side_old_924031.awb") ~= 0 then
					local var_465_6 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031108", "story_v_side_old_924031.awb") / 1000

					if var_465_6 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_6 + var_465_0
					end

					if var_465_2.prefab_name ~= "" and arg_462_1.actors_[var_465_2.prefab_name] ~= nil then
						local var_465_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_2.prefab_name].transform, "story_v_side_old_924031", "924031108", "story_v_side_old_924031.awb")

						arg_462_1:RecordAudio("924031108", var_465_7)
						arg_462_1:RecordAudio("924031108", var_465_7)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031108", "story_v_side_old_924031.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031108", "story_v_side_old_924031.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_8 = math.max(var_465_1, arg_462_1.talkMaxDuration)

			if var_465_0 <= arg_462_1.time_ and arg_462_1.time_ < var_465_0 + var_465_8 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_0) / var_465_8

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_0 + var_465_8 and arg_462_1.time_ < var_465_0 + var_465_8 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play924031109 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 924031109
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play924031110(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["102003ui_story"]) and arg_466_1.var_.characterEffect102003ui_story == nil then
				arg_466_1.var_.characterEffect102003ui_story = arg_466_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["102003ui_story"]) then
				if arg_466_1.var_.characterEffect102003ui_story and not isNil(arg_466_1.actors_["102003ui_story"]) then
					arg_466_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_466_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_0)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["102003ui_story"]) and arg_466_1.var_.characterEffect102003ui_story then
				arg_466_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_466_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_469_1 = 0
			local var_469_2 = 0.525

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_3 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(924031109).content)

				arg_466_1.text_.text = var_469_3

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 21 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_3) / 21)

				if (21 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_3) / 21)) > 0 and var_469_2 < var_469_5 then
					arg_466_1.talkMaxDuration = var_469_5

					if var_469_5 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + var_469_1
					end
				end

				arg_466_1.text_.text = var_469_3
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_6 = math.max(var_469_2, arg_466_1.talkMaxDuration)

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_6 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_1) / var_469_6

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_1 + var_469_6 and arg_466_1.time_ < var_469_1 + var_469_6 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play924031110 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 924031110
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play924031111(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos102003ui_story = arg_470_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["102003ui_story"].transform.position).z)
				arg_470_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["102003ui_story"].transform.localEulerAngles = arg_470_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_470_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["102003ui_story"].transform.position).z)
				arg_470_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["102003ui_story"].transform.localEulerAngles = arg_470_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_473_1 = 0
			local var_473_2 = 0.925

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_3 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(924031110).content)

				arg_470_1.text_.text = var_473_3

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 37 <= 0 and var_473_2 or var_473_2 * (utf8.len(var_473_3) / 37)

				if (37 <= 0 and var_473_2 or var_473_2 * (utf8.len(var_473_3) / 37)) > 0 and var_473_2 < var_473_5 then
					arg_470_1.talkMaxDuration = var_473_5

					if var_473_5 + var_473_1 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + var_473_1
					end
				end

				arg_470_1.text_.text = var_473_3
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_6 = math.max(var_473_2, arg_470_1.talkMaxDuration)

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_6 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_1) / var_473_6

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_1 + var_473_6 and arg_470_1.time_ < var_473_1 + var_473_6 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031111 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 924031111
		arg_474_1.duration_ = 4.47

		local var_474_0 = {
			zh = 3.233,
			ja = 4.466
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play924031112(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos102003ui_story = arg_474_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_477_0 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 then
				arg_474_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_474_1.time_ - 0) / var_477_0)
				arg_474_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["102003ui_story"].transform.position).z)
				arg_474_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["102003ui_story"].transform.localEulerAngles = arg_474_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 then
				arg_474_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_474_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["102003ui_story"].transform.position).z)
				arg_474_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["102003ui_story"].transform.localEulerAngles = arg_474_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_477_1 = arg_474_1.actors_["102003ui_story"]

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(var_477_1) and arg_474_1.var_.characterEffect102003ui_story == nil then
				arg_474_1.var_.characterEffect102003ui_story = var_477_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_2 and not isNil(var_477_1) then
				if arg_474_1.var_.characterEffect102003ui_story and not isNil(var_477_1) then
					arg_474_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= 0 + var_477_2 and arg_474_1.time_ < 0 + var_477_2 + arg_477_0 and not isNil(var_477_1) and arg_474_1.var_.characterEffect102003ui_story then
				arg_474_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action4_2")
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_477_4 = 0
			local var_477_5 = 0.35

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_4 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_6 = arg_474_1:GetWordFromCfg(924031111)
				local var_477_7 = arg_474_1:FormatText(var_477_6.content)

				arg_474_1.text_.text = var_477_7

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_9 = 14 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 14)

				if (14 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 14)) > 0 and var_477_5 < var_477_9 then
					arg_474_1.talkMaxDuration = var_477_9

					if var_477_9 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_9 + var_477_4
					end
				end

				arg_474_1.text_.text = var_477_7
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031111", "story_v_side_old_924031.awb") ~= 0 then
					local var_477_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031111", "story_v_side_old_924031.awb") / 1000

					if var_477_10 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_10 + var_477_4
					end

					if var_477_6.prefab_name ~= "" and arg_474_1.actors_[var_477_6.prefab_name] ~= nil then
						local var_477_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_6.prefab_name].transform, "story_v_side_old_924031", "924031111", "story_v_side_old_924031.awb")

						arg_474_1:RecordAudio("924031111", var_477_11)
						arg_474_1:RecordAudio("924031111", var_477_11)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031111", "story_v_side_old_924031.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031111", "story_v_side_old_924031.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_12 = math.max(var_477_5, arg_474_1.talkMaxDuration)

			if var_477_4 <= arg_474_1.time_ and arg_474_1.time_ < var_477_4 + var_477_12 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_4) / var_477_12

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_4 + var_477_12 and arg_474_1.time_ < var_477_4 + var_477_12 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031112 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 924031112
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play924031113(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(arg_478_1.actors_["102003ui_story"]) and arg_478_1.var_.characterEffect102003ui_story == nil then
				arg_478_1.var_.characterEffect102003ui_story = arg_478_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_0 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 and not isNil(arg_478_1.actors_["102003ui_story"]) then
				if arg_478_1.var_.characterEffect102003ui_story and not isNil(arg_478_1.actors_["102003ui_story"]) then
					arg_478_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_478_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_478_1.time_ - 0) / var_481_0)
				end
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 and not isNil(arg_478_1.actors_["102003ui_story"]) and arg_478_1.var_.characterEffect102003ui_story then
				arg_478_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_478_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_481_1 = 0
			local var_481_2 = 0.225

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_3 = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(924031112).content)

				arg_478_1.text_.text = var_481_3

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 9 <= 0 and var_481_2 or var_481_2 * (utf8.len(var_481_3) / 9)

				if (9 <= 0 and var_481_2 or var_481_2 * (utf8.len(var_481_3) / 9)) > 0 and var_481_2 < var_481_5 then
					arg_478_1.talkMaxDuration = var_481_5

					if var_481_5 + var_481_1 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_5 + var_481_1
					end
				end

				arg_478_1.text_.text = var_481_3
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_6 = math.max(var_481_2, arg_478_1.talkMaxDuration)

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_6 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_1) / var_481_6

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_1 + var_481_6 and arg_478_1.time_ < var_481_1 + var_481_6 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play924031113 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 924031113
		arg_482_1.duration_ = 9.33

		local var_482_0 = {
			zh = 8.233,
			ja = 9.333
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play924031114(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.var_.moveOldPos102003ui_story = arg_482_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_485_0 = 0.001

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 then
				arg_482_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_482_1.time_ - 0) / var_485_0)
				arg_482_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_482_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["102003ui_story"].transform.position).z)
				arg_482_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_482_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_482_1.actors_["102003ui_story"].transform.localEulerAngles = arg_482_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 then
				arg_482_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_482_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_482_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_482_1.actors_["102003ui_story"].transform.position).z)
				arg_482_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_482_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_482_1.actors_["102003ui_story"].transform.localEulerAngles = arg_482_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_485_1 = arg_482_1.actors_["102003ui_story"]

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(var_485_1) and arg_482_1.var_.characterEffect102003ui_story == nil then
				arg_482_1.var_.characterEffect102003ui_story = var_485_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_2 and not isNil(var_485_1) then
				if arg_482_1.var_.characterEffect102003ui_story and not isNil(var_485_1) then
					arg_482_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= 0 + var_485_2 and arg_482_1.time_ < 0 + var_485_2 + arg_485_0 and not isNil(var_485_1) and arg_482_1.var_.characterEffect102003ui_story then
				arg_482_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_485_4 = 0
			local var_485_5 = 0.625

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_4 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_6 = arg_482_1:GetWordFromCfg(924031113)
				local var_485_7 = arg_482_1:FormatText(var_485_6.content)

				arg_482_1.text_.text = var_485_7

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_9 = 25 <= 0 and var_485_5 or var_485_5 * (utf8.len(var_485_7) / 25)

				if (25 <= 0 and var_485_5 or var_485_5 * (utf8.len(var_485_7) / 25)) > 0 and var_485_5 < var_485_9 then
					arg_482_1.talkMaxDuration = var_485_9

					if var_485_9 + var_485_4 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_9 + var_485_4
					end
				end

				arg_482_1.text_.text = var_485_7
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031113", "story_v_side_old_924031.awb") ~= 0 then
					local var_485_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031113", "story_v_side_old_924031.awb") / 1000

					if var_485_10 + var_485_4 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_10 + var_485_4
					end

					if var_485_6.prefab_name ~= "" and arg_482_1.actors_[var_485_6.prefab_name] ~= nil then
						local var_485_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_6.prefab_name].transform, "story_v_side_old_924031", "924031113", "story_v_side_old_924031.awb")

						arg_482_1:RecordAudio("924031113", var_485_11)
						arg_482_1:RecordAudio("924031113", var_485_11)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031113", "story_v_side_old_924031.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031113", "story_v_side_old_924031.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_12 = math.max(var_485_5, arg_482_1.talkMaxDuration)

			if var_485_4 <= arg_482_1.time_ and arg_482_1.time_ < var_485_4 + var_485_12 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_4) / var_485_12

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_4 + var_485_12 and arg_482_1.time_ < var_485_4 + var_485_12 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031114 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 924031114
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play924031115(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(arg_486_1.actors_["102003ui_story"]) and arg_486_1.var_.characterEffect102003ui_story == nil then
				arg_486_1.var_.characterEffect102003ui_story = arg_486_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_0 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 and not isNil(arg_486_1.actors_["102003ui_story"]) then
				if arg_486_1.var_.characterEffect102003ui_story and not isNil(arg_486_1.actors_["102003ui_story"]) then
					arg_486_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_486_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_486_1.time_ - 0) / var_489_0)
				end
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 and not isNil(arg_486_1.actors_["102003ui_story"]) and arg_486_1.var_.characterEffect102003ui_story then
				arg_486_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_486_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_489_1 = 0
			local var_489_2 = 0.275

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_3 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(924031114).content)

				arg_486_1.text_.text = var_489_3

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_5 = 11 <= 0 and var_489_2 or var_489_2 * (utf8.len(var_489_3) / 11)

				if (11 <= 0 and var_489_2 or var_489_2 * (utf8.len(var_489_3) / 11)) > 0 and var_489_2 < var_489_5 then
					arg_486_1.talkMaxDuration = var_489_5

					if var_489_5 + var_489_1 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_5 + var_489_1
					end
				end

				arg_486_1.text_.text = var_489_3
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_6 = math.max(var_489_2, arg_486_1.talkMaxDuration)

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_6 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_1) / var_489_6

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_1 + var_489_6 and arg_486_1.time_ < var_489_1 + var_489_6 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play924031115 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 924031115
		arg_490_1.duration_ = 9.47

		local var_490_0 = {
			zh = 6.233,
			ja = 9.466
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play924031116(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["102003ui_story"]) and arg_490_1.var_.characterEffect102003ui_story == nil then
				arg_490_1.var_.characterEffect102003ui_story = arg_490_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_0 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["102003ui_story"]) then
				if arg_490_1.var_.characterEffect102003ui_story and not isNil(arg_490_1.actors_["102003ui_story"]) then
					arg_490_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["102003ui_story"]) and arg_490_1.var_.characterEffect102003ui_story then
				arg_490_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_493_2 = 0
			local var_493_3 = 0.575

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_2 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_4 = arg_490_1:GetWordFromCfg(924031115)
				local var_493_5 = arg_490_1:FormatText(var_493_4.content)

				arg_490_1.text_.text = var_493_5

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_7 = 23 <= 0 and var_493_3 or var_493_3 * (utf8.len(var_493_5) / 23)

				if (23 <= 0 and var_493_3 or var_493_3 * (utf8.len(var_493_5) / 23)) > 0 and var_493_3 < var_493_7 then
					arg_490_1.talkMaxDuration = var_493_7

					if var_493_7 + var_493_2 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_7 + var_493_2
					end
				end

				arg_490_1.text_.text = var_493_5
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031115", "story_v_side_old_924031.awb") ~= 0 then
					local var_493_8 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031115", "story_v_side_old_924031.awb") / 1000

					if var_493_8 + var_493_2 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_2
					end

					if var_493_4.prefab_name ~= "" and arg_490_1.actors_[var_493_4.prefab_name] ~= nil then
						local var_493_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_4.prefab_name].transform, "story_v_side_old_924031", "924031115", "story_v_side_old_924031.awb")

						arg_490_1:RecordAudio("924031115", var_493_9)
						arg_490_1:RecordAudio("924031115", var_493_9)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031115", "story_v_side_old_924031.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031115", "story_v_side_old_924031.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_10 = math.max(var_493_3, arg_490_1.talkMaxDuration)

			if var_493_2 <= arg_490_1.time_ and arg_490_1.time_ < var_493_2 + var_493_10 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_2) / var_493_10

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_2 + var_493_10 and arg_490_1.time_ < var_493_2 + var_493_10 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play924031116 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 924031116
		arg_494_1.duration_ = 15.43

		local var_494_0 = {
			zh = 9.166,
			ja = 15.433
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play924031117(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.975

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_1 = arg_494_1:GetWordFromCfg(924031116)
				local var_497_2 = arg_494_1:FormatText(var_497_1.content)

				arg_494_1.text_.text = var_497_2

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_4 = 39 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 39)

				if (39 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 39)) > 0 and var_497_0 < var_497_4 then
					arg_494_1.talkMaxDuration = var_497_4

					if var_497_4 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_4 + 0
					end
				end

				arg_494_1.text_.text = var_497_2
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031116", "story_v_side_old_924031.awb") ~= 0 then
					local var_497_5 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031116", "story_v_side_old_924031.awb") / 1000

					if var_497_5 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + 0
					end

					if var_497_1.prefab_name ~= "" and arg_494_1.actors_[var_497_1.prefab_name] ~= nil then
						local var_497_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_1.prefab_name].transform, "story_v_side_old_924031", "924031116", "story_v_side_old_924031.awb")

						arg_494_1:RecordAudio("924031116", var_497_6)
						arg_494_1:RecordAudio("924031116", var_497_6)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031116", "story_v_side_old_924031.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031116", "story_v_side_old_924031.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_7 = math.max(var_497_0, arg_494_1.talkMaxDuration)

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_7 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - 0) / var_497_7

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= 0 + var_497_7 and arg_494_1.time_ < 0 + var_497_7 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play924031117 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 924031117
		arg_498_1.duration_ = 13.43

		local var_498_0 = {
			zh = 11.1,
			ja = 13.433
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play924031118(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action486")
			end

			local var_501_0 = 0
			local var_501_1 = 1

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_2 = arg_498_1:GetWordFromCfg(924031117)
				local var_501_3 = arg_498_1:FormatText(var_501_2.content)

				arg_498_1.text_.text = var_501_3

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_5 = 40 <= 0 and var_501_1 or var_501_1 * (utf8.len(var_501_3) / 40)

				if (40 <= 0 and var_501_1 or var_501_1 * (utf8.len(var_501_3) / 40)) > 0 and var_501_1 < var_501_5 then
					arg_498_1.talkMaxDuration = var_501_5

					if var_501_5 + var_501_0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_5 + var_501_0
					end
				end

				arg_498_1.text_.text = var_501_3
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031117", "story_v_side_old_924031.awb") ~= 0 then
					local var_501_6 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031117", "story_v_side_old_924031.awb") / 1000

					if var_501_6 + var_501_0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_6 + var_501_0
					end

					if var_501_2.prefab_name ~= "" and arg_498_1.actors_[var_501_2.prefab_name] ~= nil then
						local var_501_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_2.prefab_name].transform, "story_v_side_old_924031", "924031117", "story_v_side_old_924031.awb")

						arg_498_1:RecordAudio("924031117", var_501_7)
						arg_498_1:RecordAudio("924031117", var_501_7)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031117", "story_v_side_old_924031.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031117", "story_v_side_old_924031.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_8 = math.max(var_501_1, arg_498_1.talkMaxDuration)

			if var_501_0 <= arg_498_1.time_ and arg_498_1.time_ < var_501_0 + var_501_8 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_0) / var_501_8

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_0 + var_501_8 and arg_498_1.time_ < var_501_0 + var_501_8 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play924031118 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 924031118
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play924031119(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(arg_502_1.actors_["102003ui_story"]) and arg_502_1.var_.characterEffect102003ui_story == nil then
				arg_502_1.var_.characterEffect102003ui_story = arg_502_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_0 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 and not isNil(arg_502_1.actors_["102003ui_story"]) then
				if arg_502_1.var_.characterEffect102003ui_story and not isNil(arg_502_1.actors_["102003ui_story"]) then
					arg_502_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_502_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_502_1.time_ - 0) / var_505_0)
				end
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 and not isNil(arg_502_1.actors_["102003ui_story"]) and arg_502_1.var_.characterEffect102003ui_story then
				arg_502_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_502_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_505_1 = 0
			local var_505_2 = 0.25

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
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

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_3 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(924031118).content)

				arg_502_1.text_.text = var_505_3

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 10 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_3) / 10)

				if (10 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_3) / 10)) > 0 and var_505_2 < var_505_5 then
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
	Play924031119 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 924031119
		arg_506_1.duration_ = 5.63

		local var_506_0 = {
			zh = 4.333,
			ja = 5.633
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play924031120(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.var_.moveOldPos102003ui_story = arg_506_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_509_0 = 0.001

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 then
				arg_506_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_506_1.time_ - 0) / var_509_0)
				arg_506_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_506_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["102003ui_story"].transform.position).z)
				arg_506_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_506_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_506_1.actors_["102003ui_story"].transform.localEulerAngles = arg_506_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 then
				arg_506_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_506_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_506_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["102003ui_story"].transform.position).z)
				arg_506_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_506_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_506_1.actors_["102003ui_story"].transform.localEulerAngles = arg_506_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_509_1 = arg_506_1.actors_["102003ui_story"]

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(var_509_1) and arg_506_1.var_.characterEffect102003ui_story == nil then
				arg_506_1.var_.characterEffect102003ui_story = var_509_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_2 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_2 and not isNil(var_509_1) then
				if arg_506_1.var_.characterEffect102003ui_story and not isNil(var_509_1) then
					arg_506_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= 0 + var_509_2 and arg_506_1.time_ < 0 + var_509_2 + arg_509_0 and not isNil(var_509_1) and arg_506_1.var_.characterEffect102003ui_story then
				arg_506_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action464")
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_509_4 = 0
			local var_509_5 = 0.425

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_4 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_6 = arg_506_1:GetWordFromCfg(924031119)
				local var_509_7 = arg_506_1:FormatText(var_509_6.content)

				arg_506_1.text_.text = var_509_7

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_9 = 17 <= 0 and var_509_5 or var_509_5 * (utf8.len(var_509_7) / 17)

				if (17 <= 0 and var_509_5 or var_509_5 * (utf8.len(var_509_7) / 17)) > 0 and var_509_5 < var_509_9 then
					arg_506_1.talkMaxDuration = var_509_9

					if var_509_9 + var_509_4 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_9 + var_509_4
					end
				end

				arg_506_1.text_.text = var_509_7
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031119", "story_v_side_old_924031.awb") ~= 0 then
					local var_509_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031119", "story_v_side_old_924031.awb") / 1000

					if var_509_10 + var_509_4 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_10 + var_509_4
					end

					if var_509_6.prefab_name ~= "" and arg_506_1.actors_[var_509_6.prefab_name] ~= nil then
						local var_509_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_6.prefab_name].transform, "story_v_side_old_924031", "924031119", "story_v_side_old_924031.awb")

						arg_506_1:RecordAudio("924031119", var_509_11)
						arg_506_1:RecordAudio("924031119", var_509_11)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031119", "story_v_side_old_924031.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031119", "story_v_side_old_924031.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_12 = math.max(var_509_5, arg_506_1.talkMaxDuration)

			if var_509_4 <= arg_506_1.time_ and arg_506_1.time_ < var_509_4 + var_509_12 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_4) / var_509_12

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_4 + var_509_12 and arg_506_1.time_ < var_509_4 + var_509_12 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_506_1:InitPlayNodeList()
	end,
	Play924031120 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 924031120
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play924031121(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.var_.moveOldPos102003ui_story = arg_510_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_513_0 = 0.001

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 then
				arg_510_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_510_1.time_ - 0) / var_513_0)
				arg_510_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["102003ui_story"].transform.position).z)
				arg_510_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["102003ui_story"].transform.localEulerAngles = arg_510_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 then
				arg_510_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_510_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["102003ui_story"].transform.position).z)
				arg_510_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["102003ui_story"].transform.localEulerAngles = arg_510_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_513_1 = arg_510_1.actors_["102003ui_story"]

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(var_513_1) and arg_510_1.var_.characterEffect102003ui_story == nil then
				arg_510_1.var_.characterEffect102003ui_story = var_513_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_2 and not isNil(var_513_1) then
				if arg_510_1.var_.characterEffect102003ui_story and not isNil(var_513_1) then
					arg_510_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_510_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_510_1.time_ - 0) / var_513_2)
				end
			end

			if arg_510_1.time_ >= 0 + var_513_2 and arg_510_1.time_ < 0 + var_513_2 + arg_513_0 and not isNil(var_513_1) and arg_510_1.var_.characterEffect102003ui_story then
				arg_510_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_510_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_513_3 = 0
			local var_513_4 = 0.85

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_3 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_5 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(924031120).content)

				arg_510_1.text_.text = var_513_5

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_7 = 34 <= 0 and var_513_4 or var_513_4 * (utf8.len(var_513_5) / 34)

				if (34 <= 0 and var_513_4 or var_513_4 * (utf8.len(var_513_5) / 34)) > 0 and var_513_4 < var_513_7 then
					arg_510_1.talkMaxDuration = var_513_7

					if var_513_7 + var_513_3 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_7 + var_513_3
					end
				end

				arg_510_1.text_.text = var_513_5
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_8 = math.max(var_513_4, arg_510_1.talkMaxDuration)

			if var_513_3 <= arg_510_1.time_ and arg_510_1.time_ < var_513_3 + var_513_8 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_3) / var_513_8

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_3 + var_513_8 and arg_510_1.time_ < var_513_3 + var_513_8 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031121 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 924031121
		arg_514_1.duration_ = 19.1

		local var_514_0 = {
			zh = 17,
			ja = 19.1
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play924031122(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos102003ui_story = arg_514_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_517_0 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 then
				arg_514_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_514_1.time_ - 0) / var_517_0)
				arg_514_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["102003ui_story"].transform.position).z)
				arg_514_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["102003ui_story"].transform.localEulerAngles = arg_514_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 then
				arg_514_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_514_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["102003ui_story"].transform.position).z)
				arg_514_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["102003ui_story"].transform.localEulerAngles = arg_514_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_517_1 = arg_514_1.actors_["102003ui_story"]

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(var_517_1) and arg_514_1.var_.characterEffect102003ui_story == nil then
				arg_514_1.var_.characterEffect102003ui_story = var_517_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_2 and not isNil(var_517_1) then
				if arg_514_1.var_.characterEffect102003ui_story and not isNil(var_517_1) then
					arg_514_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 0 + var_517_2 and arg_514_1.time_ < 0 + var_517_2 + arg_517_0 and not isNil(var_517_1) and arg_514_1.var_.characterEffect102003ui_story then
				arg_514_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_517_4 = 0
			local var_517_5 = 1.5

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_4 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_6 = arg_514_1:GetWordFromCfg(924031121)
				local var_517_7 = arg_514_1:FormatText(var_517_6.content)

				arg_514_1.text_.text = var_517_7

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_9 = 60 <= 0 and var_517_5 or var_517_5 * (utf8.len(var_517_7) / 60)

				if (60 <= 0 and var_517_5 or var_517_5 * (utf8.len(var_517_7) / 60)) > 0 and var_517_5 < var_517_9 then
					arg_514_1.talkMaxDuration = var_517_9

					if var_517_9 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_9 + var_517_4
					end
				end

				arg_514_1.text_.text = var_517_7
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031121", "story_v_side_old_924031.awb") ~= 0 then
					local var_517_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031121", "story_v_side_old_924031.awb") / 1000

					if var_517_10 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_10 + var_517_4
					end

					if var_517_6.prefab_name ~= "" and arg_514_1.actors_[var_517_6.prefab_name] ~= nil then
						local var_517_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_6.prefab_name].transform, "story_v_side_old_924031", "924031121", "story_v_side_old_924031.awb")

						arg_514_1:RecordAudio("924031121", var_517_11)
						arg_514_1:RecordAudio("924031121", var_517_11)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031121", "story_v_side_old_924031.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031121", "story_v_side_old_924031.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_12 = math.max(var_517_5, arg_514_1.talkMaxDuration)

			if var_517_4 <= arg_514_1.time_ and arg_514_1.time_ < var_517_4 + var_517_12 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_4) / var_517_12

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_4 + var_517_12 and arg_514_1.time_ < var_517_4 + var_517_12 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play924031122 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 924031122
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play924031123(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["102003ui_story"]) and arg_518_1.var_.characterEffect102003ui_story == nil then
				arg_518_1.var_.characterEffect102003ui_story = arg_518_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_0 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["102003ui_story"]) then
				if arg_518_1.var_.characterEffect102003ui_story and not isNil(arg_518_1.actors_["102003ui_story"]) then
					arg_518_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_518_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_0)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["102003ui_story"]) and arg_518_1.var_.characterEffect102003ui_story then
				arg_518_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_518_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_521_1 = 0
			local var_521_2 = 0.375

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
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

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_3 = arg_518_1:FormatText(arg_518_1:GetWordFromCfg(924031122).content)

				arg_518_1.text_.text = var_521_3

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_5 = 15 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_3) / 15)

				if (15 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_3) / 15)) > 0 and var_521_2 < var_521_5 then
					arg_518_1.talkMaxDuration = var_521_5

					if var_521_5 + var_521_1 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_5 + var_521_1
					end
				end

				arg_518_1.text_.text = var_521_3
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_6 = math.max(var_521_2, arg_518_1.talkMaxDuration)

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_6 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_1) / var_521_6

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_1 + var_521_6 and arg_518_1.time_ < var_521_1 + var_521_6 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play924031123 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 924031123
		arg_522_1.duration_ = 14.9

		local var_522_0 = {
			zh = 11.1,
			ja = 14.9
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play924031124(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.var_.moveOldPos102003ui_story = arg_522_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_525_0 = 0.001

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 then
				arg_522_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_522_1.time_ - 0) / var_525_0)
				arg_522_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_522_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["102003ui_story"].transform.position).z)
				arg_522_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_522_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_522_1.actors_["102003ui_story"].transform.localEulerAngles = arg_522_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 then
				arg_522_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_522_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_522_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["102003ui_story"].transform.position).z)
				arg_522_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_522_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_522_1.actors_["102003ui_story"].transform.localEulerAngles = arg_522_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_525_1 = arg_522_1.actors_["102003ui_story"]

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(var_525_1) and arg_522_1.var_.characterEffect102003ui_story == nil then
				arg_522_1.var_.characterEffect102003ui_story = var_525_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_2 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_2 and not isNil(var_525_1) then
				if arg_522_1.var_.characterEffect102003ui_story and not isNil(var_525_1) then
					arg_522_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= 0 + var_525_2 and arg_522_1.time_ < 0 + var_525_2 + arg_525_0 and not isNil(var_525_1) and arg_522_1.var_.characterEffect102003ui_story then
				arg_522_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action5_1")
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_525_4 = 0
			local var_525_5 = 1.35

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_4 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_6 = arg_522_1:GetWordFromCfg(924031123)
				local var_525_7 = arg_522_1:FormatText(var_525_6.content)

				arg_522_1.text_.text = var_525_7

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_9 = 54 <= 0 and var_525_5 or var_525_5 * (utf8.len(var_525_7) / 54)

				if (54 <= 0 and var_525_5 or var_525_5 * (utf8.len(var_525_7) / 54)) > 0 and var_525_5 < var_525_9 then
					arg_522_1.talkMaxDuration = var_525_9

					if var_525_9 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_9 + var_525_4
					end
				end

				arg_522_1.text_.text = var_525_7
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031123", "story_v_side_old_924031.awb") ~= 0 then
					local var_525_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031123", "story_v_side_old_924031.awb") / 1000

					if var_525_10 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_10 + var_525_4
					end

					if var_525_6.prefab_name ~= "" and arg_522_1.actors_[var_525_6.prefab_name] ~= nil then
						local var_525_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_6.prefab_name].transform, "story_v_side_old_924031", "924031123", "story_v_side_old_924031.awb")

						arg_522_1:RecordAudio("924031123", var_525_11)
						arg_522_1:RecordAudio("924031123", var_525_11)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031123", "story_v_side_old_924031.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031123", "story_v_side_old_924031.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_12 = math.max(var_525_5, arg_522_1.talkMaxDuration)

			if var_525_4 <= arg_522_1.time_ and arg_522_1.time_ < var_525_4 + var_525_12 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_4) / var_525_12

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_4 + var_525_12 and arg_522_1.time_ < var_525_4 + var_525_12 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031124 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 924031124
		arg_526_1.duration_ = 14

		local var_526_0 = {
			zh = 11.233,
			ja = 14
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play924031125(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0.9

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_1 = arg_526_1:GetWordFromCfg(924031124)
				local var_529_2 = arg_526_1:FormatText(var_529_1.content)

				arg_526_1.text_.text = var_529_2

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_4 = 36 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_2) / 36)

				if (36 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_2) / 36)) > 0 and var_529_0 < var_529_4 then
					arg_526_1.talkMaxDuration = var_529_4

					if var_529_4 + 0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_4 + 0
					end
				end

				arg_526_1.text_.text = var_529_2
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031124", "story_v_side_old_924031.awb") ~= 0 then
					local var_529_5 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031124", "story_v_side_old_924031.awb") / 1000

					if var_529_5 + 0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_5 + 0
					end

					if var_529_1.prefab_name ~= "" and arg_526_1.actors_[var_529_1.prefab_name] ~= nil then
						local var_529_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_1.prefab_name].transform, "story_v_side_old_924031", "924031124", "story_v_side_old_924031.awb")

						arg_526_1:RecordAudio("924031124", var_529_6)
						arg_526_1:RecordAudio("924031124", var_529_6)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031124", "story_v_side_old_924031.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031124", "story_v_side_old_924031.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_7 = math.max(var_529_0, arg_526_1.talkMaxDuration)

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_7 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - 0) / var_529_7

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= 0 + var_529_7 and arg_526_1.time_ < 0 + var_529_7 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play924031125 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 924031125
		arg_530_1.duration_ = 14.43

		local var_530_0 = {
			zh = 12.4,
			ja = 14.433
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play924031126(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1.var_.moveOldPos102003ui_story = arg_530_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_533_0 = 0.001

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 then
				arg_530_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_530_1.time_ - 0) / var_533_0)
				arg_530_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_530_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["102003ui_story"].transform.position).z)
				arg_530_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_530_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_530_1.actors_["102003ui_story"].transform.localEulerAngles = arg_530_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 then
				arg_530_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_530_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_530_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["102003ui_story"].transform.position).z)
				arg_530_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_530_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_530_1.actors_["102003ui_story"].transform.localEulerAngles = arg_530_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action456")
			end

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_533_1 = 0
			local var_533_2 = 0.9

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_3 = arg_530_1:GetWordFromCfg(924031125)
				local var_533_4 = arg_530_1:FormatText(var_533_3.content)

				arg_530_1.text_.text = var_533_4

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_6 = 36 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_4) / 36)

				if (36 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_4) / 36)) > 0 and var_533_2 < var_533_6 then
					arg_530_1.talkMaxDuration = var_533_6

					if var_533_6 + var_533_1 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_6 + var_533_1
					end
				end

				arg_530_1.text_.text = var_533_4
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031125", "story_v_side_old_924031.awb") ~= 0 then
					local var_533_7 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031125", "story_v_side_old_924031.awb") / 1000

					if var_533_7 + var_533_1 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_7 + var_533_1
					end

					if var_533_3.prefab_name ~= "" and arg_530_1.actors_[var_533_3.prefab_name] ~= nil then
						local var_533_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_3.prefab_name].transform, "story_v_side_old_924031", "924031125", "story_v_side_old_924031.awb")

						arg_530_1:RecordAudio("924031125", var_533_8)
						arg_530_1:RecordAudio("924031125", var_533_8)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031125", "story_v_side_old_924031.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031125", "story_v_side_old_924031.awb")
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
				actorName = "102003ui_story",
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
	Play924031126 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 924031126
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play924031127(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.var_.moveOldPos102003ui_story = arg_534_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_537_0 = 0.001

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_0 then
				arg_534_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_534_1.time_ - 0) / var_537_0)
				arg_534_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_534_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["102003ui_story"].transform.position).z)
				arg_534_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_534_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_534_1.actors_["102003ui_story"].transform.localEulerAngles = arg_534_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_534_1.time_ >= 0 + var_537_0 and arg_534_1.time_ < 0 + var_537_0 + arg_537_0 then
				arg_534_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_534_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_534_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["102003ui_story"].transform.position).z)
				arg_534_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_534_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_534_1.actors_["102003ui_story"].transform.localEulerAngles = arg_534_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_537_1 = arg_534_1.actors_["102003ui_story"]

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(var_537_1) and arg_534_1.var_.characterEffect102003ui_story == nil then
				arg_534_1.var_.characterEffect102003ui_story = var_537_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_2 = 0.200000002980232

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_2 and not isNil(var_537_1) then
				if arg_534_1.var_.characterEffect102003ui_story and not isNil(var_537_1) then
					arg_534_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_534_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_534_1.time_ - 0) / var_537_2)
				end
			end

			if arg_534_1.time_ >= 0 + var_537_2 and arg_534_1.time_ < 0 + var_537_2 + arg_537_0 and not isNil(var_537_1) and arg_534_1.var_.characterEffect102003ui_story then
				arg_534_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_534_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_537_3 = 0
			local var_537_4 = 0.975

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_3 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, false)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_5 = arg_534_1:FormatText(arg_534_1:GetWordFromCfg(924031126).content)

				arg_534_1.text_.text = var_537_5

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_7 = 39 <= 0 and var_537_4 or var_537_4 * (utf8.len(var_537_5) / 39)

				if (39 <= 0 and var_537_4 or var_537_4 * (utf8.len(var_537_5) / 39)) > 0 and var_537_4 < var_537_7 then
					arg_534_1.talkMaxDuration = var_537_7

					if var_537_7 + var_537_3 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_7 + var_537_3
					end
				end

				arg_534_1.text_.text = var_537_5
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_8 = math.max(var_537_4, arg_534_1.talkMaxDuration)

			if var_537_3 <= arg_534_1.time_ and arg_534_1.time_ < var_537_3 + var_537_8 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_3) / var_537_8

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_3 + var_537_8 and arg_534_1.time_ < var_537_3 + var_537_8 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031127 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 924031127
		arg_538_1.duration_ = 6.3

		local var_538_0 = {
			zh = 5.133,
			ja = 6.3
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play924031128(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.var_.moveOldPos102003ui_story = arg_538_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_541_0 = 0.001

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 then
				arg_538_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_538_1.time_ - 0) / var_541_0)
				arg_538_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).z)
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles = arg_538_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 then
				arg_538_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_538_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).z)
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles = arg_538_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_541_1 = arg_538_1.actors_["102003ui_story"]

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(var_541_1) and arg_538_1.var_.characterEffect102003ui_story == nil then
				arg_538_1.var_.characterEffect102003ui_story = var_541_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_2 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_2 and not isNil(var_541_1) then
				if arg_538_1.var_.characterEffect102003ui_story and not isNil(var_541_1) then
					arg_538_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= 0 + var_541_2 and arg_538_1.time_ < 0 + var_541_2 + arg_541_0 and not isNil(var_541_1) and arg_538_1.var_.characterEffect102003ui_story then
				arg_538_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_2")
			end

			local var_541_4 = 0
			local var_541_5 = 0.325

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_4 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_6 = arg_538_1:GetWordFromCfg(924031127)
				local var_541_7 = arg_538_1:FormatText(var_541_6.content)

				arg_538_1.text_.text = var_541_7

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_9 = 13 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 13)

				if (13 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 13)) > 0 and var_541_5 < var_541_9 then
					arg_538_1.talkMaxDuration = var_541_9

					if var_541_9 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_9 + var_541_4
					end
				end

				arg_538_1.text_.text = var_541_7
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031127", "story_v_side_old_924031.awb") ~= 0 then
					local var_541_10 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031127", "story_v_side_old_924031.awb") / 1000

					if var_541_10 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_10 + var_541_4
					end

					if var_541_6.prefab_name ~= "" and arg_538_1.actors_[var_541_6.prefab_name] ~= nil then
						local var_541_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_6.prefab_name].transform, "story_v_side_old_924031", "924031127", "story_v_side_old_924031.awb")

						arg_538_1:RecordAudio("924031127", var_541_11)
						arg_538_1:RecordAudio("924031127", var_541_11)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031127", "story_v_side_old_924031.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031127", "story_v_side_old_924031.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_12 = math.max(var_541_5, arg_538_1.talkMaxDuration)

			if var_541_4 <= arg_538_1.time_ and arg_538_1.time_ < var_541_4 + var_541_12 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_4) / var_541_12

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_4 + var_541_12 and arg_538_1.time_ < var_541_4 + var_541_12 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924031128 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 924031128
		arg_542_1.duration_ = 2.93

		local var_542_0 = {
			zh = 2.933,
			ja = 2.733
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play924031129(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_545_0 = 0
			local var_545_1 = 0.25

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_2 = arg_542_1:GetWordFromCfg(924031128)
				local var_545_3 = arg_542_1:FormatText(var_545_2.content)

				arg_542_1.text_.text = var_545_3

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_5 = 10 <= 0 and var_545_1 or var_545_1 * (utf8.len(var_545_3) / 10)

				if (10 <= 0 and var_545_1 or var_545_1 * (utf8.len(var_545_3) / 10)) > 0 and var_545_1 < var_545_5 then
					arg_542_1.talkMaxDuration = var_545_5

					if var_545_5 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_5 + var_545_0
					end
				end

				arg_542_1.text_.text = var_545_3
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031128", "story_v_side_old_924031.awb") ~= 0 then
					local var_545_6 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031128", "story_v_side_old_924031.awb") / 1000

					if var_545_6 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_6 + var_545_0
					end

					if var_545_2.prefab_name ~= "" and arg_542_1.actors_[var_545_2.prefab_name] ~= nil then
						local var_545_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_2.prefab_name].transform, "story_v_side_old_924031", "924031128", "story_v_side_old_924031.awb")

						arg_542_1:RecordAudio("924031128", var_545_7)
						arg_542_1:RecordAudio("924031128", var_545_7)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031128", "story_v_side_old_924031.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031128", "story_v_side_old_924031.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_8 = math.max(var_545_1, arg_542_1.talkMaxDuration)

			if var_545_0 <= arg_542_1.time_ and arg_542_1.time_ < var_545_0 + var_545_8 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_0) / var_545_8

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_0 + var_545_8 and arg_542_1.time_ < var_545_0 + var_545_8 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play924031129 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 924031129
		arg_546_1.duration_ = 9

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play924031130(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			if 2 < arg_546_1.time_ and arg_546_1.time_ <= 2 + arg_549_0 then
				local var_549_0 = arg_546_1.bgs_.STblack

				arg_546_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_549_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_549_1 = var_549_0:GetComponent("SpriteRenderer")

				if var_549_1 and var_549_1.sprite then
					local var_549_2 = 2 * (var_549_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_549_0.transform.localScale = Vector3.New(var_549_2 / var_549_1.sprite.bounds.size.y < var_549_2 * manager.ui.mainCameraCom_.aspect / var_549_1.sprite.bounds.size.x and var_549_2 * manager.ui.mainCameraCom_.aspect / var_549_1.sprite.bounds.size.x or var_549_2 / var_549_1.sprite.bounds.size.y, var_549_2 / var_549_1.sprite.bounds.size.y < var_549_2 * manager.ui.mainCameraCom_.aspect / var_549_1.sprite.bounds.size.x and var_549_2 * manager.ui.mainCameraCom_.aspect / var_549_1.sprite.bounds.size.x or var_549_2 / var_549_1.sprite.bounds.size.y, 0)
				end

				for iter_549_0, iter_549_1 in pairs(arg_546_1.bgs_) do
					if iter_549_0 ~= "STblack" then
						iter_549_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_549_3 = 3.999999999999

			if 3.999999999999 < arg_546_1.time_ and arg_546_1.time_ <= var_549_3 + arg_549_0 then
				arg_546_1.allBtn_.enabled = false
			end

			if arg_546_1.time_ >= var_549_3 + 0.3 and arg_546_1.time_ < var_549_3 + 0.3 + arg_549_0 then
				arg_546_1.allBtn_.enabled = true
			end

			local var_549_4 = 0

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_4 + arg_549_0 then
				arg_546_1.mask_.enabled = true
				arg_546_1.mask_.raycastTarget = true

				arg_546_1:SetGaussion(false)
			end

			local var_549_5 = 2

			if var_549_4 <= arg_546_1.time_ and arg_546_1.time_ < var_549_4 + var_549_5 then
				local var_549_6 = Color.New(0, 0, 0)

				var_549_6.a = Mathf.Lerp(0, 1, (arg_546_1.time_ - var_549_4) / var_549_5)
				arg_546_1.mask_.color = var_549_6
			end

			if arg_546_1.time_ >= var_549_4 + var_549_5 and arg_546_1.time_ < var_549_4 + var_549_5 + arg_549_0 then
				local var_549_7 = Color.New(0, 0, 0)

				var_549_7.a = 1
				arg_546_1.mask_.color = var_549_7
			end

			local var_549_8 = 2

			if 2 < arg_546_1.time_ and arg_546_1.time_ <= var_549_8 + arg_549_0 then
				arg_546_1.mask_.enabled = true
				arg_546_1.mask_.raycastTarget = true

				arg_546_1:SetGaussion(false)
			end

			local var_549_9 = 2

			if var_549_8 <= arg_546_1.time_ and arg_546_1.time_ < var_549_8 + var_549_9 then
				local var_549_10 = Color.New(0, 0, 0)

				var_549_10.a = Mathf.Lerp(1, 0, (arg_546_1.time_ - var_549_8) / var_549_9)
				arg_546_1.mask_.color = var_549_10
			end

			if arg_546_1.time_ >= var_549_8 + var_549_9 and arg_546_1.time_ < var_549_8 + var_549_9 + arg_549_0 then
				local var_549_11 = Color.New(0, 0, 0)

				arg_546_1.mask_.enabled = false
				var_549_11.a = 0
				arg_546_1.mask_.color = var_549_11
			end

			local var_549_12 = arg_546_1.actors_["102003ui_story"].transform

			if 1.96599999815226 < arg_546_1.time_ and arg_546_1.time_ <= 1.96599999815226 + arg_549_0 then
				arg_546_1.var_.moveOldPos102003ui_story = var_549_12.localPosition
			end

			local var_549_13 = 0.001

			if 1.96599999815226 <= arg_546_1.time_ and arg_546_1.time_ < 1.96599999815226 + var_549_13 then
				var_549_12.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_546_1.time_ - 1.96599999815226) / var_549_13)
				var_549_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_549_12.position).x, (manager.ui.mainCamera.transform.position - var_549_12.position).y, (manager.ui.mainCamera.transform.position - var_549_12.position).z)
				var_549_12.localEulerAngles.z = 0
				var_549_12.localEulerAngles.x = 0
				var_549_12.localEulerAngles = var_549_12.localEulerAngles
			end

			if arg_546_1.time_ >= 1.96599999815226 + var_549_13 and arg_546_1.time_ < 1.96599999815226 + var_549_13 + arg_549_0 then
				var_549_12.localPosition = Vector3.New(0, 100, 0)
				var_549_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_549_12.position).x, (manager.ui.mainCamera.transform.position - var_549_12.position).y, (manager.ui.mainCamera.transform.position - var_549_12.position).z)
				var_549_12.localEulerAngles.z = 0
				var_549_12.localEulerAngles.x = 0
				var_549_12.localEulerAngles = var_549_12.localEulerAngles
			end

			local var_549_14 = arg_546_1.actors_["102003ui_story"]

			if 1.96599999815226 < arg_546_1.time_ and arg_546_1.time_ <= 1.96599999815226 + arg_549_0 and not isNil(var_549_14) and arg_546_1.var_.characterEffect102003ui_story == nil then
				arg_546_1.var_.characterEffect102003ui_story = var_549_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_549_15 = 0.034000001847744

			if 1.96599999815226 <= arg_546_1.time_ and arg_546_1.time_ < 1.96599999815226 + var_549_15 and not isNil(var_549_14) then
				if arg_546_1.var_.characterEffect102003ui_story and not isNil(var_549_14) then
					arg_546_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_546_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_546_1.time_ - 1.96599999815226) / var_549_15)
				end
			end

			if arg_546_1.time_ >= 1.96599999815226 + var_549_15 and arg_546_1.time_ < 1.96599999815226 + var_549_15 + arg_549_0 and not isNil(var_549_14) and arg_546_1.var_.characterEffect102003ui_story then
				arg_546_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_546_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if arg_546_1.frameCnt_ <= 1 then
				arg_546_1.dialog_:SetActive(false)
			end

			local var_549_16 = 3.999999999999
			local var_549_17 = 0.625

			if 3.999999999999 < arg_546_1.time_ and arg_546_1.time_ <= var_549_16 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0

				arg_546_1.dialog_:SetActive(true)

				arg_546_1.dialogCg_.alpha = 0

				local var_549_18 = LeanTween.value(arg_546_1.dialog_, 0, 1, 0.3)

				var_549_18:setOnUpdate(LuaHelper.FloatAction(function(arg_550_0)
					arg_546_1.dialogCg_.alpha = arg_550_0
				end))
				var_549_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_546_1.dialog_)
					var_549_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_546_1.duration_ = arg_546_1.duration_ + 0.3

				SetActive(arg_546_1.leftNameGo_, false)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_19 = arg_546_1:FormatText(arg_546_1:GetWordFromCfg(924031129).content)

				arg_546_1.text_.text = var_549_19

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_21 = 25 <= 0 and var_549_17 or var_549_17 * (utf8.len(var_549_19) / 25)

				if (25 <= 0 and var_549_17 or var_549_17 * (utf8.len(var_549_19) / 25)) > 0 and var_549_17 < var_549_21 then
					arg_546_1.talkMaxDuration = var_549_21
					var_549_16 = var_549_16 + 0.3

					if var_549_21 + var_549_16 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_21 + var_549_16
					end
				end

				arg_546_1.text_.text = var_549_19
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_22 = var_549_16 + 0.3
			local var_549_23 = math.max(var_549_17, arg_546_1.talkMaxDuration)

			if var_549_16 + 0.3 <= arg_546_1.time_ and arg_546_1.time_ < var_549_22 + var_549_23 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_22) / var_549_23

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_22 + var_549_23 and arg_546_1.time_ < var_549_22 + var_549_23 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_546_1:InitPlayNodeList()
	end,
	Play924031130 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 924031130
		arg_552_1.duration_ = 1.23

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play924031131(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.fswbg_:SetActive(true)
				arg_552_1.dialog_:SetActive(false)

				arg_552_1.fswtw_.percent = 0
				arg_552_1.fswt_.text = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(924031130).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.fswt_)

				arg_552_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_552_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_552_1.fswtw_:SetDirty()

				arg_552_1.typewritterCharCountI18N = 0

				SetActive(arg_552_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_552_1:ShowNextGo(false)
			end

			local var_555_0 = 0.1

			if 0.1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				arg_552_1.var_.oldValueTypewriter = arg_552_1.fswtw_.percent

				SetActive(arg_552_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_552_1:ShowNextGo(false)
			end

			local var_555_1 = 17
			local var_555_2 = 1.13333333333333
			local var_555_3, var_555_4 = arg_552_1:GetPercentByPara(arg_552_1:FormatText(arg_552_1:GetWordFromCfg(924031130).content), 1)

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0

				local var_555_5 = var_555_1 <= 0 and var_555_2 or var_555_2 * ((var_555_4 - arg_552_1.typewritterCharCountI18N) / var_555_1)

				if (var_555_1 <= 0 and var_555_2 or var_555_2 * ((var_555_4 - arg_552_1.typewritterCharCountI18N) / var_555_1)) > 0 and var_555_2 < var_555_5 then
					arg_552_1.talkMaxDuration = var_555_5

					if var_555_5 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + var_555_0
					end
				end
			end

			local var_555_6 = math.max(1.13333333333333, arg_552_1.talkMaxDuration)

			if var_555_0 <= arg_552_1.time_ and arg_552_1.time_ < var_555_0 + var_555_6 then
				arg_552_1.fswtw_.percent = Mathf.Lerp(arg_552_1.var_.oldValueTypewriter, var_555_3, (arg_552_1.time_ - var_555_0) / var_555_6)
				arg_552_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_552_1.fswtw_:SetDirty()
			end

			if arg_552_1.time_ >= var_555_0 + var_555_6 and arg_552_1.time_ < var_555_0 + var_555_6 + arg_555_0 then
				arg_552_1.fswtw_.percent = var_555_3

				arg_552_1.fswtw_:SetDirty()
				arg_552_1:ShowNextGo(true)

				arg_552_1.typewritterCharCountI18N = var_555_4
			end

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				local var_555_7 = arg_552_1.fswbg_.transform:Find("textbox/adapt/content") or arg_552_1.fswbg_.transform:Find("textbox/content")
				local var_555_8 = arg_552_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_555_9 = var_555_7:GetComponent("RectTransform")

				var_555_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_555_9.offsetMin = Vector2.New(0, 0)
				var_555_9.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play924031131 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 924031131
		arg_556_1.duration_ = 1.23

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play924031132(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.fswbg_:SetActive(true)
				arg_556_1.dialog_:SetActive(false)

				arg_556_1.fswtw_.percent = 0
				arg_556_1.fswt_.text = arg_556_1:FormatText(arg_556_1:GetWordFromCfg(924031131).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.fswt_)

				arg_556_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_556_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_556_1.fswtw_:SetDirty()

				arg_556_1.typewritterCharCountI18N = 0

				SetActive(arg_556_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_556_1:ShowNextGo(false)
			end

			local var_559_0 = 0.1

			if 0.1 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				arg_556_1.var_.oldValueTypewriter = arg_556_1.fswtw_.percent

				SetActive(arg_556_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_556_1:ShowNextGo(false)
			end

			local var_559_1 = 17
			local var_559_2 = 1.13333333333333
			local var_559_3, var_559_4 = arg_556_1:GetPercentByPara(arg_556_1:FormatText(arg_556_1:GetWordFromCfg(924031131).content), 1)

			if var_559_0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0

				local var_559_5 = var_559_1 <= 0 and var_559_2 or var_559_2 * ((var_559_4 - arg_556_1.typewritterCharCountI18N) / var_559_1)

				if (var_559_1 <= 0 and var_559_2 or var_559_2 * ((var_559_4 - arg_556_1.typewritterCharCountI18N) / var_559_1)) > 0 and var_559_2 < var_559_5 then
					arg_556_1.talkMaxDuration = var_559_5

					if var_559_5 + var_559_0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_5 + var_559_0
					end
				end
			end

			local var_559_6 = math.max(1.13333333333333, arg_556_1.talkMaxDuration)

			if var_559_0 <= arg_556_1.time_ and arg_556_1.time_ < var_559_0 + var_559_6 then
				arg_556_1.fswtw_.percent = Mathf.Lerp(arg_556_1.var_.oldValueTypewriter, var_559_3, (arg_556_1.time_ - var_559_0) / var_559_6)
				arg_556_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_556_1.fswtw_:SetDirty()
			end

			if arg_556_1.time_ >= var_559_0 + var_559_6 and arg_556_1.time_ < var_559_0 + var_559_6 + arg_559_0 then
				arg_556_1.fswtw_.percent = var_559_3

				arg_556_1.fswtw_:SetDirty()
				arg_556_1:ShowNextGo(true)

				arg_556_1.typewritterCharCountI18N = var_559_4
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play924031132 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 924031132
		arg_560_1.duration_ = 9

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play924031133(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			if 2 < arg_560_1.time_ and arg_560_1.time_ <= 2 + arg_563_0 then
				local var_563_0 = arg_560_1.bgs_.X204_f

				arg_560_1.bgs_.X204_f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_563_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_563_1 = var_563_0:GetComponent("SpriteRenderer")

				if var_563_1 and var_563_1.sprite then
					local var_563_2 = 2 * (var_563_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_563_0.transform.localScale = Vector3.New(var_563_2 / var_563_1.sprite.bounds.size.y < var_563_2 * manager.ui.mainCameraCom_.aspect / var_563_1.sprite.bounds.size.x and var_563_2 * manager.ui.mainCameraCom_.aspect / var_563_1.sprite.bounds.size.x or var_563_2 / var_563_1.sprite.bounds.size.y, var_563_2 / var_563_1.sprite.bounds.size.y < var_563_2 * manager.ui.mainCameraCom_.aspect / var_563_1.sprite.bounds.size.x and var_563_2 * manager.ui.mainCameraCom_.aspect / var_563_1.sprite.bounds.size.x or var_563_2 / var_563_1.sprite.bounds.size.y, 0)
				end

				for iter_563_0, iter_563_1 in pairs(arg_560_1.bgs_) do
					if iter_563_0 ~= "X204_f" then
						iter_563_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_563_3 = 3.999999999999

			if 3.999999999999 < arg_560_1.time_ and arg_560_1.time_ <= var_563_3 + arg_563_0 then
				arg_560_1.allBtn_.enabled = false
			end

			if arg_560_1.time_ >= var_563_3 + 0.3 and arg_560_1.time_ < var_563_3 + 0.3 + arg_563_0 then
				arg_560_1.allBtn_.enabled = true
			end

			local var_563_4 = 0

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_4 + arg_563_0 then
				arg_560_1.mask_.enabled = true
				arg_560_1.mask_.raycastTarget = true

				arg_560_1:SetGaussion(false)
			end

			local var_563_5 = 2

			if var_563_4 <= arg_560_1.time_ and arg_560_1.time_ < var_563_4 + var_563_5 then
				local var_563_6 = Color.New(0, 0, 0)

				var_563_6.a = Mathf.Lerp(0, 1, (arg_560_1.time_ - var_563_4) / var_563_5)
				arg_560_1.mask_.color = var_563_6
			end

			if arg_560_1.time_ >= var_563_4 + var_563_5 and arg_560_1.time_ < var_563_4 + var_563_5 + arg_563_0 then
				local var_563_7 = Color.New(0, 0, 0)

				var_563_7.a = 1
				arg_560_1.mask_.color = var_563_7
			end

			local var_563_8 = 2

			if 2 < arg_560_1.time_ and arg_560_1.time_ <= var_563_8 + arg_563_0 then
				arg_560_1.mask_.enabled = true
				arg_560_1.mask_.raycastTarget = true

				arg_560_1:SetGaussion(false)
			end

			local var_563_9 = 2

			if var_563_8 <= arg_560_1.time_ and arg_560_1.time_ < var_563_8 + var_563_9 then
				local var_563_10 = Color.New(0, 0, 0)

				var_563_10.a = Mathf.Lerp(1, 0, (arg_560_1.time_ - var_563_8) / var_563_9)
				arg_560_1.mask_.color = var_563_10
			end

			if arg_560_1.time_ >= var_563_8 + var_563_9 and arg_560_1.time_ < var_563_8 + var_563_9 + arg_563_0 then
				local var_563_11 = Color.New(0, 0, 0)

				arg_560_1.mask_.enabled = false
				var_563_11.a = 0
				arg_560_1.mask_.color = var_563_11
			end

			if 2 < arg_560_1.time_ and arg_560_1.time_ <= 2 + arg_563_0 then
				arg_560_1.fswbg_:SetActive(false)
				arg_560_1.dialog_:SetActive(false)
				SetActive(arg_560_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_560_1:ShowNextGo(false)
			end

			if 0.125 < arg_560_1.time_ and arg_560_1.time_ <= 0.125 + arg_563_0 then
				arg_560_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 1.73333333333333 < arg_560_1.time_ and arg_560_1.time_ <= 1.73333333333333 + arg_563_0 then
				arg_560_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			if arg_560_1.frameCnt_ <= 1 then
				arg_560_1.dialog_:SetActive(false)
			end

			local var_563_14 = 3.999999999999
			local var_563_15 = 0.575

			if 3.999999999999 < arg_560_1.time_ and arg_560_1.time_ <= var_563_14 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0

				arg_560_1.dialog_:SetActive(true)

				arg_560_1.dialogCg_.alpha = 0

				local var_563_16 = LeanTween.value(arg_560_1.dialog_, 0, 1, 0.3)

				var_563_16:setOnUpdate(LuaHelper.FloatAction(function(arg_564_0)
					arg_560_1.dialogCg_.alpha = arg_564_0
				end))
				var_563_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_560_1.dialog_)
					var_563_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_560_1.duration_ = arg_560_1.duration_ + 0.3

				SetActive(arg_560_1.leftNameGo_, false)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_17 = arg_560_1:FormatText(arg_560_1:GetWordFromCfg(924031132).content)

				arg_560_1.text_.text = var_563_17

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_19 = 23 <= 0 and var_563_15 or var_563_15 * (utf8.len(var_563_17) / 23)

				if (23 <= 0 and var_563_15 or var_563_15 * (utf8.len(var_563_17) / 23)) > 0 and var_563_15 < var_563_19 then
					arg_560_1.talkMaxDuration = var_563_19
					var_563_14 = var_563_14 + 0.3

					if var_563_19 + var_563_14 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_19 + var_563_14
					end
				end

				arg_560_1.text_.text = var_563_17
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_20 = var_563_14 + 0.3
			local var_563_21 = math.max(var_563_15, arg_560_1.talkMaxDuration)

			if var_563_14 + 0.3 <= arg_560_1.time_ and arg_560_1.time_ < var_563_20 + var_563_21 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_20) / var_563_21

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_20 + var_563_21 and arg_560_1.time_ < var_563_20 + var_563_21 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play924031133 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 924031133
		arg_566_1.duration_ = 5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play924031134(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0.125

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
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

				arg_566_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_566_1.callingController_:SetSelectedState("normal")

				arg_566_1.keyicon_.color = Color.New(1, 1, 1)
				arg_566_1.icon_.color = Color.New(1, 1, 1)

				local var_569_1 = arg_566_1:FormatText(arg_566_1:GetWordFromCfg(924031133).content)

				arg_566_1.text_.text = var_569_1

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_3 = 5 <= 0 and var_569_0 or var_569_0 * (utf8.len(var_569_1) / 5)

				if (5 <= 0 and var_569_0 or var_569_0 * (utf8.len(var_569_1) / 5)) > 0 and var_569_0 < var_569_3 then
					arg_566_1.talkMaxDuration = var_569_3

					if var_569_3 + 0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_3 + 0
					end
				end

				arg_566_1.text_.text = var_569_1
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_4 = math.max(var_569_0, arg_566_1.talkMaxDuration)

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_4 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - 0) / var_569_4

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= 0 + var_569_4 and arg_566_1.time_ < 0 + var_569_4 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play924031134 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 924031134
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
			arg_570_1.auto_ = false
		end

		function arg_570_1.playNext_(arg_572_0)
			arg_570_1.onStoryFinished_()
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_573_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_570_1.bgmTxt_.text ~= var_573_2 and arg_570_1.bgmTxt_.text ~= "" then
						if arg_570_1.bgmTxt2_.text ~= "" then
							arg_570_1.bgmTxt_.text = arg_570_1.bgmTxt2_.text
						end

						arg_570_1.bgmTxt2_.text = var_573_2

						arg_570_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_570_1.bgmTxt_.text = var_573_2
						arg_570_1.bgmTxt2_.text = var_573_2
					end

					if arg_570_1.bgmTimer then
						arg_570_1.bgmTimer:Stop()

						arg_570_1.bgmTimer = nil
					end

					if arg_570_1.settingData.show_music_name == 1 then
						arg_570_1.musicController:SetSelectedState("show")
						arg_570_1.musicAnimator_:Play("open", 0, 0)

						if arg_570_1.settingData.music_time ~= 0 then
							arg_570_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_570_1.settingData.music_time), function()
								if arg_570_1 == nil or isNil(arg_570_1.bgmTxt_) then
									return
								end

								arg_570_1.musicController:SetSelectedState("hide")
								arg_570_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_573_3 = 0
			local var_573_4 = 0.95

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_3 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, false)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_5 = arg_570_1:FormatText(arg_570_1:GetWordFromCfg(924031134).content)

				arg_570_1.text_.text = var_573_5

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_7 = 38 <= 0 and var_573_4 or var_573_4 * (utf8.len(var_573_5) / 38)

				if (38 <= 0 and var_573_4 or var_573_4 * (utf8.len(var_573_5) / 38)) > 0 and var_573_4 < var_573_7 then
					arg_570_1.talkMaxDuration = var_573_7

					if var_573_7 + var_573_3 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_7 + var_573_3
					end
				end

				arg_570_1.text_.text = var_573_5
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_8 = math.max(var_573_4, arg_570_1.talkMaxDuration)

			if var_573_3 <= arg_570_1.time_ and arg_570_1.time_ < var_573_3 + var_573_8 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_3) / var_573_8

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_3 + var_573_8 and arg_570_1.time_ < var_573_3 + var_573_8 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play924031103 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 924031103
		arg_575_1.duration_ = 4.87

		local var_575_0 = {
			zh = 3.4,
			ja = 4.866
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play924031104(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.var_.moveOldPos102003ui_story = arg_575_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_578_0 = 0.001

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 then
				arg_575_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_575_1.time_ - 0) / var_578_0)
				arg_575_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["102003ui_story"].transform.position).z)
				arg_575_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["102003ui_story"].transform.localEulerAngles = arg_575_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 then
				arg_575_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_575_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["102003ui_story"].transform.position).z)
				arg_575_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["102003ui_story"].transform.localEulerAngles = arg_575_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_578_1 = arg_575_1.actors_["102003ui_story"]

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(var_578_1) and arg_575_1.var_.characterEffect102003ui_story == nil then
				arg_575_1.var_.characterEffect102003ui_story = var_578_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_2 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_2 and not isNil(var_578_1) then
				if arg_575_1.var_.characterEffect102003ui_story and not isNil(var_578_1) then
					arg_575_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= 0 + var_578_2 and arg_575_1.time_ < 0 + var_578_2 + arg_578_0 and not isNil(var_578_1) and arg_575_1.var_.characterEffect102003ui_story then
				arg_575_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_578_4 = "102003ui_story"

			if arg_575_1.actors_["102003ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102003ui_story"))) then
				local var_578_5 = Object.Instantiate(Asset.Load("Char/" .. "102003ui_story"), arg_575_1.stage_.transform)

				var_578_5.name = var_578_4
				var_578_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_575_1.actors_[var_578_4] = var_578_5

				local var_578_6 = var_578_5:GetComponentInChildren(typeof(CharacterEffect))

				var_578_6.enabled = true

				local var_578_7 = GameObjectTools.GetOrAddComponent(var_578_5, typeof(DynamicBoneHelper))

				if var_578_7 then
					var_578_7:EnableDynamicBone(false)
				end

				arg_575_1:ShowWeapon(var_578_6.transform, false)

				arg_575_1.var_[var_578_4 .. "Animator"] = var_578_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_575_1.var_[var_578_4 .. "Animator"].applyRootMotion = true
				arg_575_1.var_[var_578_4 .. "LipSync"] = var_578_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action12_1")
			end

			local var_578_8 = "102003ui_story"

			if arg_575_1.actors_["102003ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102003ui_story"))) then
				local var_578_9 = Object.Instantiate(Asset.Load("Char/" .. "102003ui_story"), arg_575_1.stage_.transform)

				var_578_9.name = var_578_8
				var_578_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_575_1.actors_[var_578_8] = var_578_9

				local var_578_10 = var_578_9:GetComponentInChildren(typeof(CharacterEffect))

				var_578_10.enabled = true

				local var_578_11 = GameObjectTools.GetOrAddComponent(var_578_9, typeof(DynamicBoneHelper))

				if var_578_11 then
					var_578_11:EnableDynamicBone(false)
				end

				arg_575_1:ShowWeapon(var_578_10.transform, false)

				arg_575_1.var_[var_578_8 .. "Animator"] = var_578_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_575_1.var_[var_578_8 .. "Animator"].applyRootMotion = true
				arg_575_1.var_[var_578_8 .. "LipSync"] = var_578_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_578_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_575_1.bgmTxt_.text ~= var_578_14 and arg_575_1.bgmTxt_.text ~= "" then
						if arg_575_1.bgmTxt2_.text ~= "" then
							arg_575_1.bgmTxt_.text = arg_575_1.bgmTxt2_.text
						end

						arg_575_1.bgmTxt2_.text = var_578_14

						arg_575_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_575_1.bgmTxt_.text = var_578_14
						arg_575_1.bgmTxt2_.text = var_578_14
					end

					if arg_575_1.bgmTimer then
						arg_575_1.bgmTimer:Stop()

						arg_575_1.bgmTimer = nil
					end

					if arg_575_1.settingData.show_music_name == 1 then
						arg_575_1.musicController:SetSelectedState("show")
						arg_575_1.musicAnimator_:Play("open", 0, 0)

						if arg_575_1.settingData.music_time ~= 0 then
							arg_575_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_575_1.settingData.music_time), function()
								if arg_575_1 == nil or isNil(arg_575_1.bgmTxt_) then
									return
								end

								arg_575_1.musicController:SetSelectedState("hide")
								arg_575_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_578_15 = 0
			local var_578_16 = 0.075

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_15 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_17 = arg_575_1:GetWordFromCfg(924031103)
				local var_578_18 = arg_575_1:FormatText(var_578_17.content)

				arg_575_1.text_.text = var_578_18

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_20 = 12 <= 0 and var_578_16 or var_578_16 * (utf8.len(var_578_18) / 12)

				if (12 <= 0 and var_578_16 or var_578_16 * (utf8.len(var_578_18) / 12)) > 0 and var_578_16 < var_578_20 then
					arg_575_1.talkMaxDuration = var_578_20

					if var_578_20 + var_578_15 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_20 + var_578_15
					end
				end

				arg_575_1.text_.text = var_578_18
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924031", "924031103", "story_v_side_old_924031.awb") ~= 0 then
					local var_578_21 = manager.audio:GetVoiceLength("story_v_side_old_924031", "924031103", "story_v_side_old_924031.awb") / 1000

					if var_578_21 + var_578_15 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_21 + var_578_15
					end

					if var_578_17.prefab_name ~= "" and arg_575_1.actors_[var_578_17.prefab_name] ~= nil then
						local var_578_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_17.prefab_name].transform, "story_v_side_old_924031", "924031103", "story_v_side_old_924031.awb")

						arg_575_1:RecordAudio("924031103", var_578_22)
						arg_575_1:RecordAudio("924031103", var_578_22)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_side_old_924031", "924031103", "story_v_side_old_924031.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_side_old_924031", "924031103", "story_v_side_old_924031.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_23 = math.max(var_578_16, arg_575_1.talkMaxDuration)

			if var_578_15 <= arg_575_1.time_ and arg_575_1.time_ < var_578_15 + var_578_23 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_15) / var_578_23

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_15 + var_578_23 and arg_575_1.time_ < var_578_15 + var_578_23 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H07j",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/H02",
		"TextureConfig/Background/I17i",
		"TextureConfig/Background/I17l",
		"TextureConfig/Background/I17f",
		"TextureConfig/Background/X204_f",
		"TextureConfig/Background/ST04c"
	},
	voices = {
		"story_v_side_old_924031.awb"
	}
}
