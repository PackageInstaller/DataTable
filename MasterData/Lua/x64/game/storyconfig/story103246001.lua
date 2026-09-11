return {
	Play324601001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324601001
		arg_1_1.duration_ = 9.97

		local var_1_0 = {
			zh = 8.19933333631356,
			ja = 9.96633333631356
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
				arg_1_0:Play324601002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2009 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2009")
				var_4_0.name = "ST2009"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2009 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2009

				arg_1_1.bgs_.ST2009.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2009" then
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

			local var_4_9 = "1070ui_story"

			if arg_1_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1070ui_story"].transform

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1070ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.63333333333333 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_1_1.time_ - 1.63333333333333) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.63333333333333 + var_4_14 and arg_1_1.time_ < 1.63333333333333 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.95, -6.05)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1070ui_story"]

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1070ui_story == nil then
				arg_1_1.var_.characterEffect1070ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.63333333333333 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1070ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.63333333333333 + var_4_16 and arg_1_1.time_ < 1.63333333333333 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1070ui_story then
				arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 1.66733333518108 < arg_1_1.time_ and arg_1_1.time_ <= 1.66733333518108 + arg_4_0 then
				arg_1_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 1.83333333631357
			local var_4_24 = 0.825

			if 1.83333333631357 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(324601001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 33 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 33)

				if (33 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 33)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601001", "story_v_out_324601.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_324601", "324601001", "story_v_out_324601.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_324601", "324601001", "story_v_out_324601.awb")

						arg_1_1:RecordAudio("324601001", var_4_31)
						arg_1_1:RecordAudio("324601001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324601", "324601001", "story_v_out_324601.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324601", "324601001", "story_v_out_324601.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play324601002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324601002
		arg_8_1.duration_ = 13.13

		local var_8_0 = {
			zh = 8,
			ja = 13.133
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
				arg_8_0:Play324601003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1070ui_story"]) and arg_8_1.var_.characterEffect1070ui_story == nil then
				arg_8_1.var_.characterEffect1070ui_story = arg_8_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1070ui_story"]) then
				if arg_8_1.var_.characterEffect1070ui_story and not isNil(arg_8_1.actors_["1070ui_story"]) then
					arg_8_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1070ui_story"]) and arg_8_1.var_.characterEffect1070ui_story then
				arg_8_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 0.775

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(324601002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 31 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 31)

				if (31 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 31)) > 0 and var_11_2 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601002", "story_v_out_324601.awb") ~= 0 then
					local var_11_7 = manager.audio:GetVoiceLength("story_v_out_324601", "324601002", "story_v_out_324601.awb") / 1000

					if var_11_7 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_1
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_324601", "324601002", "story_v_out_324601.awb")

						arg_8_1:RecordAudio("324601002", var_11_8)
						arg_8_1:RecordAudio("324601002", var_11_8)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324601", "324601002", "story_v_out_324601.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324601", "324601002", "story_v_out_324601.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_9 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_9 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_9

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_9 and arg_8_1.time_ < var_11_1 + var_11_9 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324601003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324601003
		arg_12_1.duration_ = 10.97

		local var_12_0 = {
			zh = 9.633,
			ja = 10.966
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
				arg_12_0:Play324601004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1070ui_story"]) and arg_12_1.var_.characterEffect1070ui_story == nil then
				arg_12_1.var_.characterEffect1070ui_story = arg_12_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1070ui_story"]) then
				if arg_12_1.var_.characterEffect1070ui_story and not isNil(arg_12_1.actors_["1070ui_story"]) then
					arg_12_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1070ui_story"]) and arg_12_1.var_.characterEffect1070ui_story then
				arg_12_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_2")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_15_2 = 0
			local var_15_3 = 1.075

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:GetWordFromCfg(324601003)
				local var_15_5 = arg_12_1:FormatText(var_15_4.content)

				arg_12_1.text_.text = var_15_5

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_7 = 43 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_5) / 43)

				if (43 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_5) / 43)) > 0 and var_15_3 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_5
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601003", "story_v_out_324601.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_324601", "324601003", "story_v_out_324601.awb") / 1000

					if var_15_8 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_2
					end

					if var_15_4.prefab_name ~= "" and arg_12_1.actors_[var_15_4.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_4.prefab_name].transform, "story_v_out_324601", "324601003", "story_v_out_324601.awb")

						arg_12_1:RecordAudio("324601003", var_15_9)
						arg_12_1:RecordAudio("324601003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324601", "324601003", "story_v_out_324601.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324601", "324601003", "story_v_out_324601.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_10 and arg_12_1.time_ < var_15_2 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324601004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324601004
		arg_16_1.duration_ = 11.03

		local var_16_0 = {
			zh = 11.033,
			ja = 10.366
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
				arg_16_0:Play324601005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1070ui_story"]) and arg_16_1.var_.characterEffect1070ui_story == nil then
				arg_16_1.var_.characterEffect1070ui_story = arg_16_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1070ui_story"]) then
				if arg_16_1.var_.characterEffect1070ui_story and not isNil(arg_16_1.actors_["1070ui_story"]) then
					arg_16_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1070ui_story"]) and arg_16_1.var_.characterEffect1070ui_story then
				arg_16_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 0.85

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(324601004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 34 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 34)

				if (34 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 34)) > 0 and var_19_2 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601004", "story_v_out_324601.awb") ~= 0 then
					local var_19_7 = manager.audio:GetVoiceLength("story_v_out_324601", "324601004", "story_v_out_324601.awb") / 1000

					if var_19_7 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_1
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_324601", "324601004", "story_v_out_324601.awb")

						arg_16_1:RecordAudio("324601004", var_19_8)
						arg_16_1:RecordAudio("324601004", var_19_8)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324601", "324601004", "story_v_out_324601.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324601", "324601004", "story_v_out_324601.awb")
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
	Play324601005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324601005
		arg_20_1.duration_ = 6.63

		local var_20_0 = {
			zh = 6.4,
			ja = 6.633
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
				arg_20_0:Play324601006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.6

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(324601005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 24 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 24)

				if (24 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 24)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601005", "story_v_out_324601.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_324601", "324601005", "story_v_out_324601.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_324601", "324601005", "story_v_out_324601.awb")

						arg_20_1:RecordAudio("324601005", var_23_6)
						arg_20_1:RecordAudio("324601005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324601", "324601005", "story_v_out_324601.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324601", "324601005", "story_v_out_324601.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324601006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324601006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324601007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1.05

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

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(324601006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 42 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 42)

				if (42 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 42)) > 0 and var_27_0 < var_27_3 then
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
	Play324601007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324601007
		arg_28_1.duration_ = 9.6

		local var_28_0 = {
			zh = 9.6,
			ja = 6.2
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
				arg_28_0:Play324601008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.825

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(324601007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 33 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 33)

				if (33 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 33)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601007", "story_v_out_324601.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_324601", "324601007", "story_v_out_324601.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_324601", "324601007", "story_v_out_324601.awb")

						arg_28_1:RecordAudio("324601007", var_31_6)
						arg_28_1:RecordAudio("324601007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324601", "324601007", "story_v_out_324601.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324601", "324601007", "story_v_out_324601.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324601008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324601008
		arg_32_1.duration_ = 1.8

		local var_32_0 = {
			zh = 0.999999999999,
			ja = 1.8
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
				arg_32_0:Play324601009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1070ui_story"]) and arg_32_1.var_.characterEffect1070ui_story == nil then
				arg_32_1.var_.characterEffect1070ui_story = arg_32_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1070ui_story"]) then
				if arg_32_1.var_.characterEffect1070ui_story and not isNil(arg_32_1.actors_["1070ui_story"]) then
					arg_32_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1070ui_story"]) and arg_32_1.var_.characterEffect1070ui_story then
				arg_32_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_35_2 = 0
			local var_35_3 = 0.075

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:GetWordFromCfg(324601008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 3 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 3)

				if (3 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 3)) > 0 and var_35_3 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601008", "story_v_out_324601.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_324601", "324601008", "story_v_out_324601.awb") / 1000

					if var_35_8 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_2
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_324601", "324601008", "story_v_out_324601.awb")

						arg_32_1:RecordAudio("324601008", var_35_9)
						arg_32_1:RecordAudio("324601008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324601", "324601008", "story_v_out_324601.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324601", "324601008", "story_v_out_324601.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_10 and arg_32_1.time_ < var_35_2 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324601009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324601009
		arg_36_1.duration_ = 6.4

		local var_36_0 = {
			zh = 5.3,
			ja = 6.4
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
				arg_36_0:Play324601010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1070ui_story"]) and arg_36_1.var_.characterEffect1070ui_story == nil then
				arg_36_1.var_.characterEffect1070ui_story = arg_36_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1070ui_story"]) then
				if arg_36_1.var_.characterEffect1070ui_story and not isNil(arg_36_1.actors_["1070ui_story"]) then
					arg_36_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1070ui_story"]) and arg_36_1.var_.characterEffect1070ui_story then
				arg_36_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 0.475

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(324601009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 19 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_4) / 19)

				if (19 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_4) / 19)) > 0 and var_39_2 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601009", "story_v_out_324601.awb") ~= 0 then
					local var_39_7 = manager.audio:GetVoiceLength("story_v_out_324601", "324601009", "story_v_out_324601.awb") / 1000

					if var_39_7 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_1
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_324601", "324601009", "story_v_out_324601.awb")

						arg_36_1:RecordAudio("324601009", var_39_8)
						arg_36_1:RecordAudio("324601009", var_39_8)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324601", "324601009", "story_v_out_324601.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324601", "324601009", "story_v_out_324601.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_9 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_9 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_9

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_9 and arg_36_1.time_ < var_39_1 + var_39_9 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324601010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324601010
		arg_40_1.duration_ = 10.73

		local var_40_0 = {
			zh = 10.266,
			ja = 10.733
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
				arg_40_0:Play324601011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 1.05

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(324601010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 42 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 42)

				if (42 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 42)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601010", "story_v_out_324601.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_324601", "324601010", "story_v_out_324601.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_324601", "324601010", "story_v_out_324601.awb")

						arg_40_1:RecordAudio("324601010", var_43_6)
						arg_40_1:RecordAudio("324601010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324601", "324601010", "story_v_out_324601.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324601", "324601010", "story_v_out_324601.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324601011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324601011
		arg_44_1.duration_ = 15.27

		local var_44_0 = {
			zh = 12.866,
			ja = 15.266
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
				arg_44_0:Play324601012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.05

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(324601011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 42 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 42)

				if (42 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 42)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601011", "story_v_out_324601.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_324601", "324601011", "story_v_out_324601.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_324601", "324601011", "story_v_out_324601.awb")

						arg_44_1:RecordAudio("324601011", var_47_6)
						arg_44_1:RecordAudio("324601011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324601", "324601011", "story_v_out_324601.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324601", "324601011", "story_v_out_324601.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324601012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324601012
		arg_48_1.duration_ = 6.27

		local var_48_0 = {
			zh = 5.5,
			ja = 6.266
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
				arg_48_0:Play324601013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1070ui_story"]) and arg_48_1.var_.characterEffect1070ui_story == nil then
				arg_48_1.var_.characterEffect1070ui_story = arg_48_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1070ui_story"]) then
				if arg_48_1.var_.characterEffect1070ui_story and not isNil(arg_48_1.actors_["1070ui_story"]) then
					arg_48_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1070ui_story"]) and arg_48_1.var_.characterEffect1070ui_story then
				arg_48_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_51_2 = 0
			local var_51_3 = 0.55

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(324601012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 22 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 22)

				if (22 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 22)) > 0 and var_51_3 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601012", "story_v_out_324601.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_324601", "324601012", "story_v_out_324601.awb") / 1000

					if var_51_8 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_2
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_324601", "324601012", "story_v_out_324601.awb")

						arg_48_1:RecordAudio("324601012", var_51_9)
						arg_48_1:RecordAudio("324601012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324601", "324601012", "story_v_out_324601.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324601", "324601012", "story_v_out_324601.awb")
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
	Play324601013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324601013
		arg_52_1.duration_ = 7.97

		local var_52_0 = {
			zh = 5.966,
			ja = 7.966
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
				arg_52_0:Play324601014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1070ui_story"]) and arg_52_1.var_.characterEffect1070ui_story == nil then
				arg_52_1.var_.characterEffect1070ui_story = arg_52_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1070ui_story"]) then
				if arg_52_1.var_.characterEffect1070ui_story and not isNil(arg_52_1.actors_["1070ui_story"]) then
					arg_52_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1070ui_story"]) and arg_52_1.var_.characterEffect1070ui_story then
				arg_52_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.7

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(324601013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 28 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 28)

				if (28 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 28)) > 0 and var_55_2 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601013", "story_v_out_324601.awb") ~= 0 then
					local var_55_7 = manager.audio:GetVoiceLength("story_v_out_324601", "324601013", "story_v_out_324601.awb") / 1000

					if var_55_7 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_1
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_324601", "324601013", "story_v_out_324601.awb")

						arg_52_1:RecordAudio("324601013", var_55_8)
						arg_52_1:RecordAudio("324601013", var_55_8)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324601", "324601013", "story_v_out_324601.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324601", "324601013", "story_v_out_324601.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_9 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_9 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_9

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_9 and arg_52_1.time_ < var_55_1 + var_55_9 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324601014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324601014
		arg_56_1.duration_ = 11.9

		local var_56_0 = {
			zh = 9.1,
			ja = 11.9
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
				arg_56_0:Play324601015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.825

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:GetWordFromCfg(324601014)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 33 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 33)

				if (33 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 33)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601014", "story_v_out_324601.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_324601", "324601014", "story_v_out_324601.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_324601", "324601014", "story_v_out_324601.awb")

						arg_56_1:RecordAudio("324601014", var_59_6)
						arg_56_1:RecordAudio("324601014", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324601", "324601014", "story_v_out_324601.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324601", "324601014", "story_v_out_324601.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324601015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324601015
		arg_60_1.duration_ = 5.37

		local var_60_0 = {
			zh = 5.366,
			ja = 5.266
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
				arg_60_0:Play324601016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1070ui_story"]) and arg_60_1.var_.characterEffect1070ui_story == nil then
				arg_60_1.var_.characterEffect1070ui_story = arg_60_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1070ui_story"]) then
				if arg_60_1.var_.characterEffect1070ui_story and not isNil(arg_60_1.actors_["1070ui_story"]) then
					arg_60_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1070ui_story"]) and arg_60_1.var_.characterEffect1070ui_story then
				arg_60_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_63_2 = 0
			local var_63_3 = 0.475

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_4 = arg_60_1:GetWordFromCfg(324601015)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 19 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 19)

				if (19 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 19)) > 0 and var_63_3 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_2
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601015", "story_v_out_324601.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_324601", "324601015", "story_v_out_324601.awb") / 1000

					if var_63_8 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_2
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_324601", "324601015", "story_v_out_324601.awb")

						arg_60_1:RecordAudio("324601015", var_63_9)
						arg_60_1:RecordAudio("324601015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_324601", "324601015", "story_v_out_324601.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_324601", "324601015", "story_v_out_324601.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_3, arg_60_1.talkMaxDuration)

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_2) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_2 + var_63_10 and arg_60_1.time_ < var_63_2 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play324601016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324601016
		arg_64_1.duration_ = 14.83

		local var_64_0 = {
			zh = 8.966,
			ja = 14.833
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324601017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1070ui_story"]) and arg_64_1.var_.characterEffect1070ui_story == nil then
				arg_64_1.var_.characterEffect1070ui_story = arg_64_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1070ui_story"]) then
				if arg_64_1.var_.characterEffect1070ui_story and not isNil(arg_64_1.actors_["1070ui_story"]) then
					arg_64_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1070ui_story"]) and arg_64_1.var_.characterEffect1070ui_story then
				arg_64_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 0.9

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(324601016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_6 = 36 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_4) / 36)

				if (36 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_4) / 36)) > 0 and var_67_2 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601016", "story_v_out_324601.awb") ~= 0 then
					local var_67_7 = manager.audio:GetVoiceLength("story_v_out_324601", "324601016", "story_v_out_324601.awb") / 1000

					if var_67_7 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_1
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_324601", "324601016", "story_v_out_324601.awb")

						arg_64_1:RecordAudio("324601016", var_67_8)
						arg_64_1:RecordAudio("324601016", var_67_8)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_324601", "324601016", "story_v_out_324601.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_324601", "324601016", "story_v_out_324601.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_9 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_9 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_9

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_9 and arg_64_1.time_ < var_67_1 + var_67_9 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play324601017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324601017
		arg_68_1.duration_ = 10.83

		local var_68_0 = {
			zh = 8.633,
			ja = 10.833
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324601018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.875

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(324601017)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 35 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 35)

				if (35 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 35)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601017", "story_v_out_324601.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_324601", "324601017", "story_v_out_324601.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_324601", "324601017", "story_v_out_324601.awb")

						arg_68_1:RecordAudio("324601017", var_71_6)
						arg_68_1:RecordAudio("324601017", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324601", "324601017", "story_v_out_324601.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324601", "324601017", "story_v_out_324601.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play324601018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324601018
		arg_72_1.duration_ = 5.27

		local var_72_0 = {
			zh = 4.733,
			ja = 5.266
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
				arg_72_0:Play324601019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1070ui_story"]) and arg_72_1.var_.characterEffect1070ui_story == nil then
				arg_72_1.var_.characterEffect1070ui_story = arg_72_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1070ui_story"]) then
				if arg_72_1.var_.characterEffect1070ui_story and not isNil(arg_72_1.actors_["1070ui_story"]) then
					arg_72_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1070ui_story"]) and arg_72_1.var_.characterEffect1070ui_story then
				arg_72_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_75_2 = 0
			local var_75_3 = 0.5

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_4 = arg_72_1:GetWordFromCfg(324601018)
				local var_75_5 = arg_72_1:FormatText(var_75_4.content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 20 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 20)

				if (20 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 20)) > 0 and var_75_3 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601018", "story_v_out_324601.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_324601", "324601018", "story_v_out_324601.awb") / 1000

					if var_75_8 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_2
					end

					if var_75_4.prefab_name ~= "" and arg_72_1.actors_[var_75_4.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_4.prefab_name].transform, "story_v_out_324601", "324601018", "story_v_out_324601.awb")

						arg_72_1:RecordAudio("324601018", var_75_9)
						arg_72_1:RecordAudio("324601018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324601", "324601018", "story_v_out_324601.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324601", "324601018", "story_v_out_324601.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_10 and arg_72_1.time_ < var_75_2 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play324601019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324601019
		arg_76_1.duration_ = 13.83

		local var_76_0 = {
			zh = 9.766,
			ja = 13.833
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324601020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1070ui_story"]) and arg_76_1.var_.characterEffect1070ui_story == nil then
				arg_76_1.var_.characterEffect1070ui_story = arg_76_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1070ui_story"]) then
				if arg_76_1.var_.characterEffect1070ui_story and not isNil(arg_76_1.actors_["1070ui_story"]) then
					arg_76_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1070ui_story"]) and arg_76_1.var_.characterEffect1070ui_story then
				arg_76_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.825

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(324601019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 33 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 33)

				if (33 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 33)) > 0 and var_79_2 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601019", "story_v_out_324601.awb") ~= 0 then
					local var_79_7 = manager.audio:GetVoiceLength("story_v_out_324601", "324601019", "story_v_out_324601.awb") / 1000

					if var_79_7 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_1
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_324601", "324601019", "story_v_out_324601.awb")

						arg_76_1:RecordAudio("324601019", var_79_8)
						arg_76_1:RecordAudio("324601019", var_79_8)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_324601", "324601019", "story_v_out_324601.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_324601", "324601019", "story_v_out_324601.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_9 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_9 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_9

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_9 and arg_76_1.time_ < var_79_1 + var_79_9 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324601020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324601020
		arg_80_1.duration_ = 3.13

		local var_80_0 = {
			zh = 3.133,
			ja = 2.866
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
				arg_80_0:Play324601021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1070ui_story"]) and arg_80_1.var_.characterEffect1070ui_story == nil then
				arg_80_1.var_.characterEffect1070ui_story = arg_80_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1070ui_story"]) then
				if arg_80_1.var_.characterEffect1070ui_story and not isNil(arg_80_1.actors_["1070ui_story"]) then
					arg_80_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1070ui_story"]) and arg_80_1.var_.characterEffect1070ui_story then
				arg_80_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_83_2 = 0
			local var_83_3 = 0.3

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_4 = arg_80_1:GetWordFromCfg(324601020)
				local var_83_5 = arg_80_1:FormatText(var_83_4.content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 12 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 12)

				if (12 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 12)) > 0 and var_83_3 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_2
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601020", "story_v_out_324601.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_324601", "324601020", "story_v_out_324601.awb") / 1000

					if var_83_8 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_2
					end

					if var_83_4.prefab_name ~= "" and arg_80_1.actors_[var_83_4.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_4.prefab_name].transform, "story_v_out_324601", "324601020", "story_v_out_324601.awb")

						arg_80_1:RecordAudio("324601020", var_83_9)
						arg_80_1:RecordAudio("324601020", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_324601", "324601020", "story_v_out_324601.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_324601", "324601020", "story_v_out_324601.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_3, arg_80_1.talkMaxDuration)

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_2) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_2 + var_83_10 and arg_80_1.time_ < var_83_2 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play324601021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324601021
		arg_84_1.duration_ = 6.63

		local var_84_0 = {
			zh = 4.133,
			ja = 6.633
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
				arg_84_0:Play324601022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1070ui_story"]) and arg_84_1.var_.characterEffect1070ui_story == nil then
				arg_84_1.var_.characterEffect1070ui_story = arg_84_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1070ui_story"]) then
				if arg_84_1.var_.characterEffect1070ui_story and not isNil(arg_84_1.actors_["1070ui_story"]) then
					arg_84_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1070ui_story"]) and arg_84_1.var_.characterEffect1070ui_story then
				arg_84_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.35

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(324601021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 14 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_4) / 14)

				if (14 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_4) / 14)) > 0 and var_87_2 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601021", "story_v_out_324601.awb") ~= 0 then
					local var_87_7 = manager.audio:GetVoiceLength("story_v_out_324601", "324601021", "story_v_out_324601.awb") / 1000

					if var_87_7 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_1
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_324601", "324601021", "story_v_out_324601.awb")

						arg_84_1:RecordAudio("324601021", var_87_8)
						arg_84_1:RecordAudio("324601021", var_87_8)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324601", "324601021", "story_v_out_324601.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324601", "324601021", "story_v_out_324601.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_9 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_9 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_9

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_9 and arg_84_1.time_ < var_87_1 + var_87_9 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324601022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324601022
		arg_88_1.duration_ = 8.63

		local var_88_0 = {
			zh = 6.3,
			ja = 8.633
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
				arg_88_0:Play324601023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.575

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_1 = arg_88_1:GetWordFromCfg(324601022)
				local var_91_2 = arg_88_1:FormatText(var_91_1.content)

				arg_88_1.text_.text = var_91_2

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 23 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 23)

				if (23 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 23)) > 0 and var_91_0 < var_91_4 then
					arg_88_1.talkMaxDuration = var_91_4

					if var_91_4 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_4 + 0
					end
				end

				arg_88_1.text_.text = var_91_2
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601022", "story_v_out_324601.awb") ~= 0 then
					local var_91_5 = manager.audio:GetVoiceLength("story_v_out_324601", "324601022", "story_v_out_324601.awb") / 1000

					if var_91_5 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + 0
					end

					if var_91_1.prefab_name ~= "" and arg_88_1.actors_[var_91_1.prefab_name] ~= nil then
						local var_91_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_1.prefab_name].transform, "story_v_out_324601", "324601022", "story_v_out_324601.awb")

						arg_88_1:RecordAudio("324601022", var_91_6)
						arg_88_1:RecordAudio("324601022", var_91_6)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_324601", "324601022", "story_v_out_324601.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_324601", "324601022", "story_v_out_324601.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play324601023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324601023
		arg_92_1.duration_ = 12.87

		local var_92_0 = {
			zh = 9.866,
			ja = 12.866
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
				arg_92_0:Play324601024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.95

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(324601023)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 38 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 38)

				if (38 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 38)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601023", "story_v_out_324601.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_324601", "324601023", "story_v_out_324601.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_324601", "324601023", "story_v_out_324601.awb")

						arg_92_1:RecordAudio("324601023", var_95_6)
						arg_92_1:RecordAudio("324601023", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_324601", "324601023", "story_v_out_324601.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_324601", "324601023", "story_v_out_324601.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play324601024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324601024
		arg_96_1.duration_ = 3.7

		local var_96_0 = {
			zh = 2.933,
			ja = 3.7
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
				arg_96_0:Play324601025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1070ui_story"]) and arg_96_1.var_.characterEffect1070ui_story == nil then
				arg_96_1.var_.characterEffect1070ui_story = arg_96_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1070ui_story"]) then
				if arg_96_1.var_.characterEffect1070ui_story and not isNil(arg_96_1.actors_["1070ui_story"]) then
					arg_96_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1070ui_story"]) and arg_96_1.var_.characterEffect1070ui_story then
				arg_96_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_99_2 = 0
			local var_99_3 = 0.325

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(324601024)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 13 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 13)

				if (13 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 13)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601024", "story_v_out_324601.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_324601", "324601024", "story_v_out_324601.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_324601", "324601024", "story_v_out_324601.awb")

						arg_96_1:RecordAudio("324601024", var_99_9)
						arg_96_1:RecordAudio("324601024", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_324601", "324601024", "story_v_out_324601.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_324601", "324601024", "story_v_out_324601.awb")
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
	Play324601025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324601025
		arg_100_1.duration_ = 8.8

		local var_100_0 = {
			zh = 8.1,
			ja = 8.8
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
			arg_100_1.auto_ = false
		end

		function arg_100_1.playNext_(arg_102_0)
			arg_100_1.onStoryFinished_()
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1070ui_story"]) and arg_100_1.var_.characterEffect1070ui_story == nil then
				arg_100_1.var_.characterEffect1070ui_story = arg_100_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1070ui_story"]) then
				if arg_100_1.var_.characterEffect1070ui_story and not isNil(arg_100_1.actors_["1070ui_story"]) then
					arg_100_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1070ui_story"]) and arg_100_1.var_.characterEffect1070ui_story then
				arg_100_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.8

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(324601025)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_6 = 32 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_4) / 32)

				if (32 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_4) / 32)) > 0 and var_103_2 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324601", "324601025", "story_v_out_324601.awb") ~= 0 then
					local var_103_7 = manager.audio:GetVoiceLength("story_v_out_324601", "324601025", "story_v_out_324601.awb") / 1000

					if var_103_7 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_1
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_324601", "324601025", "story_v_out_324601.awb")

						arg_100_1:RecordAudio("324601025", var_103_8)
						arg_100_1:RecordAudio("324601025", var_103_8)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_324601", "324601025", "story_v_out_324601.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_324601", "324601025", "story_v_out_324601.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_9 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_9 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_9

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_9 and arg_100_1.time_ < var_103_1 + var_103_9 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2009"
	},
	voices = {
		"story_v_out_324601.awb"
	}
}
