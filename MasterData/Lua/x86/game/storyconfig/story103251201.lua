return {
	Play325121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325121001
		arg_1_1.duration_ = 6.63

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2011 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2011")
				var_4_0.name = "ST2011"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2011 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2011

				arg_1_1.bgs_.ST2011.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2011" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone", "")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_151", "se_story_151_footstep01", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_1_story_kushulin", "bgm_activity_5_1_story_kushulin", "bgm_activity_5_1_story_kushulin.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_5_1_story_kushulin", "bgm_activity_5_1_story_kushulin")

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

			local var_4_14 = 1.63333333333333
			local var_4_15 = 0.625

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325121001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 25 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 25)

				if (25 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 25)) > 0 and var_4_15 < var_4_19 then
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
	Play325121002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325121002
		arg_8_1.duration_ = 7.57

		local var_8_0 = {
			zh = 4.2,
			ja = 7.566
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
				arg_8_0:Play325121003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.325

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(325121002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 13 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 13)

				if (13 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 13)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121002", "story_v_out_325121.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121002", "story_v_out_325121.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_325121", "325121002", "story_v_out_325121.awb")

						arg_8_1:RecordAudio("325121002", var_11_6)
						arg_8_1:RecordAudio("325121002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325121", "325121002", "story_v_out_325121.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325121", "325121002", "story_v_out_325121.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325121003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325121003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325121004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.175

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325121003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 47 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 47)

				if (47 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 47)) > 0 and var_15_0 < var_15_3 then
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
	Play325121004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325121004
		arg_16_1.duration_ = 3.6

		local var_16_0 = {
			zh = 2.366,
			ja = 3.6
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
				arg_16_0:Play325121005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1069ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1069ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1069ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1069ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1069ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1069ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1069ui_story = var_19_3.localPosition
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, -1, -6)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			local var_19_5 = arg_16_1.actors_["1069ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1069ui_story == nil then
				arg_16_1.var_.characterEffect1069ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 and not isNil(var_19_5) then
				if arg_16_1.var_.characterEffect1069ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1069ui_story then
				arg_16_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_8 = 0
			local var_19_9 = 0.25

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(325121004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 10 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 10)

				if (10 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 10)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121004", "story_v_out_325121.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_325121", "325121004", "story_v_out_325121.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_out_325121", "325121004", "story_v_out_325121.awb")

						arg_16_1:RecordAudio("325121004", var_19_15)
						arg_16_1:RecordAudio("325121004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325121", "325121004", "story_v_out_325121.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325121", "325121004", "story_v_out_325121.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
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
	Play325121005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325121005
		arg_20_1.duration_ = 2.1

		local var_20_0 = {
			zh = 2.1,
			ja = 2
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
				arg_20_0:Play325121006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1069ui_story"]) and arg_20_1.var_.characterEffect1069ui_story == nil then
				arg_20_1.var_.characterEffect1069ui_story = arg_20_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1069ui_story"]) then
				if arg_20_1.var_.characterEffect1069ui_story and not isNil(arg_20_1.actors_["1069ui_story"]) then
					arg_20_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1069ui_story"]) and arg_20_1.var_.characterEffect1069ui_story then
				arg_20_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 0.2

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(325121005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 8 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_4) / 8)

				if (8 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_4) / 8)) > 0 and var_23_2 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121005", "story_v_out_325121.awb") ~= 0 then
					local var_23_7 = manager.audio:GetVoiceLength("story_v_out_325121", "325121005", "story_v_out_325121.awb") / 1000

					if var_23_7 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_1
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_325121", "325121005", "story_v_out_325121.awb")

						arg_20_1:RecordAudio("325121005", var_23_8)
						arg_20_1:RecordAudio("325121005", var_23_8)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325121", "325121005", "story_v_out_325121.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325121", "325121005", "story_v_out_325121.awb")
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
	Play325121006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325121006
		arg_24_1.duration_ = 2.27

		local var_24_0 = {
			zh = 1.766,
			ja = 2.266
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
				arg_24_0:Play325121007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1069ui_story"]) and arg_24_1.var_.characterEffect1069ui_story == nil then
				arg_24_1.var_.characterEffect1069ui_story = arg_24_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1069ui_story"]) then
				if arg_24_1.var_.characterEffect1069ui_story and not isNil(arg_24_1.actors_["1069ui_story"]) then
					arg_24_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1069ui_story"]) and arg_24_1.var_.characterEffect1069ui_story then
				arg_24_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_27_2 = 0
			local var_27_3 = 0.2

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(325121006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 8 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 8)

				if (8 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 8)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121006", "story_v_out_325121.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_325121", "325121006", "story_v_out_325121.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_325121", "325121006", "story_v_out_325121.awb")

						arg_24_1:RecordAudio("325121006", var_27_9)
						arg_24_1:RecordAudio("325121006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325121", "325121006", "story_v_out_325121.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325121", "325121006", "story_v_out_325121.awb")
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
	Play325121007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325121007
		arg_28_1.duration_ = 8.5

		local var_28_0 = {
			zh = 5.93333333333333,
			ja = 8.49933333333333
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
				arg_28_0:Play325121008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 1.4 < arg_28_1.time_ and arg_28_1.time_ <= 1.4 + arg_31_0 then
				local var_31_0 = arg_28_1.bgs_.ST2011

				arg_28_1.bgs_.ST2011.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_31_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_1 = var_31_0:GetComponent("SpriteRenderer")

				if var_31_1 and var_31_1.sprite then
					local var_31_2 = 2 * (var_31_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_31_0.transform.localScale = Vector3.New(var_31_2 / var_31_1.sprite.bounds.size.y < var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x and var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x or var_31_2 / var_31_1.sprite.bounds.size.y, var_31_2 / var_31_1.sprite.bounds.size.y < var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x and var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x or var_31_2 / var_31_1.sprite.bounds.size.y, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "ST2011" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_3 = 1.4

			if 1.4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= var_31_3 + 0.3 and arg_28_1.time_ < var_31_3 + 0.3 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_4 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_5 = 1.4

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_5 then
				local var_31_6 = Color.New(0, 0, 0)

				var_31_6.a = Mathf.Lerp(0, 1, (arg_28_1.time_ - var_31_4) / var_31_5)
				arg_28_1.mask_.color = var_31_6
			end

			if arg_28_1.time_ >= var_31_4 + var_31_5 and arg_28_1.time_ < var_31_4 + var_31_5 + arg_31_0 then
				local var_31_7 = Color.New(0, 0, 0)

				var_31_7.a = 1
				arg_28_1.mask_.color = var_31_7
			end

			local var_31_8 = 1.4

			if 1.4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_9 = 2

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_9 then
				local var_31_10 = Color.New(0, 0, 0)

				var_31_10.a = Mathf.Lerp(1, 0, (arg_28_1.time_ - var_31_8) / var_31_9)
				arg_28_1.mask_.color = var_31_10
			end

			if arg_28_1.time_ >= var_31_8 + var_31_9 and arg_28_1.time_ < var_31_8 + var_31_9 + arg_31_0 then
				local var_31_11 = Color.New(0, 0, 0)

				arg_28_1.mask_.enabled = false
				var_31_11.a = 0
				arg_28_1.mask_.color = var_31_11
			end

			local var_31_12 = arg_28_1.actors_["1069ui_story"].transform

			if 1.4 < arg_28_1.time_ and arg_28_1.time_ <= 1.4 + arg_31_0 then
				arg_28_1.var_.moveOldPos1069ui_story = var_31_12.localPosition
			end

			local var_31_13 = 0.001

			if 1.4 <= arg_28_1.time_ and arg_28_1.time_ < 1.4 + var_31_13 then
				var_31_12.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 1.4) / var_31_13)
				var_31_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_12.position).x, (manager.ui.mainCamera.transform.position - var_31_12.position).y, (manager.ui.mainCamera.transform.position - var_31_12.position).z)
				var_31_12.localEulerAngles.z = 0
				var_31_12.localEulerAngles.x = 0
				var_31_12.localEulerAngles = var_31_12.localEulerAngles
			end

			if arg_28_1.time_ >= 1.4 + var_31_13 and arg_28_1.time_ < 1.4 + var_31_13 + arg_31_0 then
				var_31_12.localPosition = Vector3.New(0, 100, 0)
				var_31_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_12.position).x, (manager.ui.mainCamera.transform.position - var_31_12.position).y, (manager.ui.mainCamera.transform.position - var_31_12.position).z)
				var_31_12.localEulerAngles.z = 0
				var_31_12.localEulerAngles.x = 0
				var_31_12.localEulerAngles = var_31_12.localEulerAngles
			end

			local var_31_14 = arg_28_1.actors_["1069ui_story"]

			if 1.4 < arg_28_1.time_ and arg_28_1.time_ <= 1.4 + arg_31_0 and not isNil(var_31_14) and arg_28_1.var_.characterEffect1069ui_story == nil then
				arg_28_1.var_.characterEffect1069ui_story = var_31_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_15 = 0.200000002980232

			if 1.4 <= arg_28_1.time_ and arg_28_1.time_ < 1.4 + var_31_15 and not isNil(var_31_14) then
				if arg_28_1.var_.characterEffect1069ui_story and not isNil(var_31_14) then
					arg_28_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 1.4) / var_31_15)
				end
			end

			if arg_28_1.time_ >= 1.4 + var_31_15 and arg_28_1.time_ < 1.4 + var_31_15 + arg_31_0 and not isNil(var_31_14) and arg_28_1.var_.characterEffect1069ui_story then
				arg_28_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_31_16 = 1.4

			arg_28_1.isInRecall_ = false

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.screenFilterGo_:SetActive(true)

				arg_28_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_31_2, iter_31_3 in pairs(arg_28_1.actors_) do
					for iter_31_4, iter_31_5 in ipairs((iter_31_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_31_5.color = iter_31_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_31_17 = 0.034000001847744

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_17 then
				arg_28_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_28_1.time_ - var_31_16) / var_31_17)
			end

			if arg_28_1.time_ >= var_31_16 + var_31_17 and arg_28_1.time_ < var_31_16 + var_31_17 + arg_31_0 then
				arg_28_1.screenFilterEffect_.weight = 1
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_18 = 2.83333333333333
			local var_31_19 = 0.2

			if 2.83333333333333 < arg_28_1.time_ and arg_28_1.time_ <= var_31_18 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_20 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_20:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_28_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_31_21 = arg_28_1:GetWordFromCfg(325121007)
				local var_31_22 = arg_28_1:FormatText(var_31_21.content)

				arg_28_1.text_.text = var_31_22

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_24 = 8 <= 0 and var_31_19 or var_31_19 * (utf8.len(var_31_22) / 8)

				if (8 <= 0 and var_31_19 or var_31_19 * (utf8.len(var_31_22) / 8)) > 0 and var_31_19 < var_31_24 then
					arg_28_1.talkMaxDuration = var_31_24
					var_31_18 = var_31_18 + 0.3

					if var_31_24 + var_31_18 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_24 + var_31_18
					end
				end

				arg_28_1.text_.text = var_31_22
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121007", "story_v_out_325121.awb") ~= 0 then
					local var_31_25 = manager.audio:GetVoiceLength("story_v_out_325121", "325121007", "story_v_out_325121.awb") / 1000

					if var_31_25 + var_31_18 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_25 + var_31_18
					end

					if var_31_21.prefab_name ~= "" and arg_28_1.actors_[var_31_21.prefab_name] ~= nil then
						local var_31_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_21.prefab_name].transform, "story_v_out_325121", "325121007", "story_v_out_325121.awb")

						arg_28_1:RecordAudio("325121007", var_31_26)
						arg_28_1:RecordAudio("325121007", var_31_26)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325121", "325121007", "story_v_out_325121.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325121", "325121007", "story_v_out_325121.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_27 = var_31_18 + 0.3
			local var_31_28 = math.max(var_31_19, arg_28_1.talkMaxDuration)

			if var_31_18 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_27 + var_31_28 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_27) / var_31_28

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_27 + var_31_28 and arg_28_1.time_ < var_31_27 + var_31_28 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325121008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 325121008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play325121009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 1.475

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

				local var_37_1 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(325121008).content)

				arg_34_1.text_.text = var_37_1

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_3 = 59 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 59)

				if (59 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 59)) > 0 and var_37_0 < var_37_3 then
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
	Play325121009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 325121009
		arg_38_1.duration_ = 2.97

		local var_38_0 = {
			zh = 2.8,
			ja = 2.966
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
				arg_38_0:Play325121010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1069ui_story = arg_38_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_41_0 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 then
				arg_38_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_38_1.time_ - 0) / var_41_0)
				arg_38_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1069ui_story"].transform.position).z)
				arg_38_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["1069ui_story"].transform.localEulerAngles = arg_38_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 then
				arg_38_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_38_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1069ui_story"].transform.position).z)
				arg_38_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["1069ui_story"].transform.localEulerAngles = arg_38_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_41_1 = arg_38_1.actors_["1069ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect1069ui_story == nil then
				arg_38_1.var_.characterEffect1069ui_story = var_41_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_2 and not isNil(var_41_1) then
				if arg_38_1.var_.characterEffect1069ui_story and not isNil(var_41_1) then
					arg_38_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_2 and arg_38_1.time_ < 0 + var_41_2 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect1069ui_story then
				arg_38_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action3_1")
			end

			local var_41_4 = 0
			local var_41_5 = 0.35

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_6 = arg_38_1:GetWordFromCfg(325121009)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 14 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 14)

				if (14 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 14)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121009", "story_v_out_325121.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_325121", "325121009", "story_v_out_325121.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_325121", "325121009", "story_v_out_325121.awb")

						arg_38_1:RecordAudio("325121009", var_41_11)
						arg_38_1:RecordAudio("325121009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_325121", "325121009", "story_v_out_325121.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_325121", "325121009", "story_v_out_325121.awb")
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
				actorName = "1069ui_story",
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
	Play325121010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325121010
		arg_42_1.duration_ = 5

		local var_42_0 = {
			zh = 2.6,
			ja = 5
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play325121011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1069ui_story"]) and arg_42_1.var_.characterEffect1069ui_story == nil then
				arg_42_1.var_.characterEffect1069ui_story = arg_42_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1069ui_story"]) then
				if arg_42_1.var_.characterEffect1069ui_story and not isNil(arg_42_1.actors_["1069ui_story"]) then
					arg_42_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_0)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1069ui_story"]) and arg_42_1.var_.characterEffect1069ui_story then
				arg_42_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_45_1 = 0
			local var_45_2 = 0.225

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_42_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_45_3 = arg_42_1:GetWordFromCfg(325121010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_6 = 9 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_4) / 9)

				if (9 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_4) / 9)) > 0 and var_45_2 < var_45_6 then
					arg_42_1.talkMaxDuration = var_45_6

					if var_45_6 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_6 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121010", "story_v_out_325121.awb") ~= 0 then
					local var_45_7 = manager.audio:GetVoiceLength("story_v_out_325121", "325121010", "story_v_out_325121.awb") / 1000

					if var_45_7 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_1
					end

					if var_45_3.prefab_name ~= "" and arg_42_1.actors_[var_45_3.prefab_name] ~= nil then
						local var_45_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_3.prefab_name].transform, "story_v_out_325121", "325121010", "story_v_out_325121.awb")

						arg_42_1:RecordAudio("325121010", var_45_8)
						arg_42_1:RecordAudio("325121010", var_45_8)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_325121", "325121010", "story_v_out_325121.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_325121", "325121010", "story_v_out_325121.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_9 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_9 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_9

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_9 and arg_42_1.time_ < var_45_1 + var_45_9 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play325121011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325121011
		arg_46_1.duration_ = 2

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play325121012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1069ui_story"]) and arg_46_1.var_.characterEffect1069ui_story == nil then
				arg_46_1.var_.characterEffect1069ui_story = arg_46_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1069ui_story"]) then
				if arg_46_1.var_.characterEffect1069ui_story and not isNil(arg_46_1.actors_["1069ui_story"]) then
					arg_46_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1069ui_story"]) and arg_46_1.var_.characterEffect1069ui_story then
				arg_46_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action3_2")
			end

			local var_49_2 = 0
			local var_49_3 = 0.175

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:GetWordFromCfg(325121011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_7 = 7 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 7)

				if (7 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 7)) > 0 and var_49_3 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121011", "story_v_out_325121.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_325121", "325121011", "story_v_out_325121.awb") / 1000

					if var_49_8 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_2
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_325121", "325121011", "story_v_out_325121.awb")

						arg_46_1:RecordAudio("325121011", var_49_9)
						arg_46_1:RecordAudio("325121011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_325121", "325121011", "story_v_out_325121.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_325121", "325121011", "story_v_out_325121.awb")
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
	Play325121012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325121012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play325121013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1069ui_story = arg_50_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_53_0 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 then
				arg_50_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_50_1.time_ - 0) / var_53_0)
				arg_50_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1069ui_story"].transform.position).z)
				arg_50_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1069ui_story"].transform.localEulerAngles = arg_50_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 then
				arg_50_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1069ui_story"].transform.position).z)
				arg_50_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1069ui_story"].transform.localEulerAngles = arg_50_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_53_1 = arg_50_1.actors_["1069ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect1069ui_story == nil then
				arg_50_1.var_.characterEffect1069ui_story = var_53_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_2 and not isNil(var_53_1) then
				if arg_50_1.var_.characterEffect1069ui_story and not isNil(var_53_1) then
					arg_50_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_2)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_2 and arg_50_1.time_ < 0 + var_53_2 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect1069ui_story then
				arg_50_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_53_3 = 0
			local var_53_4 = 1.05

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_3 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_5 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(325121012).content)

				arg_50_1.text_.text = var_53_5

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_7 = 42 <= 0 and var_53_4 or var_53_4 * (utf8.len(var_53_5) / 42)

				if (42 <= 0 and var_53_4 or var_53_4 * (utf8.len(var_53_5) / 42)) > 0 and var_53_4 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_3 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_3
					end
				end

				arg_50_1.text_.text = var_53_5
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_8 = math.max(var_53_4, arg_50_1.talkMaxDuration)

			if var_53_3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_3 + var_53_8 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_3) / var_53_8

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_3 + var_53_8 and arg_50_1.time_ < var_53_3 + var_53_8 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play325121013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325121013
		arg_54_1.duration_ = 5.83

		local var_54_0 = {
			zh = 5.833,
			ja = 4.366
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
				arg_54_0:Play325121014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.5

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_54_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_57_1 = arg_54_1:GetWordFromCfg(325121013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 20 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 20)

				if (20 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 20)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121013", "story_v_out_325121.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121013", "story_v_out_325121.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_325121", "325121013", "story_v_out_325121.awb")

						arg_54_1:RecordAudio("325121013", var_57_6)
						arg_54_1:RecordAudio("325121013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325121", "325121013", "story_v_out_325121.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325121", "325121013", "story_v_out_325121.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325121014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325121014
		arg_58_1.duration_ = 3.5

		local var_58_0 = {
			zh = 2.5,
			ja = 3.5
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play325121015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1069ui_story = arg_58_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_58_1.time_ - 0) / var_61_0)
				arg_58_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1069ui_story"].transform.position).z)
				arg_58_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1069ui_story"].transform.localEulerAngles = arg_58_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_58_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1069ui_story"].transform.position).z)
				arg_58_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1069ui_story"].transform.localEulerAngles = arg_58_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_61_1 = arg_58_1.actors_["1069ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1069ui_story == nil then
				arg_58_1.var_.characterEffect1069ui_story = var_61_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 and not isNil(var_61_1) then
				if arg_58_1.var_.characterEffect1069ui_story and not isNil(var_61_1) then
					arg_58_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1069ui_story then
				arg_58_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_61_4 = 0
			local var_61_5 = 0.3

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_6 = arg_58_1:GetWordFromCfg(325121014)
				local var_61_7 = arg_58_1:FormatText(var_61_6.content)

				arg_58_1.text_.text = var_61_7

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_9 = 12 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 12)

				if (12 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 12)) > 0 and var_61_5 < var_61_9 then
					arg_58_1.talkMaxDuration = var_61_9

					if var_61_9 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_4
					end
				end

				arg_58_1.text_.text = var_61_7
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121014", "story_v_out_325121.awb") ~= 0 then
					local var_61_10 = manager.audio:GetVoiceLength("story_v_out_325121", "325121014", "story_v_out_325121.awb") / 1000

					if var_61_10 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_4
					end

					if var_61_6.prefab_name ~= "" and arg_58_1.actors_[var_61_6.prefab_name] ~= nil then
						local var_61_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_6.prefab_name].transform, "story_v_out_325121", "325121014", "story_v_out_325121.awb")

						arg_58_1:RecordAudio("325121014", var_61_11)
						arg_58_1:RecordAudio("325121014", var_61_11)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325121", "325121014", "story_v_out_325121.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325121", "325121014", "story_v_out_325121.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_12 = math.max(var_61_5, arg_58_1.talkMaxDuration)

			if var_61_4 <= arg_58_1.time_ and arg_58_1.time_ < var_61_4 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_4) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_4 + var_61_12 and arg_58_1.time_ < var_61_4 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play325121015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325121015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play325121016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1069ui_story = arg_62_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_65_0 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 then
				arg_62_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_0)
				arg_62_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1069ui_story"].transform.position).z)
				arg_62_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1069ui_story"].transform.localEulerAngles = arg_62_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 then
				arg_62_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1069ui_story"].transform.position).z)
				arg_62_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1069ui_story"].transform.localEulerAngles = arg_62_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_65_1 = arg_62_1.actors_["1069ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect1069ui_story == nil then
				arg_62_1.var_.characterEffect1069ui_story = var_65_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_2 and not isNil(var_65_1) then
				if arg_62_1.var_.characterEffect1069ui_story and not isNil(var_65_1) then
					arg_62_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_2)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_2 and arg_62_1.time_ < 0 + var_65_2 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect1069ui_story then
				arg_62_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_62_1.time_ and arg_62_1.time_ <= 0.1 + arg_65_0 then
				arg_62_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_side_1028_stone", "")
			end

			if 0.6 < arg_62_1.time_ and arg_62_1.time_ <= 0.6 + arg_65_0 then
				arg_62_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword15", "")
			end

			local var_65_5 = 0
			local var_65_6 = 1.25

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_7 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(325121015).content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 50 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_7) / 50)

				if (50 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_7) / 50)) > 0 and var_65_6 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_5 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_5
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_6, arg_62_1.talkMaxDuration)

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_5) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_5 + var_65_10 and arg_62_1.time_ < var_65_5 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
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
	Play325121016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325121016
		arg_66_1.duration_ = 5.07

		local var_66_0 = {
			zh = 3.6,
			ja = 5.066
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
				arg_66_0:Play325121017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.25

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_66_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_69_1 = arg_66_1:GetWordFromCfg(325121016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 10 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 10)

				if (10 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 10)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121016", "story_v_out_325121.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121016", "story_v_out_325121.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_325121", "325121016", "story_v_out_325121.awb")

						arg_66_1:RecordAudio("325121016", var_69_6)
						arg_66_1:RecordAudio("325121016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_325121", "325121016", "story_v_out_325121.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_325121", "325121016", "story_v_out_325121.awb")
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
	Play325121017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325121017
		arg_70_1.duration_ = 5.1

		local var_70_0 = {
			zh = 4.5,
			ja = 5.1
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
				arg_70_0:Play325121018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1069ui_story = arg_70_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_73_0 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 then
				arg_70_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_70_1.time_ - 0) / var_73_0)
				arg_70_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1069ui_story"].transform.position).z)
				arg_70_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1069ui_story"].transform.localEulerAngles = arg_70_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 then
				arg_70_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_70_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1069ui_story"].transform.position).z)
				arg_70_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1069ui_story"].transform.localEulerAngles = arg_70_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_73_1 = arg_70_1.actors_["1069ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_1) and arg_70_1.var_.characterEffect1069ui_story == nil then
				arg_70_1.var_.characterEffect1069ui_story = var_73_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_2 and not isNil(var_73_1) then
				if arg_70_1.var_.characterEffect1069ui_story and not isNil(var_73_1) then
					arg_70_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_2 and arg_70_1.time_ < 0 + var_73_2 + arg_73_0 and not isNil(var_73_1) and arg_70_1.var_.characterEffect1069ui_story then
				arg_70_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action6_1")
			end

			local var_73_4 = 0
			local var_73_5 = 0.45

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_6 = arg_70_1:GetWordFromCfg(325121017)
				local var_73_7 = arg_70_1:FormatText(var_73_6.content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 18 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 18)

				if (18 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 18)) > 0 and var_73_5 < var_73_9 then
					arg_70_1.talkMaxDuration = var_73_9

					if var_73_9 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_9 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121017", "story_v_out_325121.awb") ~= 0 then
					local var_73_10 = manager.audio:GetVoiceLength("story_v_out_325121", "325121017", "story_v_out_325121.awb") / 1000

					if var_73_10 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_4
					end

					if var_73_6.prefab_name ~= "" and arg_70_1.actors_[var_73_6.prefab_name] ~= nil then
						local var_73_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_6.prefab_name].transform, "story_v_out_325121", "325121017", "story_v_out_325121.awb")

						arg_70_1:RecordAudio("325121017", var_73_11)
						arg_70_1:RecordAudio("325121017", var_73_11)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325121", "325121017", "story_v_out_325121.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325121", "325121017", "story_v_out_325121.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_12 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_12 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_12

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_12 and arg_70_1.time_ < var_73_4 + var_73_12 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play325121018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325121018
		arg_74_1.duration_ = 7.8

		local var_74_0 = {
			zh = 7.433,
			ja = 7.8
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325121019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1069ui_story"]) and arg_74_1.var_.characterEffect1069ui_story == nil then
				arg_74_1.var_.characterEffect1069ui_story = arg_74_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1069ui_story"]) then
				if arg_74_1.var_.characterEffect1069ui_story and not isNil(arg_74_1.actors_["1069ui_story"]) then
					arg_74_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_0)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1069ui_story"]) and arg_74_1.var_.characterEffect1069ui_story then
				arg_74_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_77_1 = 0
			local var_77_2 = 0.55

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_74_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_77_3 = arg_74_1:GetWordFromCfg(325121018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 22 <= 0 and var_77_2 or var_77_2 * (utf8.len(var_77_4) / 22)

				if (22 <= 0 and var_77_2 or var_77_2 * (utf8.len(var_77_4) / 22)) > 0 and var_77_2 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_1
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121018", "story_v_out_325121.awb") ~= 0 then
					local var_77_7 = manager.audio:GetVoiceLength("story_v_out_325121", "325121018", "story_v_out_325121.awb") / 1000

					if var_77_7 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_1
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_325121", "325121018", "story_v_out_325121.awb")

						arg_74_1:RecordAudio("325121018", var_77_8)
						arg_74_1:RecordAudio("325121018", var_77_8)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325121", "325121018", "story_v_out_325121.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325121", "325121018", "story_v_out_325121.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_9 = math.max(var_77_2, arg_74_1.talkMaxDuration)

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_9 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_1) / var_77_9

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_1 + var_77_9 and arg_74_1.time_ < var_77_1 + var_77_9 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325121019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325121019
		arg_78_1.duration_ = 6.8

		local var_78_0 = {
			zh = 3.866,
			ja = 6.8
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325121020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1069ui_story"]) and arg_78_1.var_.characterEffect1069ui_story == nil then
				arg_78_1.var_.characterEffect1069ui_story = arg_78_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1069ui_story"]) then
				if arg_78_1.var_.characterEffect1069ui_story and not isNil(arg_78_1.actors_["1069ui_story"]) then
					arg_78_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1069ui_story"]) and arg_78_1.var_.characterEffect1069ui_story then
				arg_78_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action6_2")
			end

			local var_81_2 = 0
			local var_81_3 = 0.425

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_4 = arg_78_1:GetWordFromCfg(325121019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 17 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 17)

				if (17 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 17)) > 0 and var_81_3 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121019", "story_v_out_325121.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_325121", "325121019", "story_v_out_325121.awb") / 1000

					if var_81_8 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_2
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_325121", "325121019", "story_v_out_325121.awb")

						arg_78_1:RecordAudio("325121019", var_81_9)
						arg_78_1:RecordAudio("325121019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_325121", "325121019", "story_v_out_325121.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_325121", "325121019", "story_v_out_325121.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_3, arg_78_1.talkMaxDuration)

			if var_81_2 <= arg_78_1.time_ and arg_78_1.time_ < var_81_2 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_2) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_2 + var_81_10 and arg_78_1.time_ < var_81_2 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325121020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325121020
		arg_82_1.duration_ = 12.53

		local var_82_0 = {
			zh = 5.633,
			ja = 12.533
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play325121021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1069ui_story"]) and arg_82_1.var_.characterEffect1069ui_story == nil then
				arg_82_1.var_.characterEffect1069ui_story = arg_82_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1069ui_story"]) then
				if arg_82_1.var_.characterEffect1069ui_story and not isNil(arg_82_1.actors_["1069ui_story"]) then
					arg_82_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_0)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1069ui_story"]) and arg_82_1.var_.characterEffect1069ui_story then
				arg_82_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_85_1 = 0
			local var_85_2 = 0.425

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_82_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_85_3 = arg_82_1:GetWordFromCfg(325121020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_6 = 17 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_4) / 17)

				if (17 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_4) / 17)) > 0 and var_85_2 < var_85_6 then
					arg_82_1.talkMaxDuration = var_85_6

					if var_85_6 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_1
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121020", "story_v_out_325121.awb") ~= 0 then
					local var_85_7 = manager.audio:GetVoiceLength("story_v_out_325121", "325121020", "story_v_out_325121.awb") / 1000

					if var_85_7 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_1
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_325121", "325121020", "story_v_out_325121.awb")

						arg_82_1:RecordAudio("325121020", var_85_8)
						arg_82_1:RecordAudio("325121020", var_85_8)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325121", "325121020", "story_v_out_325121.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325121", "325121020", "story_v_out_325121.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_9 = math.max(var_85_2, arg_82_1.talkMaxDuration)

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_9 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_1) / var_85_9

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_1 + var_85_9 and arg_82_1.time_ < var_85_1 + var_85_9 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play325121021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325121021
		arg_86_1.duration_ = 20.57

		local var_86_0 = {
			zh = 12.2,
			ja = 20.566
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play325121022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 1.125

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_86_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_89_1 = arg_86_1:GetWordFromCfg(325121021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 45 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 45)

				if (45 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 45)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121021", "story_v_out_325121.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121021", "story_v_out_325121.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_325121", "325121021", "story_v_out_325121.awb")

						arg_86_1:RecordAudio("325121021", var_89_6)
						arg_86_1:RecordAudio("325121021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325121", "325121021", "story_v_out_325121.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325121", "325121021", "story_v_out_325121.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play325121022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325121022
		arg_90_1.duration_ = 14.6

		local var_90_0 = {
			zh = 14.033,
			ja = 14.6
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325121023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 1.475

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_90_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_93_1 = arg_90_1:GetWordFromCfg(325121022)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 59 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 59)

				if (59 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 59)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121022", "story_v_out_325121.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121022", "story_v_out_325121.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_325121", "325121022", "story_v_out_325121.awb")

						arg_90_1:RecordAudio("325121022", var_93_6)
						arg_90_1:RecordAudio("325121022", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325121", "325121022", "story_v_out_325121.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325121", "325121022", "story_v_out_325121.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325121023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325121023
		arg_94_1.duration_ = 15.2

		local var_94_0 = {
			zh = 12.633,
			ja = 15.2
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play325121024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 1.125

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_94_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_97_1 = arg_94_1:GetWordFromCfg(325121023)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 45 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 45)

				if (45 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 45)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121023", "story_v_out_325121.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121023", "story_v_out_325121.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_325121", "325121023", "story_v_out_325121.awb")

						arg_94_1:RecordAudio("325121023", var_97_6)
						arg_94_1:RecordAudio("325121023", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325121", "325121023", "story_v_out_325121.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325121", "325121023", "story_v_out_325121.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play325121024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325121024
		arg_98_1.duration_ = 1

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play325121025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1069ui_story"]) and arg_98_1.var_.characterEffect1069ui_story == nil then
				arg_98_1.var_.characterEffect1069ui_story = arg_98_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1069ui_story"]) then
				if arg_98_1.var_.characterEffect1069ui_story and not isNil(arg_98_1.actors_["1069ui_story"]) then
					arg_98_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1069ui_story"]) and arg_98_1.var_.characterEffect1069ui_story then
				arg_98_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_101_2 = 0
			local var_101_3 = 0.05

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_4 = arg_98_1:GetWordFromCfg(325121024)
				local var_101_5 = arg_98_1:FormatText(var_101_4.content)

				arg_98_1.text_.text = var_101_5

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 2 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 2)

				if (2 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 2)) > 0 and var_101_3 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_5
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121024", "story_v_out_325121.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_325121", "325121024", "story_v_out_325121.awb") / 1000

					if var_101_8 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_2
					end

					if var_101_4.prefab_name ~= "" and arg_98_1.actors_[var_101_4.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_4.prefab_name].transform, "story_v_out_325121", "325121024", "story_v_out_325121.awb")

						arg_98_1:RecordAudio("325121024", var_101_9)
						arg_98_1:RecordAudio("325121024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325121", "325121024", "story_v_out_325121.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325121", "325121024", "story_v_out_325121.awb")
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
	Play325121025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325121025
		arg_102_1.duration_ = 9.6

		local var_102_0 = {
			zh = 6.966,
			ja = 9.6
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325121026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1069ui_story"]) and arg_102_1.var_.characterEffect1069ui_story == nil then
				arg_102_1.var_.characterEffect1069ui_story = arg_102_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1069ui_story"]) then
				if arg_102_1.var_.characterEffect1069ui_story and not isNil(arg_102_1.actors_["1069ui_story"]) then
					arg_102_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1069ui_story"]) and arg_102_1.var_.characterEffect1069ui_story then
				arg_102_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_105_1 = 0
			local var_105_2 = 0.5

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_102_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_105_3 = arg_102_1:GetWordFromCfg(325121025)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_6 = 20 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_4) / 20)

				if (20 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_4) / 20)) > 0 and var_105_2 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_1
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121025", "story_v_out_325121.awb") ~= 0 then
					local var_105_7 = manager.audio:GetVoiceLength("story_v_out_325121", "325121025", "story_v_out_325121.awb") / 1000

					if var_105_7 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_1
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_325121", "325121025", "story_v_out_325121.awb")

						arg_102_1:RecordAudio("325121025", var_105_8)
						arg_102_1:RecordAudio("325121025", var_105_8)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325121", "325121025", "story_v_out_325121.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325121", "325121025", "story_v_out_325121.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_9 = math.max(var_105_2, arg_102_1.talkMaxDuration)

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_9 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_1) / var_105_9

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_1 + var_105_9 and arg_102_1.time_ < var_105_1 + var_105_9 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325121026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325121026
		arg_106_1.duration_ = 2

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325121027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1069ui_story"]) and arg_106_1.var_.characterEffect1069ui_story == nil then
				arg_106_1.var_.characterEffect1069ui_story = arg_106_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1069ui_story"]) then
				if arg_106_1.var_.characterEffect1069ui_story and not isNil(arg_106_1.actors_["1069ui_story"]) then
					arg_106_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1069ui_story"]) and arg_106_1.var_.characterEffect1069ui_story then
				arg_106_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_2 = 0
			local var_109_3 = 0.075

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(325121026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 3 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 3)

				if (3 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 3)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121026", "story_v_out_325121.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_325121", "325121026", "story_v_out_325121.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_325121", "325121026", "story_v_out_325121.awb")

						arg_106_1:RecordAudio("325121026", var_109_9)
						arg_106_1:RecordAudio("325121026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325121", "325121026", "story_v_out_325121.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325121", "325121026", "story_v_out_325121.awb")
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
	Play325121027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325121027
		arg_110_1.duration_ = 2.9

		local var_110_0 = {
			zh = 2.9,
			ja = 2.566
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325121028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1069ui_story"]) and arg_110_1.var_.characterEffect1069ui_story == nil then
				arg_110_1.var_.characterEffect1069ui_story = arg_110_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1069ui_story"]) then
				if arg_110_1.var_.characterEffect1069ui_story and not isNil(arg_110_1.actors_["1069ui_story"]) then
					arg_110_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1069ui_story"]) and arg_110_1.var_.characterEffect1069ui_story then
				arg_110_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_113_1 = 0
			local var_113_2 = 0.275

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_110_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_113_3 = arg_110_1:GetWordFromCfg(325121027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_6 = 11 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_4) / 11)

				if (11 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_4) / 11)) > 0 and var_113_2 < var_113_6 then
					arg_110_1.talkMaxDuration = var_113_6

					if var_113_6 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121027", "story_v_out_325121.awb") ~= 0 then
					local var_113_7 = manager.audio:GetVoiceLength("story_v_out_325121", "325121027", "story_v_out_325121.awb") / 1000

					if var_113_7 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_1
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_325121", "325121027", "story_v_out_325121.awb")

						arg_110_1:RecordAudio("325121027", var_113_8)
						arg_110_1:RecordAudio("325121027", var_113_8)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_325121", "325121027", "story_v_out_325121.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_325121", "325121027", "story_v_out_325121.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_9 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_9 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_9

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_9 and arg_110_1.time_ < var_113_1 + var_113_9 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play325121028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325121028
		arg_114_1.duration_ = 6.3

		local var_114_0 = {
			zh = 6.3,
			ja = 5.366
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325121029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1069ui_story"]) and arg_114_1.var_.characterEffect1069ui_story == nil then
				arg_114_1.var_.characterEffect1069ui_story = arg_114_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1069ui_story"]) then
				if arg_114_1.var_.characterEffect1069ui_story and not isNil(arg_114_1.actors_["1069ui_story"]) then
					arg_114_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1069ui_story"]) and arg_114_1.var_.characterEffect1069ui_story then
				arg_114_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_117_2 = 0
			local var_117_3 = 0.7

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_4 = arg_114_1:GetWordFromCfg(325121028)
				local var_117_5 = arg_114_1:FormatText(var_117_4.content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_7 = 28 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 28)

				if (28 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 28)) > 0 and var_117_3 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121028", "story_v_out_325121.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_325121", "325121028", "story_v_out_325121.awb") / 1000

					if var_117_8 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_2
					end

					if var_117_4.prefab_name ~= "" and arg_114_1.actors_[var_117_4.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_4.prefab_name].transform, "story_v_out_325121", "325121028", "story_v_out_325121.awb")

						arg_114_1:RecordAudio("325121028", var_117_9)
						arg_114_1:RecordAudio("325121028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325121", "325121028", "story_v_out_325121.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325121", "325121028", "story_v_out_325121.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_3, arg_114_1.talkMaxDuration)

			if var_117_2 <= arg_114_1.time_ and arg_114_1.time_ < var_117_2 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_2) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_2 + var_117_10 and arg_114_1.time_ < var_117_2 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play325121029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325121029
		arg_118_1.duration_ = 8.5

		local var_118_0 = {
			zh = 8.5,
			ja = 7.3
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325121030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.9

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:GetWordFromCfg(325121029)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 36 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 36)

				if (36 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 36)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121029", "story_v_out_325121.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121029", "story_v_out_325121.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_325121", "325121029", "story_v_out_325121.awb")

						arg_118_1:RecordAudio("325121029", var_121_6)
						arg_118_1:RecordAudio("325121029", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325121", "325121029", "story_v_out_325121.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325121", "325121029", "story_v_out_325121.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325121030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325121030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play325121031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1069ui_story = arg_122_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1069ui_story"].transform.position).z)
				arg_122_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1069ui_story"].transform.localEulerAngles = arg_122_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1069ui_story"].transform.position).z)
				arg_122_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1069ui_story"].transform.localEulerAngles = arg_122_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_125_1 = arg_122_1.actors_["1069ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1069ui_story == nil then
				arg_122_1.var_.characterEffect1069ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 and not isNil(var_125_1) then
				if arg_122_1.var_.characterEffect1069ui_story and not isNil(var_125_1) then
					arg_122_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_2)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1069ui_story then
				arg_122_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0.6 < arg_122_1.time_ and arg_122_1.time_ <= 0.6 + arg_125_0 then
				arg_122_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_stab2", "")
			end

			local var_125_4 = 0
			local var_125_5 = 0.85

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(325121030).content)

				arg_122_1.text_.text = var_125_6

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_8 = 34 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_6) / 34)

				if (34 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_6) / 34)) > 0 and var_125_5 < var_125_8 then
					arg_122_1.talkMaxDuration = var_125_8

					if var_125_8 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_6
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_9 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_9 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_9

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_9 and arg_122_1.time_ < var_125_4 + var_125_9 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play325121031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325121031
		arg_126_1.duration_ = 4.57

		local var_126_0 = {
			zh = 3.733,
			ja = 4.566
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325121032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.275

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_126_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_129_1 = arg_126_1:GetWordFromCfg(325121031)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 11 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 11)

				if (11 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 11)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121031", "story_v_out_325121.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121031", "story_v_out_325121.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_325121", "325121031", "story_v_out_325121.awb")

						arg_126_1:RecordAudio("325121031", var_129_6)
						arg_126_1:RecordAudio("325121031", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_325121", "325121031", "story_v_out_325121.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_325121", "325121031", "story_v_out_325121.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play325121032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325121032
		arg_130_1.duration_ = 9.73

		local var_130_0 = {
			zh = 9.733,
			ja = 8.166
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325121033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1069ui_story = arg_130_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1069ui_story"].transform.position).z)
				arg_130_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1069ui_story"].transform.localEulerAngles = arg_130_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_130_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1069ui_story"].transform.position).z)
				arg_130_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1069ui_story"].transform.localEulerAngles = arg_130_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_133_1 = arg_130_1.actors_["1069ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1069ui_story == nil then
				arg_130_1.var_.characterEffect1069ui_story = var_133_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_2 and not isNil(var_133_1) then
				if arg_130_1.var_.characterEffect1069ui_story and not isNil(var_133_1) then
					arg_130_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_2 and arg_130_1.time_ < 0 + var_133_2 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1069ui_story then
				arg_130_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_133_4 = 0
			local var_133_5 = 1.25

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_6 = arg_130_1:GetWordFromCfg(325121032)
				local var_133_7 = arg_130_1:FormatText(var_133_6.content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 50 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 50)

				if (50 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 50)) > 0 and var_133_5 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_4
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121032", "story_v_out_325121.awb") ~= 0 then
					local var_133_10 = manager.audio:GetVoiceLength("story_v_out_325121", "325121032", "story_v_out_325121.awb") / 1000

					if var_133_10 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_4
					end

					if var_133_6.prefab_name ~= "" and arg_130_1.actors_[var_133_6.prefab_name] ~= nil then
						local var_133_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_6.prefab_name].transform, "story_v_out_325121", "325121032", "story_v_out_325121.awb")

						arg_130_1:RecordAudio("325121032", var_133_11)
						arg_130_1:RecordAudio("325121032", var_133_11)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_325121", "325121032", "story_v_out_325121.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_325121", "325121032", "story_v_out_325121.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_12 = math.max(var_133_5, arg_130_1.talkMaxDuration)

			if var_133_4 <= arg_130_1.time_ and arg_130_1.time_ < var_133_4 + var_133_12 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_4) / var_133_12

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_4 + var_133_12 and arg_130_1.time_ < var_133_4 + var_133_12 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play325121033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325121033
		arg_134_1.duration_ = 8

		local var_134_0 = {
			zh = 7.8,
			ja = 8
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play325121034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_2")
			end

			local var_137_0 = 0
			local var_137_1 = 0.8

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(325121033)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 32 <= 0 and var_137_1 or var_137_1 * (utf8.len(var_137_3) / 32)

				if (32 <= 0 and var_137_1 or var_137_1 * (utf8.len(var_137_3) / 32)) > 0 and var_137_1 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121033", "story_v_out_325121.awb") ~= 0 then
					local var_137_6 = manager.audio:GetVoiceLength("story_v_out_325121", "325121033", "story_v_out_325121.awb") / 1000

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end

					if var_137_2.prefab_name ~= "" and arg_134_1.actors_[var_137_2.prefab_name] ~= nil then
						local var_137_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_2.prefab_name].transform, "story_v_out_325121", "325121033", "story_v_out_325121.awb")

						arg_134_1:RecordAudio("325121033", var_137_7)
						arg_134_1:RecordAudio("325121033", var_137_7)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_325121", "325121033", "story_v_out_325121.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_325121", "325121033", "story_v_out_325121.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_8 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_8 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_8

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_8 and arg_134_1.time_ < var_137_0 + var_137_8 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play325121034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325121034
		arg_138_1.duration_ = 6.33

		local var_138_0 = {
			zh = 6.13400000184774,
			ja = 6.33400000184774
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play325121035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 1.999999999999 < arg_138_1.time_ and arg_138_1.time_ <= 1.999999999999 + arg_141_0 then
				local var_141_0 = arg_138_1.bgs_.ST2011

				arg_138_1.bgs_.ST2011.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_141_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_141_1 = var_141_0:GetComponent("SpriteRenderer")

				if var_141_1 and var_141_1.sprite then
					local var_141_2 = 2 * (var_141_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_141_0.transform.localScale = Vector3.New(var_141_2 / var_141_1.sprite.bounds.size.y < var_141_2 * manager.ui.mainCameraCom_.aspect / var_141_1.sprite.bounds.size.x and var_141_2 * manager.ui.mainCameraCom_.aspect / var_141_1.sprite.bounds.size.x or var_141_2 / var_141_1.sprite.bounds.size.y, var_141_2 / var_141_1.sprite.bounds.size.y < var_141_2 * manager.ui.mainCameraCom_.aspect / var_141_1.sprite.bounds.size.x and var_141_2 * manager.ui.mainCameraCom_.aspect / var_141_1.sprite.bounds.size.x or var_141_2 / var_141_1.sprite.bounds.size.y, 0)
				end

				for iter_141_0, iter_141_1 in pairs(arg_138_1.bgs_) do
					if iter_141_0 ~= "ST2011" then
						iter_141_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_141_3 = 0

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_3 + arg_141_0 then
				arg_138_1.allBtn_.enabled = false
			end

			if arg_138_1.time_ >= var_141_3 + 0.3 and arg_138_1.time_ < var_141_3 + 0.3 + arg_141_0 then
				arg_138_1.allBtn_.enabled = true
			end

			local var_141_4 = 0

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1.mask_.enabled = true
				arg_138_1.mask_.raycastTarget = true

				arg_138_1:SetGaussion(false)
			end

			local var_141_5 = 2

			if var_141_4 <= arg_138_1.time_ and arg_138_1.time_ < var_141_4 + var_141_5 then
				local var_141_6 = Color.New(0, 0, 0)

				var_141_6.a = Mathf.Lerp(0, 1, (arg_138_1.time_ - var_141_4) / var_141_5)
				arg_138_1.mask_.color = var_141_6
			end

			if arg_138_1.time_ >= var_141_4 + var_141_5 and arg_138_1.time_ < var_141_4 + var_141_5 + arg_141_0 then
				local var_141_7 = Color.New(0, 0, 0)

				var_141_7.a = 1
				arg_138_1.mask_.color = var_141_7
			end

			local var_141_8 = 2

			if 2 < arg_138_1.time_ and arg_138_1.time_ <= var_141_8 + arg_141_0 then
				arg_138_1.mask_.enabled = true
				arg_138_1.mask_.raycastTarget = true

				arg_138_1:SetGaussion(false)
			end

			local var_141_9 = 2

			if var_141_8 <= arg_138_1.time_ and arg_138_1.time_ < var_141_8 + var_141_9 then
				local var_141_10 = Color.New(0, 0, 0)

				var_141_10.a = Mathf.Lerp(1, 0, (arg_138_1.time_ - var_141_8) / var_141_9)
				arg_138_1.mask_.color = var_141_10
			end

			if arg_138_1.time_ >= var_141_8 + var_141_9 and arg_138_1.time_ < var_141_8 + var_141_9 + arg_141_0 then
				local var_141_11 = Color.New(0, 0, 0)

				arg_138_1.mask_.enabled = false
				var_141_11.a = 0
				arg_138_1.mask_.color = var_141_11
			end

			local var_141_12 = arg_138_1.actors_["1069ui_story"].transform

			if 1.999999999999 < arg_138_1.time_ and arg_138_1.time_ <= 1.999999999999 + arg_141_0 then
				arg_138_1.var_.moveOldPos1069ui_story = var_141_12.localPosition
			end

			local var_141_13 = 0.001

			if 1.999999999999 <= arg_138_1.time_ and arg_138_1.time_ < 1.999999999999 + var_141_13 then
				var_141_12.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 1.999999999999) / var_141_13)
				var_141_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_12.position).x, (manager.ui.mainCamera.transform.position - var_141_12.position).y, (manager.ui.mainCamera.transform.position - var_141_12.position).z)
				var_141_12.localEulerAngles.z = 0
				var_141_12.localEulerAngles.x = 0
				var_141_12.localEulerAngles = var_141_12.localEulerAngles
			end

			if arg_138_1.time_ >= 1.999999999999 + var_141_13 and arg_138_1.time_ < 1.999999999999 + var_141_13 + arg_141_0 then
				var_141_12.localPosition = Vector3.New(0, 100, 0)
				var_141_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_12.position).x, (manager.ui.mainCamera.transform.position - var_141_12.position).y, (manager.ui.mainCamera.transform.position - var_141_12.position).z)
				var_141_12.localEulerAngles.z = 0
				var_141_12.localEulerAngles.x = 0
				var_141_12.localEulerAngles = var_141_12.localEulerAngles
			end

			local var_141_14 = arg_138_1.actors_["1069ui_story"].transform

			if 3.63333333333333 < arg_138_1.time_ and arg_138_1.time_ <= 3.63333333333333 + arg_141_0 then
				arg_138_1.var_.moveOldPos1069ui_story = var_141_14.localPosition
			end

			local var_141_15 = 0.001

			if 3.63333333333333 <= arg_138_1.time_ and arg_138_1.time_ < 3.63333333333333 + var_141_15 then
				var_141_14.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_138_1.time_ - 3.63333333333333) / var_141_15)
				var_141_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_14.position).x, (manager.ui.mainCamera.transform.position - var_141_14.position).y, (manager.ui.mainCamera.transform.position - var_141_14.position).z)
				var_141_14.localEulerAngles.z = 0
				var_141_14.localEulerAngles.x = 0
				var_141_14.localEulerAngles = var_141_14.localEulerAngles
			end

			if arg_138_1.time_ >= 3.63333333333333 + var_141_15 and arg_138_1.time_ < 3.63333333333333 + var_141_15 + arg_141_0 then
				var_141_14.localPosition = Vector3.New(0, -1, -6)
				var_141_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_14.position).x, (manager.ui.mainCamera.transform.position - var_141_14.position).y, (manager.ui.mainCamera.transform.position - var_141_14.position).z)
				var_141_14.localEulerAngles.z = 0
				var_141_14.localEulerAngles.x = 0
				var_141_14.localEulerAngles = var_141_14.localEulerAngles
			end

			local var_141_16 = arg_138_1.actors_["1069ui_story"]

			if 3.63333333333333 < arg_138_1.time_ and arg_138_1.time_ <= 3.63333333333333 + arg_141_0 and not isNil(var_141_16) and arg_138_1.var_.characterEffect1069ui_story == nil then
				arg_138_1.var_.characterEffect1069ui_story = var_141_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_17 = 0.200000002980232

			if 3.63333333333333 <= arg_138_1.time_ and arg_138_1.time_ < 3.63333333333333 + var_141_17 and not isNil(var_141_16) then
				if arg_138_1.var_.characterEffect1069ui_story and not isNil(var_141_16) then
					arg_138_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 3.63333333333333 + var_141_17 and arg_138_1.time_ < 3.63333333333333 + var_141_17 + arg_141_0 and not isNil(var_141_16) and arg_138_1.var_.characterEffect1069ui_story then
				arg_138_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 3.63333333333333 < arg_138_1.time_ and arg_138_1.time_ <= 3.63333333333333 + arg_141_0 then
				arg_138_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 3.63333333333333 < arg_138_1.time_ and arg_138_1.time_ <= 3.63333333333333 + arg_141_0 then
				arg_138_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_141_19 = 2

			arg_138_1.isInRecall_ = false

			if var_141_19 < arg_138_1.time_ and arg_138_1.time_ <= var_141_19 + arg_141_0 then
				arg_138_1.screenFilterGo_:SetActive(false)

				for iter_141_2, iter_141_3 in pairs(arg_138_1.actors_) do
					for iter_141_4, iter_141_5 in ipairs((iter_141_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_141_5.color = iter_141_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_141_20 = 0.034000001847744

			if var_141_19 <= arg_138_1.time_ and arg_138_1.time_ < var_141_19 + var_141_20 then
				arg_138_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_138_1.time_ - var_141_19) / var_141_20)
			end

			if arg_138_1.time_ >= var_141_19 + var_141_20 and arg_138_1.time_ < var_141_19 + var_141_20 + arg_141_0 then
				arg_138_1.screenFilterEffect_.weight = 0
			end

			if arg_138_1.frameCnt_ <= 1 then
				arg_138_1.dialog_:SetActive(false)
			end

			local var_141_21 = 3.83400000184774
			local var_141_22 = 0.3

			if 3.83400000184774 < arg_138_1.time_ and arg_138_1.time_ <= var_141_21 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0

				arg_138_1.dialog_:SetActive(true)

				arg_138_1.dialogCg_.alpha = 0

				local var_141_23 = LeanTween.value(arg_138_1.dialog_, 0, 1, 0.3)

				var_141_23:setOnUpdate(LuaHelper.FloatAction(function(arg_142_0)
					arg_138_1.dialogCg_.alpha = arg_142_0
				end))
				var_141_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_138_1.dialog_)
					var_141_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_138_1.duration_ = arg_138_1.duration_ + 0.3

				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_24 = arg_138_1:GetWordFromCfg(325121034)
				local var_141_25 = arg_138_1:FormatText(var_141_24.content)

				arg_138_1.text_.text = var_141_25

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_27 = 12 <= 0 and var_141_22 or var_141_22 * (utf8.len(var_141_25) / 12)

				if (12 <= 0 and var_141_22 or var_141_22 * (utf8.len(var_141_25) / 12)) > 0 and var_141_22 < var_141_27 then
					arg_138_1.talkMaxDuration = var_141_27
					var_141_21 = var_141_21 + 0.3

					if var_141_27 + var_141_21 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_27 + var_141_21
					end
				end

				arg_138_1.text_.text = var_141_25
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121034", "story_v_out_325121.awb") ~= 0 then
					local var_141_28 = manager.audio:GetVoiceLength("story_v_out_325121", "325121034", "story_v_out_325121.awb") / 1000

					if var_141_28 + var_141_21 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_28 + var_141_21
					end

					if var_141_24.prefab_name ~= "" and arg_138_1.actors_[var_141_24.prefab_name] ~= nil then
						local var_141_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_24.prefab_name].transform, "story_v_out_325121", "325121034", "story_v_out_325121.awb")

						arg_138_1:RecordAudio("325121034", var_141_29)
						arg_138_1:RecordAudio("325121034", var_141_29)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325121", "325121034", "story_v_out_325121.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325121", "325121034", "story_v_out_325121.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_30 = var_141_21 + 0.3
			local var_141_31 = math.max(var_141_22, arg_138_1.talkMaxDuration)

			if var_141_21 + 0.3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_30 + var_141_31 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_30) / var_141_31

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_30 + var_141_31 and arg_138_1.time_ < var_141_30 + var_141_31 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play325121035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325121035
		arg_144_1.duration_ = 2.67

		local var_144_0 = {
			zh = 2.266,
			ja = 2.666
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play325121036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.25

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(325121035)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 10 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 10)

				if (10 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 10)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121035", "story_v_out_325121.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121035", "story_v_out_325121.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_325121", "325121035", "story_v_out_325121.awb")

						arg_144_1:RecordAudio("325121035", var_147_6)
						arg_144_1:RecordAudio("325121035", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325121", "325121035", "story_v_out_325121.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325121", "325121035", "story_v_out_325121.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play325121036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325121036
		arg_148_1.duration_ = 2.83

		local var_148_0 = {
			zh = 1.6,
			ja = 2.833
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325121037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1069ui_story"]) and arg_148_1.var_.characterEffect1069ui_story == nil then
				arg_148_1.var_.characterEffect1069ui_story = arg_148_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1069ui_story"]) then
				if arg_148_1.var_.characterEffect1069ui_story and not isNil(arg_148_1.actors_["1069ui_story"]) then
					arg_148_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_0)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1069ui_story"]) and arg_148_1.var_.characterEffect1069ui_story then
				arg_148_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_151_1 = 0
			local var_151_2 = 0.075

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1525].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10177")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(325121036)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 3 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 3)

				if (3 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 3)) > 0 and var_151_2 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121036", "story_v_out_325121.awb") ~= 0 then
					local var_151_7 = manager.audio:GetVoiceLength("story_v_out_325121", "325121036", "story_v_out_325121.awb") / 1000

					if var_151_7 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_1
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_325121", "325121036", "story_v_out_325121.awb")

						arg_148_1:RecordAudio("325121036", var_151_8)
						arg_148_1:RecordAudio("325121036", var_151_8)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_325121", "325121036", "story_v_out_325121.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_325121", "325121036", "story_v_out_325121.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_9 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_9 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_9

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_9 and arg_148_1.time_ < var_151_1 + var_151_9 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325121037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325121037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play325121038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1069ui_story = arg_152_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1069ui_story"].transform.position).z)
				arg_152_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1069ui_story"].transform.localEulerAngles = arg_152_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1069ui_story"].transform.position).z)
				arg_152_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1069ui_story"].transform.localEulerAngles = arg_152_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_155_1 = 0
			local var_155_2 = 0.775

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_3 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(325121037).content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 31 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 31)

				if (31 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 31)) > 0 and var_155_2 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_1
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_6 = math.max(var_155_2, arg_152_1.talkMaxDuration)

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_6 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_1) / var_155_6

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_1 + var_155_6 and arg_152_1.time_ < var_155_1 + var_155_6 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
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
	Play325121038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325121038
		arg_156_1.duration_ = 7.17

		local var_156_0 = {
			zh = 6.86666666666667,
			ja = 7.16666666666667
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
				arg_156_0:Play325121039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if arg_156_1.bgs_.J02 == nil then
				local var_159_0 = Object.Instantiate(arg_156_1.paintGo_)

				var_159_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J02")
				var_159_0.name = "J02"
				var_159_0.transform.parent = arg_156_1.stage_.transform
				var_159_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_.J02 = var_159_0
			end

			if 1.2 < arg_156_1.time_ and arg_156_1.time_ <= 1.2 + arg_159_0 then
				local var_159_1 = arg_156_1.bgs_.J02

				arg_156_1.bgs_.J02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_2 = var_159_1:GetComponent("SpriteRenderer")

				if var_159_2 and var_159_2.sprite then
					local var_159_3 = 2 * (var_159_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_1.transform.localScale = Vector3.New(var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "J02" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_4 = 0

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
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

			local var_159_6 = 1.2

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 then
				local var_159_7 = Color.New(0, 0, 0)

				var_159_7.a = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_5) / var_159_6)
				arg_156_1.mask_.color = var_159_7
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 then
				local var_159_8 = Color.New(0, 0, 0)

				var_159_8.a = 1
				arg_156_1.mask_.color = var_159_8
			end

			local var_159_9 = 1.2

			if 1.2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_9 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_10 = 1.66666666666667

			if var_159_9 <= arg_156_1.time_ and arg_156_1.time_ < var_159_9 + var_159_10 then
				local var_159_11 = Color.New(0, 0, 0)

				var_159_11.a = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_9) / var_159_10)
				arg_156_1.mask_.color = var_159_11
			end

			if arg_156_1.time_ >= var_159_9 + var_159_10 and arg_156_1.time_ < var_159_9 + var_159_10 + arg_159_0 then
				local var_159_12 = Color.New(0, 0, 0)

				arg_156_1.mask_.enabled = false
				var_159_12.a = 0
				arg_156_1.mask_.color = var_159_12
			end

			if 1.2 < arg_156_1.time_ and arg_156_1.time_ <= 1.2 + arg_159_0 then
				arg_156_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_lost_city", "")
			end

			if 0.1 < arg_156_1.time_ and arg_156_1.time_ <= 0.1 + arg_159_0 then
				arg_156_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone", "")
			end

			if 1.2 < arg_156_1.time_ and arg_156_1.time_ <= 1.2 + arg_159_0 then
				arg_156_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_battleground", "")
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_16 = 2.96666666666667
			local var_159_17 = 0.375

			if 2.96666666666667 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_18 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_18:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_156_1.dialogCg_.alpha = arg_160_0
				end))
				var_159_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_19 = arg_156_1:GetWordFromCfg(325121038)
				local var_159_20 = arg_156_1:FormatText(var_159_19.content)

				arg_156_1.text_.text = var_159_20

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_22 = 15 <= 0 and var_159_17 or var_159_17 * (utf8.len(var_159_20) / 15)

				if (15 <= 0 and var_159_17 or var_159_17 * (utf8.len(var_159_20) / 15)) > 0 and var_159_17 < var_159_22 then
					arg_156_1.talkMaxDuration = var_159_22
					var_159_16 = var_159_16 + 0.3

					if var_159_22 + var_159_16 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_16
					end
				end

				arg_156_1.text_.text = var_159_20
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121038", "story_v_out_325121.awb") ~= 0 then
					local var_159_23 = manager.audio:GetVoiceLength("story_v_out_325121", "325121038", "story_v_out_325121.awb") / 1000

					if var_159_23 + var_159_16 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_16
					end

					if var_159_19.prefab_name ~= "" and arg_156_1.actors_[var_159_19.prefab_name] ~= nil then
						local var_159_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_19.prefab_name].transform, "story_v_out_325121", "325121038", "story_v_out_325121.awb")

						arg_156_1:RecordAudio("325121038", var_159_24)
						arg_156_1:RecordAudio("325121038", var_159_24)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325121", "325121038", "story_v_out_325121.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325121", "325121038", "story_v_out_325121.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_25 = var_159_16 + 0.3
			local var_159_26 = math.max(var_159_17, arg_156_1.talkMaxDuration)

			if var_159_16 + 0.3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_25 + var_159_26 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_25) / var_159_26

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_25 + var_159_26 and arg_156_1.time_ < var_159_25 + var_159_26 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play325121039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 325121039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play325121040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.5

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(325121039).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 60 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 60)

				if (60 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 60)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play325121040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 325121040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play325121041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 1.025

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_1 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(325121040).content)

				arg_166_1.text_.text = var_169_1

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_3 = 41 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 41)

				if (41 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 41)) > 0 and var_169_0 < var_169_3 then
					arg_166_1.talkMaxDuration = var_169_3

					if var_169_3 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_3 + 0
					end
				end

				arg_166_1.text_.text = var_169_1
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_4 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_4

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play325121041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 325121041
		arg_170_1.duration_ = 12.17

		local var_170_0 = {
			zh = 6.3,
			ja = 12.166
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play325121042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.65

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_1 = arg_170_1:GetWordFromCfg(325121041)
				local var_173_2 = arg_170_1:FormatText(var_173_1.content)

				arg_170_1.text_.text = var_173_2

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 26 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 26)

				if (26 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 26)) > 0 and var_173_0 < var_173_4 then
					arg_170_1.talkMaxDuration = var_173_4

					if var_173_4 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_4 + 0
					end
				end

				arg_170_1.text_.text = var_173_2
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121041", "story_v_out_325121.awb") ~= 0 then
					local var_173_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121041", "story_v_out_325121.awb") / 1000

					if var_173_5 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + 0
					end

					if var_173_1.prefab_name ~= "" and arg_170_1.actors_[var_173_1.prefab_name] ~= nil then
						local var_173_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_1.prefab_name].transform, "story_v_out_325121", "325121041", "story_v_out_325121.awb")

						arg_170_1:RecordAudio("325121041", var_173_6)
						arg_170_1:RecordAudio("325121041", var_173_6)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_325121", "325121041", "story_v_out_325121.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_325121", "325121041", "story_v_out_325121.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_7 and arg_170_1.time_ < 0 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play325121042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 325121042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play325121043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 1.05

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

				local var_177_1 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(325121042).content)

				arg_174_1.text_.text = var_177_1

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_3 = 42 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 42)

				if (42 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 42)) > 0 and var_177_0 < var_177_3 then
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
	Play325121043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 325121043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play325121044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 1.675

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(325121043).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 67 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 67)

				if (67 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 67)) > 0 and var_181_0 < var_181_3 then
					arg_178_1.talkMaxDuration = var_181_3

					if var_181_3 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_3 + 0
					end
				end

				arg_178_1.text_.text = var_181_1
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_4 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_4

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play325121044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 325121044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play325121045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 1.15

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(325121044).content)

				arg_182_1.text_.text = var_185_1

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_3 = 46 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 46)

				if (46 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 46)) > 0 and var_185_0 < var_185_3 then
					arg_182_1.talkMaxDuration = var_185_3

					if var_185_3 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_3 + 0
					end
				end

				arg_182_1.text_.text = var_185_1
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_4 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_4

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play325121045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 325121045
		arg_186_1.duration_ = 11.77

		local var_186_0 = {
			zh = 8.966,
			ja = 11.766
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play325121046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.925

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_1 = arg_186_1:GetWordFromCfg(325121045)
				local var_189_2 = arg_186_1:FormatText(var_189_1.content)

				arg_186_1.text_.text = var_189_2

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 37 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 37)

				if (37 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 37)) > 0 and var_189_0 < var_189_4 then
					arg_186_1.talkMaxDuration = var_189_4

					if var_189_4 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_4 + 0
					end
				end

				arg_186_1.text_.text = var_189_2
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121045", "story_v_out_325121.awb") ~= 0 then
					local var_189_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121045", "story_v_out_325121.awb") / 1000

					if var_189_5 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + 0
					end

					if var_189_1.prefab_name ~= "" and arg_186_1.actors_[var_189_1.prefab_name] ~= nil then
						local var_189_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_1.prefab_name].transform, "story_v_out_325121", "325121045", "story_v_out_325121.awb")

						arg_186_1:RecordAudio("325121045", var_189_6)
						arg_186_1:RecordAudio("325121045", var_189_6)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_325121", "325121045", "story_v_out_325121.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_325121", "325121045", "story_v_out_325121.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play325121046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 325121046
		arg_190_1.duration_ = 7.6

		local var_190_0 = {
			zh = 5,
			ja = 7.6
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play325121047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.55

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_1 = arg_190_1:GetWordFromCfg(325121046)
				local var_193_2 = arg_190_1:FormatText(var_193_1.content)

				arg_190_1.text_.text = var_193_2

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_4 = 22 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 22)

				if (22 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 22)) > 0 and var_193_0 < var_193_4 then
					arg_190_1.talkMaxDuration = var_193_4

					if var_193_4 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_4 + 0
					end
				end

				arg_190_1.text_.text = var_193_2
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121046", "story_v_out_325121.awb") ~= 0 then
					local var_193_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121046", "story_v_out_325121.awb") / 1000

					if var_193_5 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + 0
					end

					if var_193_1.prefab_name ~= "" and arg_190_1.actors_[var_193_1.prefab_name] ~= nil then
						local var_193_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_1.prefab_name].transform, "story_v_out_325121", "325121046", "story_v_out_325121.awb")

						arg_190_1:RecordAudio("325121046", var_193_6)
						arg_190_1:RecordAudio("325121046", var_193_6)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_325121", "325121046", "story_v_out_325121.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_325121", "325121046", "story_v_out_325121.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_7 and arg_190_1.time_ < 0 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play325121047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 325121047
		arg_194_1.duration_ = 4.4

		local var_194_0 = {
			zh = 3.566,
			ja = 4.4
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play325121048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.35

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_1 = arg_194_1:GetWordFromCfg(325121047)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 14 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 14)

				if (14 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 14)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121047", "story_v_out_325121.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121047", "story_v_out_325121.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_325121", "325121047", "story_v_out_325121.awb")

						arg_194_1:RecordAudio("325121047", var_197_6)
						arg_194_1:RecordAudio("325121047", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_325121", "325121047", "story_v_out_325121.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_325121", "325121047", "story_v_out_325121.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play325121048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 325121048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play325121049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0.9

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(325121048).content)

				arg_198_1.text_.text = var_201_1

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_3 = 36 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 36)

				if (36 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 36)) > 0 and var_201_0 < var_201_3 then
					arg_198_1.talkMaxDuration = var_201_3

					if var_201_3 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_3 + 0
					end
				end

				arg_198_1.text_.text = var_201_1
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_4 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_4

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play325121049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 325121049
		arg_202_1.duration_ = 12.33

		local var_202_0 = {
			zh = 9.9,
			ja = 12.333
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play325121050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 1.15

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_1 = arg_202_1:GetWordFromCfg(325121049)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 46 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 46)

				if (46 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 46)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121049", "story_v_out_325121.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121049", "story_v_out_325121.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_325121", "325121049", "story_v_out_325121.awb")

						arg_202_1:RecordAudio("325121049", var_205_6)
						arg_202_1:RecordAudio("325121049", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_325121", "325121049", "story_v_out_325121.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_325121", "325121049", "story_v_out_325121.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play325121050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325121050
		arg_206_1.duration_ = 9.53

		local var_206_0 = {
			zh = 5.333,
			ja = 9.533
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play325121051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.625

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_1 = arg_206_1:GetWordFromCfg(325121050)
				local var_209_2 = arg_206_1:FormatText(var_209_1.content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 25 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 25)

				if (25 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 25)) > 0 and var_209_0 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + 0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121050", "story_v_out_325121.awb") ~= 0 then
					local var_209_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121050", "story_v_out_325121.awb") / 1000

					if var_209_5 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + 0
					end

					if var_209_1.prefab_name ~= "" and arg_206_1.actors_[var_209_1.prefab_name] ~= nil then
						local var_209_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_1.prefab_name].transform, "story_v_out_325121", "325121050", "story_v_out_325121.awb")

						arg_206_1:RecordAudio("325121050", var_209_6)
						arg_206_1:RecordAudio("325121050", var_209_6)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325121", "325121050", "story_v_out_325121.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325121", "325121050", "story_v_out_325121.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play325121051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325121051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play325121052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.625

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(325121051).content)

				arg_210_1.text_.text = var_213_1

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_3 = 51 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 51)

				if (51 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 51)) > 0 and var_213_0 < var_213_3 then
					arg_210_1.talkMaxDuration = var_213_3

					if var_213_3 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_3 + 0
					end
				end

				arg_210_1.text_.text = var_213_1
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_4 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_4

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play325121052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325121052
		arg_214_1.duration_ = 5.87

		local var_214_0 = {
			zh = 4.066,
			ja = 5.866
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play325121053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.45

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:GetWordFromCfg(325121052)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 18 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 18)

				if (18 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 18)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121052", "story_v_out_325121.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121052", "story_v_out_325121.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_325121", "325121052", "story_v_out_325121.awb")

						arg_214_1:RecordAudio("325121052", var_217_6)
						arg_214_1:RecordAudio("325121052", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_325121", "325121052", "story_v_out_325121.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_325121", "325121052", "story_v_out_325121.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play325121053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325121053
		arg_218_1.duration_ = 6.07

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play325121054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if arg_218_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_221_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_218_1.stage_.transform)

				var_221_0.name = "1059ui_story"
				var_221_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.actors_["1059ui_story"] = var_221_0

				local var_221_1 = var_221_0:GetComponentInChildren(typeof(CharacterEffect))

				var_221_1.enabled = true

				local var_221_2 = GameObjectTools.GetOrAddComponent(var_221_0, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(false)
				end

				arg_218_1:ShowWeapon(var_221_1.transform, false)

				arg_218_1.var_["1059ui_story" .. "Animator"] = var_221_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_218_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_218_1.var_["1059ui_story" .. "LipSync"] = var_221_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_221_3 = arg_218_1.actors_["1059ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1059ui_story = var_221_3.localPosition
			end

			local var_221_4 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				var_221_3.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_4)
				var_221_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_3.position).x, (manager.ui.mainCamera.transform.position - var_221_3.position).y, (manager.ui.mainCamera.transform.position - var_221_3.position).z)
				var_221_3.localEulerAngles.z = 0
				var_221_3.localEulerAngles.x = 0
				var_221_3.localEulerAngles = var_221_3.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				var_221_3.localPosition = Vector3.New(0, 100, 0)
				var_221_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_3.position).x, (manager.ui.mainCamera.transform.position - var_221_3.position).y, (manager.ui.mainCamera.transform.position - var_221_3.position).z)
				var_221_3.localEulerAngles.z = 0
				var_221_3.localEulerAngles.x = 0
				var_221_3.localEulerAngles = var_221_3.localEulerAngles
			end

			local var_221_5 = arg_218_1.actors_["1059ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.characterEffect1059ui_story == nil then
				arg_218_1.var_.characterEffect1059ui_story = var_221_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_6 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_6 and not isNil(var_221_5) then
				if arg_218_1.var_.characterEffect1059ui_story and not isNil(var_221_5) then
					arg_218_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_6)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_6 and arg_218_1.time_ < 0 + var_221_6 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.characterEffect1059ui_story then
				arg_218_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_221_7 = 0

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 then
				arg_218_1.allBtn_.enabled = false
			end

			if arg_218_1.time_ >= var_221_7 + 1.53333333333333 and arg_218_1.time_ < var_221_7 + 1.53333333333333 + arg_221_0 then
				arg_218_1.allBtn_.enabled = true
			end

			if 0.3 < arg_218_1.time_ and arg_218_1.time_ <= 0.3 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "se_story_151", "se_story_151_tiger", "")
			end

			if 0.0666666666666669 < arg_218_1.time_ and arg_218_1.time_ <= 0.0666666666666669 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_218_1.frameCnt_ <= 1 then
				arg_218_1.dialog_:SetActive(false)
			end

			local var_221_10 = 1.06666666666667
			local var_221_11 = 0.6

			if 1.06666666666667 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0

				arg_218_1.dialog_:SetActive(true)

				arg_218_1.dialogCg_.alpha = 0

				local var_221_12 = LeanTween.value(arg_218_1.dialog_, 0, 1, 0.3)

				var_221_12:setOnUpdate(LuaHelper.FloatAction(function(arg_222_0)
					arg_218_1.dialogCg_.alpha = arg_222_0
				end))
				var_221_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_218_1.dialog_)
					var_221_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_218_1.duration_ = arg_218_1.duration_ + 0.3

				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_13 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(325121053).content)

				arg_218_1.text_.text = var_221_13

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_15 = 24 <= 0 and var_221_11 or var_221_11 * (utf8.len(var_221_13) / 24)

				if (24 <= 0 and var_221_11 or var_221_11 * (utf8.len(var_221_13) / 24)) > 0 and var_221_11 < var_221_15 then
					arg_218_1.talkMaxDuration = var_221_15
					var_221_10 = var_221_10 + 0.3

					if var_221_15 + var_221_10 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_15 + var_221_10
					end
				end

				arg_218_1.text_.text = var_221_13
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_16 = var_221_10 + 0.3
			local var_221_17 = math.max(var_221_11, arg_218_1.talkMaxDuration)

			if var_221_10 + 0.3 <= arg_218_1.time_ and arg_218_1.time_ < var_221_16 + var_221_17 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_16) / var_221_17

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_16 + var_221_17 and arg_218_1.time_ < var_221_16 + var_221_17 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.06666666666667,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play325121054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 325121054
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play325121055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0.425 < arg_224_1.time_ and arg_224_1.time_ <= 0.425 + arg_227_0 then
				arg_224_1:AudioAction("play", "effect", "se_story_140", "se_story_140_magic", "")
			end

			local var_227_1 = 0
			local var_227_2 = 1.425

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_3 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(325121054).content)

				arg_224_1.text_.text = var_227_3

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 57 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 57)

				if (57 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 57)) > 0 and var_227_2 < var_227_5 then
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
	Play325121055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 325121055
		arg_228_1.duration_ = 6.37

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play325121056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				local var_231_0 = arg_228_1.var_.effectqwewe

				if not arg_228_1.var_.effectqwewe then
					var_231_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), manager.ui.mainCamera.transform)
					var_231_0.name = "qwewe"
					arg_228_1.var_.effectqwewe = var_231_0
				else
					var_231_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_231_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_231_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_231_2 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_231_0.transform.localScale = Vector3.New(var_231_0.transform.localScale.x * var_231_2, var_231_0.transform.localScale.y * var_231_2, var_231_0.transform.localScale.z * var_231_2)
			end

			local var_231_3 = 0

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_3 + arg_231_0 then
				arg_228_1.allBtn_.enabled = false
			end

			if arg_228_1.time_ >= var_231_3 + 1.43333333333333 and arg_228_1.time_ < var_231_3 + 1.43333333333333 + arg_231_0 then
				arg_228_1.allBtn_.enabled = true
			end

			if 0.2 < arg_228_1.time_ and arg_228_1.time_ <= 0.2 + arg_231_0 then
				arg_228_1:AudioAction("play", "effect", "se_story_151", "se_story_151_magic", "")
			end

			if arg_228_1.frameCnt_ <= 1 then
				arg_228_1.dialog_:SetActive(false)
			end

			local var_231_5 = 1.36666666666667
			local var_231_6 = 1.575

			if 1.36666666666667 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0

				arg_228_1.dialog_:SetActive(true)

				arg_228_1.dialogCg_.alpha = 0

				local var_231_7 = LeanTween.value(arg_228_1.dialog_, 0, 1, 0.3)

				var_231_7:setOnUpdate(LuaHelper.FloatAction(function(arg_232_0)
					arg_228_1.dialogCg_.alpha = arg_232_0
				end))
				var_231_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_228_1.dialog_)
					var_231_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_228_1.duration_ = arg_228_1.duration_ + 0.3

				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_8 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(325121055).content)

				arg_228_1.text_.text = var_231_8

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_10 = 63 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_8) / 63)

				if (63 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_8) / 63)) > 0 and var_231_6 < var_231_10 then
					arg_228_1.talkMaxDuration = var_231_10
					var_231_5 = var_231_5 + 0.3

					if var_231_10 + var_231_5 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_5
					end
				end

				arg_228_1.text_.text = var_231_8
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_11 = var_231_5 + 0.3
			local var_231_12 = math.max(var_231_6, arg_228_1.talkMaxDuration)

			if var_231_5 + 0.3 <= arg_228_1.time_ and arg_228_1.time_ < var_231_11 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_11) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_11 + var_231_12 and arg_228_1.time_ < var_231_11 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play325121056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325121056
		arg_234_1.duration_ = 8.97

		local var_234_0 = {
			zh = 8.966,
			ja = 8
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play325121057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1069ui_story = arg_234_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1069ui_story"].transform.position).z)
				arg_234_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1069ui_story"].transform.localEulerAngles = arg_234_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_234_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1069ui_story"].transform.position).z)
				arg_234_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1069ui_story"].transform.localEulerAngles = arg_234_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["1069ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1069ui_story == nil then
				arg_234_1.var_.characterEffect1069ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect1069ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1069ui_story then
				arg_234_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_237_4 = "1077ui_story"

			if arg_234_1.actors_["1077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1077ui_story"))) then
				local var_237_5 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_234_1.stage_.transform)

				var_237_5.name = var_237_4
				var_237_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.actors_[var_237_4] = var_237_5

				local var_237_6 = var_237_5:GetComponentInChildren(typeof(CharacterEffect))

				var_237_6.enabled = true

				local var_237_7 = GameObjectTools.GetOrAddComponent(var_237_5, typeof(DynamicBoneHelper))

				if var_237_7 then
					var_237_7:EnableDynamicBone(false)
				end

				arg_234_1:ShowWeapon(var_237_6.transform, false)

				arg_234_1.var_[var_237_4 .. "Animator"] = var_237_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_234_1.var_[var_237_4 .. "Animator"].applyRootMotion = true
				arg_234_1.var_[var_237_4 .. "LipSync"] = var_237_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if 0.200000002980232 < arg_234_1.time_ and arg_234_1.time_ <= 0.200000002980232 + arg_237_0 then
				arg_234_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_237_10 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_10 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_10

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_10
						arg_234_1.bgmTxt2_.text = var_237_10
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire01", "")
			end

			local var_237_12 = 0
			local var_237_13 = 0.325

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_12 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_14 = arg_234_1:GetWordFromCfg(325121056)
				local var_237_15 = arg_234_1:FormatText(var_237_14.content)

				arg_234_1.text_.text = var_237_15

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_17 = 13 <= 0 and var_237_13 or var_237_13 * (utf8.len(var_237_15) / 13)

				if (13 <= 0 and var_237_13 or var_237_13 * (utf8.len(var_237_15) / 13)) > 0 and var_237_13 < var_237_17 then
					arg_234_1.talkMaxDuration = var_237_17

					if var_237_17 + var_237_12 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_17 + var_237_12
					end
				end

				arg_234_1.text_.text = var_237_15
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121056", "story_v_out_325121.awb") ~= 0 then
					local var_237_18 = manager.audio:GetVoiceLength("story_v_out_325121", "325121056", "story_v_out_325121.awb") / 1000

					if var_237_18 + var_237_12 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_18 + var_237_12
					end

					if var_237_14.prefab_name ~= "" and arg_234_1.actors_[var_237_14.prefab_name] ~= nil then
						local var_237_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_14.prefab_name].transform, "story_v_out_325121", "325121056", "story_v_out_325121.awb")

						arg_234_1:RecordAudio("325121056", var_237_19)
						arg_234_1:RecordAudio("325121056", var_237_19)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_325121", "325121056", "story_v_out_325121.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_325121", "325121056", "story_v_out_325121.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_20 = math.max(var_237_13, arg_234_1.talkMaxDuration)

			if var_237_12 <= arg_234_1.time_ and arg_234_1.time_ < var_237_12 + var_237_20 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_12) / var_237_20

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_12 + var_237_20 and arg_234_1.time_ < var_237_12 + var_237_20 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play325121057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 325121057
		arg_239_1.duration_ = 6.8

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play325121058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_9001
			local var_242_9000

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1069ui_story = arg_239_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1069ui_story"].transform.position).z)
				arg_239_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1069ui_story"].transform.localEulerAngles = arg_239_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1069ui_story"].transform.position).z)
				arg_239_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1069ui_story"].transform.localEulerAngles = arg_239_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1069ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1069ui_story == nil then
				arg_239_1.var_.characterEffect1069ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1069ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_2)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1069ui_story then
				arg_239_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 1.30000000298023 < arg_239_1.time_ and arg_239_1.time_ <= 1.30000000298023 + arg_242_0 then
				local var_242_3 = arg_239_1.var_.effectwqew

				if not arg_239_1.var_.effectwqew then
					var_242_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_242_3.name = "wqew"
					arg_239_1.var_.effectwqew = var_242_3
				else
					var_242_3.transform:SetParent(var_242_9001)
				end

				var_242_3.transform.localPosition = Vector3.New(0, 0, -2.83)
				var_242_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_242_3.transform.localScale = Vector3.New(var_242_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_242_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_242_3.transform.localScale.z)
			end

			local var_242_5 = 0.5666666696469

			if 0.5666666696469 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_6 = 0.733333333333333

			if var_242_5 <= arg_239_1.time_ and arg_239_1.time_ < var_242_5 + var_242_6 then
				local var_242_7 = Color.New(1, 1, 1)

				var_242_7.a = Mathf.Lerp(1, 0, (arg_239_1.time_ - var_242_5) / var_242_6)
				arg_239_1.mask_.color = var_242_7
			end

			if arg_239_1.time_ >= var_242_5 + var_242_6 and arg_239_1.time_ < var_242_5 + var_242_6 + arg_242_0 then
				local var_242_8 = Color.New(1, 1, 1)

				arg_239_1.mask_.enabled = false
				var_242_8.a = 0
				arg_239_1.mask_.color = var_242_8
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				local var_242_9 = arg_239_1.var_.effect321323

				if not arg_239_1.var_.effect321323 then
					var_242_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_explosion"), manager.ui.mainCamera.transform)
					var_242_9.name = "321323"
					arg_239_1.var_.effect321323 = var_242_9
				else
					var_242_9.transform:SetParent(var_242_9000)
				end

				var_242_9.transform.localPosition = Vector3.New(0, 0, 0.04)
				var_242_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_242_9.transform.localScale = Vector3.New(var_242_9.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_242_9.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_242_9.transform.localScale.z)
			end

			local var_242_11 = 1.8
			local var_242_12 = 0.7

			if 1.8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_11 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_13 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(325121057).content)

				arg_239_1.text_.text = var_242_13

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_15 = 28 <= 0 and var_242_12 or var_242_12 * (utf8.len(var_242_13) / 28)

				if (28 <= 0 and var_242_12 or var_242_12 * (utf8.len(var_242_13) / 28)) > 0 and var_242_12 < var_242_15 then
					arg_239_1.talkMaxDuration = var_242_15

					if var_242_15 + var_242_11 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_15 + var_242_11
					end
				end

				arg_239_1.text_.text = var_242_13
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_16 = math.max(var_242_12, arg_239_1.talkMaxDuration)

			if var_242_11 <= arg_239_1.time_ and arg_239_1.time_ < var_242_11 + var_242_16 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_11) / var_242_16

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_11 + var_242_16 and arg_239_1.time_ < var_242_11 + var_242_16 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play325121058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 325121058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play325121059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 1.175

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(325121058).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 47 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 47)

				if (47 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 47)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play325121059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 325121059
		arg_247_1.duration_ = 5.03

		local var_247_0 = {
			zh = 2.266,
			ja = 5.033
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
				arg_247_0:Play325121060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.375

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
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

				local var_250_1 = arg_247_1:GetWordFromCfg(325121059)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 15 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 15)

				if (15 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 15)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121059", "story_v_out_325121.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121059", "story_v_out_325121.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_325121", "325121059", "story_v_out_325121.awb")

						arg_247_1:RecordAudio("325121059", var_250_6)
						arg_247_1:RecordAudio("325121059", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_325121", "325121059", "story_v_out_325121.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_325121", "325121059", "story_v_out_325121.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play325121060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 325121060
		arg_251_1.duration_ = 9.57

		local var_251_0 = {
			zh = 5.666,
			ja = 9.566
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
				arg_251_0:Play325121061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.575

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

				local var_254_1 = arg_251_1:GetWordFromCfg(325121060)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 23 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 23)

				if (23 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 23)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121060", "story_v_out_325121.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121060", "story_v_out_325121.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_325121", "325121060", "story_v_out_325121.awb")

						arg_251_1:RecordAudio("325121060", var_254_6)
						arg_251_1:RecordAudio("325121060", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_325121", "325121060", "story_v_out_325121.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_325121", "325121060", "story_v_out_325121.awb")
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
	Play325121061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 325121061
		arg_255_1.duration_ = 13.57

		local var_255_0 = {
			zh = 10.133,
			ja = 13.566
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play325121062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 1

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(325121061)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 40 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 40)

				if (40 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 40)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325121", "325121061", "story_v_out_325121.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_325121", "325121061", "story_v_out_325121.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_325121", "325121061", "story_v_out_325121.awb")

						arg_255_1:RecordAudio("325121061", var_258_6)
						arg_255_1:RecordAudio("325121061", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_325121", "325121061", "story_v_out_325121.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_325121", "325121061", "story_v_out_325121.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play325121062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 325121062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play325121063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0.5 < arg_259_1.time_ and arg_259_1.time_ <= 0.5 + arg_262_0 then
				arg_259_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_finger", "")
			end

			local var_262_1 = 0
			local var_262_2 = 0.775

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(325121062).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 31 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 31)

				if (31 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 31)) > 0 and var_262_2 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_1
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_6 = math.max(var_262_2, arg_259_1.talkMaxDuration)

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_6 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_1) / var_262_6

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_1 + var_262_6 and arg_259_1.time_ < var_262_1 + var_262_6 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play325121063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 325121063
		arg_263_1.duration_ = 5

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
			local var_266_2 = 0.525

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(325121063).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 21 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 21)

				if (21 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 21)) > 0 and var_266_2 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_6 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_6 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_6

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_6 and arg_263_1.time_ < var_266_1 + var_266_6 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2011",
		"TextureConfig/Background/J02"
	},
	voices = {
		"story_v_out_325121.awb"
	}
}
