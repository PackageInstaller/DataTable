return {
	Play325111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325111001
		arg_1_1.duration_ = 7.23

		local var_1_0 = {
			zh = 5.265999999999,
			ja = 7.232999999999
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST41 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST41")
				var_4_0.name = "ST41"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST41 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST41

				arg_1_1.bgs_.ST41.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST41" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan")

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

			local var_4_13 = 1.499999999999
			local var_4_14 = 0.5

			if 1.499999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1527].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(325111001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 20 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 20)

				if (20 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 20)) > 0 and var_4_14 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_13 = var_4_13 + 0.3

					if var_4_19 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111001", "story_v_out_325111.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_325111", "325111001", "story_v_out_325111.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_325111", "325111001", "story_v_out_325111.awb")

						arg_1_1:RecordAudio("325111001", var_4_21)
						arg_1_1:RecordAudio("325111001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325111", "325111001", "story_v_out_325111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325111", "325111001", "story_v_out_325111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_13 + 0.3
			local var_4_23 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
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
	Play325111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325111002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1075ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1075ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1075ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1075ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1075ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1075ui_story = var_11_3.localPosition
			end

			local var_11_4 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_8_1.time_ - 0) / var_11_4)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			local var_11_5 = arg_8_1.actors_["1075ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1075ui_story == nil then
				arg_8_1.var_.characterEffect1075ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect1075ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1075ui_story then
				arg_8_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_8 = 0
			local var_11_9 = 0.175

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(325111002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 7 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 7)

				if (7 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 7)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111002", "story_v_out_325111.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_325111", "325111002", "story_v_out_325111.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_325111", "325111002", "story_v_out_325111.awb")

						arg_8_1:RecordAudio("325111002", var_11_15)
						arg_8_1:RecordAudio("325111002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325111", "325111002", "story_v_out_325111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325111", "325111002", "story_v_out_325111.awb")
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
				actorName = "1075ui_story",
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
	Play325111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325111003
		arg_12_1.duration_ = 8.73

		local var_12_0 = {
			zh = 6.6,
			ja = 8.733
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
				arg_12_0:Play325111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1075ui_story"]) and arg_12_1.var_.characterEffect1075ui_story == nil then
				arg_12_1.var_.characterEffect1075ui_story = arg_12_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1075ui_story"]) then
				if arg_12_1.var_.characterEffect1075ui_story and not isNil(arg_12_1.actors_["1075ui_story"]) then
					arg_12_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1075ui_story"]) and arg_12_1.var_.characterEffect1075ui_story then
				arg_12_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.95

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1527].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(325111003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 38 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_4) / 38)

				if (38 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_4) / 38)) > 0 and var_15_2 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111003", "story_v_out_325111.awb") ~= 0 then
					local var_15_7 = manager.audio:GetVoiceLength("story_v_out_325111", "325111003", "story_v_out_325111.awb") / 1000

					if var_15_7 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_1
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_325111", "325111003", "story_v_out_325111.awb")

						arg_12_1:RecordAudio("325111003", var_15_8)
						arg_12_1:RecordAudio("325111003", var_15_8)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325111", "325111003", "story_v_out_325111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325111", "325111003", "story_v_out_325111.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_9 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_9 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_9

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_9 and arg_12_1.time_ < var_15_1 + var_15_9 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325111004
		arg_16_1.duration_ = 7.77

		local var_16_0 = {
			zh = 3.866,
			ja = 7.766
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
				arg_16_0:Play325111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1075ui_story"]) and arg_16_1.var_.characterEffect1075ui_story == nil then
				arg_16_1.var_.characterEffect1075ui_story = arg_16_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1075ui_story"]) then
				if arg_16_1.var_.characterEffect1075ui_story and not isNil(arg_16_1.actors_["1075ui_story"]) then
					arg_16_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1075ui_story"]) and arg_16_1.var_.characterEffect1075ui_story then
				arg_16_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_19_2 = 0
			local var_19_3 = 0.525

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:GetWordFromCfg(325111004)
				local var_19_5 = arg_16_1:FormatText(var_19_4.content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 21 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 21)

				if (21 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 21)) > 0 and var_19_3 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111004", "story_v_out_325111.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_325111", "325111004", "story_v_out_325111.awb") / 1000

					if var_19_8 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_2
					end

					if var_19_4.prefab_name ~= "" and arg_16_1.actors_[var_19_4.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_4.prefab_name].transform, "story_v_out_325111", "325111004", "story_v_out_325111.awb")

						arg_16_1:RecordAudio("325111004", var_19_9)
						arg_16_1:RecordAudio("325111004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325111", "325111004", "story_v_out_325111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325111", "325111004", "story_v_out_325111.awb")
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
	Play325111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325111005
		arg_20_1.duration_ = 6.57

		local var_20_0 = {
			zh = 4.6,
			ja = 6.566
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
				arg_20_0:Play325111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1075ui_story"]) and arg_20_1.var_.characterEffect1075ui_story == nil then
				arg_20_1.var_.characterEffect1075ui_story = arg_20_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1075ui_story"]) then
				if arg_20_1.var_.characterEffect1075ui_story and not isNil(arg_20_1.actors_["1075ui_story"]) then
					arg_20_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1075ui_story"]) and arg_20_1.var_.characterEffect1075ui_story then
				arg_20_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 0.525

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1527].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(325111005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 21 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_4) / 21)

				if (21 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_4) / 21)) > 0 and var_23_2 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111005", "story_v_out_325111.awb") ~= 0 then
					local var_23_7 = manager.audio:GetVoiceLength("story_v_out_325111", "325111005", "story_v_out_325111.awb") / 1000

					if var_23_7 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_1
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_325111", "325111005", "story_v_out_325111.awb")

						arg_20_1:RecordAudio("325111005", var_23_8)
						arg_20_1:RecordAudio("325111005", var_23_8)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325111", "325111005", "story_v_out_325111.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325111", "325111005", "story_v_out_325111.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_9 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_9 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_9

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_9 and arg_20_1.time_ < var_23_1 + var_23_9 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325111006
		arg_24_1.duration_ = 3.93

		local var_24_0 = {
			zh = 1.999999999999,
			ja = 3.933
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
				arg_24_0:Play325111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1075ui_story"]) and arg_24_1.var_.characterEffect1075ui_story == nil then
				arg_24_1.var_.characterEffect1075ui_story = arg_24_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1075ui_story"]) then
				if arg_24_1.var_.characterEffect1075ui_story and not isNil(arg_24_1.actors_["1075ui_story"]) then
					arg_24_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1075ui_story"]) and arg_24_1.var_.characterEffect1075ui_story then
				arg_24_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_27_2 = 0
			local var_27_3 = 0.125

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(325111006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 5 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 5)

				if (5 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 5)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111006", "story_v_out_325111.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_325111", "325111006", "story_v_out_325111.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_325111", "325111006", "story_v_out_325111.awb")

						arg_24_1:RecordAudio("325111006", var_27_9)
						arg_24_1:RecordAudio("325111006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325111", "325111006", "story_v_out_325111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325111", "325111006", "story_v_out_325111.awb")
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
	Play325111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325111007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1075ui_story = arg_28_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1075ui_story"].transform.position).z)
				arg_28_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1075ui_story"].transform.localEulerAngles = arg_28_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1075ui_story"].transform.position).z)
				arg_28_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1075ui_story"].transform.localEulerAngles = arg_28_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_31_1 = arg_28_1.actors_["1075ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1075ui_story == nil then
				arg_28_1.var_.characterEffect1075ui_story = var_31_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 and not isNil(var_31_1) then
				if arg_28_1.var_.characterEffect1075ui_story and not isNil(var_31_1) then
					arg_28_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_2)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1075ui_story then
				arg_28_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_31_3 = 0
			local var_31_4 = 0.75

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

				local var_31_5 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(325111007).content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 30 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 30)

				if (30 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 30)) > 0 and var_31_4 < var_31_7 then
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
				actorName = "1075ui_story",
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
	Play325111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325111008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0.1 < arg_32_1.time_ and arg_32_1.time_ <= 0.1 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_phone", "")
			end

			local var_35_1 = 0
			local var_35_2 = 1.325

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(325111008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 53 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 53)

				if (53 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 53)) > 0 and var_35_2 < var_35_5 then
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
	Play325111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325111009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0.1 < arg_36_1.time_ and arg_36_1.time_ <= 0.1 + arg_39_0 then
				arg_36_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_battle_phone", "")
			end

			local var_39_1 = 0
			local var_39_2 = 1.175

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(325111009).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 47 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 47)

				if (47 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 47)) > 0 and var_39_2 < var_39_5 then
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
	Play325111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325111010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.675

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(325111010).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 27 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 27)

				if (27 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 27)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325111011
		arg_44_1.duration_ = 2.13

		local var_44_0 = {
			zh = 2.133,
			ja = 1.999999999999
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
				arg_44_0:Play325111012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1075ui_story = arg_44_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1075ui_story"].transform.position).z)
				arg_44_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1075ui_story"].transform.localEulerAngles = arg_44_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_44_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1075ui_story"].transform.position).z)
				arg_44_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1075ui_story"].transform.localEulerAngles = arg_44_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1075ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1075ui_story == nil then
				arg_44_1.var_.characterEffect1075ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect1075ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1075ui_story then
				arg_44_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_47_5 = 0
			local var_47_6 = 0.1

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_7 = arg_44_1:GetWordFromCfg(325111011)
				local var_47_8 = arg_44_1:FormatText(var_47_7.content)

				arg_44_1.text_.text = var_47_8

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 4 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_8) / 4)

				if (4 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_8) / 4)) > 0 and var_47_6 < var_47_10 then
					arg_44_1.talkMaxDuration = var_47_10

					if var_47_10 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_8
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111011", "story_v_out_325111.awb") ~= 0 then
					local var_47_11 = manager.audio:GetVoiceLength("story_v_out_325111", "325111011", "story_v_out_325111.awb") / 1000

					if var_47_11 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_11 + var_47_5
					end

					if var_47_7.prefab_name ~= "" and arg_44_1.actors_[var_47_7.prefab_name] ~= nil then
						local var_47_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_7.prefab_name].transform, "story_v_out_325111", "325111011", "story_v_out_325111.awb")

						arg_44_1:RecordAudio("325111011", var_47_12)
						arg_44_1:RecordAudio("325111011", var_47_12)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325111", "325111011", "story_v_out_325111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325111", "325111011", "story_v_out_325111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_13 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_13 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_13

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_13 and arg_44_1.time_ < var_47_5 + var_47_13 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play325111012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325111012
		arg_48_1.duration_ = 6.24

		local var_48_0 = {
			zh = 5.24166666666667,
			ja = 6.24166666666667
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
				arg_48_0:Play325111013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if arg_48_1.bgs_.J23g == nil then
				local var_51_0 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J23g")
				var_51_0.name = "J23g"
				var_51_0.transform.parent = arg_48_1.stage_.transform
				var_51_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_.J23g = var_51_0
			end

			if 1.56666666666667 < arg_48_1.time_ and arg_48_1.time_ <= 1.56666666666667 + arg_51_0 then
				local var_51_1 = arg_48_1.bgs_.J23g

				arg_48_1.bgs_.J23g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_51_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_2 = var_51_1:GetComponent("SpriteRenderer")

				if var_51_2 and var_51_2.sprite then
					local var_51_3 = 2 * (var_51_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_51_1.transform.localScale = Vector3.New(var_51_3 / var_51_2.sprite.bounds.size.y < var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x and var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x or var_51_3 / var_51_2.sprite.bounds.size.y, var_51_3 / var_51_2.sprite.bounds.size.y < var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x and var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x or var_51_3 / var_51_2.sprite.bounds.size.y, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "J23g" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_4 = 0

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			if arg_48_1.time_ >= var_51_4 + 0.3 and arg_48_1.time_ < var_51_4 + 0.3 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			local var_51_5 = 0

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_6 = 1.56666666666667

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 then
				local var_51_7 = Color.New(0, 0, 0)

				var_51_7.a = Mathf.Lerp(0, 1, (arg_48_1.time_ - var_51_5) / var_51_6)
				arg_48_1.mask_.color = var_51_7
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 then
				local var_51_8 = Color.New(0, 0, 0)

				var_51_8.a = 1
				arg_48_1.mask_.color = var_51_8
			end

			local var_51_9 = 1.56666666666667

			if 1.56666666666667 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_10 = 1.56666666666533

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_10 then
				local var_51_11 = Color.New(0, 0, 0)

				var_51_11.a = Mathf.Lerp(1, 0, (arg_48_1.time_ - var_51_9) / var_51_10)
				arg_48_1.mask_.color = var_51_11
			end

			if arg_48_1.time_ >= var_51_9 + var_51_10 and arg_48_1.time_ < var_51_9 + var_51_10 + arg_51_0 then
				local var_51_12 = Color.New(0, 0, 0)

				arg_48_1.mask_.enabled = false
				var_51_12.a = 0
				arg_48_1.mask_.color = var_51_12
			end

			local var_51_13 = arg_48_1.actors_["1075ui_story"].transform

			if 1.56666666666667 < arg_48_1.time_ and arg_48_1.time_ <= 1.56666666666667 + arg_51_0 then
				arg_48_1.var_.moveOldPos1075ui_story = var_51_13.localPosition
			end

			local var_51_14 = 0.001

			if 1.56666666666667 <= arg_48_1.time_ and arg_48_1.time_ < 1.56666666666667 + var_51_14 then
				var_51_13.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 1.56666666666667) / var_51_14)
				var_51_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_13.position).x, (manager.ui.mainCamera.transform.position - var_51_13.position).y, (manager.ui.mainCamera.transform.position - var_51_13.position).z)
				var_51_13.localEulerAngles.z = 0
				var_51_13.localEulerAngles.x = 0
				var_51_13.localEulerAngles = var_51_13.localEulerAngles
			end

			if arg_48_1.time_ >= 1.56666666666667 + var_51_14 and arg_48_1.time_ < 1.56666666666667 + var_51_14 + arg_51_0 then
				var_51_13.localPosition = Vector3.New(0, 100, 0)
				var_51_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_13.position).x, (manager.ui.mainCamera.transform.position - var_51_13.position).y, (manager.ui.mainCamera.transform.position - var_51_13.position).z)
				var_51_13.localEulerAngles.z = 0
				var_51_13.localEulerAngles.x = 0
				var_51_13.localEulerAngles = var_51_13.localEulerAngles
			end

			local var_51_15 = "1077ui_story"

			if arg_48_1.actors_["1077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1077ui_story"))) then
				local var_51_16 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_48_1.stage_.transform)

				var_51_16.name = var_51_15
				var_51_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_[var_51_15] = var_51_16

				local var_51_17 = var_51_16:GetComponentInChildren(typeof(CharacterEffect))

				var_51_17.enabled = true

				local var_51_18 = GameObjectTools.GetOrAddComponent(var_51_16, typeof(DynamicBoneHelper))

				if var_51_18 then
					var_51_18:EnableDynamicBone(false)
				end

				arg_48_1:ShowWeapon(var_51_17.transform, false)

				arg_48_1.var_[var_51_15 .. "Animator"] = var_51_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_48_1.var_[var_51_15 .. "Animator"].applyRootMotion = true
				arg_48_1.var_[var_51_15 .. "LipSync"] = var_51_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_51_19 = arg_48_1.actors_["1077ui_story"].transform

			if 2.96666666666667 < arg_48_1.time_ and arg_48_1.time_ <= 2.96666666666667 + arg_51_0 then
				arg_48_1.var_.moveOldPos1077ui_story = var_51_19.localPosition

				local var_51_20 = GameObjectTools.GetOrAddComponent(var_51_19.gameObject, typeof(DynamicBoneHelper))

				if var_51_20 then
					var_51_20:EnableDynamicBone(false)
				end
			end

			local var_51_21 = 0.001

			if 2.96666666666667 <= arg_48_1.time_ and arg_48_1.time_ < 2.96666666666667 + var_51_21 then
				var_51_19.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_48_1.time_ - 2.96666666666667) / var_51_21)
				var_51_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_19.position).x, (manager.ui.mainCamera.transform.position - var_51_19.position).y, (manager.ui.mainCamera.transform.position - var_51_19.position).z)
				var_51_19.localEulerAngles.z = 0
				var_51_19.localEulerAngles.x = 0
				var_51_19.localEulerAngles = var_51_19.localEulerAngles
			end

			if arg_48_1.time_ >= 2.96666666666667 + var_51_21 and arg_48_1.time_ < 2.96666666666667 + var_51_21 + arg_51_0 then
				var_51_19.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_51_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_19.position).x, (manager.ui.mainCamera.transform.position - var_51_19.position).y, (manager.ui.mainCamera.transform.position - var_51_19.position).z)
				var_51_19.localEulerAngles.z = 0
				var_51_19.localEulerAngles.x = 0
				var_51_19.localEulerAngles = var_51_19.localEulerAngles

				local var_51_22 = GameObjectTools.GetOrAddComponent(var_51_19.gameObject, typeof(DynamicBoneHelper))

				if var_51_22 then
					var_51_22:EnableDynamicBone(true)
				end
			end

			local var_51_23 = arg_48_1.actors_["1077ui_story"]

			if 2.96666666666667 < arg_48_1.time_ and arg_48_1.time_ <= 2.96666666666667 + arg_51_0 and not isNil(var_51_23) and arg_48_1.var_.characterEffect1077ui_story == nil then
				arg_48_1.var_.characterEffect1077ui_story = var_51_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_24 = 0.200000002980232

			if 2.96666666666667 <= arg_48_1.time_ and arg_48_1.time_ < 2.96666666666667 + var_51_24 and not isNil(var_51_23) then
				if arg_48_1.var_.characterEffect1077ui_story and not isNil(var_51_23) then
					arg_48_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 2.96666666666667 + var_51_24 and arg_48_1.time_ < 2.96666666666667 + var_51_24 + arg_51_0 and not isNil(var_51_23) and arg_48_1.var_.characterEffect1077ui_story then
				arg_48_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_51_26 = arg_48_1.actors_["1075ui_story"]

			if 1.56666666666667 < arg_48_1.time_ and arg_48_1.time_ <= 1.56666666666667 + arg_51_0 and not isNil(var_51_26) and arg_48_1.var_.characterEffect1075ui_story == nil then
				arg_48_1.var_.characterEffect1075ui_story = var_51_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_27 = 0.200000002980232

			if 1.56666666666667 <= arg_48_1.time_ and arg_48_1.time_ < 1.56666666666667 + var_51_27 and not isNil(var_51_26) then
				if arg_48_1.var_.characterEffect1075ui_story and not isNil(var_51_26) then
					arg_48_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 1.56666666666667) / var_51_27)
				end
			end

			if arg_48_1.time_ >= 1.56666666666667 + var_51_27 and arg_48_1.time_ < 1.56666666666667 + var_51_27 + arg_51_0 and not isNil(var_51_26) and arg_48_1.var_.characterEffect1075ui_story then
				arg_48_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 2.96666666666667 < arg_48_1.time_ and arg_48_1.time_ <= 2.96666666666667 + arg_51_0 then
				arg_48_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 2.96666666666667 < arg_48_1.time_ and arg_48_1.time_ <= 2.96666666666667 + arg_51_0 then
				arg_48_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_48_1.time_ and arg_48_1.time_ <= 1.2 + arg_51_0 then
				arg_48_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_workshop", "")
			end

			if 0.1 < arg_48_1.time_ and arg_48_1.time_ <= 0.1 + arg_51_0 then
				arg_48_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:AudioAction("play", "music", "bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu.awb")

				local var_51_32 = manager.audio:GetAudioName("bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu")

				if "" ~= "" then
					if arg_48_1.bgmTxt_.text ~= var_51_32 and arg_48_1.bgmTxt_.text ~= "" then
						if arg_48_1.bgmTxt2_.text ~= "" then
							arg_48_1.bgmTxt_.text = arg_48_1.bgmTxt2_.text
						end

						arg_48_1.bgmTxt2_.text = var_51_32

						arg_48_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_48_1.bgmTxt_.text = var_51_32
						arg_48_1.bgmTxt2_.text = var_51_32
					end

					if arg_48_1.bgmTimer then
						arg_48_1.bgmTimer:Stop()

						arg_48_1.bgmTimer = nil
					end

					if arg_48_1.settingData.show_music_name == 1 then
						arg_48_1.musicController:SetSelectedState("show")
						arg_48_1.musicAnimator_:Play("open", 0, 0)

						if arg_48_1.settingData.music_time ~= 0 then
							arg_48_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_48_1.settingData.music_time), function()
								if arg_48_1 == nil or isNil(arg_48_1.bgmTxt_) then
									return
								end

								arg_48_1.musicController:SetSelectedState("hide")
								arg_48_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_48_1.frameCnt_ <= 1 then
				arg_48_1.dialog_:SetActive(false)
			end

			local var_51_33 = 3.34166666666667
			local var_51_34 = 0.225

			if 3.34166666666667 < arg_48_1.time_ and arg_48_1.time_ <= var_51_33 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				arg_48_1.dialog_:SetActive(true)

				arg_48_1.dialogCg_.alpha = 0

				local var_51_35 = LeanTween.value(arg_48_1.dialog_, 0, 1, 0.3)

				var_51_35:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_48_1.dialogCg_.alpha = arg_53_0
				end))
				var_51_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_48_1.dialog_)
					var_51_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_48_1.duration_ = arg_48_1.duration_ + 0.3

				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_36 = arg_48_1:GetWordFromCfg(325111012)
				local var_51_37 = arg_48_1:FormatText(var_51_36.content)

				arg_48_1.text_.text = var_51_37

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_39 = 9 <= 0 and var_51_34 or var_51_34 * (utf8.len(var_51_37) / 9)

				if (9 <= 0 and var_51_34 or var_51_34 * (utf8.len(var_51_37) / 9)) > 0 and var_51_34 < var_51_39 then
					arg_48_1.talkMaxDuration = var_51_39
					var_51_33 = var_51_33 + 0.3

					if var_51_39 + var_51_33 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_39 + var_51_33
					end
				end

				arg_48_1.text_.text = var_51_37
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111012", "story_v_out_325111.awb") ~= 0 then
					local var_51_40 = manager.audio:GetVoiceLength("story_v_out_325111", "325111012", "story_v_out_325111.awb") / 1000

					if var_51_40 + var_51_33 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_40 + var_51_33
					end

					if var_51_36.prefab_name ~= "" and arg_48_1.actors_[var_51_36.prefab_name] ~= nil then
						local var_51_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_36.prefab_name].transform, "story_v_out_325111", "325111012", "story_v_out_325111.awb")

						arg_48_1:RecordAudio("325111012", var_51_41)
						arg_48_1:RecordAudio("325111012", var_51_41)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325111", "325111012", "story_v_out_325111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325111", "325111012", "story_v_out_325111.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_42 = var_51_33 + 0.3
			local var_51_43 = math.max(var_51_34, arg_48_1.talkMaxDuration)

			if var_51_33 + 0.3 <= arg_48_1.time_ and arg_48_1.time_ < var_51_42 + var_51_43 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_42) / var_51_43

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_42 + var_51_43 and arg_48_1.time_ < var_51_42 + var_51_43 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play325111013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 325111013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play325111014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1077ui_story = arg_55_1.actors_["1077ui_story"].transform.localPosition

				local var_58_0 = GameObjectTools.GetOrAddComponent(arg_55_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_58_0 then
					var_58_0:EnableDynamicBone(false)
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_1)
				arg_55_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1077ui_story"].transform.position).z)
				arg_55_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1077ui_story"].transform.localEulerAngles = arg_55_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1077ui_story"].transform.position).z)
				arg_55_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1077ui_story"].transform.localEulerAngles = arg_55_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_58_2 = GameObjectTools.GetOrAddComponent(arg_55_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_58_2 then
					var_58_2:EnableDynamicBone(true)
				end
			end

			local var_58_3 = arg_55_1.actors_["1077ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect1077ui_story == nil then
				arg_55_1.var_.characterEffect1077ui_story = var_58_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_4 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 and not isNil(var_58_3) then
				if arg_55_1.var_.characterEffect1077ui_story and not isNil(var_58_3) then
					arg_55_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_4)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect1077ui_story then
				arg_55_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 1 < arg_55_1.time_ and arg_55_1.time_ <= 1 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_151", "se_story_151_footstep05", "")
			end

			local var_58_6 = 0
			local var_58_7 = 1.45

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_8 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(325111013).content)

				arg_55_1.text_.text = var_58_8

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 58 <= 0 and var_58_7 or var_58_7 * (utf8.len(var_58_8) / 58)

				if (58 <= 0 and var_58_7 or var_58_7 * (utf8.len(var_58_8) / 58)) > 0 and var_58_7 < var_58_10 then
					arg_55_1.talkMaxDuration = var_58_10

					if var_58_10 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_8
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_11 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_11 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_11

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_11 and arg_55_1.time_ < var_58_6 + var_58_11 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 325111014
		arg_59_1.duration_ = 7.93

		local var_59_0 = {
			zh = 6.466,
			ja = 7.933
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play325111015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if arg_59_1.bgs_.J23h == nil then
				local var_62_0 = Object.Instantiate(arg_59_1.paintGo_)

				var_62_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J23h")
				var_62_0.name = "J23h"
				var_62_0.transform.parent = arg_59_1.stage_.transform
				var_62_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.bgs_.J23h = var_62_0
			end

			if 1 < arg_59_1.time_ and arg_59_1.time_ <= 1 + arg_62_0 then
				local var_62_1 = arg_59_1.bgs_.J23h

				arg_59_1.bgs_.J23h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_62_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_2 = var_62_1:GetComponent("SpriteRenderer")

				if var_62_2 and var_62_2.sprite then
					local var_62_3 = 2 * (var_62_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_62_1.transform.localScale = Vector3.New(var_62_3 / var_62_2.sprite.bounds.size.y < var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x and var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x or var_62_3 / var_62_2.sprite.bounds.size.y, var_62_3 / var_62_2.sprite.bounds.size.y < var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x and var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x or var_62_3 / var_62_2.sprite.bounds.size.y, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "J23h" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_4 = 0

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			if arg_59_1.time_ >= var_62_4 + 0.3 and arg_59_1.time_ < var_62_4 + 0.3 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_5 = 0

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_6 = 1

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_6 then
				local var_62_7 = Color.New(0, 0, 0)

				var_62_7.a = Mathf.Lerp(0, 1, (arg_59_1.time_ - var_62_5) / var_62_6)
				arg_59_1.mask_.color = var_62_7
			end

			if arg_59_1.time_ >= var_62_5 + var_62_6 and arg_59_1.time_ < var_62_5 + var_62_6 + arg_62_0 then
				local var_62_8 = Color.New(0, 0, 0)

				var_62_8.a = 1
				arg_59_1.mask_.color = var_62_8
			end

			local var_62_9 = 1

			if 1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_10 = 1.36666666666667

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_10 then
				local var_62_11 = Color.New(0, 0, 0)

				var_62_11.a = Mathf.Lerp(1, 0, (arg_59_1.time_ - var_62_9) / var_62_10)
				arg_59_1.mask_.color = var_62_11
			end

			if arg_59_1.time_ >= var_62_9 + var_62_10 and arg_59_1.time_ < var_62_9 + var_62_10 + arg_62_0 then
				local var_62_12 = Color.New(0, 0, 0)

				arg_59_1.mask_.enabled = false
				var_62_12.a = 0
				arg_59_1.mask_.color = var_62_12
			end

			if 1.2 < arg_59_1.time_ and arg_59_1.time_ <= 1.2 + arg_62_0 then
				arg_59_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if 0.1 < arg_59_1.time_ and arg_59_1.time_ <= 0.1 + arg_62_0 then
				arg_59_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_15 = 2
			local var_62_16 = 0.6

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
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

				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_18 = arg_59_1:GetWordFromCfg(325111014)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_21 = 24 <= 0 and var_62_16 or var_62_16 * (utf8.len(var_62_19) / 24)

				if (24 <= 0 and var_62_16 or var_62_16 * (utf8.len(var_62_19) / 24)) > 0 and var_62_16 < var_62_21 then
					arg_59_1.talkMaxDuration = var_62_21
					var_62_15 = var_62_15 + 0.3

					if var_62_21 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_21 + var_62_15
					end
				end

				arg_59_1.text_.text = var_62_19
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111014", "story_v_out_325111.awb") ~= 0 then
					local var_62_22 = manager.audio:GetVoiceLength("story_v_out_325111", "325111014", "story_v_out_325111.awb") / 1000

					if var_62_22 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_22 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_out_325111", "325111014", "story_v_out_325111.awb")

						arg_59_1:RecordAudio("325111014", var_62_23)
						arg_59_1:RecordAudio("325111014", var_62_23)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_325111", "325111014", "story_v_out_325111.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_325111", "325111014", "story_v_out_325111.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_24 = var_62_15 + 0.3
			local var_62_25 = math.max(var_62_16, arg_59_1.talkMaxDuration)

			if var_62_15 + 0.3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_24 + var_62_25 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_24) / var_62_25

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_24 + var_62_25 and arg_59_1.time_ < var_62_24 + var_62_25 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play325111015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 325111015
		arg_65_1.duration_ = 7.47

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play325111016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_9000

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				local var_68_0 = arg_65_1.bgs_.J23h

				arg_65_1.bgs_.J23h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_1 = var_68_0:GetComponent("SpriteRenderer")

				if var_68_1 and var_68_1.sprite then
					local var_68_2 = 2 * (var_68_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_0.transform.localScale = Vector3.New(var_68_2 / var_68_1.sprite.bounds.size.y < var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x and var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x or var_68_2 / var_68_1.sprite.bounds.size.y, var_68_2 / var_68_1.sprite.bounds.size.y < var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x and var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x or var_68_2 / var_68_1.sprite.bounds.size.y, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "J23h" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_3 = "ST2010"

			if arg_65_1.bgs_.ST2010 == nil then
				local var_68_4 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_3)
				var_68_4.name = var_68_3
				var_68_4.transform.parent = arg_65_1.stage_.transform
				var_68_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_3] = var_68_4
			end

			if 1.025 < arg_65_1.time_ and arg_65_1.time_ <= 1.025 + arg_68_0 then
				local var_68_5 = arg_65_1.bgs_.ST2010

				arg_65_1.bgs_.ST2010.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_6 = var_68_5:GetComponent("SpriteRenderer")

				if var_68_6 and var_68_6.sprite then
					local var_68_7 = 2 * (var_68_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_5.transform.localScale = Vector3.New(var_68_7 / var_68_6.sprite.bounds.size.y < var_68_7 * manager.ui.mainCameraCom_.aspect / var_68_6.sprite.bounds.size.x and var_68_7 * manager.ui.mainCameraCom_.aspect / var_68_6.sprite.bounds.size.x or var_68_7 / var_68_6.sprite.bounds.size.y, var_68_7 / var_68_6.sprite.bounds.size.y < var_68_7 * manager.ui.mainCameraCom_.aspect / var_68_6.sprite.bounds.size.x and var_68_7 * manager.ui.mainCameraCom_.aspect / var_68_6.sprite.bounds.size.x or var_68_7 / var_68_6.sprite.bounds.size.y, 0)
				end

				for iter_68_2, iter_68_3 in pairs(arg_65_1.bgs_) do
					if iter_68_2 ~= "ST2010" then
						iter_68_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_8 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			if arg_65_1.time_ >= var_68_8 + 0.3 and arg_65_1.time_ < var_68_8 + 0.3 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			if 0.666666666666667 < arg_65_1.time_ and arg_65_1.time_ <= 0.666666666666667 + arg_68_0 then
				local var_68_9 = arg_65_1.var_.effect132131

				if not arg_65_1.var_.effect132131 then
					var_68_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_68_9.name = "132131"
					arg_65_1.var_.effect132131 = var_68_9
				else
					var_68_9.transform:SetParent(var_68_9000)
				end

				var_68_9.transform.localPosition = Vector3.New(0, 0, -0.91)
				var_68_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_68_9.transform.localScale = Vector3.New(var_68_9.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_68_9.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_68_9.transform.localScale.z)
			end

			if 1 < arg_65_1.time_ and arg_65_1.time_ <= 1 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_151", "se_story_151_footstep05", "")
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_12 = 2.46666666666667
			local var_68_13 = 1.025

			if 2.46666666666667 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_14 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_14:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(325111015).content)

				arg_65_1.text_.text = var_68_15

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 41 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_15) / 41)

				if (41 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_15) / 41)) > 0 and var_68_13 < var_68_17 then
					arg_65_1.talkMaxDuration = var_68_17
					var_68_12 = var_68_12 + 0.3

					if var_68_17 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_15
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = var_68_12 + 0.3
			local var_68_19 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_18 + var_68_19 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_18) / var_68_19

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_18 + var_68_19 and arg_65_1.time_ < var_68_18 + var_68_19 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play325111016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 325111016
		arg_71_1.duration_ = 7.1

		local var_71_0 = {
			zh = 4.533,
			ja = 7.1
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play325111017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1077ui_story = arg_71_1.actors_["1077ui_story"].transform.localPosition

				local var_74_0 = GameObjectTools.GetOrAddComponent(arg_71_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_74_0 then
					var_74_0:EnableDynamicBone(false)
				end
			end

			local var_74_1 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 then
				arg_71_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_71_1.time_ - 0) / var_74_1)
				arg_71_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1077ui_story"].transform.position).z)
				arg_71_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1077ui_story"].transform.localEulerAngles = arg_71_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 then
				arg_71_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_71_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1077ui_story"].transform.position).z)
				arg_71_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1077ui_story"].transform.localEulerAngles = arg_71_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_74_2 = GameObjectTools.GetOrAddComponent(arg_71_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_74_2 then
					var_74_2:EnableDynamicBone(true)
				end
			end

			local var_74_3 = arg_71_1.actors_["1077ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect1077ui_story == nil then
				arg_71_1.var_.characterEffect1077ui_story = var_74_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_4 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 and not isNil(var_74_3) then
				if arg_71_1.var_.characterEffect1077ui_story and not isNil(var_74_3) then
					arg_71_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect1077ui_story then
				arg_71_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_74_6 = 0
			local var_74_7 = 0.5

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(325111016)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 20 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 20)

				if (20 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 20)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111016", "story_v_out_325111.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111016", "story_v_out_325111.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_325111", "325111016", "story_v_out_325111.awb")

						arg_71_1:RecordAudio("325111016", var_74_13)
						arg_71_1:RecordAudio("325111016", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_325111", "325111016", "story_v_out_325111.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_325111", "325111016", "story_v_out_325111.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play325111017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 325111017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play325111018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1077ui_story = arg_75_1.actors_["1077ui_story"].transform.localPosition

				local var_78_0 = GameObjectTools.GetOrAddComponent(arg_75_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_78_0 then
					var_78_0:EnableDynamicBone(false)
				end
			end

			local var_78_1 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 then
				arg_75_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_1)
				arg_75_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1077ui_story"].transform.position).z)
				arg_75_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1077ui_story"].transform.localEulerAngles = arg_75_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 then
				arg_75_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1077ui_story"].transform.position).z)
				arg_75_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1077ui_story"].transform.localEulerAngles = arg_75_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_78_2 = GameObjectTools.GetOrAddComponent(arg_75_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_78_2 then
					var_78_2:EnableDynamicBone(true)
				end
			end

			local var_78_3 = arg_75_1.actors_["1077ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_3) and arg_75_1.var_.characterEffect1077ui_story == nil then
				arg_75_1.var_.characterEffect1077ui_story = var_78_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_4 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 and not isNil(var_78_3) then
				if arg_75_1.var_.characterEffect1077ui_story and not isNil(var_78_3) then
					arg_75_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_4)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 and not isNil(var_78_3) and arg_75_1.var_.characterEffect1077ui_story then
				arg_75_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_78_5 = 0
			local var_78_6 = 1.175

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(325111017).content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 47 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_7) / 47)

				if (47 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_7) / 47)) > 0 and var_78_6 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_6, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_5) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_10 and arg_75_1.time_ < var_78_5 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play325111018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 325111018
		arg_79_1.duration_ = 4.6

		local var_79_0 = {
			zh = 2.8,
			ja = 4.6
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play325111019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1077ui_story = arg_79_1.actors_["1077ui_story"].transform.localPosition

				local var_82_0 = GameObjectTools.GetOrAddComponent(arg_79_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_82_0 then
					var_82_0:EnableDynamicBone(false)
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_79_1.time_ - 0) / var_82_1)
				arg_79_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1077ui_story"].transform.position).z)
				arg_79_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1077ui_story"].transform.localEulerAngles = arg_79_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_79_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1077ui_story"].transform.position).z)
				arg_79_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1077ui_story"].transform.localEulerAngles = arg_79_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_82_2 = GameObjectTools.GetOrAddComponent(arg_79_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_82_2 then
					var_82_2:EnableDynamicBone(true)
				end
			end

			local var_82_3 = arg_79_1.actors_["1077ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.characterEffect1077ui_story == nil then
				arg_79_1.var_.characterEffect1077ui_story = var_82_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_4 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 and not isNil(var_82_3) then
				if arg_79_1.var_.characterEffect1077ui_story and not isNil(var_82_3) then
					arg_79_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.characterEffect1077ui_story then
				arg_79_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_82_6 = 0
			local var_82_7 = 0.4

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:GetWordFromCfg(325111018)
				local var_82_9 = arg_79_1:FormatText(var_82_8.content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 16 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_9) / 16)

				if (16 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_9) / 16)) > 0 and var_82_7 < var_82_11 then
					arg_79_1.talkMaxDuration = var_82_11

					if var_82_11 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_11 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111018", "story_v_out_325111.awb") ~= 0 then
					local var_82_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111018", "story_v_out_325111.awb") / 1000

					if var_82_12 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_6
					end

					if var_82_8.prefab_name ~= "" and arg_79_1.actors_[var_82_8.prefab_name] ~= nil then
						local var_82_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_8.prefab_name].transform, "story_v_out_325111", "325111018", "story_v_out_325111.awb")

						arg_79_1:RecordAudio("325111018", var_82_13)
						arg_79_1:RecordAudio("325111018", var_82_13)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_325111", "325111018", "story_v_out_325111.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_325111", "325111018", "story_v_out_325111.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_14 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_14 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_14

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_14 and arg_79_1.time_ < var_82_6 + var_82_14 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play325111019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 325111019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play325111020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1077ui_story = arg_83_1.actors_["1077ui_story"].transform.localPosition

				local var_86_0 = GameObjectTools.GetOrAddComponent(arg_83_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_86_0 then
					var_86_0:EnableDynamicBone(false)
				end
			end

			local var_86_1 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 then
				arg_83_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_1)
				arg_83_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1077ui_story"].transform.position).z)
				arg_83_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1077ui_story"].transform.localEulerAngles = arg_83_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 then
				arg_83_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1077ui_story"].transform.position).z)
				arg_83_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1077ui_story"].transform.localEulerAngles = arg_83_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_86_2 = GameObjectTools.GetOrAddComponent(arg_83_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_86_2 then
					var_86_2:EnableDynamicBone(true)
				end
			end

			local var_86_3 = arg_83_1.actors_["1077ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.characterEffect1077ui_story == nil then
				arg_83_1.var_.characterEffect1077ui_story = var_86_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_4 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 and not isNil(var_86_3) then
				if arg_83_1.var_.characterEffect1077ui_story and not isNil(var_86_3) then
					arg_83_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_4)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.characterEffect1077ui_story then
				arg_83_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 1 < arg_83_1.time_ and arg_83_1.time_ <= 1 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_activity_1_4_3", "se_story_activity_1_4_3_rock", "")
			end

			local var_86_6 = 0
			local var_86_7 = 1.275

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_8 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(325111019).content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 51 <= 0 and var_86_7 or var_86_7 * (utf8.len(var_86_8) / 51)

				if (51 <= 0 and var_86_7 or var_86_7 * (utf8.len(var_86_8) / 51)) > 0 and var_86_7 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_11 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_11 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_11

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_11 and arg_83_1.time_ < var_86_6 + var_86_11 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play325111020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 325111020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play325111021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 1.3

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(325111020).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 52 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 52)

				if (52 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 52)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play325111021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 325111021
		arg_91_1.duration_ = 11.13

		local var_91_0 = {
			zh = 7.366,
			ja = 11.133
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
				arg_91_0:Play325111022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1077ui_story = arg_91_1.actors_["1077ui_story"].transform.localPosition

				local var_94_0 = GameObjectTools.GetOrAddComponent(arg_91_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_94_0 then
					var_94_0:EnableDynamicBone(false)
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_91_1.time_ - 0) / var_94_1)
				arg_91_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1077ui_story"].transform.position).z)
				arg_91_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1077ui_story"].transform.localEulerAngles = arg_91_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_91_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1077ui_story"].transform.position).z)
				arg_91_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1077ui_story"].transform.localEulerAngles = arg_91_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_94_2 = GameObjectTools.GetOrAddComponent(arg_91_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_94_2 then
					var_94_2:EnableDynamicBone(true)
				end
			end

			local var_94_3 = arg_91_1.actors_["1077ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_3) and arg_91_1.var_.characterEffect1077ui_story == nil then
				arg_91_1.var_.characterEffect1077ui_story = var_94_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_4 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 and not isNil(var_94_3) then
				if arg_91_1.var_.characterEffect1077ui_story and not isNil(var_94_3) then
					arg_91_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 and not isNil(var_94_3) and arg_91_1.var_.characterEffect1077ui_story then
				arg_91_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_94_6 = 0
			local var_94_7 = 0.75

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_8 = arg_91_1:GetWordFromCfg(325111021)
				local var_94_9 = arg_91_1:FormatText(var_94_8.content)

				arg_91_1.text_.text = var_94_9

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 30 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 30)

				if (30 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 30)) > 0 and var_94_7 < var_94_11 then
					arg_91_1.talkMaxDuration = var_94_11

					if var_94_11 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_9
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111021", "story_v_out_325111.awb") ~= 0 then
					local var_94_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111021", "story_v_out_325111.awb") / 1000

					if var_94_12 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_6
					end

					if var_94_8.prefab_name ~= "" and arg_91_1.actors_[var_94_8.prefab_name] ~= nil then
						local var_94_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_8.prefab_name].transform, "story_v_out_325111", "325111021", "story_v_out_325111.awb")

						arg_91_1:RecordAudio("325111021", var_94_13)
						arg_91_1:RecordAudio("325111021", var_94_13)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_325111", "325111021", "story_v_out_325111.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_325111", "325111021", "story_v_out_325111.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_14 and arg_91_1.time_ < var_94_6 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play325111022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 325111022
		arg_95_1.duration_ = 12.97

		local var_95_0 = {
			zh = 7.133,
			ja = 12.966
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
				arg_95_0:Play325111023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.775

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(325111022)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 31 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 31)

				if (31 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 31)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111022", "story_v_out_325111.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_325111", "325111022", "story_v_out_325111.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_325111", "325111022", "story_v_out_325111.awb")

						arg_95_1:RecordAudio("325111022", var_98_6)
						arg_95_1:RecordAudio("325111022", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_325111", "325111022", "story_v_out_325111.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_325111", "325111022", "story_v_out_325111.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play325111023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 325111023
		arg_99_1.duration_ = 6.93

		local var_99_0 = {
			zh = 4.9,
			ja = 6.933
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
				arg_99_0:Play325111024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.725

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(325111023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 29 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 29)

				if (29 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 29)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111023", "story_v_out_325111.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_325111", "325111023", "story_v_out_325111.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_325111", "325111023", "story_v_out_325111.awb")

						arg_99_1:RecordAudio("325111023", var_102_6)
						arg_99_1:RecordAudio("325111023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_325111", "325111023", "story_v_out_325111.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_325111", "325111023", "story_v_out_325111.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play325111024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 325111024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play325111025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1077ui_story = arg_103_1.actors_["1077ui_story"].transform.localPosition

				local var_106_0 = GameObjectTools.GetOrAddComponent(arg_103_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_106_0 then
					var_106_0:EnableDynamicBone(false)
				end
			end

			local var_106_1 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				arg_103_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_103_1.time_ - 0) / var_106_1)
				arg_103_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1077ui_story"].transform.position).z)
				arg_103_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1077ui_story"].transform.localEulerAngles = arg_103_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 then
				arg_103_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1077ui_story"].transform.position).z)
				arg_103_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1077ui_story"].transform.localEulerAngles = arg_103_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_106_2 = GameObjectTools.GetOrAddComponent(arg_103_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_106_2 then
					var_106_2:EnableDynamicBone(true)
				end
			end

			local var_106_3 = arg_103_1.actors_["1077ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_3) and arg_103_1.var_.characterEffect1077ui_story == nil then
				arg_103_1.var_.characterEffect1077ui_story = var_106_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_4 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 and not isNil(var_106_3) then
				if arg_103_1.var_.characterEffect1077ui_story and not isNil(var_106_3) then
					arg_103_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_4)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 and not isNil(var_106_3) and arg_103_1.var_.characterEffect1077ui_story then
				arg_103_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.4 < arg_103_1.time_ and arg_103_1.time_ <= 0.4 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_150", "se_story_150_monster_growl", "")
			end

			local var_106_6 = 0
			local var_106_7 = 1.65

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_8 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(325111024).content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 66 <= 0 and var_106_7 or var_106_7 * (utf8.len(var_106_8) / 66)

				if (66 <= 0 and var_106_7 or var_106_7 * (utf8.len(var_106_8) / 66)) > 0 and var_106_7 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_11 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_11 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_11

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_11 and arg_103_1.time_ < var_106_6 + var_106_11 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 325111025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play325111026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 1.4

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(325111025).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 56 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 56)

				if (56 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 56)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play325111026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 325111026
		arg_111_1.duration_ = 6.83

		local var_111_0 = {
			zh = 3.2,
			ja = 6.833
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play325111027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1077ui_story = arg_111_1.actors_["1077ui_story"].transform.localPosition

				local var_114_0 = GameObjectTools.GetOrAddComponent(arg_111_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_114_0 then
					var_114_0:EnableDynamicBone(false)
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_111_1.time_ - 0) / var_114_1)
				arg_111_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1077ui_story"].transform.position).z)
				arg_111_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1077ui_story"].transform.localEulerAngles = arg_111_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_111_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1077ui_story"].transform.position).z)
				arg_111_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1077ui_story"].transform.localEulerAngles = arg_111_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_114_2 = GameObjectTools.GetOrAddComponent(arg_111_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(true)
				end
			end

			local var_114_3 = arg_111_1.actors_["1077ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_3) and arg_111_1.var_.characterEffect1077ui_story == nil then
				arg_111_1.var_.characterEffect1077ui_story = var_114_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_4 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 and not isNil(var_114_3) then
				if arg_111_1.var_.characterEffect1077ui_story and not isNil(var_114_3) then
					arg_111_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 and not isNil(var_114_3) and arg_111_1.var_.characterEffect1077ui_story then
				arg_111_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action438")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_114_6 = 0
			local var_114_7 = 0.775

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(325111026)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 31 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 31)

				if (31 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 31)) > 0 and var_114_7 < var_114_11 then
					arg_111_1.talkMaxDuration = var_114_11

					if var_114_11 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111026", "story_v_out_325111.awb") ~= 0 then
					local var_114_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111026", "story_v_out_325111.awb") / 1000

					if var_114_12 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_6
					end

					if var_114_8.prefab_name ~= "" and arg_111_1.actors_[var_114_8.prefab_name] ~= nil then
						local var_114_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_8.prefab_name].transform, "story_v_out_325111", "325111026", "story_v_out_325111.awb")

						arg_111_1:RecordAudio("325111026", var_114_13)
						arg_111_1:RecordAudio("325111026", var_114_13)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_325111", "325111026", "story_v_out_325111.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_325111", "325111026", "story_v_out_325111.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play325111027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 325111027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play325111028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1077ui_story = arg_115_1.actors_["1077ui_story"].transform.localPosition

				local var_118_0 = GameObjectTools.GetOrAddComponent(arg_115_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_118_0 then
					var_118_0:EnableDynamicBone(false)
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_1)
				arg_115_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1077ui_story"].transform.position).z)
				arg_115_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1077ui_story"].transform.localEulerAngles = arg_115_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1077ui_story"].transform.position).z)
				arg_115_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1077ui_story"].transform.localEulerAngles = arg_115_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_118_2 = GameObjectTools.GetOrAddComponent(arg_115_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(true)
				end
			end

			local var_118_3 = arg_115_1.actors_["1077ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.characterEffect1077ui_story == nil then
				arg_115_1.var_.characterEffect1077ui_story = var_118_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_4 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 and not isNil(var_118_3) then
				if arg_115_1.var_.characterEffect1077ui_story and not isNil(var_118_3) then
					arg_115_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_4)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.characterEffect1077ui_story then
				arg_115_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_118_5 = 0
			local var_118_6 = 1.075

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_7 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(325111027).content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 43 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_7) / 43)

				if (43 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_7) / 43)) > 0 and var_118_6 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_5
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_6, arg_115_1.talkMaxDuration)

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_5) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_5 + var_118_10 and arg_115_1.time_ < var_118_5 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 325111028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play325111029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0.4 < arg_119_1.time_ and arg_119_1.time_ <= 0.4 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_148", "se_story_148_helmet_hit", "")
			end

			local var_122_1 = 0
			local var_122_2 = 1.625

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(325111028).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 65 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 65)

				if (65 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 65)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play325111029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 325111029
		arg_123_1.duration_ = 4.2

		local var_123_0 = {
			zh = 3.833,
			ja = 4.2
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
				arg_123_0:Play325111030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1077ui_story = arg_123_1.actors_["1077ui_story"].transform.localPosition

				local var_126_0 = GameObjectTools.GetOrAddComponent(arg_123_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_126_0 then
					var_126_0:EnableDynamicBone(false)
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_123_1.time_ - 0) / var_126_1)
				arg_123_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1077ui_story"].transform.position).z)
				arg_123_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1077ui_story"].transform.localEulerAngles = arg_123_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_123_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1077ui_story"].transform.position).z)
				arg_123_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1077ui_story"].transform.localEulerAngles = arg_123_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_126_2 = GameObjectTools.GetOrAddComponent(arg_123_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_126_2 then
					var_126_2:EnableDynamicBone(true)
				end
			end

			local var_126_3 = arg_123_1.actors_["1077ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_3) and arg_123_1.var_.characterEffect1077ui_story == nil then
				arg_123_1.var_.characterEffect1077ui_story = var_126_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_4 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 and not isNil(var_126_3) then
				if arg_123_1.var_.characterEffect1077ui_story and not isNil(var_126_3) then
					arg_123_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 and not isNil(var_126_3) and arg_123_1.var_.characterEffect1077ui_story then
				arg_123_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_126_6 = 0
			local var_126_7 = 0.3

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_8 = arg_123_1:GetWordFromCfg(325111029)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 12 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 12)

				if (12 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 12)) > 0 and var_126_7 < var_126_11 then
					arg_123_1.talkMaxDuration = var_126_11

					if var_126_11 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111029", "story_v_out_325111.awb") ~= 0 then
					local var_126_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111029", "story_v_out_325111.awb") / 1000

					if var_126_12 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_6
					end

					if var_126_8.prefab_name ~= "" and arg_123_1.actors_[var_126_8.prefab_name] ~= nil then
						local var_126_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_8.prefab_name].transform, "story_v_out_325111", "325111029", "story_v_out_325111.awb")

						arg_123_1:RecordAudio("325111029", var_126_13)
						arg_123_1:RecordAudio("325111029", var_126_13)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_325111", "325111029", "story_v_out_325111.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_325111", "325111029", "story_v_out_325111.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_14 and arg_123_1.time_ < var_126_6 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 325111030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play325111031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1077ui_story = arg_127_1.actors_["1077ui_story"].transform.localPosition

				local var_130_0 = GameObjectTools.GetOrAddComponent(arg_127_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_130_0 then
					var_130_0:EnableDynamicBone(false)
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_1)
				arg_127_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1077ui_story"].transform.position).z)
				arg_127_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1077ui_story"].transform.localEulerAngles = arg_127_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1077ui_story"].transform.position).z)
				arg_127_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1077ui_story"].transform.localEulerAngles = arg_127_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_130_2 = GameObjectTools.GetOrAddComponent(arg_127_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_130_2 then
					var_130_2:EnableDynamicBone(true)
				end
			end

			local var_130_3 = arg_127_1.actors_["1077ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect1077ui_story == nil then
				arg_127_1.var_.characterEffect1077ui_story = var_130_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_4 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 and not isNil(var_130_3) then
				if arg_127_1.var_.characterEffect1077ui_story and not isNil(var_130_3) then
					arg_127_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_4)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect1077ui_story then
				arg_127_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.4 < arg_127_1.time_ and arg_127_1.time_ <= 0.4 + arg_130_0 then
				arg_127_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_punch", "")
			end

			local var_130_6 = 0
			local var_130_7 = 1.15

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(325111030).content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 46 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_8) / 46)

				if (46 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_8) / 46)) > 0 and var_130_7 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_11 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_11 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_11

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_11 and arg_127_1.time_ < var_130_6 + var_130_11 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 325111031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play325111032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.7

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(325111031).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 28 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 28)

				if (28 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 28)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play325111032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 325111032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play325111033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 1.225

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(325111032).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 49 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 49)

				if (49 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 49)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play325111033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 325111033
		arg_139_1.duration_ = 4.23

		local var_139_0 = {
			zh = 3.533,
			ja = 4.233
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
				arg_139_0:Play325111034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1077ui_story = arg_139_1.actors_["1077ui_story"].transform.localPosition

				local var_142_0 = GameObjectTools.GetOrAddComponent(arg_139_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_142_0 then
					var_142_0:EnableDynamicBone(false)
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_139_1.time_ - 0) / var_142_1)
				arg_139_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1077ui_story"].transform.position).z)
				arg_139_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1077ui_story"].transform.localEulerAngles = arg_139_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_139_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1077ui_story"].transform.position).z)
				arg_139_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1077ui_story"].transform.localEulerAngles = arg_139_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_142_2 = GameObjectTools.GetOrAddComponent(arg_139_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(true)
				end
			end

			local var_142_3 = arg_139_1.actors_["1077ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_3) and arg_139_1.var_.characterEffect1077ui_story == nil then
				arg_139_1.var_.characterEffect1077ui_story = var_142_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_4 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 and not isNil(var_142_3) then
				if arg_139_1.var_.characterEffect1077ui_story and not isNil(var_142_3) then
					arg_139_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 and not isNil(var_142_3) and arg_139_1.var_.characterEffect1077ui_story then
				arg_139_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_142_6 = 0
			local var_142_7 = 0.3

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(325111033)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 12 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 12)

				if (12 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 12)) > 0 and var_142_7 < var_142_11 then
					arg_139_1.talkMaxDuration = var_142_11

					if var_142_11 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111033", "story_v_out_325111.awb") ~= 0 then
					local var_142_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111033", "story_v_out_325111.awb") / 1000

					if var_142_12 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_6
					end

					if var_142_8.prefab_name ~= "" and arg_139_1.actors_[var_142_8.prefab_name] ~= nil then
						local var_142_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_8.prefab_name].transform, "story_v_out_325111", "325111033", "story_v_out_325111.awb")

						arg_139_1:RecordAudio("325111033", var_142_13)
						arg_139_1:RecordAudio("325111033", var_142_13)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_325111", "325111033", "story_v_out_325111.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_325111", "325111033", "story_v_out_325111.awb")
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
				actorName = "1077ui_story",
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
	Play325111034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 325111034
		arg_143_1.duration_ = 7.93

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play325111035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if arg_143_1.bgs_.ST42 == nil then
				local var_146_0 = Object.Instantiate(arg_143_1.paintGo_)

				var_146_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST42")
				var_146_0.name = "ST42"
				var_146_0.transform.parent = arg_143_1.stage_.transform
				var_146_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.bgs_.ST42 = var_146_0
			end

			if 1.63333333333333 < arg_143_1.time_ and arg_143_1.time_ <= 1.63333333333333 + arg_146_0 then
				local var_146_1 = arg_143_1.bgs_.ST42

				arg_143_1.bgs_.ST42.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_146_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_146_2 = var_146_1:GetComponent("SpriteRenderer")

				if var_146_2 and var_146_2.sprite then
					local var_146_3 = 2 * (var_146_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_146_1.transform.localScale = Vector3.New(var_146_3 / var_146_2.sprite.bounds.size.y < var_146_3 * manager.ui.mainCameraCom_.aspect / var_146_2.sprite.bounds.size.x and var_146_3 * manager.ui.mainCameraCom_.aspect / var_146_2.sprite.bounds.size.x or var_146_3 / var_146_2.sprite.bounds.size.y, var_146_3 / var_146_2.sprite.bounds.size.y < var_146_3 * manager.ui.mainCameraCom_.aspect / var_146_2.sprite.bounds.size.x and var_146_3 * manager.ui.mainCameraCom_.aspect / var_146_2.sprite.bounds.size.x or var_146_3 / var_146_2.sprite.bounds.size.y, 0)
				end

				for iter_146_0, iter_146_1 in pairs(arg_143_1.bgs_) do
					if iter_146_0 ~= "ST42" then
						iter_146_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_146_4 = 1.63333333333333

			if 1.63333333333333 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			if arg_143_1.time_ >= var_146_4 + 0.3 and arg_143_1.time_ < var_146_4 + 0.3 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			local var_146_5 = 0

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_6 = 1.63333333333333

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_6 then
				local var_146_7 = Color.New(0, 0, 0)

				var_146_7.a = Mathf.Lerp(0, 1, (arg_143_1.time_ - var_146_5) / var_146_6)
				arg_143_1.mask_.color = var_146_7
			end

			if arg_143_1.time_ >= var_146_5 + var_146_6 and arg_143_1.time_ < var_146_5 + var_146_6 + arg_146_0 then
				local var_146_8 = Color.New(0, 0, 0)

				var_146_8.a = 1
				arg_143_1.mask_.color = var_146_8
			end

			local var_146_9 = 1.63333333333333

			if 1.63333333333333 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_10 = 1.88414250034839

			if var_146_9 <= arg_143_1.time_ and arg_143_1.time_ < var_146_9 + var_146_10 then
				local var_146_11 = Color.New(0, 0, 0)

				var_146_11.a = Mathf.Lerp(1, 0, (arg_143_1.time_ - var_146_9) / var_146_10)
				arg_143_1.mask_.color = var_146_11
			end

			if arg_143_1.time_ >= var_146_9 + var_146_10 and arg_143_1.time_ < var_146_9 + var_146_10 + arg_146_0 then
				local var_146_12 = Color.New(0, 0, 0)

				arg_143_1.mask_.enabled = false
				var_146_12.a = 0
				arg_143_1.mask_.color = var_146_12
			end

			local var_146_13 = arg_143_1.actors_["1077ui_story"].transform

			if 1.63333333333333 < arg_143_1.time_ and arg_143_1.time_ <= 1.63333333333333 + arg_146_0 then
				arg_143_1.var_.moveOldPos1077ui_story = var_146_13.localPosition

				local var_146_14 = GameObjectTools.GetOrAddComponent(var_146_13.gameObject, typeof(DynamicBoneHelper))

				if var_146_14 then
					var_146_14:EnableDynamicBone(false)
				end
			end

			local var_146_15 = 0.001

			if 1.63333333333333 <= arg_143_1.time_ and arg_143_1.time_ < 1.63333333333333 + var_146_15 then
				var_146_13.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 1.63333333333333) / var_146_15)
				var_146_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_13.position).x, (manager.ui.mainCamera.transform.position - var_146_13.position).y, (manager.ui.mainCamera.transform.position - var_146_13.position).z)
				var_146_13.localEulerAngles.z = 0
				var_146_13.localEulerAngles.x = 0
				var_146_13.localEulerAngles = var_146_13.localEulerAngles
			end

			if arg_143_1.time_ >= 1.63333333333333 + var_146_15 and arg_143_1.time_ < 1.63333333333333 + var_146_15 + arg_146_0 then
				var_146_13.localPosition = Vector3.New(0, 100, 0)
				var_146_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_13.position).x, (manager.ui.mainCamera.transform.position - var_146_13.position).y, (manager.ui.mainCamera.transform.position - var_146_13.position).z)
				var_146_13.localEulerAngles.z = 0
				var_146_13.localEulerAngles.x = 0
				var_146_13.localEulerAngles = var_146_13.localEulerAngles

				local var_146_16 = GameObjectTools.GetOrAddComponent(var_146_13.gameObject, typeof(DynamicBoneHelper))

				if var_146_16 then
					var_146_16:EnableDynamicBone(true)
				end
			end

			local var_146_17 = arg_143_1.actors_["1077ui_story"]

			if 1.63333333333333 < arg_143_1.time_ and arg_143_1.time_ <= 1.63333333333333 + arg_146_0 and not isNil(var_146_17) and arg_143_1.var_.characterEffect1077ui_story == nil then
				arg_143_1.var_.characterEffect1077ui_story = var_146_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_18 = 0.200000002980232

			if 1.63333333333333 <= arg_143_1.time_ and arg_143_1.time_ < 1.63333333333333 + var_146_18 and not isNil(var_146_17) then
				if arg_143_1.var_.characterEffect1077ui_story and not isNil(var_146_17) then
					arg_143_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 1.63333333333333) / var_146_18)
				end
			end

			if arg_143_1.time_ >= 1.63333333333333 + var_146_18 and arg_143_1.time_ < 1.63333333333333 + var_146_18 + arg_146_0 and not isNil(var_146_17) and arg_143_1.var_.characterEffect1077ui_story then
				arg_143_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_19 = 2.93333333333333
			local var_146_20 = 1.45

			if 2.93333333333333 < arg_143_1.time_ and arg_143_1.time_ <= var_146_19 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_21 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_21:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_22 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(325111034).content)

				arg_143_1.text_.text = var_146_22

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_24 = 58 <= 0 and var_146_20 or var_146_20 * (utf8.len(var_146_22) / 58)

				if (58 <= 0 and var_146_20 or var_146_20 * (utf8.len(var_146_22) / 58)) > 0 and var_146_20 < var_146_24 then
					arg_143_1.talkMaxDuration = var_146_24
					var_146_19 = var_146_19 + 0.3

					if var_146_24 + var_146_19 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_24 + var_146_19
					end
				end

				arg_143_1.text_.text = var_146_22
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_25 = var_146_19 + 0.3
			local var_146_26 = math.max(var_146_20, arg_143_1.talkMaxDuration)

			if var_146_19 + 0.3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_25 + var_146_26 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_25) / var_146_26

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_25 + var_146_26 and arg_143_1.time_ < var_146_25 + var_146_26 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play325111035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 325111035
		arg_149_1.duration_ = 2.23

		local var_149_0 = {
			zh = 2.233,
			ja = 1.999999999999
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play325111036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1075ui_story = arg_149_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1075ui_story"].transform.position).z)
				arg_149_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1075ui_story"].transform.localEulerAngles = arg_149_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_149_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1075ui_story"].transform.position).z)
				arg_149_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1075ui_story"].transform.localEulerAngles = arg_149_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1075ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1075ui_story == nil then
				arg_149_1.var_.characterEffect1075ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1075ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1075ui_story then
				arg_149_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_152_4 = 0
			local var_152_5 = 0.125

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(325111035)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 5 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 5)

				if (5 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 5)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111035", "story_v_out_325111.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_325111", "325111035", "story_v_out_325111.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_325111", "325111035", "story_v_out_325111.awb")

						arg_149_1:RecordAudio("325111035", var_152_11)
						arg_149_1:RecordAudio("325111035", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_325111", "325111035", "story_v_out_325111.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_325111", "325111035", "story_v_out_325111.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play325111036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 325111036
		arg_153_1.duration_ = 3.53

		local var_153_0 = {
			zh = 2.2,
			ja = 3.533
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play325111037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1075ui_story = arg_153_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1075ui_story"].transform.position).z)
				arg_153_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1075ui_story"].transform.localEulerAngles = arg_153_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_153_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1075ui_story"].transform.position).z)
				arg_153_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1075ui_story"].transform.localEulerAngles = arg_153_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_156_1 = "1053ui_story"

			if arg_153_1.actors_["1053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1053ui_story"))) then
				local var_156_2 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_153_1.stage_.transform)

				var_156_2.name = var_156_1
				var_156_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_[var_156_1] = var_156_2

				local var_156_3 = var_156_2:GetComponentInChildren(typeof(CharacterEffect))

				var_156_3.enabled = true

				local var_156_4 = GameObjectTools.GetOrAddComponent(var_156_2, typeof(DynamicBoneHelper))

				if var_156_4 then
					var_156_4:EnableDynamicBone(false)
				end

				arg_153_1:ShowWeapon(var_156_3.transform, false)

				arg_153_1.var_[var_156_1 .. "Animator"] = var_156_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_153_1.var_[var_156_1 .. "Animator"].applyRootMotion = true
				arg_153_1.var_[var_156_1 .. "LipSync"] = var_156_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_156_5 = arg_153_1.actors_["1053ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1053ui_story = var_156_5.localPosition

				local var_156_6 = GameObjectTools.GetOrAddComponent(var_156_5.gameObject, typeof(DynamicBoneHelper))

				if var_156_6 then
					var_156_6:EnableDynamicBone(false)
				end
			end

			local var_156_7 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				var_156_5.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_153_1.time_ - 0) / var_156_7)
				var_156_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_5.position).x, (manager.ui.mainCamera.transform.position - var_156_5.position).y, (manager.ui.mainCamera.transform.position - var_156_5.position).z)
				var_156_5.localEulerAngles.z = 0
				var_156_5.localEulerAngles.x = 0
				var_156_5.localEulerAngles = var_156_5.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				var_156_5.localPosition = Vector3.New(0.7, -1.08, -6)
				var_156_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_5.position).x, (manager.ui.mainCamera.transform.position - var_156_5.position).y, (manager.ui.mainCamera.transform.position - var_156_5.position).z)
				var_156_5.localEulerAngles.z = 0
				var_156_5.localEulerAngles.x = 0
				var_156_5.localEulerAngles = var_156_5.localEulerAngles

				local var_156_8 = GameObjectTools.GetOrAddComponent(var_156_5.gameObject, typeof(DynamicBoneHelper))

				if var_156_8 then
					var_156_8:EnableDynamicBone(true)
				end
			end

			local var_156_9 = arg_153_1.actors_["1053ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1053ui_story == nil then
				arg_153_1.var_.characterEffect1053ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_10 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_10 and not isNil(var_156_9) then
				if arg_153_1.var_.characterEffect1053ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_10 and arg_153_1.time_ < 0 + var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1053ui_story then
				arg_153_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_156_12 = arg_153_1.actors_["1075ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_12) and arg_153_1.var_.characterEffect1075ui_story == nil then
				arg_153_1.var_.characterEffect1075ui_story = var_156_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_13 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_13 and not isNil(var_156_12) then
				if arg_153_1.var_.characterEffect1075ui_story and not isNil(var_156_12) then
					arg_153_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_13)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_13 and arg_153_1.time_ < 0 + var_156_13 + arg_156_0 and not isNil(var_156_12) and arg_153_1.var_.characterEffect1075ui_story then
				arg_153_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_156_14 = 0
			local var_156_15 = 0.225

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_16 = arg_153_1:GetWordFromCfg(325111036)
				local var_156_17 = arg_153_1:FormatText(var_156_16.content)

				arg_153_1.text_.text = var_156_17

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_19 = 9 <= 0 and var_156_15 or var_156_15 * (utf8.len(var_156_17) / 9)

				if (9 <= 0 and var_156_15 or var_156_15 * (utf8.len(var_156_17) / 9)) > 0 and var_156_15 < var_156_19 then
					arg_153_1.talkMaxDuration = var_156_19

					if var_156_19 + var_156_14 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_14
					end
				end

				arg_153_1.text_.text = var_156_17
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111036", "story_v_out_325111.awb") ~= 0 then
					local var_156_20 = manager.audio:GetVoiceLength("story_v_out_325111", "325111036", "story_v_out_325111.awb") / 1000

					if var_156_20 + var_156_14 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_20 + var_156_14
					end

					if var_156_16.prefab_name ~= "" and arg_153_1.actors_[var_156_16.prefab_name] ~= nil then
						local var_156_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_16.prefab_name].transform, "story_v_out_325111", "325111036", "story_v_out_325111.awb")

						arg_153_1:RecordAudio("325111036", var_156_21)
						arg_153_1:RecordAudio("325111036", var_156_21)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_325111", "325111036", "story_v_out_325111.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_325111", "325111036", "story_v_out_325111.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_22 = math.max(var_156_15, arg_153_1.talkMaxDuration)

			if var_156_14 <= arg_153_1.time_ and arg_153_1.time_ < var_156_14 + var_156_22 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_14) / var_156_22

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_14 + var_156_22 and arg_153_1.time_ < var_156_14 + var_156_22 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play325111037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 325111037
		arg_157_1.duration_ = 6.2

		local var_157_0 = {
			zh = 4.7,
			ja = 6.2
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play325111038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1075ui_story"]) and arg_157_1.var_.characterEffect1075ui_story == nil then
				arg_157_1.var_.characterEffect1075ui_story = arg_157_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1075ui_story"]) then
				if arg_157_1.var_.characterEffect1075ui_story and not isNil(arg_157_1.actors_["1075ui_story"]) then
					arg_157_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1075ui_story"]) and arg_157_1.var_.characterEffect1075ui_story then
				arg_157_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_160_2 = arg_157_1.actors_["1053ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1053ui_story == nil then
				arg_157_1.var_.characterEffect1053ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_3 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.characterEffect1053ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_3)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1053ui_story then
				arg_157_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_160_4 = 0
			local var_160_5 = 0.6

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(325111037)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 24 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 24)

				if (24 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 24)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111037", "story_v_out_325111.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_325111", "325111037", "story_v_out_325111.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_325111", "325111037", "story_v_out_325111.awb")

						arg_157_1:RecordAudio("325111037", var_160_11)
						arg_157_1:RecordAudio("325111037", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_325111", "325111037", "story_v_out_325111.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_325111", "325111037", "story_v_out_325111.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play325111038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 325111038
		arg_161_1.duration_ = 6.87

		local var_161_0 = {
			zh = 5.533,
			ja = 6.866
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play325111039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1053ui_story"]) and arg_161_1.var_.characterEffect1053ui_story == nil then
				arg_161_1.var_.characterEffect1053ui_story = arg_161_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1053ui_story"]) then
				if arg_161_1.var_.characterEffect1053ui_story and not isNil(arg_161_1.actors_["1053ui_story"]) then
					arg_161_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1053ui_story"]) and arg_161_1.var_.characterEffect1053ui_story then
				arg_161_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_164_2 = arg_161_1.actors_["1075ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1075ui_story == nil then
				arg_161_1.var_.characterEffect1075ui_story = var_164_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.characterEffect1075ui_story and not isNil(var_164_2) then
					arg_161_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_3)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1075ui_story then
				arg_161_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_164_4 = 0
			local var_164_5 = 0.6

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(325111038)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 24 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 24)

				if (24 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 24)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111038", "story_v_out_325111.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_325111", "325111038", "story_v_out_325111.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_out_325111", "325111038", "story_v_out_325111.awb")

						arg_161_1:RecordAudio("325111038", var_164_11)
						arg_161_1:RecordAudio("325111038", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_325111", "325111038", "story_v_out_325111.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_325111", "325111038", "story_v_out_325111.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play325111039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 325111039
		arg_165_1.duration_ = 11.43

		local var_165_0 = {
			zh = 6.766,
			ja = 11.433
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play325111040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1075ui_story"]) and arg_165_1.var_.characterEffect1075ui_story == nil then
				arg_165_1.var_.characterEffect1075ui_story = arg_165_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1075ui_story"]) then
				if arg_165_1.var_.characterEffect1075ui_story and not isNil(arg_165_1.actors_["1075ui_story"]) then
					arg_165_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1075ui_story"]) and arg_165_1.var_.characterEffect1075ui_story then
				arg_165_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_168_2 = arg_165_1.actors_["1053ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect1053ui_story == nil then
				arg_165_1.var_.characterEffect1053ui_story = var_168_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_3 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.characterEffect1053ui_story and not isNil(var_168_2) then
					arg_165_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_3)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect1053ui_story then
				arg_165_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_168_4 = 0
			local var_168_5 = 0.8

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(325111039)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 32 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 32)

				if (32 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 32)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111039", "story_v_out_325111.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_325111", "325111039", "story_v_out_325111.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_325111", "325111039", "story_v_out_325111.awb")

						arg_165_1:RecordAudio("325111039", var_168_11)
						arg_165_1:RecordAudio("325111039", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_325111", "325111039", "story_v_out_325111.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_325111", "325111039", "story_v_out_325111.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play325111040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 325111040
		arg_169_1.duration_ = 13.6

		local var_169_0 = {
			zh = 9.933,
			ja = 13.6
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play325111041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.225

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(325111040)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 49 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 49)

				if (49 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 49)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111040", "story_v_out_325111.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_325111", "325111040", "story_v_out_325111.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_325111", "325111040", "story_v_out_325111.awb")

						arg_169_1:RecordAudio("325111040", var_172_6)
						arg_169_1:RecordAudio("325111040", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_325111", "325111040", "story_v_out_325111.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_325111", "325111040", "story_v_out_325111.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play325111041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 325111041
		arg_173_1.duration_ = 9.97

		local var_173_0 = {
			zh = 7.1,
			ja = 9.966
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play325111042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action6_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_176_0 = 0
			local var_176_1 = 0.825

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(325111041)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 33 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 33)

				if (33 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 33)) > 0 and var_176_1 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111041", "story_v_out_325111.awb") ~= 0 then
					local var_176_6 = manager.audio:GetVoiceLength("story_v_out_325111", "325111041", "story_v_out_325111.awb") / 1000

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end

					if var_176_2.prefab_name ~= "" and arg_173_1.actors_[var_176_2.prefab_name] ~= nil then
						local var_176_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_2.prefab_name].transform, "story_v_out_325111", "325111041", "story_v_out_325111.awb")

						arg_173_1:RecordAudio("325111041", var_176_7)
						arg_173_1:RecordAudio("325111041", var_176_7)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_325111", "325111041", "story_v_out_325111.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_325111", "325111041", "story_v_out_325111.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play325111042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 325111042
		arg_177_1.duration_ = 8.73

		local var_177_0 = {
			zh = 6.3,
			ja = 8.733
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play325111043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1053ui_story"]) and arg_177_1.var_.characterEffect1053ui_story == nil then
				arg_177_1.var_.characterEffect1053ui_story = arg_177_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1053ui_story"]) then
				if arg_177_1.var_.characterEffect1053ui_story and not isNil(arg_177_1.actors_["1053ui_story"]) then
					arg_177_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1053ui_story"]) and arg_177_1.var_.characterEffect1053ui_story then
				arg_177_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_180_2 = arg_177_1.actors_["1075ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1075ui_story == nil then
				arg_177_1.var_.characterEffect1075ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect1075ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1075ui_story then
				arg_177_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			local var_180_4 = 0
			local var_180_5 = 0.65

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(325111042)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 26 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 26)

				if (26 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 26)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111042", "story_v_out_325111.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_325111", "325111042", "story_v_out_325111.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_325111", "325111042", "story_v_out_325111.awb")

						arg_177_1:RecordAudio("325111042", var_180_11)
						arg_177_1:RecordAudio("325111042", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_325111", "325111042", "story_v_out_325111.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_325111", "325111042", "story_v_out_325111.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play325111043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 325111043
		arg_181_1.duration_ = 3.1

		local var_181_0 = {
			zh = 3,
			ja = 3.1
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play325111044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1075ui_story"]) and arg_181_1.var_.characterEffect1075ui_story == nil then
				arg_181_1.var_.characterEffect1075ui_story = arg_181_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1075ui_story"]) then
				if arg_181_1.var_.characterEffect1075ui_story and not isNil(arg_181_1.actors_["1075ui_story"]) then
					arg_181_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1075ui_story"]) and arg_181_1.var_.characterEffect1075ui_story then
				arg_181_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_184_2 = arg_181_1.actors_["1053ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1053ui_story == nil then
				arg_181_1.var_.characterEffect1053ui_story = var_184_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.characterEffect1053ui_story and not isNil(var_184_2) then
					arg_181_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_3)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1053ui_story then
				arg_181_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_184_4 = 0
			local var_184_5 = 0.225

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(325111043)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 9 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 9)

				if (9 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 9)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111043", "story_v_out_325111.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_325111", "325111043", "story_v_out_325111.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_325111", "325111043", "story_v_out_325111.awb")

						arg_181_1:RecordAudio("325111043", var_184_11)
						arg_181_1:RecordAudio("325111043", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_325111", "325111043", "story_v_out_325111.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_325111", "325111043", "story_v_out_325111.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play325111044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 325111044
		arg_185_1.duration_ = 8

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play325111045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 1.66666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 1.66666666666667 + arg_188_0 then
				local var_188_0 = arg_185_1.bgs_.ST2010

				arg_185_1.bgs_.ST2010.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_188_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_1 = var_188_0:GetComponent("SpriteRenderer")

				if var_188_1 and var_188_1.sprite then
					local var_188_2 = 2 * (var_188_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_188_0.transform.localScale = Vector3.New(var_188_2 / var_188_1.sprite.bounds.size.y < var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x and var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x or var_188_2 / var_188_1.sprite.bounds.size.y, var_188_2 / var_188_1.sprite.bounds.size.y < var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x and var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x or var_188_2 / var_188_1.sprite.bounds.size.y, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "ST2010" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_3 = 1.66666666666667

			if 1.66666666666667 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			if arg_185_1.time_ >= var_188_3 + 0.3 and arg_185_1.time_ < var_188_3 + 0.3 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			local var_188_4 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_5 = 1.66666666666667

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_5 then
				local var_188_6 = Color.New(0, 0, 0)

				var_188_6.a = Mathf.Lerp(0, 1, (arg_185_1.time_ - var_188_4) / var_188_5)
				arg_185_1.mask_.color = var_188_6
			end

			if arg_185_1.time_ >= var_188_4 + var_188_5 and arg_185_1.time_ < var_188_4 + var_188_5 + arg_188_0 then
				local var_188_7 = Color.New(0, 0, 0)

				var_188_7.a = 1
				arg_185_1.mask_.color = var_188_7
			end

			local var_188_8 = 1.66666666666667

			if 1.66666666666667 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_9 = 2

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 then
				local var_188_10 = Color.New(0, 0, 0)

				var_188_10.a = Mathf.Lerp(1, 0, (arg_185_1.time_ - var_188_8) / var_188_9)
				arg_185_1.mask_.color = var_188_10
			end

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 then
				local var_188_11 = Color.New(0, 0, 0)

				arg_185_1.mask_.enabled = false
				var_188_11.a = 0
				arg_185_1.mask_.color = var_188_11
			end

			local var_188_12 = arg_185_1.actors_["1075ui_story"].transform

			if 1.66666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 1.66666666666667 + arg_188_0 then
				arg_185_1.var_.moveOldPos1075ui_story = var_188_12.localPosition
			end

			local var_188_13 = 0.001

			if 1.66666666666667 <= arg_185_1.time_ and arg_185_1.time_ < 1.66666666666667 + var_188_13 then
				var_188_12.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 1.66666666666667) / var_188_13)
				var_188_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_12.position).x, (manager.ui.mainCamera.transform.position - var_188_12.position).y, (manager.ui.mainCamera.transform.position - var_188_12.position).z)
				var_188_12.localEulerAngles.z = 0
				var_188_12.localEulerAngles.x = 0
				var_188_12.localEulerAngles = var_188_12.localEulerAngles
			end

			if arg_185_1.time_ >= 1.66666666666667 + var_188_13 and arg_185_1.time_ < 1.66666666666667 + var_188_13 + arg_188_0 then
				var_188_12.localPosition = Vector3.New(0, 100, 0)
				var_188_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_12.position).x, (manager.ui.mainCamera.transform.position - var_188_12.position).y, (manager.ui.mainCamera.transform.position - var_188_12.position).z)
				var_188_12.localEulerAngles.z = 0
				var_188_12.localEulerAngles.x = 0
				var_188_12.localEulerAngles = var_188_12.localEulerAngles
			end

			local var_188_14 = arg_185_1.actors_["1053ui_story"].transform

			if 1.66666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 1.66666666666667 + arg_188_0 then
				arg_185_1.var_.moveOldPos1053ui_story = var_188_14.localPosition

				local var_188_15 = GameObjectTools.GetOrAddComponent(var_188_14.gameObject, typeof(DynamicBoneHelper))

				if var_188_15 then
					var_188_15:EnableDynamicBone(false)
				end
			end

			local var_188_16 = 0.001

			if 1.66666666666667 <= arg_185_1.time_ and arg_185_1.time_ < 1.66666666666667 + var_188_16 then
				var_188_14.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 1.66666666666667) / var_188_16)
				var_188_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_14.position).x, (manager.ui.mainCamera.transform.position - var_188_14.position).y, (manager.ui.mainCamera.transform.position - var_188_14.position).z)
				var_188_14.localEulerAngles.z = 0
				var_188_14.localEulerAngles.x = 0
				var_188_14.localEulerAngles = var_188_14.localEulerAngles
			end

			if arg_185_1.time_ >= 1.66666666666667 + var_188_16 and arg_185_1.time_ < 1.66666666666667 + var_188_16 + arg_188_0 then
				var_188_14.localPosition = Vector3.New(0, 100, 0)
				var_188_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_14.position).x, (manager.ui.mainCamera.transform.position - var_188_14.position).y, (manager.ui.mainCamera.transform.position - var_188_14.position).z)
				var_188_14.localEulerAngles.z = 0
				var_188_14.localEulerAngles.x = 0
				var_188_14.localEulerAngles = var_188_14.localEulerAngles

				local var_188_17 = GameObjectTools.GetOrAddComponent(var_188_14.gameObject, typeof(DynamicBoneHelper))

				if var_188_17 then
					var_188_17:EnableDynamicBone(true)
				end
			end

			local var_188_18 = arg_185_1.actors_["1075ui_story"]

			if 1.66666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 1.66666666666667 + arg_188_0 and not isNil(var_188_18) and arg_185_1.var_.characterEffect1075ui_story == nil then
				arg_185_1.var_.characterEffect1075ui_story = var_188_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_19 = 0.200000002980232

			if 1.66666666666667 <= arg_185_1.time_ and arg_185_1.time_ < 1.66666666666667 + var_188_19 and not isNil(var_188_18) then
				if arg_185_1.var_.characterEffect1075ui_story and not isNil(var_188_18) then
					arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 1.66666666666667) / var_188_19)
				end
			end

			if arg_185_1.time_ >= 1.66666666666667 + var_188_19 and arg_185_1.time_ < 1.66666666666667 + var_188_19 + arg_188_0 and not isNil(var_188_18) and arg_185_1.var_.characterEffect1075ui_story then
				arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_185_1.time_ and arg_185_1.time_ <= 0.1 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_down", "")
			end

			if 0.5 < arg_185_1.time_ and arg_185_1.time_ <= 0.5 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_activity_2_1_4", "se_story_activity_2_1_4_warchess_box_down", "")
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_22 = 3
			local var_188_23 = 1.2

			if 3 < arg_185_1.time_ and arg_185_1.time_ <= var_188_22 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_24 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_24:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_25 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(325111044).content)

				arg_185_1.text_.text = var_188_25

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_27 = 48 <= 0 and var_188_23 or var_188_23 * (utf8.len(var_188_25) / 48)

				if (48 <= 0 and var_188_23 or var_188_23 * (utf8.len(var_188_25) / 48)) > 0 and var_188_23 < var_188_27 then
					arg_185_1.talkMaxDuration = var_188_27
					var_188_22 = var_188_22 + 0.3

					if var_188_27 + var_188_22 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_27 + var_188_22
					end
				end

				arg_185_1.text_.text = var_188_25
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_28 = var_188_22 + 0.3
			local var_188_29 = math.max(var_188_23, arg_185_1.talkMaxDuration)

			if var_188_22 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_28 + var_188_29 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_28) / var_188_29

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_28 + var_188_29 and arg_185_1.time_ < var_188_28 + var_188_29 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play325111045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 325111045
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play325111046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_194_0 = 0
			local var_194_1 = 1.175

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(325111045).content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 47 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_2) / 47)

				if (47 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_2) / 47)) > 0 and var_194_1 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_5 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_5 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_5

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_5 and arg_191_1.time_ < var_194_0 + var_194_5 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play325111046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 325111046
		arg_195_1.duration_ = 6

		local var_195_0 = {
			zh = 6,
			ja = 4.8
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
				arg_195_0:Play325111047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1077ui_story = arg_195_1.actors_["1077ui_story"].transform.localPosition

				local var_198_0 = GameObjectTools.GetOrAddComponent(arg_195_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_198_0 then
					var_198_0:EnableDynamicBone(false)
				end
			end

			local var_198_1 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_1 then
				arg_195_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_195_1.time_ - 0) / var_198_1)
				arg_195_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).z)
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles = arg_195_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_1 and arg_195_1.time_ < 0 + var_198_1 + arg_198_0 then
				arg_195_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_195_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).z)
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles = arg_195_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_198_2 = GameObjectTools.GetOrAddComponent(arg_195_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(true)
				end
			end

			local var_198_3 = arg_195_1.actors_["1077ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_3) and arg_195_1.var_.characterEffect1077ui_story == nil then
				arg_195_1.var_.characterEffect1077ui_story = var_198_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_4 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 and not isNil(var_198_3) then
				if arg_195_1.var_.characterEffect1077ui_story and not isNil(var_198_3) then
					arg_195_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 and not isNil(var_198_3) and arg_195_1.var_.characterEffect1077ui_story then
				arg_195_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_198_6 = 0
			local var_198_7 = 0.675

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(325111046)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 27 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 27)

				if (27 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 27)) > 0 and var_198_7 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111046", "story_v_out_325111.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111046", "story_v_out_325111.awb") / 1000

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end

					if var_198_8.prefab_name ~= "" and arg_195_1.actors_[var_198_8.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_8.prefab_name].transform, "story_v_out_325111", "325111046", "story_v_out_325111.awb")

						arg_195_1:RecordAudio("325111046", var_198_13)
						arg_195_1:RecordAudio("325111046", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_325111", "325111046", "story_v_out_325111.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_325111", "325111046", "story_v_out_325111.awb")
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
				actorName = "1077ui_story",
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
	Play325111047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 325111047
		arg_199_1.duration_ = 11.67

		local var_199_0 = {
			zh = 11.033,
			ja = 11.666
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play325111048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.125

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(325111047)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 45 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 45)

				if (45 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 45)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111047", "story_v_out_325111.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_325111", "325111047", "story_v_out_325111.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_325111", "325111047", "story_v_out_325111.awb")

						arg_199_1:RecordAudio("325111047", var_202_6)
						arg_199_1:RecordAudio("325111047", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_325111", "325111047", "story_v_out_325111.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_325111", "325111047", "story_v_out_325111.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play325111048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 325111048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play325111049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1077ui_story = arg_203_1.actors_["1077ui_story"].transform.localPosition

				local var_206_0 = GameObjectTools.GetOrAddComponent(arg_203_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_206_0 then
					var_206_0:EnableDynamicBone(false)
				end
			end

			local var_206_1 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 then
				arg_203_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_1)
				arg_203_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1077ui_story"].transform.position).z)
				arg_203_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1077ui_story"].transform.localEulerAngles = arg_203_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 then
				arg_203_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1077ui_story"].transform.position).z)
				arg_203_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1077ui_story"].transform.localEulerAngles = arg_203_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_206_2 = GameObjectTools.GetOrAddComponent(arg_203_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_206_2 then
					var_206_2:EnableDynamicBone(true)
				end
			end

			local var_206_3 = arg_203_1.actors_["1077ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect1077ui_story == nil then
				arg_203_1.var_.characterEffect1077ui_story = var_206_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_4 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 and not isNil(var_206_3) then
				if arg_203_1.var_.characterEffect1077ui_story and not isNil(var_206_3) then
					arg_203_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_4)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect1077ui_story then
				arg_203_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_206_5 = 0
			local var_206_6 = 0.95

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(325111048).content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 38 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_7) / 38)

				if (38 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_7) / 38)) > 0 and var_206_6 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_6, arg_203_1.talkMaxDuration)

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_5) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_5 + var_206_10 and arg_203_1.time_ < var_206_5 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 325111049
		arg_207_1.duration_ = 4.57

		local var_207_0 = {
			zh = 4.166,
			ja = 4.566
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
				arg_207_0:Play325111050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1077ui_story = arg_207_1.actors_["1077ui_story"].transform.localPosition

				local var_210_0 = GameObjectTools.GetOrAddComponent(arg_207_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_210_0 then
					var_210_0:EnableDynamicBone(false)
				end
			end

			local var_210_1 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				arg_207_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_207_1.time_ - 0) / var_210_1)
				arg_207_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1077ui_story"].transform.position).z)
				arg_207_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1077ui_story"].transform.localEulerAngles = arg_207_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 then
				arg_207_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_207_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1077ui_story"].transform.position).z)
				arg_207_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1077ui_story"].transform.localEulerAngles = arg_207_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_210_2 = GameObjectTools.GetOrAddComponent(arg_207_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_210_2 then
					var_210_2:EnableDynamicBone(true)
				end
			end

			local var_210_3 = arg_207_1.actors_["1077ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1077ui_story == nil then
				arg_207_1.var_.characterEffect1077ui_story = var_210_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_4 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 and not isNil(var_210_3) then
				if arg_207_1.var_.characterEffect1077ui_story and not isNil(var_210_3) then
					arg_207_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1077ui_story then
				arg_207_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_210_6 = 0
			local var_210_7 = 0.425

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(325111049)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 17 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 17)

				if (17 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 17)) > 0 and var_210_7 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111049", "story_v_out_325111.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111049", "story_v_out_325111.awb") / 1000

					if var_210_12 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_6
					end

					if var_210_8.prefab_name ~= "" and arg_207_1.actors_[var_210_8.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_8.prefab_name].transform, "story_v_out_325111", "325111049", "story_v_out_325111.awb")

						arg_207_1:RecordAudio("325111049", var_210_13)
						arg_207_1:RecordAudio("325111049", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_325111", "325111049", "story_v_out_325111.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_325111", "325111049", "story_v_out_325111.awb")
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
				actorName = "1077ui_story",
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
	Play325111050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 325111050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play325111051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1077ui_story = arg_211_1.actors_["1077ui_story"].transform.localPosition

				local var_214_0 = GameObjectTools.GetOrAddComponent(arg_211_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_214_0 then
					var_214_0:EnableDynamicBone(false)
				end
			end

			local var_214_1 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 then
				arg_211_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_1)
				arg_211_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).z)
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles = arg_211_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).z)
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles = arg_211_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_214_2 = GameObjectTools.GetOrAddComponent(arg_211_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(true)
				end
			end

			local var_214_3 = arg_211_1.actors_["1077ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect1077ui_story == nil then
				arg_211_1.var_.characterEffect1077ui_story = var_214_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_4 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 and not isNil(var_214_3) then
				if arg_211_1.var_.characterEffect1077ui_story and not isNil(var_214_3) then
					arg_211_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_4)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect1077ui_story then
				arg_211_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_214_5 = 0
			local var_214_6 = 1.325

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_7 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(325111050).content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 53 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_7) / 53)

				if (53 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_7) / 53)) > 0 and var_214_6 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_10 and arg_211_1.time_ < var_214_5 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 325111051
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play325111052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.05

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(325111051).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 42 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 42)

				if (42 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 42)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play325111052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 325111052
		arg_219_1.duration_ = 4.97

		local var_219_0 = {
			zh = 4.766,
			ja = 4.966
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
				arg_219_0:Play325111053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1077ui_story = arg_219_1.actors_["1077ui_story"].transform.localPosition

				local var_222_0 = GameObjectTools.GetOrAddComponent(arg_219_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_222_0 then
					var_222_0:EnableDynamicBone(false)
				end
			end

			local var_222_1 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 then
				arg_219_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_219_1.time_ - 0) / var_222_1)
				arg_219_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1077ui_story"].transform.position).z)
				arg_219_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1077ui_story"].transform.localEulerAngles = arg_219_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 then
				arg_219_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_219_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1077ui_story"].transform.position).z)
				arg_219_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1077ui_story"].transform.localEulerAngles = arg_219_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_222_2 = GameObjectTools.GetOrAddComponent(arg_219_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_222_2 then
					var_222_2:EnableDynamicBone(true)
				end
			end

			local var_222_3 = arg_219_1.actors_["1077ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_3) and arg_219_1.var_.characterEffect1077ui_story == nil then
				arg_219_1.var_.characterEffect1077ui_story = var_222_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_4 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 and not isNil(var_222_3) then
				if arg_219_1.var_.characterEffect1077ui_story and not isNil(var_222_3) then
					arg_219_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 and not isNil(var_222_3) and arg_219_1.var_.characterEffect1077ui_story then
				arg_219_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_222_6 = 0
			local var_222_7 = 0.575

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(325111052)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 23 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 23)

				if (23 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 23)) > 0 and var_222_7 < var_222_11 then
					arg_219_1.talkMaxDuration = var_222_11

					if var_222_11 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111052", "story_v_out_325111.awb") ~= 0 then
					local var_222_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111052", "story_v_out_325111.awb") / 1000

					if var_222_12 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_6
					end

					if var_222_8.prefab_name ~= "" and arg_219_1.actors_[var_222_8.prefab_name] ~= nil then
						local var_222_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_8.prefab_name].transform, "story_v_out_325111", "325111052", "story_v_out_325111.awb")

						arg_219_1:RecordAudio("325111052", var_222_13)
						arg_219_1:RecordAudio("325111052", var_222_13)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_325111", "325111052", "story_v_out_325111.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_325111", "325111052", "story_v_out_325111.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_14 and arg_219_1.time_ < var_222_6 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play325111053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 325111053
		arg_223_1.duration_ = 4.37

		local var_223_0 = {
			zh = 4.366,
			ja = 3.433
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
				arg_223_0:Play325111054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1077ui_story"]) and arg_223_1.var_.characterEffect1077ui_story == nil then
				arg_223_1.var_.characterEffect1077ui_story = arg_223_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1077ui_story"]) then
				if arg_223_1.var_.characterEffect1077ui_story and not isNil(arg_223_1.actors_["1077ui_story"]) then
					arg_223_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1077ui_story"]) and arg_223_1.var_.characterEffect1077ui_story then
				arg_223_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			if arg_223_1.time_ >= var_226_1 + 1.23333333333333 and arg_223_1.time_ < var_226_1 + 1.23333333333333 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			local var_226_2 = 0
			local var_226_3 = 0.35

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_4 = arg_223_1:GetWordFromCfg(325111053)
				local var_226_5 = arg_223_1:FormatText(var_226_4.content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 14 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 14)

				if (14 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 14)) > 0 and var_226_3 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111053", "story_v_out_325111.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_325111", "325111053", "story_v_out_325111.awb") / 1000

					if var_226_8 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_2
					end

					if var_226_4.prefab_name ~= "" and arg_223_1.actors_[var_226_4.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_4.prefab_name].transform, "story_v_out_325111", "325111053", "story_v_out_325111.awb")

						arg_223_1:RecordAudio("325111053", var_226_9)
						arg_223_1:RecordAudio("325111053", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_325111", "325111053", "story_v_out_325111.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_325111", "325111053", "story_v_out_325111.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_10 and arg_223_1.time_ < var_226_2 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play325111054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 325111054
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play325111055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if arg_227_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_230_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_227_1.stage_.transform)

				var_230_0.name = "1059ui_story"
				var_230_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["1059ui_story"] = var_230_0

				local var_230_1 = var_230_0:GetComponentInChildren(typeof(CharacterEffect))

				var_230_1.enabled = true

				local var_230_2 = GameObjectTools.GetOrAddComponent(var_230_0, typeof(DynamicBoneHelper))

				if var_230_2 then
					var_230_2:EnableDynamicBone(false)
				end

				arg_227_1:ShowWeapon(var_230_1.transform, false)

				arg_227_1.var_["1059ui_story" .. "Animator"] = var_230_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_227_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_227_1.var_["1059ui_story" .. "LipSync"] = var_230_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_230_3 = arg_227_1.actors_["1059ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1059ui_story = var_230_3.localPosition
			end

			local var_230_4 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				var_230_3.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_4)
				var_230_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_3.position).x, (manager.ui.mainCamera.transform.position - var_230_3.position).y, (manager.ui.mainCamera.transform.position - var_230_3.position).z)
				var_230_3.localEulerAngles.z = 0
				var_230_3.localEulerAngles.x = 0
				var_230_3.localEulerAngles = var_230_3.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				var_230_3.localPosition = Vector3.New(0, 100, 0)
				var_230_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_3.position).x, (manager.ui.mainCamera.transform.position - var_230_3.position).y, (manager.ui.mainCamera.transform.position - var_230_3.position).z)
				var_230_3.localEulerAngles.z = 0
				var_230_3.localEulerAngles.x = 0
				var_230_3.localEulerAngles = var_230_3.localEulerAngles
			end

			local var_230_5 = arg_227_1.actors_["1077ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1077ui_story = var_230_5.localPosition

				local var_230_6 = GameObjectTools.GetOrAddComponent(var_230_5.gameObject, typeof(DynamicBoneHelper))

				if var_230_6 then
					var_230_6:EnableDynamicBone(false)
				end
			end

			local var_230_7 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				var_230_5.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_7)
				var_230_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_5.position).x, (manager.ui.mainCamera.transform.position - var_230_5.position).y, (manager.ui.mainCamera.transform.position - var_230_5.position).z)
				var_230_5.localEulerAngles.z = 0
				var_230_5.localEulerAngles.x = 0
				var_230_5.localEulerAngles = var_230_5.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				var_230_5.localPosition = Vector3.New(0, 100, 0)
				var_230_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_5.position).x, (manager.ui.mainCamera.transform.position - var_230_5.position).y, (manager.ui.mainCamera.transform.position - var_230_5.position).z)
				var_230_5.localEulerAngles.z = 0
				var_230_5.localEulerAngles.x = 0
				var_230_5.localEulerAngles = var_230_5.localEulerAngles

				local var_230_8 = GameObjectTools.GetOrAddComponent(var_230_5.gameObject, typeof(DynamicBoneHelper))

				if var_230_8 then
					var_230_8:EnableDynamicBone(true)
				end
			end

			local var_230_9 = arg_227_1.actors_["1059ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1059ui_story == nil then
				arg_227_1.var_.characterEffect1059ui_story = var_230_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_10 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_10 and not isNil(var_230_9) then
				if arg_227_1.var_.characterEffect1059ui_story and not isNil(var_230_9) then
					arg_227_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_10)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_10 and arg_227_1.time_ < 0 + var_230_10 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1059ui_story then
				arg_227_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_227_1.time_ and arg_227_1.time_ <= 0.1 + arg_230_0 then
				arg_227_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_roll", "")
			end

			local var_230_12 = 0
			local var_230_13 = 1.325

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_12 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_14 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(325111054).content)

				arg_227_1.text_.text = var_230_14

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_16 = 53 <= 0 and var_230_13 or var_230_13 * (utf8.len(var_230_14) / 53)

				if (53 <= 0 and var_230_13 or var_230_13 * (utf8.len(var_230_14) / 53)) > 0 and var_230_13 < var_230_16 then
					arg_227_1.talkMaxDuration = var_230_16

					if var_230_16 + var_230_12 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_16 + var_230_12
					end
				end

				arg_227_1.text_.text = var_230_14
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_17 = math.max(var_230_13, arg_227_1.talkMaxDuration)

			if var_230_12 <= arg_227_1.time_ and arg_227_1.time_ < var_230_12 + var_230_17 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_12) / var_230_17

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_12 + var_230_17 and arg_227_1.time_ < var_230_12 + var_230_17 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play325111055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 325111055
		arg_231_1.duration_ = 3.1

		local var_231_0 = {
			zh = 1.999999999999,
			ja = 3.1
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play325111056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1077ui_story = arg_231_1.actors_["1077ui_story"].transform.localPosition

				local var_234_0 = GameObjectTools.GetOrAddComponent(arg_231_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_234_0 then
					var_234_0:EnableDynamicBone(false)
				end
			end

			local var_234_1 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 then
				arg_231_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_231_1.time_ - 0) / var_234_1)
				arg_231_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1077ui_story"].transform.position).z)
				arg_231_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1077ui_story"].transform.localEulerAngles = arg_231_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 then
				arg_231_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_231_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1077ui_story"].transform.position).z)
				arg_231_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1077ui_story"].transform.localEulerAngles = arg_231_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_234_2 = GameObjectTools.GetOrAddComponent(arg_231_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_234_2 then
					var_234_2:EnableDynamicBone(true)
				end
			end

			local var_234_3 = arg_231_1.actors_["1077ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect1077ui_story == nil then
				arg_231_1.var_.characterEffect1077ui_story = var_234_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_4 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 and not isNil(var_234_3) then
				if arg_231_1.var_.characterEffect1077ui_story and not isNil(var_234_3) then
					arg_231_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect1077ui_story then
				arg_231_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_234_6 = 0
			local var_234_7 = 0.1

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_8 = arg_231_1:GetWordFromCfg(325111055)
				local var_234_9 = arg_231_1:FormatText(var_234_8.content)

				arg_231_1.text_.text = var_234_9

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 4 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_9) / 4)

				if (4 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_9) / 4)) > 0 and var_234_7 < var_234_11 then
					arg_231_1.talkMaxDuration = var_234_11

					if var_234_11 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_9
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111055", "story_v_out_325111.awb") ~= 0 then
					local var_234_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111055", "story_v_out_325111.awb") / 1000

					if var_234_12 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_12 + var_234_6
					end

					if var_234_8.prefab_name ~= "" and arg_231_1.actors_[var_234_8.prefab_name] ~= nil then
						local var_234_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_8.prefab_name].transform, "story_v_out_325111", "325111055", "story_v_out_325111.awb")

						arg_231_1:RecordAudio("325111055", var_234_13)
						arg_231_1:RecordAudio("325111055", var_234_13)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_325111", "325111055", "story_v_out_325111.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_325111", "325111055", "story_v_out_325111.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_14 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_14 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_14

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_14 and arg_231_1.time_ < var_234_6 + var_234_14 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play325111056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 325111056
		arg_235_1.duration_ = 6.17

		local var_235_0 = {
			zh = 6.166,
			ja = 6.1
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play325111057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1077ui_story = arg_235_1.actors_["1077ui_story"].transform.localPosition

				local var_238_0 = GameObjectTools.GetOrAddComponent(arg_235_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_238_0 then
					var_238_0:EnableDynamicBone(false)
				end
			end

			local var_238_1 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 then
				arg_235_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_235_1.time_ - 0) / var_238_1)
				arg_235_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1077ui_story"].transform.position).z)
				arg_235_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1077ui_story"].transform.localEulerAngles = arg_235_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 then
				arg_235_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_235_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1077ui_story"].transform.position).z)
				arg_235_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1077ui_story"].transform.localEulerAngles = arg_235_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_238_2 = GameObjectTools.GetOrAddComponent(arg_235_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_238_2 then
					var_238_2:EnableDynamicBone(true)
				end
			end

			local var_238_3 = arg_235_1.actors_["1077ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.characterEffect1077ui_story == nil then
				arg_235_1.var_.characterEffect1077ui_story = var_238_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_4 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 and not isNil(var_238_3) then
				if arg_235_1.var_.characterEffect1077ui_story and not isNil(var_238_3) then
					arg_235_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_4)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.characterEffect1077ui_story then
				arg_235_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_238_5 = 0
			local var_238_6 = 0.65

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_7 = arg_235_1:GetWordFromCfg(325111056)
				local var_238_8 = arg_235_1:FormatText(var_238_7.content)

				arg_235_1.text_.text = var_238_8

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_10 = 26 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 26)

				if (26 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 26)) > 0 and var_238_6 < var_238_10 then
					arg_235_1.talkMaxDuration = var_238_10

					if var_238_10 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_5
					end
				end

				arg_235_1.text_.text = var_238_8
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111056", "story_v_out_325111.awb") ~= 0 then
					local var_238_11 = manager.audio:GetVoiceLength("story_v_out_325111", "325111056", "story_v_out_325111.awb") / 1000

					if var_238_11 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_5
					end

					if var_238_7.prefab_name ~= "" and arg_235_1.actors_[var_238_7.prefab_name] ~= nil then
						local var_238_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_7.prefab_name].transform, "story_v_out_325111", "325111056", "story_v_out_325111.awb")

						arg_235_1:RecordAudio("325111056", var_238_12)
						arg_235_1:RecordAudio("325111056", var_238_12)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_325111", "325111056", "story_v_out_325111.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_325111", "325111056", "story_v_out_325111.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_13 = math.max(var_238_6, arg_235_1.talkMaxDuration)

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_13 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_5) / var_238_13

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_5 + var_238_13 and arg_235_1.time_ < var_238_5 + var_238_13 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play325111057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 325111057
		arg_239_1.duration_ = 9.6

		local var_239_0 = {
			zh = 9.6,
			ja = 8.266
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play325111058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.9

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:GetWordFromCfg(325111057)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 36 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 36)

				if (36 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 36)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111057", "story_v_out_325111.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_325111", "325111057", "story_v_out_325111.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_325111", "325111057", "story_v_out_325111.awb")

						arg_239_1:RecordAudio("325111057", var_242_6)
						arg_239_1:RecordAudio("325111057", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_325111", "325111057", "story_v_out_325111.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_325111", "325111057", "story_v_out_325111.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play325111058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 325111058
		arg_243_1.duration_ = 6

		local var_243_0 = {
			zh = 3.633,
			ja = 6
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
				arg_243_0:Play325111059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1077ui_story"]) and arg_243_1.var_.characterEffect1077ui_story == nil then
				arg_243_1.var_.characterEffect1077ui_story = arg_243_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1077ui_story"]) then
				if arg_243_1.var_.characterEffect1077ui_story and not isNil(arg_243_1.actors_["1077ui_story"]) then
					arg_243_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1077ui_story"]) and arg_243_1.var_.characterEffect1077ui_story then
				arg_243_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_246_2 = arg_243_1.actors_["1059ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.characterEffect1059ui_story == nil then
				arg_243_1.var_.characterEffect1059ui_story = var_246_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_3 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.characterEffect1059ui_story and not isNil(var_246_2) then
					arg_243_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_3)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.characterEffect1059ui_story then
				arg_243_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_246_4 = 0
			local var_246_5 = 0.5

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(325111058)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 20 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 20)

				if (20 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 20)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111058", "story_v_out_325111.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_325111", "325111058", "story_v_out_325111.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_out_325111", "325111058", "story_v_out_325111.awb")

						arg_243_1:RecordAudio("325111058", var_246_11)
						arg_243_1:RecordAudio("325111058", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_325111", "325111058", "story_v_out_325111.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_325111", "325111058", "story_v_out_325111.awb")
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

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play325111059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 325111059
		arg_247_1.duration_ = 6

		local var_247_0 = {
			zh = 5.5,
			ja = 6
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play325111060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1059ui_story"]) and arg_247_1.var_.characterEffect1059ui_story == nil then
				arg_247_1.var_.characterEffect1059ui_story = arg_247_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1059ui_story"]) then
				if arg_247_1.var_.characterEffect1059ui_story and not isNil(arg_247_1.actors_["1059ui_story"]) then
					arg_247_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1059ui_story"]) and arg_247_1.var_.characterEffect1059ui_story then
				arg_247_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_250_2 = arg_247_1.actors_["1077ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.characterEffect1077ui_story == nil then
				arg_247_1.var_.characterEffect1077ui_story = var_250_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_3 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_3 and not isNil(var_250_2) then
				if arg_247_1.var_.characterEffect1077ui_story and not isNil(var_250_2) then
					arg_247_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_3)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_3 and arg_247_1.time_ < 0 + var_250_3 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.characterEffect1077ui_story then
				arg_247_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_250_4 = 0
			local var_250_5 = 0.6

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_6 = arg_247_1:GetWordFromCfg(325111059)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 24 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 24)

				if (24 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 24)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111059", "story_v_out_325111.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_out_325111", "325111059", "story_v_out_325111.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_out_325111", "325111059", "story_v_out_325111.awb")

						arg_247_1:RecordAudio("325111059", var_250_11)
						arg_247_1:RecordAudio("325111059", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_325111", "325111059", "story_v_out_325111.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_325111", "325111059", "story_v_out_325111.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play325111060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 325111060
		arg_251_1.duration_ = 13.43

		local var_251_0 = {
			zh = 10.133,
			ja = 13.433
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play325111061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.85

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:GetWordFromCfg(325111060)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 34 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 34)

				if (34 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 34)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111060", "story_v_out_325111.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_325111", "325111060", "story_v_out_325111.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_325111", "325111060", "story_v_out_325111.awb")

						arg_251_1:RecordAudio("325111060", var_254_6)
						arg_251_1:RecordAudio("325111060", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_325111", "325111060", "story_v_out_325111.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_325111", "325111060", "story_v_out_325111.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play325111061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 325111061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play325111062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1059ui_story = arg_255_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1059ui_story"].transform.position).z)
				arg_255_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1059ui_story"].transform.localEulerAngles = arg_255_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1059ui_story"].transform.position).z)
				arg_255_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1059ui_story"].transform.localEulerAngles = arg_255_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["1077ui_story"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1077ui_story = var_258_1.localPosition

				local var_258_2 = GameObjectTools.GetOrAddComponent(var_258_1.gameObject, typeof(DynamicBoneHelper))

				if var_258_2 then
					var_258_2:EnableDynamicBone(false)
				end
			end

			local var_258_3 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_3 then
				var_258_1.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 0) / var_258_3)
				var_258_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_1.position).x, (manager.ui.mainCamera.transform.position - var_258_1.position).y, (manager.ui.mainCamera.transform.position - var_258_1.position).z)
				var_258_1.localEulerAngles.z = 0
				var_258_1.localEulerAngles.x = 0
				var_258_1.localEulerAngles = var_258_1.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_3 and arg_255_1.time_ < 0 + var_258_3 + arg_258_0 then
				var_258_1.localPosition = Vector3.New(0, 100, 0)
				var_258_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_1.position).x, (manager.ui.mainCamera.transform.position - var_258_1.position).y, (manager.ui.mainCamera.transform.position - var_258_1.position).z)
				var_258_1.localEulerAngles.z = 0
				var_258_1.localEulerAngles.x = 0
				var_258_1.localEulerAngles = var_258_1.localEulerAngles

				local var_258_4 = GameObjectTools.GetOrAddComponent(var_258_1.gameObject, typeof(DynamicBoneHelper))

				if var_258_4 then
					var_258_4:EnableDynamicBone(true)
				end
			end

			local var_258_5 = arg_255_1.actors_["1059ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.characterEffect1059ui_story == nil then
				arg_255_1.var_.characterEffect1059ui_story = var_258_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_6 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_6 and not isNil(var_258_5) then
				if arg_255_1.var_.characterEffect1059ui_story and not isNil(var_258_5) then
					arg_255_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_6)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_6 and arg_255_1.time_ < 0 + var_258_6 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.characterEffect1059ui_story then
				arg_255_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_255_1.time_ and arg_255_1.time_ <= 0.1 + arg_258_0 then
				arg_255_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword13", "")
			end

			local var_258_8 = 0
			local var_258_9 = 0.6

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_10 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(325111061).content)

				arg_255_1.text_.text = var_258_10

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_12 = 25 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_10) / 25)

				if (25 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_10) / 25)) > 0 and var_258_9 < var_258_12 then
					arg_255_1.talkMaxDuration = var_258_12

					if var_258_12 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_12 + var_258_8
					end
				end

				arg_255_1.text_.text = var_258_10
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_13 = math.max(var_258_9, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_13 and arg_255_1.time_ < var_258_8 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play325111062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 325111062
		arg_259_1.duration_ = 6

		local var_259_0 = {
			zh = 4.333,
			ja = 6
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play325111063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.4

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:GetWordFromCfg(325111062)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 16 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 16)

				if (16 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 16)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111062", "story_v_out_325111.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_325111", "325111062", "story_v_out_325111.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_325111", "325111062", "story_v_out_325111.awb")

						arg_259_1:RecordAudio("325111062", var_262_6)
						arg_259_1:RecordAudio("325111062", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_325111", "325111062", "story_v_out_325111.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_325111", "325111062", "story_v_out_325111.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play325111063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 325111063
		arg_263_1.duration_ = 10.37

		local var_263_0 = {
			zh = 6.766,
			ja = 10.366
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
			arg_263_1.auto_ = false
		end

		function arg_263_1.playNext_(arg_265_0)
			arg_263_1.onStoryFinished_()
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_266_1 = 0
			local var_266_2 = 0.825

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_3 = arg_263_1:GetWordFromCfg(325111063)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 33 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_4) / 33)

				if (33 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_4) / 33)) > 0 and var_266_2 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111063", "story_v_out_325111.awb") ~= 0 then
					local var_266_7 = manager.audio:GetVoiceLength("story_v_out_325111", "325111063", "story_v_out_325111.awb") / 1000

					if var_266_7 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_1
					end

					if var_266_3.prefab_name ~= "" and arg_263_1.actors_[var_266_3.prefab_name] ~= nil then
						local var_266_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_3.prefab_name].transform, "story_v_out_325111", "325111063", "story_v_out_325111.awb")

						arg_263_1:RecordAudio("325111063", var_266_8)
						arg_263_1:RecordAudio("325111063", var_266_8)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_325111", "325111063", "story_v_out_325111.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_325111", "325111063", "story_v_out_325111.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_9 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_9 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_9

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_9 and arg_263_1.time_ < var_266_1 + var_266_9 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST41",
		"TextureConfig/Background/J23g",
		"TextureConfig/Background/J23h",
		"TextureConfig/Background/ST2010",
		"TextureConfig/Background/ST42"
	},
	voices = {
		"story_v_out_325111.awb"
	}
}
