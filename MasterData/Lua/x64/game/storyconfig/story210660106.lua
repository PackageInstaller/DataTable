return {
	Play1106606001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106606001
		arg_1_1.duration_ = 6.77

		local var_1_0 = {
			zh = 6,
			ja = 6.766
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
				arg_1_0:Play1106606002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST10 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_4_0.name = "ST10"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST10 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST10

				arg_1_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST10" then
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

			local var_4_8 = "1066ui_story"

			if arg_1_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1066ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.77, -6.1)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1066ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1066ui_story == nil then
				arg_1_1.var_.characterEffect1066ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1066ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1066ui_story then
				arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 0.633333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.633333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 0.4

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(1106606001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 16 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 16)

				if (16 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 16)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606001", "story_v_side_new_1106606.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606001", "story_v_side_new_1106606.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_side_new_1106606", "1106606001", "story_v_side_new_1106606.awb")

						arg_1_1:RecordAudio("1106606001", var_4_31)
						arg_1_1:RecordAudio("1106606001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606001", "story_v_side_new_1106606.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606001", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1106606002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1106606002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1106606003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1066ui_story"]) and arg_9_1.var_.characterEffect1066ui_story == nil then
				arg_9_1.var_.characterEffect1066ui_story = arg_9_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1066ui_story"]) then
				if arg_9_1.var_.characterEffect1066ui_story and not isNil(arg_9_1.actors_["1066ui_story"]) then
					arg_9_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1066ui_story"]) and arg_9_1.var_.characterEffect1066ui_story then
				arg_9_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 1.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1106606002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 48 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 48)

				if (48 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 48)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1106606003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1106606003
		arg_13_1.duration_ = 1.9

		local var_13_0 = {
			zh = 1.9,
			ja = 1.566
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
				arg_13_0:Play1106606004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.15

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(1106606003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 6 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 6)

				if (6 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 6)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606003", "story_v_side_new_1106606.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606003", "story_v_side_new_1106606.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_side_new_1106606", "1106606003", "story_v_side_new_1106606.awb")

						arg_13_1:RecordAudio("1106606003", var_16_6)
						arg_13_1:RecordAudio("1106606003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606003", "story_v_side_new_1106606.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606003", "story_v_side_new_1106606.awb")
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
	Play1106606004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1106606004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1106606005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.05

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1106606004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 42 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 42)

				if (42 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 42)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1106606005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1106606005
		arg_21_1.duration_ = 6.6

		local var_21_0 = {
			zh = 4.733,
			ja = 6.6
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
				arg_21_0:Play1106606006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1066ui_story = arg_21_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1066ui_story"].transform.position).z)
				arg_21_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1066ui_story"].transform.localEulerAngles = arg_21_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_21_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1066ui_story"].transform.position).z)
				arg_21_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1066ui_story"].transform.localEulerAngles = arg_21_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1066ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1066ui_story == nil then
				arg_21_1.var_.characterEffect1066ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1066ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1066ui_story then
				arg_21_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_4 = 0
			local var_24_5 = 0.625

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(1106606005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 25 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 25)

				if (25 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 25)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606005", "story_v_side_new_1106606.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606005", "story_v_side_new_1106606.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_side_new_1106606", "1106606005", "story_v_side_new_1106606.awb")

						arg_21_1:RecordAudio("1106606005", var_24_11)
						arg_21_1:RecordAudio("1106606005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606005", "story_v_side_new_1106606.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606005", "story_v_side_new_1106606.awb")
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

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play1106606006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1106606006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1106606007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1066ui_story"]) and arg_25_1.var_.characterEffect1066ui_story == nil then
				arg_25_1.var_.characterEffect1066ui_story = arg_25_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1066ui_story"]) then
				if arg_25_1.var_.characterEffect1066ui_story and not isNil(arg_25_1.actors_["1066ui_story"]) then
					arg_25_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1066ui_story"]) and arg_25_1.var_.characterEffect1066ui_story then
				arg_25_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.85

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1106606006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 74 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 74)

				if (74 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 74)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1106606007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1106606007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1106606008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.4

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1106606007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 56 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 56)

				if (56 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 56)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1106606008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1106606008
		arg_33_1.duration_ = 3.1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1106606009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1066ui_story = arg_33_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).z)
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles = arg_33_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_33_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).z)
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles = arg_33_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1066ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1066ui_story == nil then
				arg_33_1.var_.characterEffect1066ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1066ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1066ui_story then
				arg_33_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action423")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.275

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(1106606008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 11 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 11)

				if (11 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 11)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606008", "story_v_side_new_1106606.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606008", "story_v_side_new_1106606.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_side_new_1106606", "1106606008", "story_v_side_new_1106606.awb")

						arg_33_1:RecordAudio("1106606008", var_36_11)
						arg_33_1:RecordAudio("1106606008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606008", "story_v_side_new_1106606.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606008", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1106606009
		arg_37_1.duration_ = 2.67

		local var_37_0 = {
			zh = 2.666,
			ja = 1.766
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
				arg_37_0:Play1106606010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1066ui_story"]) and arg_37_1.var_.characterEffect1066ui_story == nil then
				arg_37_1.var_.characterEffect1066ui_story = arg_37_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1066ui_story"]) then
				if arg_37_1.var_.characterEffect1066ui_story and not isNil(arg_37_1.actors_["1066ui_story"]) then
					arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1066ui_story"]) and arg_37_1.var_.characterEffect1066ui_story then
				arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.15

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(1106606009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 6 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 6)

				if (6 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 6)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606009", "story_v_side_new_1106606.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606009", "story_v_side_new_1106606.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_side_new_1106606", "1106606009", "story_v_side_new_1106606.awb")

						arg_37_1:RecordAudio("1106606009", var_40_8)
						arg_37_1:RecordAudio("1106606009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606009", "story_v_side_new_1106606.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606009", "story_v_side_new_1106606.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_9 and arg_37_1.time_ < var_40_1 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1106606010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1106606010
		arg_41_1.duration_ = 3.1

		local var_41_0 = {
			zh = 3.1,
			ja = 2.333
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
				arg_41_0:Play1106606011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1066ui_story = arg_41_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).z)
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles = arg_41_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_41_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).z)
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles = arg_41_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1066ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1066ui_story == nil then
				arg_41_1.var_.characterEffect1066ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1066ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1066ui_story then
				arg_41_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.375

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(1106606010)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606010", "story_v_side_new_1106606.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606010", "story_v_side_new_1106606.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_side_new_1106606", "1106606010", "story_v_side_new_1106606.awb")

						arg_41_1:RecordAudio("1106606010", var_44_11)
						arg_41_1:RecordAudio("1106606010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606010", "story_v_side_new_1106606.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606010", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1106606011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1106606012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1066ui_story"]) and arg_45_1.var_.characterEffect1066ui_story == nil then
				arg_45_1.var_.characterEffect1066ui_story = arg_45_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1066ui_story"]) then
				if arg_45_1.var_.characterEffect1066ui_story and not isNil(arg_45_1.actors_["1066ui_story"]) then
					arg_45_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1066ui_story"]) and arg_45_1.var_.characterEffect1066ui_story then
				arg_45_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.3

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

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1106606011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 12 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 12)

				if (12 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 12)) > 0 and var_48_2 < var_48_5 then
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
	Play1106606012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1106606012
		arg_49_1.duration_ = 5.17

		local var_49_0 = {
			zh = 5.166,
			ja = 4.5
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1106606013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1066ui_story = arg_49_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).z)
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles = arg_49_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_49_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1066ui_story"].transform.position).z)
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1066ui_story"].transform.localEulerAngles = arg_49_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1066ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1066ui_story == nil then
				arg_49_1.var_.characterEffect1066ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1066ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1066ui_story then
				arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_52_4 = 0
			local var_52_5 = 0.575

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(1106606012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 23 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 23)

				if (23 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 23)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606012", "story_v_side_new_1106606.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606012", "story_v_side_new_1106606.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_side_new_1106606", "1106606012", "story_v_side_new_1106606.awb")

						arg_49_1:RecordAudio("1106606012", var_52_11)
						arg_49_1:RecordAudio("1106606012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606012", "story_v_side_new_1106606.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606012", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1106606013
		arg_53_1.duration_ = 1

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"

			SetActive(arg_53_1.choicesGo_, true)

			for iter_54_0, iter_54_1 in ipairs(arg_53_1.choices_) do
				SetActive(iter_54_1.go, iter_54_0 <= 2)
			end

			arg_53_1.choices_[1].txt.text = arg_53_1:FormatText(StoryChoiceCfg[556].name)
			arg_53_1.choices_[2].txt.text = arg_53_1:FormatText(StoryChoiceCfg[557].name)
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1106606014(arg_53_1)
			end

			if arg_55_0 == 2 then
				arg_53_0:Play1106606015(arg_53_1)
			end

			arg_53_1:RecordChoiceLog(1106606013, 556, 557)
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1066ui_story"]) and arg_53_1.var_.characterEffect1066ui_story == nil then
				arg_53_1.var_.characterEffect1066ui_story = arg_53_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1066ui_story"]) then
				if arg_53_1.var_.characterEffect1066ui_story and not isNil(arg_53_1.actors_["1066ui_story"]) then
					arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1066ui_story"]) and arg_53_1.var_.characterEffect1066ui_story then
				arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_1 + 0.5 and arg_53_1.time_ < var_56_1 + 0.5 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1106606014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1106606014
		arg_57_1.duration_ = 5.43

		local var_57_0 = {
			zh = 2.999999999999,
			ja = 5.433
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
				arg_57_0:Play1106606016(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1066ui_story = arg_57_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1066ui_story"].transform.position).z)
				arg_57_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1066ui_story"].transform.localEulerAngles = arg_57_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_57_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1066ui_story"].transform.position).z)
				arg_57_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1066ui_story"].transform.localEulerAngles = arg_57_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1066ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1066ui_story == nil then
				arg_57_1.var_.characterEffect1066ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1066ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1066ui_story then
				arg_57_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action436")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_60_4 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_4 + 3 and arg_57_1.time_ < var_60_4 + 3 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_5 = 0
			local var_60_6 = 0.2

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(1106606014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 8 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 8)

				if (8 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 8)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606014", "story_v_side_new_1106606.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606014", "story_v_side_new_1106606.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_side_new_1106606", "1106606014", "story_v_side_new_1106606.awb")

						arg_57_1:RecordAudio("1106606014", var_60_12)
						arg_57_1:RecordAudio("1106606014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606014", "story_v_side_new_1106606.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606014", "story_v_side_new_1106606.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_13 and arg_57_1.time_ < var_60_5 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play1106606016 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1106606016
		arg_61_1.duration_ = 9.3

		local var_61_0 = {
			zh = 3.066,
			ja = 9.3
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
				arg_61_0:Play1106606017(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1066ui_story = arg_61_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1066ui_story"].transform.position).z)
				arg_61_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1066ui_story"].transform.localEulerAngles = arg_61_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_61_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1066ui_story"].transform.position).z)
				arg_61_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1066ui_story"].transform.localEulerAngles = arg_61_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1066ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1066ui_story == nil then
				arg_61_1.var_.characterEffect1066ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1066ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1066ui_story then
				arg_61_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_4 = 0
			local var_64_5 = 0.275

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(1106606016)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 11 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 11)

				if (11 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 11)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606016", "story_v_side_new_1106606.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606016", "story_v_side_new_1106606.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_side_new_1106606", "1106606016", "story_v_side_new_1106606.awb")

						arg_61_1:RecordAudio("1106606016", var_64_11)
						arg_61_1:RecordAudio("1106606016", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606016", "story_v_side_new_1106606.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606016", "story_v_side_new_1106606.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play1106606017 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1106606017
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1106606018(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1066ui_story"]) and arg_65_1.var_.characterEffect1066ui_story == nil then
				arg_65_1.var_.characterEffect1066ui_story = arg_65_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1066ui_story"]) then
				if arg_65_1.var_.characterEffect1066ui_story and not isNil(arg_65_1.actors_["1066ui_story"]) then
					arg_65_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1066ui_story"]) and arg_65_1.var_.characterEffect1066ui_story then
				arg_65_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 1.55

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

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1106606017).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 62 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 62)

				if (62 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 62)) > 0 and var_68_2 < var_68_5 then
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
	Play1106606018 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1106606018
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1106606019(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.225

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
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

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1106606018).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 49 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 49)

				if (49 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 49)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1106606019 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1106606019
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1106606020(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_76_0 = 0
			local var_76_1 = 0.575

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
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

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_2 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1106606019).content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 23 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_2) / 23)

				if (23 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_2) / 23)) > 0 and var_76_1 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_5 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_5 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_5

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_5 and arg_73_1.time_ < var_76_0 + var_76_5 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1106606020 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1106606020
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1106606021(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.725

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1106606020).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 29 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 29)

				if (29 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 29)) > 0 and var_80_0 < var_80_3 then
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
	Play1106606021 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1106606021
		arg_81_1.duration_ = 3.2

		local var_81_0 = {
			zh = 2.566,
			ja = 3.2
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
				arg_81_0:Play1106606022(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1066ui_story = arg_81_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1066ui_story"].transform.position).z)
				arg_81_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1066ui_story"].transform.localEulerAngles = arg_81_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_81_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1066ui_story"].transform.position).z)
				arg_81_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1066ui_story"].transform.localEulerAngles = arg_81_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1066ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1066ui_story == nil then
				arg_81_1.var_.characterEffect1066ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1066ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1066ui_story then
				arg_81_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_4 = 0
			local var_84_5 = 0.2

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(1106606021)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 8 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 8)

				if (8 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 8)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606021", "story_v_side_new_1106606.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606021", "story_v_side_new_1106606.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_side_new_1106606", "1106606021", "story_v_side_new_1106606.awb")

						arg_81_1:RecordAudio("1106606021", var_84_11)
						arg_81_1:RecordAudio("1106606021", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606021", "story_v_side_new_1106606.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606021", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606022 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1106606022
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1106606023(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1066ui_story"]) and arg_85_1.var_.characterEffect1066ui_story == nil then
				arg_85_1.var_.characterEffect1066ui_story = arg_85_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1066ui_story"]) then
				if arg_85_1.var_.characterEffect1066ui_story and not isNil(arg_85_1.actors_["1066ui_story"]) then
					arg_85_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1066ui_story"]) and arg_85_1.var_.characterEffect1066ui_story then
				arg_85_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.075

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
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

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1106606022).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 3 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 3)

				if (3 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 3)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1106606023 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1106606023
		arg_89_1.duration_ = 16.27

		local var_89_0 = {
			zh = 2.8,
			ja = 16.266
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
				arg_89_0:Play1106606024(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1066ui_story = arg_89_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1066ui_story"].transform.position).z)
				arg_89_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1066ui_story"].transform.localEulerAngles = arg_89_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_89_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1066ui_story"].transform.position).z)
				arg_89_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1066ui_story"].transform.localEulerAngles = arg_89_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1066ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1066ui_story == nil then
				arg_89_1.var_.characterEffect1066ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1066ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1066ui_story then
				arg_89_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_92_4 = 0
			local var_92_5 = 0.325

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(1106606023)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 13 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 13)

				if (13 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 13)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606023", "story_v_side_new_1106606.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606023", "story_v_side_new_1106606.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_side_new_1106606", "1106606023", "story_v_side_new_1106606.awb")

						arg_89_1:RecordAudio("1106606023", var_92_11)
						arg_89_1:RecordAudio("1106606023", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606023", "story_v_side_new_1106606.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606023", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606024 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1106606024
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1106606025(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1066ui_story"]) and arg_93_1.var_.characterEffect1066ui_story == nil then
				arg_93_1.var_.characterEffect1066ui_story = arg_93_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1066ui_story"]) then
				if arg_93_1.var_.characterEffect1066ui_story and not isNil(arg_93_1.actors_["1066ui_story"]) then
					arg_93_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1066ui_story"]) and arg_93_1.var_.characterEffect1066ui_story then
				arg_93_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.275

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

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1106606024).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 11 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 11)

				if (11 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 11)) > 0 and var_96_2 < var_96_5 then
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
	Play1106606025 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1106606025
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1106606026(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.15

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

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1106606025).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 46 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 46)

				if (46 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 46)) > 0 and var_100_0 < var_100_3 then
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
	Play1106606026 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1106606026
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1106606027(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.275

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
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

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1106606026).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 11 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 11)

				if (11 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 11)) > 0 and var_104_0 < var_104_3 then
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
	Play1106606027 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1106606027
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1106606028(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1106606027).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 16 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 16)

				if (16 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 16)) > 0 and var_108_0 < var_108_3 then
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
	Play1106606028 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1106606028
		arg_109_1.duration_ = 7.93

		local var_109_0 = {
			zh = 6.3,
			ja = 7.933
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
				arg_109_0:Play1106606029(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1066ui_story = arg_109_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1066ui_story"].transform.position).z)
				arg_109_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1066ui_story"].transform.localEulerAngles = arg_109_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_109_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1066ui_story"].transform.position).z)
				arg_109_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1066ui_story"].transform.localEulerAngles = arg_109_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1066ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1066ui_story == nil then
				arg_109_1.var_.characterEffect1066ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1066ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1066ui_story then
				arg_109_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.45

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(1106606028)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 18 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 18)

				if (18 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 18)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606028", "story_v_side_new_1106606.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606028", "story_v_side_new_1106606.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_side_new_1106606", "1106606028", "story_v_side_new_1106606.awb")

						arg_109_1:RecordAudio("1106606028", var_112_11)
						arg_109_1:RecordAudio("1106606028", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606028", "story_v_side_new_1106606.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606028", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606029 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1106606029
		arg_113_1.duration_ = 7.13

		local var_113_0 = {
			zh = 7.133,
			ja = 5.833
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
				arg_113_0:Play1106606030(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1066ui_story = arg_113_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1066ui_story"].transform.position).z)
				arg_113_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1066ui_story"].transform.localEulerAngles = arg_113_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_113_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1066ui_story"].transform.position).z)
				arg_113_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1066ui_story"].transform.localEulerAngles = arg_113_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1066ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1066ui_story == nil then
				arg_113_1.var_.characterEffect1066ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1066ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1066ui_story then
				arg_113_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_116_4 = 0
			local var_116_5 = 0.8

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(1106606029)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 32 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 32)

				if (32 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 32)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606029", "story_v_side_new_1106606.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606029", "story_v_side_new_1106606.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_side_new_1106606", "1106606029", "story_v_side_new_1106606.awb")

						arg_113_1:RecordAudio("1106606029", var_116_11)
						arg_113_1:RecordAudio("1106606029", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606029", "story_v_side_new_1106606.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606029", "story_v_side_new_1106606.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play1106606030 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1106606030
		arg_117_1.duration_ = 9

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1106606031(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 2 < arg_117_1.time_ and arg_117_1.time_ <= 2 + arg_120_0 then
				local var_120_0 = arg_117_1.bgs_.ST10

				arg_117_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_1 = var_120_0:GetComponent("SpriteRenderer")

				if var_120_1 and var_120_1.sprite then
					local var_120_2 = 2 * (var_120_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_0.transform.localScale = Vector3.New(var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "ST10" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_3 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_4 = 2

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_4 then
				local var_120_5 = Color.New(0, 0, 0)

				var_120_5.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_3) / var_120_4)
				arg_117_1.mask_.color = var_120_5
			end

			if arg_117_1.time_ >= var_120_3 + var_120_4 and arg_117_1.time_ < var_120_3 + var_120_4 + arg_120_0 then
				local var_120_6 = Color.New(0, 0, 0)

				var_120_6.a = 1
				arg_117_1.mask_.color = var_120_6
			end

			local var_120_7 = 2

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_8 = 2

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_8 then
				local var_120_9 = Color.New(0, 0, 0)

				var_120_9.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_7) / var_120_8)
				arg_117_1.mask_.color = var_120_9
			end

			if arg_117_1.time_ >= var_120_7 + var_120_8 and arg_117_1.time_ < var_120_7 + var_120_8 + arg_120_0 then
				local var_120_10 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_10.a = 0
				arg_117_1.mask_.color = var_120_10
			end

			local var_120_11 = arg_117_1.actors_["1066ui_story"].transform

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= 2 + arg_120_0 then
				arg_117_1.var_.moveOldPos1066ui_story = var_120_11.localPosition
			end

			local var_120_12 = 0.001

			if 2 <= arg_117_1.time_ and arg_117_1.time_ < 2 + var_120_12 then
				var_120_11.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 2) / var_120_12)
				var_120_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_11.position).x, (manager.ui.mainCamera.transform.position - var_120_11.position).y, (manager.ui.mainCamera.transform.position - var_120_11.position).z)
				var_120_11.localEulerAngles.z = 0
				var_120_11.localEulerAngles.x = 0
				var_120_11.localEulerAngles = var_120_11.localEulerAngles
			end

			if arg_117_1.time_ >= 2 + var_120_12 and arg_117_1.time_ < 2 + var_120_12 + arg_120_0 then
				var_120_11.localPosition = Vector3.New(0, 100, 0)
				var_120_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_11.position).x, (manager.ui.mainCamera.transform.position - var_120_11.position).y, (manager.ui.mainCamera.transform.position - var_120_11.position).z)
				var_120_11.localEulerAngles.z = 0
				var_120_11.localEulerAngles.x = 0
				var_120_11.localEulerAngles = var_120_11.localEulerAngles
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_13 = 4
			local var_120_14 = 0.975

			if 4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_15 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_15:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_16 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1106606030).content)

				arg_117_1.text_.text = var_120_16

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_18 = 39 <= 0 and var_120_14 or var_120_14 * (utf8.len(var_120_16) / 39)

				if (39 <= 0 and var_120_14 or var_120_14 * (utf8.len(var_120_16) / 39)) > 0 and var_120_14 < var_120_18 then
					arg_117_1.talkMaxDuration = var_120_18
					var_120_13 = var_120_13 + 0.3

					if var_120_18 + var_120_13 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_13
					end
				end

				arg_117_1.text_.text = var_120_16
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_19 = var_120_13 + 0.3
			local var_120_20 = math.max(var_120_14, arg_117_1.talkMaxDuration)

			if var_120_13 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_19 + var_120_20 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_19) / var_120_20

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_19 + var_120_20 and arg_117_1.time_ < var_120_19 + var_120_20 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play1106606031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1106606031
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1106606032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1.7

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1106606031).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 68 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 68)

				if (68 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 68)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1106606032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1106606032
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1106606033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.725

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
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

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1106606032).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 29 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 29)

				if (29 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 29)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1106606033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1106606033
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1106606034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1.125

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

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1106606033).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 45 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 45)

				if (45 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 45)) > 0 and var_134_0 < var_134_3 then
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
	Play1106606034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1106606034
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1106606035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.675

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

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1106606034).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 27 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 27)

				if (27 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 27)) > 0 and var_138_0 < var_138_3 then
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
	Play1106606035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1106606035
		arg_139_1.duration_ = 2.23

		local var_139_0 = {
			zh = 2.233,
			ja = 1.999999999999
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
				arg_139_0:Play1106606036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1066ui_story = arg_139_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1066ui_story"].transform.position).z)
				arg_139_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1066ui_story"].transform.localEulerAngles = arg_139_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_139_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1066ui_story"].transform.position).z)
				arg_139_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1066ui_story"].transform.localEulerAngles = arg_139_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1066ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1066ui_story == nil then
				arg_139_1.var_.characterEffect1066ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1066ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1066ui_story then
				arg_139_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_142_4 = 0
			local var_142_5 = 0.125

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[579].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(1106606035)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 5 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 5)

				if (5 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 5)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606035", "story_v_side_new_1106606.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606035", "story_v_side_new_1106606.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_side_new_1106606", "1106606035", "story_v_side_new_1106606.awb")

						arg_139_1:RecordAudio("1106606035", var_142_11)
						arg_139_1:RecordAudio("1106606035", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606035", "story_v_side_new_1106606.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606035", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606036 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1106606036
		arg_143_1.duration_ = 4.3

		local var_143_0 = {
			zh = 3.8,
			ja = 4.3
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
				arg_143_0:Play1106606037(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1066ui_story = arg_143_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).z)
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles = arg_143_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_143_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).z)
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles = arg_143_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_1 = 0
			local var_146_2 = 0.45

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(1106606036)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 18 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 18)

				if (18 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 18)) > 0 and var_146_2 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606036", "story_v_side_new_1106606.awb") ~= 0 then
					local var_146_7 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606036", "story_v_side_new_1106606.awb") / 1000

					if var_146_7 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_1
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_side_new_1106606", "1106606036", "story_v_side_new_1106606.awb")

						arg_143_1:RecordAudio("1106606036", var_146_8)
						arg_143_1:RecordAudio("1106606036", var_146_8)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606036", "story_v_side_new_1106606.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606036", "story_v_side_new_1106606.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_9 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_9 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_9

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_9 and arg_143_1.time_ < var_146_1 + var_146_9 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play1106606037 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1106606037
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1106606038(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1066ui_story"]) and arg_147_1.var_.characterEffect1066ui_story == nil then
				arg_147_1.var_.characterEffect1066ui_story = arg_147_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1066ui_story"]) then
				if arg_147_1.var_.characterEffect1066ui_story and not isNil(arg_147_1.actors_["1066ui_story"]) then
					arg_147_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1066ui_story"]) and arg_147_1.var_.characterEffect1066ui_story then
				arg_147_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.65

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
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

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1106606037).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 26 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 26)

				if (26 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 26)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1106606038 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1106606038
		arg_151_1.duration_ = 2.37

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1106606039(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1066ui_story = arg_151_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).z)
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles = arg_151_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_151_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).z)
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles = arg_151_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1066ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1066ui_story == nil then
				arg_151_1.var_.characterEffect1066ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1066ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1066ui_story then
				arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_154_4 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			if arg_151_1.time_ >= var_154_4 + 2.36666666666667 and arg_151_1.time_ < var_154_4 + 2.36666666666667 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_5 = 0
			local var_154_6 = 0.25

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(1106606038)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 10 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 10)

				if (10 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 10)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606038", "story_v_side_new_1106606.awb") ~= 0 then
					local var_154_11 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606038", "story_v_side_new_1106606.awb") / 1000

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_side_new_1106606", "1106606038", "story_v_side_new_1106606.awb")

						arg_151_1:RecordAudio("1106606038", var_154_12)
						arg_151_1:RecordAudio("1106606038", var_154_12)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606038", "story_v_side_new_1106606.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606038", "story_v_side_new_1106606.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_13 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_13 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_5) / var_154_13

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_5 + var_154_13 and arg_151_1.time_ < var_154_5 + var_154_13 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play1106606039 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1106606039
		arg_155_1.duration_ = 12.17

		local var_155_0 = {
			zh = 8.466,
			ja = 12.166
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1106606040(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_158_0 = 0
			local var_158_1 = 1.05

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(1106606039)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 42 <= 0 and var_158_1 or var_158_1 * (utf8.len(var_158_3) / 42)

				if (42 <= 0 and var_158_1 or var_158_1 * (utf8.len(var_158_3) / 42)) > 0 and var_158_1 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606039", "story_v_side_new_1106606.awb") ~= 0 then
					local var_158_6 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606039", "story_v_side_new_1106606.awb") / 1000

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end

					if var_158_2.prefab_name ~= "" and arg_155_1.actors_[var_158_2.prefab_name] ~= nil then
						local var_158_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_2.prefab_name].transform, "story_v_side_new_1106606", "1106606039", "story_v_side_new_1106606.awb")

						arg_155_1:RecordAudio("1106606039", var_158_7)
						arg_155_1:RecordAudio("1106606039", var_158_7)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606039", "story_v_side_new_1106606.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606039", "story_v_side_new_1106606.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_8 and arg_155_1.time_ < var_158_0 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1106606040 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1106606040
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1106606041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1066ui_story"]) and arg_159_1.var_.characterEffect1066ui_story == nil then
				arg_159_1.var_.characterEffect1066ui_story = arg_159_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1066ui_story"]) then
				if arg_159_1.var_.characterEffect1066ui_story and not isNil(arg_159_1.actors_["1066ui_story"]) then
					arg_159_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1066ui_story"]) and arg_159_1.var_.characterEffect1066ui_story then
				arg_159_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 0.25

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
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

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1106606040).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 10 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 10)

				if (10 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 10)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1106606041 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1106606041
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1106606042(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1066ui_story = arg_163_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1066ui_story"].transform.position).z)
				arg_163_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1066ui_story"].transform.localEulerAngles = arg_163_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1066ui_story"].transform.position).z)
				arg_163_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1066ui_story"].transform.localEulerAngles = arg_163_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_166_1 = 0
			local var_166_2 = 0.775

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(1106606041).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 31 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 31)

				if (31 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 31)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play1106606042 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1106606042
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1106606043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.7

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

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1106606042).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 28 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 28)

				if (28 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 28)) > 0 and var_170_0 < var_170_3 then
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
	Play1106606043 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1106606043
		arg_171_1.duration_ = 6.4

		local var_171_0 = {
			zh = 6.4,
			ja = 6.1
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
				arg_171_0:Play1106606044(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1066ui_story = arg_171_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).z)
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles = arg_171_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_171_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).z)
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles = arg_171_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1066ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1066ui_story == nil then
				arg_171_1.var_.characterEffect1066ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1066ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1066ui_story then
				arg_171_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_174_4 = 0
			local var_174_5 = 0.7

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(1106606043)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 28 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 28)

				if (28 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 28)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606043", "story_v_side_new_1106606.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606043", "story_v_side_new_1106606.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_side_new_1106606", "1106606043", "story_v_side_new_1106606.awb")

						arg_171_1:RecordAudio("1106606043", var_174_11)
						arg_171_1:RecordAudio("1106606043", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606043", "story_v_side_new_1106606.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606043", "story_v_side_new_1106606.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_12 and arg_171_1.time_ < var_174_4 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play1106606044 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1106606044
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1106606045(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1066ui_story"]) and arg_175_1.var_.characterEffect1066ui_story == nil then
				arg_175_1.var_.characterEffect1066ui_story = arg_175_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1066ui_story"]) then
				if arg_175_1.var_.characterEffect1066ui_story and not isNil(arg_175_1.actors_["1066ui_story"]) then
					arg_175_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1066ui_story"]) and arg_175_1.var_.characterEffect1066ui_story then
				arg_175_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.25

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
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

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1106606044).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 10 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 10)

				if (10 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 10)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_6 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_6 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_6

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_6 and arg_175_1.time_ < var_178_1 + var_178_6 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1106606045 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1106606045
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1106606046(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.775

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1106606045).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 31 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 31)

				if (31 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 31)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1106606046 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1106606046
		arg_183_1.duration_ = 5

		local var_183_0 = {
			zh = 4.7,
			ja = 5
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
				arg_183_0:Play1106606047(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1066ui_story = arg_183_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1066ui_story"].transform.position).z)
				arg_183_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1066ui_story"].transform.localEulerAngles = arg_183_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_183_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1066ui_story"].transform.position).z)
				arg_183_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1066ui_story"].transform.localEulerAngles = arg_183_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1066ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1066ui_story == nil then
				arg_183_1.var_.characterEffect1066ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1066ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1066ui_story then
				arg_183_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_186_4 = 0
			local var_186_5 = 0.475

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(1106606046)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 19 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 19)

				if (19 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 19)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606046", "story_v_side_new_1106606.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606046", "story_v_side_new_1106606.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_side_new_1106606", "1106606046", "story_v_side_new_1106606.awb")

						arg_183_1:RecordAudio("1106606046", var_186_11)
						arg_183_1:RecordAudio("1106606046", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606046", "story_v_side_new_1106606.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606046", "story_v_side_new_1106606.awb")
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

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play1106606047 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1106606047
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1106606048(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1066ui_story"]) and arg_187_1.var_.characterEffect1066ui_story == nil then
				arg_187_1.var_.characterEffect1066ui_story = arg_187_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1066ui_story"]) then
				if arg_187_1.var_.characterEffect1066ui_story and not isNil(arg_187_1.actors_["1066ui_story"]) then
					arg_187_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1066ui_story"]) and arg_187_1.var_.characterEffect1066ui_story then
				arg_187_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.35

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1106606047).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 14 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 14)

				if (14 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 14)) > 0 and var_190_2 < var_190_5 then
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
	Play1106606048 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1106606048
		arg_191_1.duration_ = 10.47

		local var_191_0 = {
			zh = 6.366,
			ja = 10.466
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
				arg_191_0:Play1106606049(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1066ui_story = arg_191_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1066ui_story"].transform.position).z)
				arg_191_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1066ui_story"].transform.localEulerAngles = arg_191_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_191_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1066ui_story"].transform.position).z)
				arg_191_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1066ui_story"].transform.localEulerAngles = arg_191_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1066ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1066ui_story == nil then
				arg_191_1.var_.characterEffect1066ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1066ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1066ui_story then
				arg_191_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_4 = 0
			local var_194_5 = 0.75

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(1106606048)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 30 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 30)

				if (30 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 30)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606048", "story_v_side_new_1106606.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606048", "story_v_side_new_1106606.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_side_new_1106606", "1106606048", "story_v_side_new_1106606.awb")

						arg_191_1:RecordAudio("1106606048", var_194_11)
						arg_191_1:RecordAudio("1106606048", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606048", "story_v_side_new_1106606.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606048", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606049 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1106606049
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1106606050(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1066ui_story"]) and arg_195_1.var_.characterEffect1066ui_story == nil then
				arg_195_1.var_.characterEffect1066ui_story = arg_195_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1066ui_story"]) then
				if arg_195_1.var_.characterEffect1066ui_story and not isNil(arg_195_1.actors_["1066ui_story"]) then
					arg_195_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1066ui_story"]) and arg_195_1.var_.characterEffect1066ui_story then
				arg_195_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.85

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1106606049).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 34 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 34)

				if (34 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 34)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1106606050 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1106606050
		arg_199_1.duration_ = 5.57

		local var_199_0 = {
			zh = 1.999999999999,
			ja = 5.566
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
				arg_199_0:Play1106606051(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1066ui_story = arg_199_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1066ui_story"].transform.position).z)
				arg_199_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1066ui_story"].transform.localEulerAngles = arg_199_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_199_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1066ui_story"].transform.position).z)
				arg_199_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1066ui_story"].transform.localEulerAngles = arg_199_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1066ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1066ui_story == nil then
				arg_199_1.var_.characterEffect1066ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1066ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1066ui_story then
				arg_199_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_202_4 = 0
			local var_202_5 = 0.15

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(1106606050)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 6 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 6)

				if (6 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 6)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606050", "story_v_side_new_1106606.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606050", "story_v_side_new_1106606.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_side_new_1106606", "1106606050", "story_v_side_new_1106606.awb")

						arg_199_1:RecordAudio("1106606050", var_202_11)
						arg_199_1:RecordAudio("1106606050", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606050", "story_v_side_new_1106606.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606050", "story_v_side_new_1106606.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play1106606051 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1106606051
		arg_203_1.duration_ = 9

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1106606052(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				local var_206_0 = arg_203_1.bgs_.ST10

				arg_203_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_1 = var_206_0:GetComponent("SpriteRenderer")

				if var_206_1 and var_206_1.sprite then
					local var_206_2 = 2 * (var_206_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_0.transform.localScale = Vector3.New(var_206_2 / var_206_1.sprite.bounds.size.y < var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x and var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x or var_206_2 / var_206_1.sprite.bounds.size.y, var_206_2 / var_206_1.sprite.bounds.size.y < var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x and var_206_2 * manager.ui.mainCameraCom_.aspect / var_206_1.sprite.bounds.size.x or var_206_2 / var_206_1.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "ST10" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_3 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_3 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_4 = 2

			if var_206_3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_3 + var_206_4 then
				local var_206_5 = Color.New(0, 0, 0)

				var_206_5.a = Mathf.Lerp(0, 1, (arg_203_1.time_ - var_206_3) / var_206_4)
				arg_203_1.mask_.color = var_206_5
			end

			if arg_203_1.time_ >= var_206_3 + var_206_4 and arg_203_1.time_ < var_206_3 + var_206_4 + arg_206_0 then
				local var_206_6 = Color.New(0, 0, 0)

				var_206_6.a = 1
				arg_203_1.mask_.color = var_206_6
			end

			local var_206_7 = 2

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_8 = 2

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_8 then
				local var_206_9 = Color.New(0, 0, 0)

				var_206_9.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_7) / var_206_8)
				arg_203_1.mask_.color = var_206_9
			end

			if arg_203_1.time_ >= var_206_7 + var_206_8 and arg_203_1.time_ < var_206_7 + var_206_8 + arg_206_0 then
				local var_206_10 = Color.New(0, 0, 0)

				arg_203_1.mask_.enabled = false
				var_206_10.a = 0
				arg_203_1.mask_.color = var_206_10
			end

			local var_206_11 = arg_203_1.actors_["1066ui_story"].transform

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				arg_203_1.var_.moveOldPos1066ui_story = var_206_11.localPosition
			end

			local var_206_12 = 0.001

			if 2 <= arg_203_1.time_ and arg_203_1.time_ < 2 + var_206_12 then
				var_206_11.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 2) / var_206_12)
				var_206_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_11.position).x, (manager.ui.mainCamera.transform.position - var_206_11.position).y, (manager.ui.mainCamera.transform.position - var_206_11.position).z)
				var_206_11.localEulerAngles.z = 0
				var_206_11.localEulerAngles.x = 0
				var_206_11.localEulerAngles = var_206_11.localEulerAngles
			end

			if arg_203_1.time_ >= 2 + var_206_12 and arg_203_1.time_ < 2 + var_206_12 + arg_206_0 then
				var_206_11.localPosition = Vector3.New(0, 100, 0)
				var_206_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_11.position).x, (manager.ui.mainCamera.transform.position - var_206_11.position).y, (manager.ui.mainCamera.transform.position - var_206_11.position).z)
				var_206_11.localEulerAngles.z = 0
				var_206_11.localEulerAngles.x = 0
				var_206_11.localEulerAngles = var_206_11.localEulerAngles
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_13 = 4
			local var_206_14 = 1.125

			if 4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_15 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_15:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_16 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(1106606051).content)

				arg_203_1.text_.text = var_206_16

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_18 = 45 <= 0 and var_206_14 or var_206_14 * (utf8.len(var_206_16) / 45)

				if (45 <= 0 and var_206_14 or var_206_14 * (utf8.len(var_206_16) / 45)) > 0 and var_206_14 < var_206_18 then
					arg_203_1.talkMaxDuration = var_206_18
					var_206_13 = var_206_13 + 0.3

					if var_206_18 + var_206_13 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_18 + var_206_13
					end
				end

				arg_203_1.text_.text = var_206_16
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_19 = var_206_13 + 0.3
			local var_206_20 = math.max(var_206_14, arg_203_1.talkMaxDuration)

			if var_206_13 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_19 + var_206_20 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_19) / var_206_20

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_19 + var_206_20 and arg_203_1.time_ < var_206_19 + var_206_20 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play1106606052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1106606052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1106606053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.625

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1106606052).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 65 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 65)

				if (65 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 65)) > 0 and var_212_0 < var_212_3 then
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
	Play1106606053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1106606053
		arg_213_1.duration_ = 1.97

		local var_213_0 = {
			zh = 1.633,
			ja = 1.966
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1106606054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1066ui_story = arg_213_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1066ui_story"].transform.position).z)
				arg_213_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1066ui_story"].transform.localEulerAngles = arg_213_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_213_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1066ui_story"].transform.position).z)
				arg_213_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1066ui_story"].transform.localEulerAngles = arg_213_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1066ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1066ui_story == nil then
				arg_213_1.var_.characterEffect1066ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1066ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1066ui_story then
				arg_213_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_4 = 0
			local var_216_5 = 0.15

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(1106606053)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 6 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 6)

				if (6 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 6)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606053", "story_v_side_new_1106606.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606053", "story_v_side_new_1106606.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_side_new_1106606", "1106606053", "story_v_side_new_1106606.awb")

						arg_213_1:RecordAudio("1106606053", var_216_11)
						arg_213_1:RecordAudio("1106606053", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606053", "story_v_side_new_1106606.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606053", "story_v_side_new_1106606.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play1106606054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1106606054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1106606055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1066ui_story"]) and arg_217_1.var_.characterEffect1066ui_story == nil then
				arg_217_1.var_.characterEffect1066ui_story = arg_217_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1066ui_story"]) then
				if arg_217_1.var_.characterEffect1066ui_story and not isNil(arg_217_1.actors_["1066ui_story"]) then
					arg_217_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1066ui_story"]) and arg_217_1.var_.characterEffect1066ui_story then
				arg_217_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 0.35

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1106606054).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 14 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 14)

				if (14 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 14)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1106606055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1106606055
		arg_221_1.duration_ = 3.77

		local var_221_0 = {
			zh = 3.766,
			ja = 2.033
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1106606056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1066ui_story = arg_221_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1066ui_story"].transform.position).z)
				arg_221_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1066ui_story"].transform.localEulerAngles = arg_221_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_221_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1066ui_story"].transform.position).z)
				arg_221_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1066ui_story"].transform.localEulerAngles = arg_221_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1066ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1066ui_story == nil then
				arg_221_1.var_.characterEffect1066ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1066ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1066ui_story then
				arg_221_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_224_4 = 0
			local var_224_5 = 0.425

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(1106606055)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 17 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 17)

				if (17 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 17)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606055", "story_v_side_new_1106606.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606055", "story_v_side_new_1106606.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_side_new_1106606", "1106606055", "story_v_side_new_1106606.awb")

						arg_221_1:RecordAudio("1106606055", var_224_11)
						arg_221_1:RecordAudio("1106606055", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606055", "story_v_side_new_1106606.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606055", "story_v_side_new_1106606.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play1106606056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1106606056
		arg_225_1.duration_ = 3.63

		local var_225_0 = {
			zh = 3.633,
			ja = 3.5
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1106606057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1066ui_story = arg_225_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1066ui_story"].transform.position).z)
				arg_225_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1066ui_story"].transform.localEulerAngles = arg_225_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_225_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1066ui_story"].transform.position).z)
				arg_225_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1066ui_story"].transform.localEulerAngles = arg_225_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1066ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1066ui_story == nil then
				arg_225_1.var_.characterEffect1066ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1066ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1066ui_story then
				arg_225_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_228_4 = 0
			local var_228_5 = 0.3

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(1106606056)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 12 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 12)

				if (12 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 12)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606056", "story_v_side_new_1106606.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606056", "story_v_side_new_1106606.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_side_new_1106606", "1106606056", "story_v_side_new_1106606.awb")

						arg_225_1:RecordAudio("1106606056", var_228_11)
						arg_225_1:RecordAudio("1106606056", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606056", "story_v_side_new_1106606.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606056", "story_v_side_new_1106606.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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

		arg_225_1:InitPlayNodeList()
	end,
	Play1106606057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1106606057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1106606058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1066ui_story"]) and arg_229_1.var_.characterEffect1066ui_story == nil then
				arg_229_1.var_.characterEffect1066ui_story = arg_229_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1066ui_story"]) then
				if arg_229_1.var_.characterEffect1066ui_story and not isNil(arg_229_1.actors_["1066ui_story"]) then
					arg_229_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1066ui_story"]) and arg_229_1.var_.characterEffect1066ui_story then
				arg_229_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 1.05

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(1106606057).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 42 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 42)

				if (42 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 42)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1106606058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1106606058
		arg_233_1.duration_ = 2.53

		local var_233_0 = {
			zh = 2.533,
			ja = 1.999999999999
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
				arg_233_0:Play1106606059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1066ui_story = arg_233_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).z)
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles = arg_233_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_233_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1066ui_story"].transform.position).z)
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1066ui_story"].transform.localEulerAngles = arg_233_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1066ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1066ui_story == nil then
				arg_233_1.var_.characterEffect1066ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1066ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1066ui_story then
				arg_233_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_4 = 0
			local var_236_5 = 0.25

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(1106606058)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 10 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 10)

				if (10 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 10)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606058", "story_v_side_new_1106606.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606058", "story_v_side_new_1106606.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_side_new_1106606", "1106606058", "story_v_side_new_1106606.awb")

						arg_233_1:RecordAudio("1106606058", var_236_11)
						arg_233_1:RecordAudio("1106606058", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606058", "story_v_side_new_1106606.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606058", "story_v_side_new_1106606.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play1106606059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1106606059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1106606060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1066ui_story"]) and arg_237_1.var_.characterEffect1066ui_story == nil then
				arg_237_1.var_.characterEffect1066ui_story = arg_237_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1066ui_story"]) then
				if arg_237_1.var_.characterEffect1066ui_story and not isNil(arg_237_1.actors_["1066ui_story"]) then
					arg_237_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1066ui_story"]) and arg_237_1.var_.characterEffect1066ui_story then
				arg_237_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.625

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(1106606059).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 25 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 25)

				if (25 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 25)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1106606060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1106606060
		arg_241_1.duration_ = 6.83

		local var_241_0 = {
			zh = 6.833,
			ja = 6.366
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
				arg_241_0:Play1106606061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1066ui_story = arg_241_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1066ui_story"].transform.position).z)
				arg_241_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1066ui_story"].transform.localEulerAngles = arg_241_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_241_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1066ui_story"].transform.position).z)
				arg_241_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1066ui_story"].transform.localEulerAngles = arg_241_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1066ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1066ui_story == nil then
				arg_241_1.var_.characterEffect1066ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1066ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1066ui_story then
				arg_241_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_244_4 = 0
			local var_244_5 = 0.775

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(1106606060)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 31 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 31)

				if (31 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 31)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606060", "story_v_side_new_1106606.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606060", "story_v_side_new_1106606.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_side_new_1106606", "1106606060", "story_v_side_new_1106606.awb")

						arg_241_1:RecordAudio("1106606060", var_244_11)
						arg_241_1:RecordAudio("1106606060", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606060", "story_v_side_new_1106606.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606060", "story_v_side_new_1106606.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play1106606061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1106606061
		arg_245_1.duration_ = 9

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1106606062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 2 < arg_245_1.time_ and arg_245_1.time_ <= 2 + arg_248_0 then
				local var_248_0 = arg_245_1.bgs_.ST10

				arg_245_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_248_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_1 = var_248_0:GetComponent("SpriteRenderer")

				if var_248_1 and var_248_1.sprite then
					local var_248_2 = 2 * (var_248_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_248_0.transform.localScale = Vector3.New(var_248_2 / var_248_1.sprite.bounds.size.y < var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x and var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x or var_248_2 / var_248_1.sprite.bounds.size.y, var_248_2 / var_248_1.sprite.bounds.size.y < var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x and var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x or var_248_2 / var_248_1.sprite.bounds.size.y, 0)
				end

				for iter_248_0, iter_248_1 in pairs(arg_245_1.bgs_) do
					if iter_248_0 ~= "ST10" then
						iter_248_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_3 = 0

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_3 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_4 = 2

			if var_248_3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_3 + var_248_4 then
				local var_248_5 = Color.New(0, 0, 0)

				var_248_5.a = Mathf.Lerp(0, 1, (arg_245_1.time_ - var_248_3) / var_248_4)
				arg_245_1.mask_.color = var_248_5
			end

			if arg_245_1.time_ >= var_248_3 + var_248_4 and arg_245_1.time_ < var_248_3 + var_248_4 + arg_248_0 then
				local var_248_6 = Color.New(0, 0, 0)

				var_248_6.a = 1
				arg_245_1.mask_.color = var_248_6
			end

			local var_248_7 = 2

			if 2 < arg_245_1.time_ and arg_245_1.time_ <= var_248_7 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_8 = 2

			if var_248_7 <= arg_245_1.time_ and arg_245_1.time_ < var_248_7 + var_248_8 then
				local var_248_9 = Color.New(0, 0, 0)

				var_248_9.a = Mathf.Lerp(1, 0, (arg_245_1.time_ - var_248_7) / var_248_8)
				arg_245_1.mask_.color = var_248_9
			end

			if arg_245_1.time_ >= var_248_7 + var_248_8 and arg_245_1.time_ < var_248_7 + var_248_8 + arg_248_0 then
				local var_248_10 = Color.New(0, 0, 0)

				arg_245_1.mask_.enabled = false
				var_248_10.a = 0
				arg_245_1.mask_.color = var_248_10
			end

			local var_248_11 = arg_245_1.actors_["1066ui_story"].transform

			if 2 < arg_245_1.time_ and arg_245_1.time_ <= 2 + arg_248_0 then
				arg_245_1.var_.moveOldPos1066ui_story = var_248_11.localPosition
			end

			local var_248_12 = 0.001

			if 2 <= arg_245_1.time_ and arg_245_1.time_ < 2 + var_248_12 then
				var_248_11.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 2) / var_248_12)
				var_248_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_11.position).x, (manager.ui.mainCamera.transform.position - var_248_11.position).y, (manager.ui.mainCamera.transform.position - var_248_11.position).z)
				var_248_11.localEulerAngles.z = 0
				var_248_11.localEulerAngles.x = 0
				var_248_11.localEulerAngles = var_248_11.localEulerAngles
			end

			if arg_245_1.time_ >= 2 + var_248_12 and arg_245_1.time_ < 2 + var_248_12 + arg_248_0 then
				var_248_11.localPosition = Vector3.New(0, 100, 0)
				var_248_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_11.position).x, (manager.ui.mainCamera.transform.position - var_248_11.position).y, (manager.ui.mainCamera.transform.position - var_248_11.position).z)
				var_248_11.localEulerAngles.z = 0
				var_248_11.localEulerAngles.x = 0
				var_248_11.localEulerAngles = var_248_11.localEulerAngles
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_13 = 4
			local var_248_14 = 1.2

			if 4 < arg_245_1.time_ and arg_245_1.time_ <= var_248_13 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_15 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_15:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_16 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(1106606061).content)

				arg_245_1.text_.text = var_248_16

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_18 = 48 <= 0 and var_248_14 or var_248_14 * (utf8.len(var_248_16) / 48)

				if (48 <= 0 and var_248_14 or var_248_14 * (utf8.len(var_248_16) / 48)) > 0 and var_248_14 < var_248_18 then
					arg_245_1.talkMaxDuration = var_248_18
					var_248_13 = var_248_13 + 0.3

					if var_248_18 + var_248_13 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_18 + var_248_13
					end
				end

				arg_245_1.text_.text = var_248_16
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_19 = var_248_13 + 0.3
			local var_248_20 = math.max(var_248_14, arg_245_1.talkMaxDuration)

			if var_248_13 + 0.3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_19 + var_248_20 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_19) / var_248_20

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_19 + var_248_20 and arg_245_1.time_ < var_248_19 + var_248_20 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play1106606062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1106606062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1106606063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.75

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(1106606062).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 30 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 30)

				if (30 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 30)) > 0 and var_254_0 < var_254_3 then
					arg_251_1.talkMaxDuration = var_254_3

					if var_254_3 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_3 + 0
					end
				end

				arg_251_1.text_.text = var_254_1
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_4 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_4

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1106606063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1106606063
		arg_255_1.duration_ = 2

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1106606064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1066ui_story = arg_255_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1066ui_story"].transform.position).z)
				arg_255_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1066ui_story"].transform.localEulerAngles = arg_255_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_255_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1066ui_story"].transform.position).z)
				arg_255_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1066ui_story"].transform.localEulerAngles = arg_255_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["1066ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1066ui_story == nil then
				arg_255_1.var_.characterEffect1066ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect1066ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1066ui_story then
				arg_255_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_258_4 = 0
			local var_258_5 = 0.1

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:GetWordFromCfg(1106606063)
				local var_258_7 = arg_255_1:FormatText(var_258_6.content)

				arg_255_1.text_.text = var_258_7

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_9 = 4 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 4)

				if (4 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 4)) > 0 and var_258_5 < var_258_9 then
					arg_255_1.talkMaxDuration = var_258_9

					if var_258_9 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_9 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_7
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606063", "story_v_side_new_1106606.awb") ~= 0 then
					local var_258_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606063", "story_v_side_new_1106606.awb") / 1000

					if var_258_10 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_4
					end

					if var_258_6.prefab_name ~= "" and arg_255_1.actors_[var_258_6.prefab_name] ~= nil then
						local var_258_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_6.prefab_name].transform, "story_v_side_new_1106606", "1106606063", "story_v_side_new_1106606.awb")

						arg_255_1:RecordAudio("1106606063", var_258_11)
						arg_255_1:RecordAudio("1106606063", var_258_11)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606063", "story_v_side_new_1106606.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606063", "story_v_side_new_1106606.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_12 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_12 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_12

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_12 and arg_255_1.time_ < var_258_4 + var_258_12 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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

		arg_255_1:InitPlayNodeList()
	end,
	Play1106606064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1106606064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1106606065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1066ui_story"]) and arg_259_1.var_.characterEffect1066ui_story == nil then
				arg_259_1.var_.characterEffect1066ui_story = arg_259_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1066ui_story"]) then
				if arg_259_1.var_.characterEffect1066ui_story and not isNil(arg_259_1.actors_["1066ui_story"]) then
					arg_259_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_0)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1066ui_story"]) and arg_259_1.var_.characterEffect1066ui_story then
				arg_259_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_262_1 = 0
			local var_262_2 = 0.25

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(1106606064).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 10 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 10)

				if (10 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 10)) > 0 and var_262_2 < var_262_5 then
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
	Play1106606065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1106606065
		arg_263_1.duration_ = 2.6

		local var_263_0 = {
			zh = 2.6,
			ja = 1.999999999999
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
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1106606066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1066ui_story = arg_263_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).z)
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles = arg_263_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_263_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1066ui_story"].transform.position).z)
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1066ui_story"].transform.localEulerAngles = arg_263_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1066ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1066ui_story == nil then
				arg_263_1.var_.characterEffect1066ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1066ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1066ui_story then
				arg_263_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_266_4 = 0
			local var_266_5 = 0.25

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(1106606065)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 10 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 10)

				if (10 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 10)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606065", "story_v_side_new_1106606.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606065", "story_v_side_new_1106606.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_side_new_1106606", "1106606065", "story_v_side_new_1106606.awb")

						arg_263_1:RecordAudio("1106606065", var_266_11)
						arg_263_1:RecordAudio("1106606065", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606065", "story_v_side_new_1106606.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606065", "story_v_side_new_1106606.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play1106606066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1106606066
		arg_267_1.duration_ = 1

		SetActive(arg_267_1.tipsGo_, true)

		arg_267_1.tipsText_.text = StoryTipsCfg[106601].name

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"

			SetActive(arg_267_1.choicesGo_, true)

			for iter_268_0, iter_268_1 in ipairs(arg_267_1.choices_) do
				SetActive(iter_268_1.go, iter_268_0 <= 2)
			end

			arg_267_1.choices_[1].txt.text = arg_267_1:FormatText(StoryChoiceCfg[558].name)
			arg_267_1.choices_[2].txt.text = arg_267_1:FormatText(StoryChoiceCfg[559].name)
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				PlayerAction.UseStoryTrigger(1066014, 210660106, 1106606066, 1)
				arg_267_0:Play1106606067(arg_267_1)
			end

			if arg_269_0 == 2 then
				arg_267_0:Play1106606069(arg_267_1)
			end

			arg_267_1:RecordChoiceLog(1106606066, 558, 559)
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1066ui_story"]) and arg_267_1.var_.characterEffect1066ui_story == nil then
				arg_267_1.var_.characterEffect1066ui_story = arg_267_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1066ui_story"]) then
				if arg_267_1.var_.characterEffect1066ui_story and not isNil(arg_267_1.actors_["1066ui_story"]) then
					arg_267_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1066ui_story"]) and arg_267_1.var_.characterEffect1066ui_story then
				arg_267_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			if arg_267_1.time_ >= var_270_1 + 0.5 and arg_267_1.time_ < var_270_1 + 0.5 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1106606067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1106606067
		arg_271_1.duration_ = 3.3

		local var_271_0 = {
			zh = 3.3,
			ja = 2.166
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1106606068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1066ui_story = arg_271_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1066ui_story"].transform.position).z)
				arg_271_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1066ui_story"].transform.localEulerAngles = arg_271_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_271_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1066ui_story"].transform.position).z)
				arg_271_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1066ui_story"].transform.localEulerAngles = arg_271_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1066ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1066ui_story == nil then
				arg_271_1.var_.characterEffect1066ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1066ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1066ui_story then
				arg_271_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_274_4 = 0
			local var_274_5 = 0.35

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(1106606067)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 14 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 14)

				if (14 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 14)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606067", "story_v_side_new_1106606.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606067", "story_v_side_new_1106606.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_side_new_1106606", "1106606067", "story_v_side_new_1106606.awb")

						arg_271_1:RecordAudio("1106606067", var_274_11)
						arg_271_1:RecordAudio("1106606067", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606067", "story_v_side_new_1106606.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606067", "story_v_side_new_1106606.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_12 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_12 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_12

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_12 and arg_271_1.time_ < var_274_4 + var_274_12 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play1106606068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1106606068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1106606071(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1066ui_story"]) and arg_275_1.var_.characterEffect1066ui_story == nil then
				arg_275_1.var_.characterEffect1066ui_story = arg_275_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1066ui_story"]) then
				if arg_275_1.var_.characterEffect1066ui_story and not isNil(arg_275_1.actors_["1066ui_story"]) then
					arg_275_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1066ui_story"]) and arg_275_1.var_.characterEffect1066ui_story then
				arg_275_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.25

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(1106606068).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 10 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 10)

				if (10 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 10)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1106606071 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1106606071
		arg_279_1.duration_ = 5.37

		local var_279_0 = {
			zh = 5.366,
			ja = 3.533
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
				arg_279_0:Play1106606072(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1066ui_story = arg_279_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1066ui_story"].transform.position).z)
				arg_279_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1066ui_story"].transform.localEulerAngles = arg_279_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_279_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1066ui_story"].transform.position).z)
				arg_279_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1066ui_story"].transform.localEulerAngles = arg_279_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1066ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1066ui_story == nil then
				arg_279_1.var_.characterEffect1066ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1066ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1066ui_story then
				arg_279_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_282_4 = 0
			local var_282_5 = 0.725

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(1106606071)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 29 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 29)

				if (29 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 29)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606071", "story_v_side_new_1106606.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606071", "story_v_side_new_1106606.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_side_new_1106606", "1106606071", "story_v_side_new_1106606.awb")

						arg_279_1:RecordAudio("1106606071", var_282_11)
						arg_279_1:RecordAudio("1106606071", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606071", "story_v_side_new_1106606.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606071", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606072 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1106606072
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1106606073(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1066ui_story = arg_283_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1066ui_story"].transform.position).z)
				arg_283_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1066ui_story"].transform.localEulerAngles = arg_283_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_283_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1066ui_story"].transform.position).z)
				arg_283_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1066ui_story"].transform.localEulerAngles = arg_283_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1066ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1066ui_story == nil then
				arg_283_1.var_.characterEffect1066ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1066ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_2)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1066ui_story then
				arg_283_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_286_3 = 0
			local var_286_4 = 1.5

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_3 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_5 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1106606072).content)

				arg_283_1.text_.text = var_286_5

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_7 = 60 <= 0 and var_286_4 or var_286_4 * (utf8.len(var_286_5) / 60)

				if (60 <= 0 and var_286_4 or var_286_4 * (utf8.len(var_286_5) / 60)) > 0 and var_286_4 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_3 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_3
					end
				end

				arg_283_1.text_.text = var_286_5
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_8 = math.max(var_286_4, arg_283_1.talkMaxDuration)

			if var_286_3 <= arg_283_1.time_ and arg_283_1.time_ < var_286_3 + var_286_8 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_3) / var_286_8

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_3 + var_286_8 and arg_283_1.time_ < var_286_3 + var_286_8 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play1106606073 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1106606073
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1106606074(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 1.175

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1106606073).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 47 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 47)

				if (47 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 47)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1106606074 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1106606074
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1106606075(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.6

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1106606074).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 24 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 24)

				if (24 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 24)) > 0 and var_294_0 < var_294_3 then
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
	Play1106606075 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1106606075
		arg_295_1.duration_ = 3.1

		local var_295_0 = {
			zh = 3.1,
			ja = 2.4
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1106606076(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1066ui_story = arg_295_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1066ui_story"].transform.position).z)
				arg_295_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1066ui_story"].transform.localEulerAngles = arg_295_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_295_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1066ui_story"].transform.position).z)
				arg_295_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1066ui_story"].transform.localEulerAngles = arg_295_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1066ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1066ui_story == nil then
				arg_295_1.var_.characterEffect1066ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1066ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1066ui_story then
				arg_295_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_298_4 = 0
			local var_298_5 = 0.4

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(1106606075)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 16 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 16)

				if (16 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 16)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606075", "story_v_side_new_1106606.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606075", "story_v_side_new_1106606.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_side_new_1106606", "1106606075", "story_v_side_new_1106606.awb")

						arg_295_1:RecordAudio("1106606075", var_298_11)
						arg_295_1:RecordAudio("1106606075", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606075", "story_v_side_new_1106606.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606075", "story_v_side_new_1106606.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_12 and arg_295_1.time_ < var_298_4 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play1106606076 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1106606076
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1106606077(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1066ui_story"]) and arg_299_1.var_.characterEffect1066ui_story == nil then
				arg_299_1.var_.characterEffect1066ui_story = arg_299_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1066ui_story"]) then
				if arg_299_1.var_.characterEffect1066ui_story and not isNil(arg_299_1.actors_["1066ui_story"]) then
					arg_299_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_0)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1066ui_story"]) and arg_299_1.var_.characterEffect1066ui_story then
				arg_299_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_302_1 = 0
			local var_302_2 = 0.6

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
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

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(1106606076).content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 24 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 24)

				if (24 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 24)) > 0 and var_302_2 < var_302_5 then
					arg_299_1.talkMaxDuration = var_302_5

					if var_302_5 + var_302_1 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + var_302_1
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_6 = math.max(var_302_2, arg_299_1.talkMaxDuration)

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_6 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_1) / var_302_6

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_1 + var_302_6 and arg_299_1.time_ < var_302_1 + var_302_6 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1106606077 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1106606077
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1106606078(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_306_0 = 0
			local var_306_1 = 0.575

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_2 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1106606077).content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 23 <= 0 and var_306_1 or var_306_1 * (utf8.len(var_306_2) / 23)

				if (23 <= 0 and var_306_1 or var_306_1 * (utf8.len(var_306_2) / 23)) > 0 and var_306_1 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_5 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_5 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_5

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_5 and arg_303_1.time_ < var_306_0 + var_306_5 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1106606078 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1106606078
		arg_307_1.duration_ = 5.13

		local var_307_0 = {
			zh = 3.6,
			ja = 5.133
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1106606079(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1066ui_story = arg_307_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).z)
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles = arg_307_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_307_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).z)
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles = arg_307_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["1066ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1066ui_story == nil then
				arg_307_1.var_.characterEffect1066ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect1066ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1066ui_story then
				arg_307_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_310_4 = 0
			local var_310_5 = 0.4

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:GetWordFromCfg(1106606078)
				local var_310_7 = arg_307_1:FormatText(var_310_6.content)

				arg_307_1.text_.text = var_310_7

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_9 = 16 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 16)

				if (16 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 16)) > 0 and var_310_5 < var_310_9 then
					arg_307_1.talkMaxDuration = var_310_9

					if var_310_9 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_7
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606078", "story_v_side_new_1106606.awb") ~= 0 then
					local var_310_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606078", "story_v_side_new_1106606.awb") / 1000

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end

					if var_310_6.prefab_name ~= "" and arg_307_1.actors_[var_310_6.prefab_name] ~= nil then
						local var_310_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_6.prefab_name].transform, "story_v_side_new_1106606", "1106606078", "story_v_side_new_1106606.awb")

						arg_307_1:RecordAudio("1106606078", var_310_11)
						arg_307_1:RecordAudio("1106606078", var_310_11)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606078", "story_v_side_new_1106606.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606078", "story_v_side_new_1106606.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_12 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 <= arg_307_1.time_ and arg_307_1.time_ < var_310_4 + var_310_12 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_4) / var_310_12

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_4 + var_310_12 and arg_307_1.time_ < var_310_4 + var_310_12 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
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

		arg_307_1:InitPlayNodeList()
	end,
	Play1106606079 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1106606079
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1106606080(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1066ui_story"]) and arg_311_1.var_.characterEffect1066ui_story == nil then
				arg_311_1.var_.characterEffect1066ui_story = arg_311_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1066ui_story"]) then
				if arg_311_1.var_.characterEffect1066ui_story and not isNil(arg_311_1.actors_["1066ui_story"]) then
					arg_311_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1066ui_story"]) and arg_311_1.var_.characterEffect1066ui_story then
				arg_311_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.225

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(1106606079).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 9 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 9)

				if (9 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 9)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1106606080 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1106606080
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1106606081(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.075

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_1 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1106606080).content)

				arg_315_1.text_.text = var_318_1

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_3 = 3 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 3)

				if (3 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 3)) > 0 and var_318_0 < var_318_3 then
					arg_315_1.talkMaxDuration = var_318_3

					if var_318_3 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_3 + 0
					end
				end

				arg_315_1.text_.text = var_318_1
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_4 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_4

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1106606081 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1106606081
		arg_319_1.duration_ = 2.3

		local var_319_0 = {
			zh = 2.3,
			ja = 2.166
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1106606082(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1066ui_story = arg_319_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1066ui_story"].transform.position).z)
				arg_319_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1066ui_story"].transform.localEulerAngles = arg_319_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_319_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1066ui_story"].transform.position).z)
				arg_319_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1066ui_story"].transform.localEulerAngles = arg_319_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_322_1 = arg_319_1.actors_["1066ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1066ui_story == nil then
				arg_319_1.var_.characterEffect1066ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect1066ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1066ui_story then
				arg_319_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_2")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_322_4 = 0
			local var_322_5 = 0.175

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(1106606081)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 7 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 7)

				if (7 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 7)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606081", "story_v_side_new_1106606.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606081", "story_v_side_new_1106606.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_side_new_1106606", "1106606081", "story_v_side_new_1106606.awb")

						arg_319_1:RecordAudio("1106606081", var_322_11)
						arg_319_1:RecordAudio("1106606081", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606081", "story_v_side_new_1106606.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606081", "story_v_side_new_1106606.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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

		arg_319_1:InitPlayNodeList()
	end,
	Play1106606082 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1106606082
		arg_323_1.duration_ = 9

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1106606083(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if arg_323_1.bgs_.STblack == nil then
				local var_326_0 = Object.Instantiate(arg_323_1.paintGo_)

				var_326_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_326_0.name = "STblack"
				var_326_0.transform.parent = arg_323_1.stage_.transform
				var_326_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.bgs_.STblack = var_326_0
			end

			if 2 < arg_323_1.time_ and arg_323_1.time_ <= 2 + arg_326_0 then
				local var_326_1 = arg_323_1.bgs_.STblack

				arg_323_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_326_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_326_2 = var_326_1:GetComponent("SpriteRenderer")

				if var_326_2 and var_326_2.sprite then
					local var_326_3 = 2 * (var_326_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_326_1.transform.localScale = Vector3.New(var_326_3 / var_326_2.sprite.bounds.size.y < var_326_3 * manager.ui.mainCameraCom_.aspect / var_326_2.sprite.bounds.size.x and var_326_3 * manager.ui.mainCameraCom_.aspect / var_326_2.sprite.bounds.size.x or var_326_3 / var_326_2.sprite.bounds.size.y, var_326_3 / var_326_2.sprite.bounds.size.y < var_326_3 * manager.ui.mainCameraCom_.aspect / var_326_2.sprite.bounds.size.x and var_326_3 * manager.ui.mainCameraCom_.aspect / var_326_2.sprite.bounds.size.x or var_326_3 / var_326_2.sprite.bounds.size.y, 0)
				end

				for iter_326_0, iter_326_1 in pairs(arg_323_1.bgs_) do
					if iter_326_0 ~= "STblack" then
						iter_326_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_326_4 = arg_323_1.actors_["1066ui_story"].transform

			if 2 < arg_323_1.time_ and arg_323_1.time_ <= 2 + arg_326_0 then
				arg_323_1.var_.moveOldPos1066ui_story = var_326_4.localPosition
			end

			local var_326_5 = 0.001

			if 2 <= arg_323_1.time_ and arg_323_1.time_ < 2 + var_326_5 then
				var_326_4.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 2) / var_326_5)
				var_326_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_4.position).x, (manager.ui.mainCamera.transform.position - var_326_4.position).y, (manager.ui.mainCamera.transform.position - var_326_4.position).z)
				var_326_4.localEulerAngles.z = 0
				var_326_4.localEulerAngles.x = 0
				var_326_4.localEulerAngles = var_326_4.localEulerAngles
			end

			if arg_323_1.time_ >= 2 + var_326_5 and arg_323_1.time_ < 2 + var_326_5 + arg_326_0 then
				var_326_4.localPosition = Vector3.New(0, 100, 0)
				var_326_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_4.position).x, (manager.ui.mainCamera.transform.position - var_326_4.position).y, (manager.ui.mainCamera.transform.position - var_326_4.position).z)
				var_326_4.localEulerAngles.z = 0
				var_326_4.localEulerAngles.x = 0
				var_326_4.localEulerAngles = var_326_4.localEulerAngles
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_326_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_323_1.bgmTxt_.text ~= var_326_8 and arg_323_1.bgmTxt_.text ~= "" then
						if arg_323_1.bgmTxt2_.text ~= "" then
							arg_323_1.bgmTxt_.text = arg_323_1.bgmTxt2_.text
						end

						arg_323_1.bgmTxt2_.text = var_326_8

						arg_323_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_323_1.bgmTxt_.text = var_326_8
						arg_323_1.bgmTxt2_.text = var_326_8
					end

					if arg_323_1.bgmTimer then
						arg_323_1.bgmTimer:Stop()

						arg_323_1.bgmTimer = nil
					end

					if arg_323_1.settingData.show_music_name == 1 then
						arg_323_1.musicController:SetSelectedState("show")
						arg_323_1.musicAnimator_:Play("open", 0, 0)

						if arg_323_1.settingData.music_time ~= 0 then
							arg_323_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_323_1.settingData.music_time), function()
								if arg_323_1 == nil or isNil(arg_323_1.bgmTxt_) then
									return
								end

								arg_323_1.musicController:SetSelectedState("hide")
								arg_323_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_326_9 = 0

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.mask_.enabled = true
				arg_323_1.mask_.raycastTarget = true

				arg_323_1:SetGaussion(false)
			end

			local var_326_10 = 2

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_10 then
				local var_326_11 = Color.New(0, 0, 0)

				var_326_11.a = Mathf.Lerp(0, 1, (arg_323_1.time_ - var_326_9) / var_326_10)
				arg_323_1.mask_.color = var_326_11
			end

			if arg_323_1.time_ >= var_326_9 + var_326_10 and arg_323_1.time_ < var_326_9 + var_326_10 + arg_326_0 then
				local var_326_12 = Color.New(0, 0, 0)

				var_326_12.a = 1
				arg_323_1.mask_.color = var_326_12
			end

			local var_326_13 = 2

			if 2 < arg_323_1.time_ and arg_323_1.time_ <= var_326_13 + arg_326_0 then
				arg_323_1.mask_.enabled = true
				arg_323_1.mask_.raycastTarget = true

				arg_323_1:SetGaussion(false)
			end

			local var_326_14 = 2

			if var_326_13 <= arg_323_1.time_ and arg_323_1.time_ < var_326_13 + var_326_14 then
				local var_326_15 = Color.New(0, 0, 0)

				var_326_15.a = Mathf.Lerp(1, 0, (arg_323_1.time_ - var_326_13) / var_326_14)
				arg_323_1.mask_.color = var_326_15
			end

			if arg_323_1.time_ >= var_326_13 + var_326_14 and arg_323_1.time_ < var_326_13 + var_326_14 + arg_326_0 then
				local var_326_16 = Color.New(0, 0, 0)

				arg_323_1.mask_.enabled = false
				var_326_16.a = 0
				arg_323_1.mask_.color = var_326_16
			end

			if arg_323_1.frameCnt_ <= 1 then
				arg_323_1.dialog_:SetActive(false)
			end

			local var_326_17 = 4
			local var_326_18 = 0.875

			if 4 < arg_323_1.time_ and arg_323_1.time_ <= var_326_17 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0

				arg_323_1.dialog_:SetActive(true)

				arg_323_1.dialogCg_.alpha = 0

				local var_326_19 = LeanTween.value(arg_323_1.dialog_, 0, 1, 0.3)

				var_326_19:setOnUpdate(LuaHelper.FloatAction(function(arg_328_0)
					arg_323_1.dialogCg_.alpha = arg_328_0
				end))
				var_326_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_323_1.dialog_)
					var_326_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_323_1.duration_ = arg_323_1.duration_ + 0.3

				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_20 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(1106606082).content)

				arg_323_1.text_.text = var_326_20

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_22 = 35 <= 0 and var_326_18 or var_326_18 * (utf8.len(var_326_20) / 35)

				if (35 <= 0 and var_326_18 or var_326_18 * (utf8.len(var_326_20) / 35)) > 0 and var_326_18 < var_326_22 then
					arg_323_1.talkMaxDuration = var_326_22
					var_326_17 = var_326_17 + 0.3

					if var_326_22 + var_326_17 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_22 + var_326_17
					end
				end

				arg_323_1.text_.text = var_326_20
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_23 = var_326_17 + 0.3
			local var_326_24 = math.max(var_326_18, arg_323_1.talkMaxDuration)

			if var_326_17 + 0.3 <= arg_323_1.time_ and arg_323_1.time_ < var_326_23 + var_326_24 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_23) / var_326_24

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_23 + var_326_24 and arg_323_1.time_ < var_326_23 + var_326_24 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play1106606083 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1106606083
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1106606084(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.85

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(1106606083).content)

				arg_330_1.text_.text = var_333_1

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_3 = 34 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 34)

				if (34 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 34)) > 0 and var_333_0 < var_333_3 then
					arg_330_1.talkMaxDuration = var_333_3

					if var_333_3 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_3 + 0
					end
				end

				arg_330_1.text_.text = var_333_1
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_4 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_4

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1106606084 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1106606084
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1106606085(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.6

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_1 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(1106606084).content)

				arg_334_1.text_.text = var_337_1

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_3 = 24 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 24)

				if (24 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 24)) > 0 and var_337_0 < var_337_3 then
					arg_334_1.talkMaxDuration = var_337_3

					if var_337_3 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_3 + 0
					end
				end

				arg_334_1.text_.text = var_337_1
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_4 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_4

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1106606085 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1106606085
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1106606086(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.925

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_1 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(1106606085).content)

				arg_338_1.text_.text = var_341_1

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_3 = 37 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 37)

				if (37 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 37)) > 0 and var_341_0 < var_341_3 then
					arg_338_1.talkMaxDuration = var_341_3

					if var_341_3 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_3 + 0
					end
				end

				arg_338_1.text_.text = var_341_1
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_4 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_4

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1106606086 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1106606086
		arg_342_1.duration_ = 9.02

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1106606087(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if arg_342_1.bgs_.R6602 == nil then
				local var_345_0 = Object.Instantiate(arg_342_1.paintGo_)

				var_345_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R6602")
				var_345_0.name = "R6602"
				var_345_0.transform.parent = arg_342_1.stage_.transform
				var_345_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_342_1.bgs_.R6602 = var_345_0
			end

			if 2 < arg_342_1.time_ and arg_342_1.time_ <= 2 + arg_345_0 then
				local var_345_1 = arg_342_1.bgs_.R6602

				arg_342_1.bgs_.R6602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_345_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_345_2 = var_345_1:GetComponent("SpriteRenderer")

				if var_345_2 and var_345_2.sprite then
					local var_345_3 = 2 * (var_345_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_345_1.transform.localScale = Vector3.New(var_345_3 / var_345_2.sprite.bounds.size.y < var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x and var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x or var_345_3 / var_345_2.sprite.bounds.size.y, var_345_3 / var_345_2.sprite.bounds.size.y < var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x and var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x or var_345_3 / var_345_2.sprite.bounds.size.y, 0)
				end

				for iter_345_0, iter_345_1 in pairs(arg_342_1.bgs_) do
					if iter_345_0 ~= "R6602" then
						iter_345_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_345_4 = 0

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_4 + arg_345_0 then
				arg_342_1.mask_.enabled = true
				arg_342_1.mask_.raycastTarget = true

				arg_342_1:SetGaussion(false)
			end

			local var_345_5 = 2

			if var_345_4 <= arg_342_1.time_ and arg_342_1.time_ < var_345_4 + var_345_5 then
				local var_345_6 = Color.New(0, 0, 0)

				var_345_6.a = Mathf.Lerp(0, 1, (arg_342_1.time_ - var_345_4) / var_345_5)
				arg_342_1.mask_.color = var_345_6
			end

			if arg_342_1.time_ >= var_345_4 + var_345_5 and arg_342_1.time_ < var_345_4 + var_345_5 + arg_345_0 then
				local var_345_7 = Color.New(0, 0, 0)

				var_345_7.a = 1
				arg_342_1.mask_.color = var_345_7
			end

			local var_345_8 = 2

			if 2 < arg_342_1.time_ and arg_342_1.time_ <= var_345_8 + arg_345_0 then
				arg_342_1.mask_.enabled = true
				arg_342_1.mask_.raycastTarget = true

				arg_342_1:SetGaussion(false)
			end

			local var_345_9 = 2

			if var_345_8 <= arg_342_1.time_ and arg_342_1.time_ < var_345_8 + var_345_9 then
				local var_345_10 = Color.New(0, 0, 0)

				var_345_10.a = Mathf.Lerp(1, 0, (arg_342_1.time_ - var_345_8) / var_345_9)
				arg_342_1.mask_.color = var_345_10
			end

			if arg_342_1.time_ >= var_345_8 + var_345_9 and arg_342_1.time_ < var_345_8 + var_345_9 + arg_345_0 then
				local var_345_11 = Color.New(0, 0, 0)

				arg_342_1.mask_.enabled = false
				var_345_11.a = 0
				arg_342_1.mask_.color = var_345_11
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_345_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_342_1.bgmTxt_.text ~= var_345_14 and arg_342_1.bgmTxt_.text ~= "" then
						if arg_342_1.bgmTxt2_.text ~= "" then
							arg_342_1.bgmTxt_.text = arg_342_1.bgmTxt2_.text
						end

						arg_342_1.bgmTxt2_.text = var_345_14

						arg_342_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_342_1.bgmTxt_.text = var_345_14
						arg_342_1.bgmTxt2_.text = var_345_14
					end

					if arg_342_1.bgmTimer then
						arg_342_1.bgmTimer:Stop()

						arg_342_1.bgmTimer = nil
					end

					if arg_342_1.settingData.show_music_name == 1 then
						arg_342_1.musicController:SetSelectedState("show")
						arg_342_1.musicAnimator_:Play("open", 0, 0)

						if arg_342_1.settingData.music_time ~= 0 then
							arg_342_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_342_1.settingData.music_time), function()
								if arg_342_1 == nil or isNil(arg_342_1.bgmTxt_) then
									return
								end

								arg_342_1.musicController:SetSelectedState("hide")
								arg_342_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.633333333333333 < arg_342_1.time_ and arg_342_1.time_ <= 0.633333333333333 + arg_345_0 then
				arg_342_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_345_17 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_342_1.bgmTxt_.text ~= var_345_17 and arg_342_1.bgmTxt_.text ~= "" then
						if arg_342_1.bgmTxt2_.text ~= "" then
							arg_342_1.bgmTxt_.text = arg_342_1.bgmTxt2_.text
						end

						arg_342_1.bgmTxt2_.text = var_345_17

						arg_342_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_342_1.bgmTxt_.text = var_345_17
						arg_342_1.bgmTxt2_.text = var_345_17
					end

					if arg_342_1.bgmTimer then
						arg_342_1.bgmTimer:Stop()

						arg_342_1.bgmTimer = nil
					end

					if arg_342_1.settingData.show_music_name == 1 then
						arg_342_1.musicController:SetSelectedState("show")
						arg_342_1.musicAnimator_:Play("open", 0, 0)

						if arg_342_1.settingData.music_time ~= 0 then
							arg_342_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_342_1.settingData.music_time), function()
								if arg_342_1 == nil or isNil(arg_342_1.bgmTxt_) then
									return
								end

								arg_342_1.musicController:SetSelectedState("hide")
								arg_342_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_345_18 = arg_342_1.bgs_.R6602.transform

			if 2 < arg_342_1.time_ and arg_342_1.time_ <= 2 + arg_345_0 then
				arg_342_1.var_.moveOldPosR6602 = var_345_18.localPosition
			end

			local var_345_19 = 0.001

			if 2 <= arg_342_1.time_ and arg_342_1.time_ < 2 + var_345_19 then
				var_345_18.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPosR6602, Vector3.New(0.83, 0.32, 6.22), (arg_342_1.time_ - 2) / var_345_19)
			end

			if arg_342_1.time_ >= 2 + var_345_19 and arg_342_1.time_ < 2 + var_345_19 + arg_345_0 then
				var_345_18.localPosition = Vector3.New(0.83, 0.32, 6.22)
			end

			local var_345_20 = arg_342_1.bgs_.R6602.transform

			if 2.01666666666667 < arg_342_1.time_ and arg_342_1.time_ <= 2.01666666666667 + arg_345_0 then
				arg_342_1.var_.moveOldPosR6602 = var_345_20.localPosition
			end

			local var_345_21 = 7

			if 2.01666666666667 <= arg_342_1.time_ and arg_342_1.time_ < 2.01666666666667 + var_345_21 then
				var_345_20.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPosR6602, Vector3.New(0.83, 1.13, 6.22), (arg_342_1.time_ - 2.01666666666667) / var_345_21)
			end

			if arg_342_1.time_ >= 2.01666666666667 + var_345_21 and arg_342_1.time_ < 2.01666666666667 + var_345_21 + arg_345_0 then
				var_345_20.localPosition = Vector3.New(0.83, 1.13, 6.22)
			end

			local var_345_22 = 4

			if 4 < arg_342_1.time_ and arg_342_1.time_ <= var_345_22 + arg_345_0 then
				arg_342_1.allBtn_.enabled = false
			end

			if arg_342_1.time_ >= var_345_22 + 3.3 and arg_342_1.time_ < var_345_22 + 3.3 + arg_345_0 then
				arg_342_1.allBtn_.enabled = true
			end

			if arg_342_1.frameCnt_ <= 1 then
				arg_342_1.dialog_:SetActive(false)
			end

			local var_345_23 = 4
			local var_345_24 = 1.65

			if 4 < arg_342_1.time_ and arg_342_1.time_ <= var_345_23 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0

				arg_342_1.dialog_:SetActive(true)

				arg_342_1.dialogCg_.alpha = 0

				local var_345_25 = LeanTween.value(arg_342_1.dialog_, 0, 1, 0.3)

				var_345_25:setOnUpdate(LuaHelper.FloatAction(function(arg_348_0)
					arg_342_1.dialogCg_.alpha = arg_348_0
				end))
				var_345_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_342_1.dialog_)
					var_345_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_342_1.duration_ = arg_342_1.duration_ + 0.3

				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_26 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(1106606086).content)

				arg_342_1.text_.text = var_345_26

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_28 = 66 <= 0 and var_345_24 or var_345_24 * (utf8.len(var_345_26) / 66)

				if (66 <= 0 and var_345_24 or var_345_24 * (utf8.len(var_345_26) / 66)) > 0 and var_345_24 < var_345_28 then
					arg_342_1.talkMaxDuration = var_345_28
					var_345_23 = var_345_23 + 0.3

					if var_345_28 + var_345_23 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_28 + var_345_23
					end
				end

				arg_342_1.text_.text = var_345_26
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_29 = var_345_23 + 0.3
			local var_345_30 = math.max(var_345_24, arg_342_1.talkMaxDuration)

			if var_345_23 + 0.3 <= arg_342_1.time_ and arg_342_1.time_ < var_345_29 + var_345_30 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_29) / var_345_30

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_29 + var_345_30 and arg_342_1.time_ < var_345_29 + var_345_30 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R6602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R6602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 7,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play1106606087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1106606087
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1106606088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.1

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_1 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(1106606087).content)

				arg_350_1.text_.text = var_353_1

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_3 = 4 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 4)

				if (4 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 4)) > 0 and var_353_0 < var_353_3 then
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
	Play1106606088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1106606088
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1106606089(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 1.375

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

				local var_357_1 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(1106606088).content)

				arg_354_1.text_.text = var_357_1

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_3 = 55 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 55)

				if (55 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 55)) > 0 and var_357_0 < var_357_3 then
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
	Play1106606089 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1106606089
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1106606090(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.8

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_1 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(1106606089).content)

				arg_358_1.text_.text = var_361_1

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_3 = 32 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 32)

				if (32 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 32)) > 0 and var_361_0 < var_361_3 then
					arg_358_1.talkMaxDuration = var_361_3

					if var_361_3 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_3 + 0
					end
				end

				arg_358_1.text_.text = var_361_1
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_4 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_4

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1106606090 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1106606090
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1106606091(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 1.725

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

				local var_365_1 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(1106606090).content)

				arg_362_1.text_.text = var_365_1

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_3 = 69 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_1) / 69)

				if (69 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_1) / 69)) > 0 and var_365_0 < var_365_3 then
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
	Play1106606091 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1106606091
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1106606092(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.7

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

				local var_369_1 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(1106606091).content)

				arg_366_1.text_.text = var_369_1

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_3 = 28 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 28)

				if (28 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 28)) > 0 and var_369_0 < var_369_3 then
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
	Play1106606092 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1106606092
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1106606093(arg_370_1)
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

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_1 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(1106606092).content)

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
	Play1106606093 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1106606093
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1106606094(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.8

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(1106606093).content)

				arg_374_1.text_.text = var_377_1

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_3 = 32 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 32)

				if (32 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 32)) > 0 and var_377_0 < var_377_3 then
					arg_374_1.talkMaxDuration = var_377_3

					if var_377_3 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_3 + 0
					end
				end

				arg_374_1.text_.text = var_377_1
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_4 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_4

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1106606094 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1106606094
		arg_378_1.duration_ = 3.4

		local var_378_0 = {
			zh = 2.933,
			ja = 3.4
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1106606095(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.225

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
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

				local var_381_1 = arg_378_1:GetWordFromCfg(1106606094)
				local var_381_2 = arg_378_1:FormatText(var_381_1.content)

				arg_378_1.text_.text = var_381_2

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 9 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 9)

				if (9 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 9)) > 0 and var_381_0 < var_381_4 then
					arg_378_1.talkMaxDuration = var_381_4

					if var_381_4 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_4 + 0
					end
				end

				arg_378_1.text_.text = var_381_2
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606094", "story_v_side_new_1106606.awb") ~= 0 then
					local var_381_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606094", "story_v_side_new_1106606.awb") / 1000

					if var_381_5 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + 0
					end

					if var_381_1.prefab_name ~= "" and arg_378_1.actors_[var_381_1.prefab_name] ~= nil then
						local var_381_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_1.prefab_name].transform, "story_v_side_new_1106606", "1106606094", "story_v_side_new_1106606.awb")

						arg_378_1:RecordAudio("1106606094", var_381_6)
						arg_378_1:RecordAudio("1106606094", var_381_6)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606094", "story_v_side_new_1106606.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606094", "story_v_side_new_1106606.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1106606095 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1106606095
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1106606096(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0.275

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_1 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(1106606095).content)

				arg_382_1.text_.text = var_385_1

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_3 = 11 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 11)

				if (11 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 11)) > 0 and var_385_0 < var_385_3 then
					arg_382_1.talkMaxDuration = var_385_3

					if var_385_3 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_3 + 0
					end
				end

				arg_382_1.text_.text = var_385_1
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_4 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_4 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_4

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_4 and arg_382_1.time_ < 0 + var_385_4 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1106606096 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1106606096
		arg_386_1.duration_ = 4

		local var_386_0 = {
			zh = 4,
			ja = 2.333
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1106606097(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.325

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
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

				local var_389_1 = arg_386_1:GetWordFromCfg(1106606096)
				local var_389_2 = arg_386_1:FormatText(var_389_1.content)

				arg_386_1.text_.text = var_389_2

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 13 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 13)

				if (13 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 13)) > 0 and var_389_0 < var_389_4 then
					arg_386_1.talkMaxDuration = var_389_4

					if var_389_4 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_4 + 0
					end
				end

				arg_386_1.text_.text = var_389_2
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606096", "story_v_side_new_1106606.awb") ~= 0 then
					local var_389_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606096", "story_v_side_new_1106606.awb") / 1000

					if var_389_5 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + 0
					end

					if var_389_1.prefab_name ~= "" and arg_386_1.actors_[var_389_1.prefab_name] ~= nil then
						local var_389_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_1.prefab_name].transform, "story_v_side_new_1106606", "1106606096", "story_v_side_new_1106606.awb")

						arg_386_1:RecordAudio("1106606096", var_389_6)
						arg_386_1:RecordAudio("1106606096", var_389_6)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606096", "story_v_side_new_1106606.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606096", "story_v_side_new_1106606.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_7 and arg_386_1.time_ < 0 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1106606097 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1106606097
		arg_390_1.duration_ = 3.27

		local var_390_0 = {
			zh = 2.5,
			ja = 3.266
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1106606098(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.2

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_1 = arg_390_1:GetWordFromCfg(1106606097)
				local var_393_2 = arg_390_1:FormatText(var_393_1.content)

				arg_390_1.text_.text = var_393_2

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 8 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 8)

				if (8 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 8)) > 0 and var_393_0 < var_393_4 then
					arg_390_1.talkMaxDuration = var_393_4

					if var_393_4 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_4 + 0
					end
				end

				arg_390_1.text_.text = var_393_2
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606097", "story_v_side_new_1106606.awb") ~= 0 then
					local var_393_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606097", "story_v_side_new_1106606.awb") / 1000

					if var_393_5 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + 0
					end

					if var_393_1.prefab_name ~= "" and arg_390_1.actors_[var_393_1.prefab_name] ~= nil then
						local var_393_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_1.prefab_name].transform, "story_v_side_new_1106606", "1106606097", "story_v_side_new_1106606.awb")

						arg_390_1:RecordAudio("1106606097", var_393_6)
						arg_390_1:RecordAudio("1106606097", var_393_6)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606097", "story_v_side_new_1106606.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606097", "story_v_side_new_1106606.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1106606098 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1106606098
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1106606099(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.4

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

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(1106606098).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 16 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 16)

				if (16 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 16)) > 0 and var_397_0 < var_397_3 then
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
	Play1106606099 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1106606099
		arg_398_1.duration_ = 3.37

		local var_398_0 = {
			zh = 3.366,
			ja = 2.733
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1106606100(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0.15

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:GetWordFromCfg(1106606099)
				local var_401_2 = arg_398_1:FormatText(var_401_1.content)

				arg_398_1.text_.text = var_401_2

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 6 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 6)

				if (6 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 6)) > 0 and var_401_0 < var_401_4 then
					arg_398_1.talkMaxDuration = var_401_4

					if var_401_4 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_4 + 0
					end
				end

				arg_398_1.text_.text = var_401_2
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606099", "story_v_side_new_1106606.awb") ~= 0 then
					local var_401_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606099", "story_v_side_new_1106606.awb") / 1000

					if var_401_5 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + 0
					end

					if var_401_1.prefab_name ~= "" and arg_398_1.actors_[var_401_1.prefab_name] ~= nil then
						local var_401_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_1.prefab_name].transform, "story_v_side_new_1106606", "1106606099", "story_v_side_new_1106606.awb")

						arg_398_1:RecordAudio("1106606099", var_401_6)
						arg_398_1:RecordAudio("1106606099", var_401_6)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606099", "story_v_side_new_1106606.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606099", "story_v_side_new_1106606.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1106606100 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1106606100
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1106606101(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.15

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
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

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_1 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(1106606100).content)

				arg_402_1.text_.text = var_405_1

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_3 = 6 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 6)

				if (6 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 6)) > 0 and var_405_0 < var_405_3 then
					arg_402_1.talkMaxDuration = var_405_3

					if var_405_3 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_3 + 0
					end
				end

				arg_402_1.text_.text = var_405_1
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_4 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_4 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_4

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_4 and arg_402_1.time_ < 0 + var_405_4 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1106606101 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1106606101
		arg_406_1.duration_ = 1

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"

			SetActive(arg_406_1.choicesGo_, true)

			for iter_407_0, iter_407_1 in ipairs(arg_406_1.choices_) do
				SetActive(iter_407_1.go, iter_407_0 <= 2)
			end

			arg_406_1.choices_[1].txt.text = arg_406_1:FormatText(StoryChoiceCfg[560].name)
			arg_406_1.choices_[2].txt.text = arg_406_1:FormatText(StoryChoiceCfg[561].name)
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1106606102(arg_406_1)
			end

			if arg_408_0 == 2 then
				arg_406_0:Play1106606104(arg_406_1)
			end

			arg_406_1:RecordChoiceLog(1106606101, 560, 561)
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.allBtn_.enabled = false
			end

			if arg_406_1.time_ >= 0 + 0.5 and arg_406_1.time_ < 0 + 0.5 + arg_409_0 then
				arg_406_1.allBtn_.enabled = true
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1106606102 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1106606102
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1106606103(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.625

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_1 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(1106606102).content)

				arg_410_1.text_.text = var_413_1

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_3 = 25 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 25)

				if (25 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 25)) > 0 and var_413_0 < var_413_3 then
					arg_410_1.talkMaxDuration = var_413_3

					if var_413_3 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_3 + 0
					end
				end

				arg_410_1.text_.text = var_413_1
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_4 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_4 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_4

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_4 and arg_410_1.time_ < 0 + var_413_4 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1106606103 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1106606103
		arg_414_1.duration_ = 4.03

		local var_414_0 = {
			zh = 4.033,
			ja = 2.866
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1106606106(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.275

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
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

				local var_417_1 = arg_414_1:GetWordFromCfg(1106606103)
				local var_417_2 = arg_414_1:FormatText(var_417_1.content)

				arg_414_1.text_.text = var_417_2

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 11 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 11)

				if (11 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 11)) > 0 and var_417_0 < var_417_4 then
					arg_414_1.talkMaxDuration = var_417_4

					if var_417_4 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_4 + 0
					end
				end

				arg_414_1.text_.text = var_417_2
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606103", "story_v_side_new_1106606.awb") ~= 0 then
					local var_417_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606103", "story_v_side_new_1106606.awb") / 1000

					if var_417_5 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + 0
					end

					if var_417_1.prefab_name ~= "" and arg_414_1.actors_[var_417_1.prefab_name] ~= nil then
						local var_417_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_1.prefab_name].transform, "story_v_side_new_1106606", "1106606103", "story_v_side_new_1106606.awb")

						arg_414_1:RecordAudio("1106606103", var_417_6)
						arg_414_1:RecordAudio("1106606103", var_417_6)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606103", "story_v_side_new_1106606.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606103", "story_v_side_new_1106606.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1106606106 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1106606106
		arg_418_1.duration_ = 0.5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"

			SetActive(arg_418_1.choicesGo_, true)

			for iter_419_0, iter_419_1 in ipairs(arg_418_1.choices_) do
				SetActive(iter_419_1.go, iter_419_0 <= 2)
			end

			arg_418_1.choices_[1].txt.text = arg_418_1:FormatText(StoryChoiceCfg[562].name)
			arg_418_1.choices_[2].txt.text = arg_418_1:FormatText(StoryChoiceCfg[563].name)
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1106606107(arg_418_1)
			end

			if arg_420_0 == 2 then
				arg_418_0:Play1106606109(arg_418_1)
			end

			arg_418_1:RecordChoiceLog(1106606106, 562, 563)
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.allBtn_.enabled = false
			end

			if arg_418_1.time_ >= 0 + 0.5 and arg_418_1.time_ < 0 + 0.5 + arg_421_0 then
				arg_418_1.allBtn_.enabled = true
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1106606107 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1106606107
		arg_422_1.duration_ = 4.43

		local var_422_0 = {
			zh = 4.433,
			ja = 3.266
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1106606108(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.325

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_1 = arg_422_1:GetWordFromCfg(1106606107)
				local var_425_2 = arg_422_1:FormatText(var_425_1.content)

				arg_422_1.text_.text = var_425_2

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 13 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 13)

				if (13 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 13)) > 0 and var_425_0 < var_425_4 then
					arg_422_1.talkMaxDuration = var_425_4

					if var_425_4 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_4 + 0
					end
				end

				arg_422_1.text_.text = var_425_2
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606107", "story_v_side_new_1106606.awb") ~= 0 then
					local var_425_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606107", "story_v_side_new_1106606.awb") / 1000

					if var_425_5 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_5 + 0
					end

					if var_425_1.prefab_name ~= "" and arg_422_1.actors_[var_425_1.prefab_name] ~= nil then
						local var_425_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_1.prefab_name].transform, "story_v_side_new_1106606", "1106606107", "story_v_side_new_1106606.awb")

						arg_422_1:RecordAudio("1106606107", var_425_6)
						arg_422_1:RecordAudio("1106606107", var_425_6)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606107", "story_v_side_new_1106606.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606107", "story_v_side_new_1106606.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_7 and arg_422_1.time_ < 0 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1106606108 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1106606108
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1106606111(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.825

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

				local var_429_1 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(1106606108).content)

				arg_426_1.text_.text = var_429_1

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_3 = 33 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 33)

				if (33 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 33)) > 0 and var_429_0 < var_429_3 then
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
	Play1106606111 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1106606111
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1106606112(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0.65

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_1 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(1106606111).content)

				arg_430_1.text_.text = var_433_1

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_3 = 26 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 26)

				if (26 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 26)) > 0 and var_433_0 < var_433_3 then
					arg_430_1.talkMaxDuration = var_433_3

					if var_433_3 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_3 + 0
					end
				end

				arg_430_1.text_.text = var_433_1
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_4 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_4

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1106606112 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1106606112
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1106606113(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 1.35

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_1 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(1106606112).content)

				arg_434_1.text_.text = var_437_1

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_3 = 54 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 54)

				if (54 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 54)) > 0 and var_437_0 < var_437_3 then
					arg_434_1.talkMaxDuration = var_437_3

					if var_437_3 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_3 + 0
					end
				end

				arg_434_1.text_.text = var_437_1
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_4 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_4 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_4

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_4 and arg_434_1.time_ < 0 + var_437_4 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1106606113 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1106606113
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1106606114(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.85

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_1 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(1106606113).content)

				arg_438_1.text_.text = var_441_1

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_3 = 34 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_1) / 34)

				if (34 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_1) / 34)) > 0 and var_441_0 < var_441_3 then
					arg_438_1.talkMaxDuration = var_441_3

					if var_441_3 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_3 + 0
					end
				end

				arg_438_1.text_.text = var_441_1
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_4 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_4 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_4

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_4 and arg_438_1.time_ < 0 + var_441_4 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1106606114 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1106606114
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1106606115(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0.325

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_1 = arg_442_1:FormatText(arg_442_1:GetWordFromCfg(1106606114).content)

				arg_442_1.text_.text = var_445_1

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_3 = 13 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_1) / 13)

				if (13 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_1) / 13)) > 0 and var_445_0 < var_445_3 then
					arg_442_1.talkMaxDuration = var_445_3

					if var_445_3 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_3 + 0
					end
				end

				arg_442_1.text_.text = var_445_1
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_4 = math.max(var_445_0, arg_442_1.talkMaxDuration)

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_4 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - 0) / var_445_4

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= 0 + var_445_4 and arg_442_1.time_ < 0 + var_445_4 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play1106606115 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1106606115
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1106606116(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0.725

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_1 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(1106606115).content)

				arg_446_1.text_.text = var_449_1

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_3 = 29 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_1) / 29)

				if (29 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_1) / 29)) > 0 and var_449_0 < var_449_3 then
					arg_446_1.talkMaxDuration = var_449_3

					if var_449_3 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_3 + 0
					end
				end

				arg_446_1.text_.text = var_449_1
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_4 = math.max(var_449_0, arg_446_1.talkMaxDuration)

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_4 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - 0) / var_449_4

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= 0 + var_449_4 and arg_446_1.time_ < 0 + var_449_4 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1106606116 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1106606116
		arg_450_1.duration_ = 15.07

		local var_450_0 = {
			zh = 13.6,
			ja = 15.066
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1106606117(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if arg_450_1.bgs_.R6602a == nil then
				local var_453_0 = Object.Instantiate(arg_450_1.paintGo_)

				var_453_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R6602a")
				var_453_0.name = "R6602a"
				var_453_0.transform.parent = arg_450_1.stage_.transform
				var_453_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_450_1.bgs_.R6602a = var_453_0
			end

			if 2 < arg_450_1.time_ and arg_450_1.time_ <= 2 + arg_453_0 then
				local var_453_1 = arg_450_1.bgs_.R6602a

				arg_450_1.bgs_.R6602a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_453_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_453_2 = var_453_1:GetComponent("SpriteRenderer")

				if var_453_2 and var_453_2.sprite then
					local var_453_3 = 2 * (var_453_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_453_1.transform.localScale = Vector3.New(var_453_3 / var_453_2.sprite.bounds.size.y < var_453_3 * manager.ui.mainCameraCom_.aspect / var_453_2.sprite.bounds.size.x and var_453_3 * manager.ui.mainCameraCom_.aspect / var_453_2.sprite.bounds.size.x or var_453_3 / var_453_2.sprite.bounds.size.y, var_453_3 / var_453_2.sprite.bounds.size.y < var_453_3 * manager.ui.mainCameraCom_.aspect / var_453_2.sprite.bounds.size.x and var_453_3 * manager.ui.mainCameraCom_.aspect / var_453_2.sprite.bounds.size.x or var_453_3 / var_453_2.sprite.bounds.size.y, 0)
				end

				for iter_453_0, iter_453_1 in pairs(arg_450_1.bgs_) do
					if iter_453_0 ~= "R6602a" then
						iter_453_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_453_4 = 0

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_4 + arg_453_0 then
				arg_450_1.mask_.enabled = true
				arg_450_1.mask_.raycastTarget = true

				arg_450_1:SetGaussion(false)
			end

			local var_453_5 = 2

			if var_453_4 <= arg_450_1.time_ and arg_450_1.time_ < var_453_4 + var_453_5 then
				local var_453_6 = Color.New(0, 0, 0)

				var_453_6.a = Mathf.Lerp(0, 1, (arg_450_1.time_ - var_453_4) / var_453_5)
				arg_450_1.mask_.color = var_453_6
			end

			if arg_450_1.time_ >= var_453_4 + var_453_5 and arg_450_1.time_ < var_453_4 + var_453_5 + arg_453_0 then
				local var_453_7 = Color.New(0, 0, 0)

				var_453_7.a = 1
				arg_450_1.mask_.color = var_453_7
			end

			local var_453_8 = 2

			if 2 < arg_450_1.time_ and arg_450_1.time_ <= var_453_8 + arg_453_0 then
				arg_450_1.mask_.enabled = true
				arg_450_1.mask_.raycastTarget = true

				arg_450_1:SetGaussion(false)
			end

			local var_453_9 = 2

			if var_453_8 <= arg_450_1.time_ and arg_450_1.time_ < var_453_8 + var_453_9 then
				local var_453_10 = Color.New(0, 0, 0)

				var_453_10.a = Mathf.Lerp(1, 0, (arg_450_1.time_ - var_453_8) / var_453_9)
				arg_450_1.mask_.color = var_453_10
			end

			if arg_450_1.time_ >= var_453_8 + var_453_9 and arg_450_1.time_ < var_453_8 + var_453_9 + arg_453_0 then
				local var_453_11 = Color.New(0, 0, 0)

				arg_450_1.mask_.enabled = false
				var_453_11.a = 0
				arg_450_1.mask_.color = var_453_11
			end

			if arg_450_1.frameCnt_ <= 1 then
				arg_450_1.dialog_:SetActive(false)
			end

			local var_453_12 = 4
			local var_453_13 = 0.625

			if 4 < arg_450_1.time_ and arg_450_1.time_ <= var_453_12 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0

				arg_450_1.dialog_:SetActive(true)

				arg_450_1.dialogCg_.alpha = 0

				local var_453_14 = LeanTween.value(arg_450_1.dialog_, 0, 1, 0.3)

				var_453_14:setOnUpdate(LuaHelper.FloatAction(function(arg_454_0)
					arg_450_1.dialogCg_.alpha = arg_454_0
				end))
				var_453_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_450_1.dialog_)
					var_453_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_450_1.duration_ = arg_450_1.duration_ + 0.3

				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_15 = arg_450_1:GetWordFromCfg(1106606116)
				local var_453_16 = arg_450_1:FormatText(var_453_15.content)

				arg_450_1.text_.text = var_453_16

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_18 = 25 <= 0 and var_453_13 or var_453_13 * (utf8.len(var_453_16) / 25)

				if (25 <= 0 and var_453_13 or var_453_13 * (utf8.len(var_453_16) / 25)) > 0 and var_453_13 < var_453_18 then
					arg_450_1.talkMaxDuration = var_453_18
					var_453_12 = var_453_12 + 0.3

					if var_453_18 + var_453_12 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_18 + var_453_12
					end
				end

				arg_450_1.text_.text = var_453_16
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606116", "story_v_side_new_1106606.awb") ~= 0 then
					local var_453_19 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606116", "story_v_side_new_1106606.awb") / 1000

					if var_453_19 + var_453_12 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_19 + var_453_12
					end

					if var_453_15.prefab_name ~= "" and arg_450_1.actors_[var_453_15.prefab_name] ~= nil then
						local var_453_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_15.prefab_name].transform, "story_v_side_new_1106606", "1106606116", "story_v_side_new_1106606.awb")

						arg_450_1:RecordAudio("1106606116", var_453_20)
						arg_450_1:RecordAudio("1106606116", var_453_20)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606116", "story_v_side_new_1106606.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606116", "story_v_side_new_1106606.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_21 = var_453_12 + 0.3
			local var_453_22 = math.max(var_453_13, arg_450_1.talkMaxDuration)

			if var_453_12 + 0.3 <= arg_450_1.time_ and arg_450_1.time_ < var_453_21 + var_453_22 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_21) / var_453_22

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_21 + var_453_22 and arg_450_1.time_ < var_453_21 + var_453_22 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1106606117 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1106606117
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1106606118(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 1.3

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_1 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(1106606117).content)

				arg_456_1.text_.text = var_459_1

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_3 = 52 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_1) / 52)

				if (52 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_1) / 52)) > 0 and var_459_0 < var_459_3 then
					arg_456_1.talkMaxDuration = var_459_3

					if var_459_3 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_3 + 0
					end
				end

				arg_456_1.text_.text = var_459_1
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_4 = math.max(var_459_0, arg_456_1.talkMaxDuration)

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - 0) / var_459_4

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1106606118 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1106606118
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1106606119(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0.525

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_1 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(1106606118).content)

				arg_460_1.text_.text = var_463_1

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_3 = 21 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_1) / 21)

				if (21 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_1) / 21)) > 0 and var_463_0 < var_463_3 then
					arg_460_1.talkMaxDuration = var_463_3

					if var_463_3 + 0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_3 + 0
					end
				end

				arg_460_1.text_.text = var_463_1
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_4 = math.max(var_463_0, arg_460_1.talkMaxDuration)

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_4 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - 0) / var_463_4

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= 0 + var_463_4 and arg_460_1.time_ < 0 + var_463_4 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1106606119 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1106606119
		arg_464_1.duration_ = 6.3

		local var_464_0 = {
			zh = 4.1,
			ja = 6.3
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1106606120(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0.425

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_1 = arg_464_1:GetWordFromCfg(1106606119)
				local var_467_2 = arg_464_1:FormatText(var_467_1.content)

				arg_464_1.text_.text = var_467_2

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_4 = 17 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_2) / 17)

				if (17 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_2) / 17)) > 0 and var_467_0 < var_467_4 then
					arg_464_1.talkMaxDuration = var_467_4

					if var_467_4 + 0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_4 + 0
					end
				end

				arg_464_1.text_.text = var_467_2
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606119", "story_v_side_new_1106606.awb") ~= 0 then
					local var_467_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606119", "story_v_side_new_1106606.awb") / 1000

					if var_467_5 + 0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_5 + 0
					end

					if var_467_1.prefab_name ~= "" and arg_464_1.actors_[var_467_1.prefab_name] ~= nil then
						local var_467_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_1.prefab_name].transform, "story_v_side_new_1106606", "1106606119", "story_v_side_new_1106606.awb")

						arg_464_1:RecordAudio("1106606119", var_467_6)
						arg_464_1:RecordAudio("1106606119", var_467_6)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606119", "story_v_side_new_1106606.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606119", "story_v_side_new_1106606.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_7 = math.max(var_467_0, arg_464_1.talkMaxDuration)

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_7 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - 0) / var_467_7

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= 0 + var_467_7 and arg_464_1.time_ < 0 + var_467_7 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1106606120 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1106606120
		arg_468_1.duration_ = 7.9

		local var_468_0 = {
			zh = 1.233,
			ja = 7.9
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1106606121(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0.05

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_1 = arg_468_1:GetWordFromCfg(1106606120)
				local var_471_2 = arg_468_1:FormatText(var_471_1.content)

				arg_468_1.text_.text = var_471_2

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 2 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_2) / 2)

				if (2 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_2) / 2)) > 0 and var_471_0 < var_471_4 then
					arg_468_1.talkMaxDuration = var_471_4

					if var_471_4 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_4 + 0
					end
				end

				arg_468_1.text_.text = var_471_2
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606120", "story_v_side_new_1106606.awb") ~= 0 then
					local var_471_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606120", "story_v_side_new_1106606.awb") / 1000

					if var_471_5 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_5 + 0
					end

					if var_471_1.prefab_name ~= "" and arg_468_1.actors_[var_471_1.prefab_name] ~= nil then
						local var_471_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_1.prefab_name].transform, "story_v_side_new_1106606", "1106606120", "story_v_side_new_1106606.awb")

						arg_468_1:RecordAudio("1106606120", var_471_6)
						arg_468_1:RecordAudio("1106606120", var_471_6)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606120", "story_v_side_new_1106606.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606120", "story_v_side_new_1106606.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_7 and arg_468_1.time_ < 0 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1106606121 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1106606121
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1106606122(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0.95

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, false)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_1 = arg_472_1:FormatText(arg_472_1:GetWordFromCfg(1106606121).content)

				arg_472_1.text_.text = var_475_1

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_3 = 38 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_1) / 38)

				if (38 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_1) / 38)) > 0 and var_475_0 < var_475_3 then
					arg_472_1.talkMaxDuration = var_475_3

					if var_475_3 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_3 + 0
					end
				end

				arg_472_1.text_.text = var_475_1
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_4 = math.max(var_475_0, arg_472_1.talkMaxDuration)

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_4 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - 0) / var_475_4

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= 0 + var_475_4 and arg_472_1.time_ < 0 + var_475_4 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play1106606122 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1106606122
		arg_476_1.duration_ = 3.97

		local var_476_0 = {
			zh = 3.966,
			ja = 3.9
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1106606123(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0.425

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_1 = arg_476_1:GetWordFromCfg(1106606122)
				local var_479_2 = arg_476_1:FormatText(var_479_1.content)

				arg_476_1.text_.text = var_479_2

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_4 = 17 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_2) / 17)

				if (17 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_2) / 17)) > 0 and var_479_0 < var_479_4 then
					arg_476_1.talkMaxDuration = var_479_4

					if var_479_4 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_4 + 0
					end
				end

				arg_476_1.text_.text = var_479_2
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606122", "story_v_side_new_1106606.awb") ~= 0 then
					local var_479_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606122", "story_v_side_new_1106606.awb") / 1000

					if var_479_5 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + 0
					end

					if var_479_1.prefab_name ~= "" and arg_476_1.actors_[var_479_1.prefab_name] ~= nil then
						local var_479_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_1.prefab_name].transform, "story_v_side_new_1106606", "1106606122", "story_v_side_new_1106606.awb")

						arg_476_1:RecordAudio("1106606122", var_479_6)
						arg_476_1:RecordAudio("1106606122", var_479_6)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606122", "story_v_side_new_1106606.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606122", "story_v_side_new_1106606.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_7 = math.max(var_479_0, arg_476_1.talkMaxDuration)

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_7 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - 0) / var_479_7

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= 0 + var_479_7 and arg_476_1.time_ < 0 + var_479_7 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1106606123 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1106606123
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1106606124(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0.425

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_1 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(1106606123).content)

				arg_480_1.text_.text = var_483_1

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_3 = 17 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 17)

				if (17 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 17)) > 0 and var_483_0 < var_483_3 then
					arg_480_1.talkMaxDuration = var_483_3

					if var_483_3 + 0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_3 + 0
					end
				end

				arg_480_1.text_.text = var_483_1
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_4 = math.max(var_483_0, arg_480_1.talkMaxDuration)

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_4 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - 0) / var_483_4

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= 0 + var_483_4 and arg_480_1.time_ < 0 + var_483_4 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play1106606124 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1106606124
		arg_484_1.duration_ = 3.27

		local var_484_0 = {
			zh = 3.266,
			ja = 2
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1106606125(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0.15

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_1 = arg_484_1:GetWordFromCfg(1106606124)
				local var_487_2 = arg_484_1:FormatText(var_487_1.content)

				arg_484_1.text_.text = var_487_2

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_4 = 6 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_2) / 6)

				if (6 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_2) / 6)) > 0 and var_487_0 < var_487_4 then
					arg_484_1.talkMaxDuration = var_487_4

					if var_487_4 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_4 + 0
					end
				end

				arg_484_1.text_.text = var_487_2
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606124", "story_v_side_new_1106606.awb") ~= 0 then
					local var_487_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606124", "story_v_side_new_1106606.awb") / 1000

					if var_487_5 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_5 + 0
					end

					if var_487_1.prefab_name ~= "" and arg_484_1.actors_[var_487_1.prefab_name] ~= nil then
						local var_487_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_1.prefab_name].transform, "story_v_side_new_1106606", "1106606124", "story_v_side_new_1106606.awb")

						arg_484_1:RecordAudio("1106606124", var_487_6)
						arg_484_1:RecordAudio("1106606124", var_487_6)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606124", "story_v_side_new_1106606.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606124", "story_v_side_new_1106606.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_7 = math.max(var_487_0, arg_484_1.talkMaxDuration)

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_7 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - 0) / var_487_7

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= 0 + var_487_7 and arg_484_1.time_ < 0 + var_487_7 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1106606125 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1106606125
		arg_488_1.duration_ = 9

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1106606126(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 2 < arg_488_1.time_ and arg_488_1.time_ <= 2 + arg_491_0 then
				local var_491_0 = arg_488_1.bgs_.ST10

				arg_488_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_491_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_491_1 = var_491_0:GetComponent("SpriteRenderer")

				if var_491_1 and var_491_1.sprite then
					local var_491_2 = 2 * (var_491_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_491_0.transform.localScale = Vector3.New(var_491_2 / var_491_1.sprite.bounds.size.y < var_491_2 * manager.ui.mainCameraCom_.aspect / var_491_1.sprite.bounds.size.x and var_491_2 * manager.ui.mainCameraCom_.aspect / var_491_1.sprite.bounds.size.x or var_491_2 / var_491_1.sprite.bounds.size.y, var_491_2 / var_491_1.sprite.bounds.size.y < var_491_2 * manager.ui.mainCameraCom_.aspect / var_491_1.sprite.bounds.size.x and var_491_2 * manager.ui.mainCameraCom_.aspect / var_491_1.sprite.bounds.size.x or var_491_2 / var_491_1.sprite.bounds.size.y, 0)
				end

				for iter_491_0, iter_491_1 in pairs(arg_488_1.bgs_) do
					if iter_491_0 ~= "ST10" then
						iter_491_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_491_3 = 0

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_3 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = true

				arg_488_1:SetGaussion(false)
			end

			local var_491_4 = 2

			if var_491_3 <= arg_488_1.time_ and arg_488_1.time_ < var_491_3 + var_491_4 then
				local var_491_5 = Color.New(0, 0, 0)

				var_491_5.a = Mathf.Lerp(0, 1, (arg_488_1.time_ - var_491_3) / var_491_4)
				arg_488_1.mask_.color = var_491_5
			end

			if arg_488_1.time_ >= var_491_3 + var_491_4 and arg_488_1.time_ < var_491_3 + var_491_4 + arg_491_0 then
				local var_491_6 = Color.New(0, 0, 0)

				var_491_6.a = 1
				arg_488_1.mask_.color = var_491_6
			end

			local var_491_7 = 2

			if 2 < arg_488_1.time_ and arg_488_1.time_ <= var_491_7 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = true

				arg_488_1:SetGaussion(false)
			end

			local var_491_8 = 2

			if var_491_7 <= arg_488_1.time_ and arg_488_1.time_ < var_491_7 + var_491_8 then
				local var_491_9 = Color.New(0, 0, 0)

				var_491_9.a = Mathf.Lerp(1, 0, (arg_488_1.time_ - var_491_7) / var_491_8)
				arg_488_1.mask_.color = var_491_9
			end

			if arg_488_1.time_ >= var_491_7 + var_491_8 and arg_488_1.time_ < var_491_7 + var_491_8 + arg_491_0 then
				local var_491_10 = Color.New(0, 0, 0)

				arg_488_1.mask_.enabled = false
				var_491_10.a = 0
				arg_488_1.mask_.color = var_491_10
			end

			if arg_488_1.frameCnt_ <= 1 then
				arg_488_1.dialog_:SetActive(false)
			end

			local var_491_11 = 4
			local var_491_12 = 1.075

			if 4 < arg_488_1.time_ and arg_488_1.time_ <= var_491_11 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0

				arg_488_1.dialog_:SetActive(true)

				arg_488_1.dialogCg_.alpha = 0

				local var_491_13 = LeanTween.value(arg_488_1.dialog_, 0, 1, 0.3)

				var_491_13:setOnUpdate(LuaHelper.FloatAction(function(arg_492_0)
					arg_488_1.dialogCg_.alpha = arg_492_0
				end))
				var_491_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_488_1.dialog_)
					var_491_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_488_1.duration_ = arg_488_1.duration_ + 0.3

				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_14 = arg_488_1:FormatText(arg_488_1:GetWordFromCfg(1106606125).content)

				arg_488_1.text_.text = var_491_14

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_16 = 43 <= 0 and var_491_12 or var_491_12 * (utf8.len(var_491_14) / 43)

				if (43 <= 0 and var_491_12 or var_491_12 * (utf8.len(var_491_14) / 43)) > 0 and var_491_12 < var_491_16 then
					arg_488_1.talkMaxDuration = var_491_16
					var_491_11 = var_491_11 + 0.3

					if var_491_16 + var_491_11 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_16 + var_491_11
					end
				end

				arg_488_1.text_.text = var_491_14
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_17 = var_491_11 + 0.3
			local var_491_18 = math.max(var_491_12, arg_488_1.talkMaxDuration)

			if var_491_11 + 0.3 <= arg_488_1.time_ and arg_488_1.time_ < var_491_17 + var_491_18 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_17) / var_491_18

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_17 + var_491_18 and arg_488_1.time_ < var_491_17 + var_491_18 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play1106606126 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1106606126
		arg_494_1.duration_ = 6.27

		local var_494_0 = {
			zh = 6.266,
			ja = 5.8
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
				arg_494_0:Play1106606127(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.775

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_1 = arg_494_1:GetWordFromCfg(1106606126)
				local var_497_2 = arg_494_1:FormatText(var_497_1.content)

				arg_494_1.text_.text = var_497_2

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_4 = 31 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 31)

				if (31 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 31)) > 0 and var_497_0 < var_497_4 then
					arg_494_1.talkMaxDuration = var_497_4

					if var_497_4 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_4 + 0
					end
				end

				arg_494_1.text_.text = var_497_2
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606126", "story_v_side_new_1106606.awb") ~= 0 then
					local var_497_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606126", "story_v_side_new_1106606.awb") / 1000

					if var_497_5 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + 0
					end

					if var_497_1.prefab_name ~= "" and arg_494_1.actors_[var_497_1.prefab_name] ~= nil then
						local var_497_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_1.prefab_name].transform, "story_v_side_new_1106606", "1106606126", "story_v_side_new_1106606.awb")

						arg_494_1:RecordAudio("1106606126", var_497_6)
						arg_494_1:RecordAudio("1106606126", var_497_6)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606126", "story_v_side_new_1106606.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606126", "story_v_side_new_1106606.awb")
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
	Play1106606127 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1106606127
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1106606128(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0.65

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_1 = arg_498_1:FormatText(arg_498_1:GetWordFromCfg(1106606127).content)

				arg_498_1.text_.text = var_501_1

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_3 = 26 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_1) / 26)

				if (26 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_1) / 26)) > 0 and var_501_0 < var_501_3 then
					arg_498_1.talkMaxDuration = var_501_3

					if var_501_3 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_3 + 0
					end
				end

				arg_498_1.text_.text = var_501_1
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_4 = math.max(var_501_0, arg_498_1.talkMaxDuration)

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_4 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - 0) / var_501_4

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= 0 + var_501_4 and arg_498_1.time_ < 0 + var_501_4 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1106606128 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1106606128
		arg_502_1.duration_ = 8

		local var_502_0 = {
			zh = 8,
			ja = 7.6
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1106606129(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.var_.moveOldPos1066ui_story = arg_502_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_505_0 = 0.001

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 then
				arg_502_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_502_1.time_ - 0) / var_505_0)
				arg_502_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_502_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1066ui_story"].transform.position).z)
				arg_502_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_502_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_502_1.actors_["1066ui_story"].transform.localEulerAngles = arg_502_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 then
				arg_502_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_502_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_502_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1066ui_story"].transform.position).z)
				arg_502_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_502_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_502_1.actors_["1066ui_story"].transform.localEulerAngles = arg_502_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_505_1 = arg_502_1.actors_["1066ui_story"]

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(var_505_1) and arg_502_1.var_.characterEffect1066ui_story == nil then
				arg_502_1.var_.characterEffect1066ui_story = var_505_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_2 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_2 and not isNil(var_505_1) then
				if arg_502_1.var_.characterEffect1066ui_story and not isNil(var_505_1) then
					arg_502_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= 0 + var_505_2 and arg_502_1.time_ < 0 + var_505_2 + arg_505_0 and not isNil(var_505_1) and arg_502_1.var_.characterEffect1066ui_story then
				arg_502_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_505_4 = 0
			local var_505_5 = 0.775

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_4 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_6 = arg_502_1:GetWordFromCfg(1106606128)
				local var_505_7 = arg_502_1:FormatText(var_505_6.content)

				arg_502_1.text_.text = var_505_7

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_9 = 31 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_7) / 31)

				if (31 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_7) / 31)) > 0 and var_505_5 < var_505_9 then
					arg_502_1.talkMaxDuration = var_505_9

					if var_505_9 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_9 + var_505_4
					end
				end

				arg_502_1.text_.text = var_505_7
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606128", "story_v_side_new_1106606.awb") ~= 0 then
					local var_505_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606128", "story_v_side_new_1106606.awb") / 1000

					if var_505_10 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_10 + var_505_4
					end

					if var_505_6.prefab_name ~= "" and arg_502_1.actors_[var_505_6.prefab_name] ~= nil then
						local var_505_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_6.prefab_name].transform, "story_v_side_new_1106606", "1106606128", "story_v_side_new_1106606.awb")

						arg_502_1:RecordAudio("1106606128", var_505_11)
						arg_502_1:RecordAudio("1106606128", var_505_11)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606128", "story_v_side_new_1106606.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606128", "story_v_side_new_1106606.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_12 = math.max(var_505_5, arg_502_1.talkMaxDuration)

			if var_505_4 <= arg_502_1.time_ and arg_502_1.time_ < var_505_4 + var_505_12 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_4) / var_505_12

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_4 + var_505_12 and arg_502_1.time_ < var_505_4 + var_505_12 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
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

		arg_502_1:InitPlayNodeList()
	end,
	Play1106606129 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1106606129
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1106606130(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(arg_506_1.actors_["1066ui_story"]) and arg_506_1.var_.characterEffect1066ui_story == nil then
				arg_506_1.var_.characterEffect1066ui_story = arg_506_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_0 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 and not isNil(arg_506_1.actors_["1066ui_story"]) then
				if arg_506_1.var_.characterEffect1066ui_story and not isNil(arg_506_1.actors_["1066ui_story"]) then
					arg_506_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_506_1.time_ - 0) / var_509_0)
				end
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 and not isNil(arg_506_1.actors_["1066ui_story"]) and arg_506_1.var_.characterEffect1066ui_story then
				arg_506_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_509_1 = 0
			local var_509_2 = 0.125

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_3 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(1106606129).content)

				arg_506_1.text_.text = var_509_3

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 5 <= 0 and var_509_2 or var_509_2 * (utf8.len(var_509_3) / 5)

				if (5 <= 0 and var_509_2 or var_509_2 * (utf8.len(var_509_3) / 5)) > 0 and var_509_2 < var_509_5 then
					arg_506_1.talkMaxDuration = var_509_5

					if var_509_5 + var_509_1 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_5 + var_509_1
					end
				end

				arg_506_1.text_.text = var_509_3
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_6 = math.max(var_509_2, arg_506_1.talkMaxDuration)

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_6 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_1) / var_509_6

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_1 + var_509_6 and arg_506_1.time_ < var_509_1 + var_509_6 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1106606130 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1106606130
		arg_510_1.duration_ = 8.57

		local var_510_0 = {
			zh = 6.8,
			ja = 8.566
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1106606131(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.var_.moveOldPos1066ui_story = arg_510_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_513_0 = 0.001

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 then
				arg_510_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_510_1.time_ - 0) / var_513_0)
				arg_510_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1066ui_story"].transform.position).z)
				arg_510_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["1066ui_story"].transform.localEulerAngles = arg_510_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 then
				arg_510_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_510_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1066ui_story"].transform.position).z)
				arg_510_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["1066ui_story"].transform.localEulerAngles = arg_510_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_513_1 = arg_510_1.actors_["1066ui_story"]

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(var_513_1) and arg_510_1.var_.characterEffect1066ui_story == nil then
				arg_510_1.var_.characterEffect1066ui_story = var_513_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_2 and not isNil(var_513_1) then
				if arg_510_1.var_.characterEffect1066ui_story and not isNil(var_513_1) then
					arg_510_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= 0 + var_513_2 and arg_510_1.time_ < 0 + var_513_2 + arg_513_0 and not isNil(var_513_1) and arg_510_1.var_.characterEffect1066ui_story then
				arg_510_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_513_4 = 0
			local var_513_5 = 0.7

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_4 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_6 = arg_510_1:GetWordFromCfg(1106606130)
				local var_513_7 = arg_510_1:FormatText(var_513_6.content)

				arg_510_1.text_.text = var_513_7

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_9 = 28 <= 0 and var_513_5 or var_513_5 * (utf8.len(var_513_7) / 28)

				if (28 <= 0 and var_513_5 or var_513_5 * (utf8.len(var_513_7) / 28)) > 0 and var_513_5 < var_513_9 then
					arg_510_1.talkMaxDuration = var_513_9

					if var_513_9 + var_513_4 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_9 + var_513_4
					end
				end

				arg_510_1.text_.text = var_513_7
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606130", "story_v_side_new_1106606.awb") ~= 0 then
					local var_513_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606130", "story_v_side_new_1106606.awb") / 1000

					if var_513_10 + var_513_4 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_10 + var_513_4
					end

					if var_513_6.prefab_name ~= "" and arg_510_1.actors_[var_513_6.prefab_name] ~= nil then
						local var_513_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_6.prefab_name].transform, "story_v_side_new_1106606", "1106606130", "story_v_side_new_1106606.awb")

						arg_510_1:RecordAudio("1106606130", var_513_11)
						arg_510_1:RecordAudio("1106606130", var_513_11)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606130", "story_v_side_new_1106606.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606130", "story_v_side_new_1106606.awb")
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
				actorName = "1066ui_story",
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
	Play1106606131 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1106606131
		arg_514_1.duration_ = 14.97

		local var_514_0 = {
			zh = 14.966,
			ja = 12.833
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
				arg_514_0:Play1106606132(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 2 < arg_514_1.time_ and arg_514_1.time_ <= 2 + arg_517_0 then
				local var_517_0 = arg_514_1.bgs_.ST10

				arg_514_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_517_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_517_1 = var_517_0:GetComponent("SpriteRenderer")

				if var_517_1 and var_517_1.sprite then
					local var_517_2 = 2 * (var_517_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_517_0.transform.localScale = Vector3.New(var_517_2 / var_517_1.sprite.bounds.size.y < var_517_2 * manager.ui.mainCameraCom_.aspect / var_517_1.sprite.bounds.size.x and var_517_2 * manager.ui.mainCameraCom_.aspect / var_517_1.sprite.bounds.size.x or var_517_2 / var_517_1.sprite.bounds.size.y, var_517_2 / var_517_1.sprite.bounds.size.y < var_517_2 * manager.ui.mainCameraCom_.aspect / var_517_1.sprite.bounds.size.x and var_517_2 * manager.ui.mainCameraCom_.aspect / var_517_1.sprite.bounds.size.x or var_517_2 / var_517_1.sprite.bounds.size.y, 0)
				end

				for iter_517_0, iter_517_1 in pairs(arg_514_1.bgs_) do
					if iter_517_0 ~= "ST10" then
						iter_517_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_517_3 = 0

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_3 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_4 = 2

			if var_517_3 <= arg_514_1.time_ and arg_514_1.time_ < var_517_3 + var_517_4 then
				local var_517_5 = Color.New(0, 0, 0)

				var_517_5.a = Mathf.Lerp(0, 1, (arg_514_1.time_ - var_517_3) / var_517_4)
				arg_514_1.mask_.color = var_517_5
			end

			if arg_514_1.time_ >= var_517_3 + var_517_4 and arg_514_1.time_ < var_517_3 + var_517_4 + arg_517_0 then
				local var_517_6 = Color.New(0, 0, 0)

				var_517_6.a = 1
				arg_514_1.mask_.color = var_517_6
			end

			local var_517_7 = 2

			if 2 < arg_514_1.time_ and arg_514_1.time_ <= var_517_7 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_8 = 2

			if var_517_7 <= arg_514_1.time_ and arg_514_1.time_ < var_517_7 + var_517_8 then
				local var_517_9 = Color.New(0, 0, 0)

				var_517_9.a = Mathf.Lerp(1, 0, (arg_514_1.time_ - var_517_7) / var_517_8)
				arg_514_1.mask_.color = var_517_9
			end

			if arg_514_1.time_ >= var_517_7 + var_517_8 and arg_514_1.time_ < var_517_7 + var_517_8 + arg_517_0 then
				local var_517_10 = Color.New(0, 0, 0)

				arg_514_1.mask_.enabled = false
				var_517_10.a = 0
				arg_514_1.mask_.color = var_517_10
			end

			local var_517_11 = arg_514_1.actors_["1066ui_story"].transform

			if 4 < arg_514_1.time_ and arg_514_1.time_ <= 4 + arg_517_0 then
				arg_514_1.var_.moveOldPos1066ui_story = var_517_11.localPosition
			end

			local var_517_12 = 0.001

			if 4 <= arg_514_1.time_ and arg_514_1.time_ < 4 + var_517_12 then
				var_517_11.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_514_1.time_ - 4) / var_517_12)
				var_517_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_11.position).x, (manager.ui.mainCamera.transform.position - var_517_11.position).y, (manager.ui.mainCamera.transform.position - var_517_11.position).z)
				var_517_11.localEulerAngles.z = 0
				var_517_11.localEulerAngles.x = 0
				var_517_11.localEulerAngles = var_517_11.localEulerAngles
			end

			if arg_514_1.time_ >= 4 + var_517_12 and arg_514_1.time_ < 4 + var_517_12 + arg_517_0 then
				var_517_11.localPosition = Vector3.New(0, -0.77, -6.1)
				var_517_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_11.position).x, (manager.ui.mainCamera.transform.position - var_517_11.position).y, (manager.ui.mainCamera.transform.position - var_517_11.position).z)
				var_517_11.localEulerAngles.z = 0
				var_517_11.localEulerAngles.x = 0
				var_517_11.localEulerAngles = var_517_11.localEulerAngles
			end

			local var_517_13 = arg_514_1.actors_["1066ui_story"]

			if 4 < arg_514_1.time_ and arg_514_1.time_ <= 4 + arg_517_0 and not isNil(var_517_13) and arg_514_1.var_.characterEffect1066ui_story == nil then
				arg_514_1.var_.characterEffect1066ui_story = var_517_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_14 = 0.200000002980232

			if 4 <= arg_514_1.time_ and arg_514_1.time_ < 4 + var_517_14 and not isNil(var_517_13) then
				if arg_514_1.var_.characterEffect1066ui_story and not isNil(var_517_13) then
					arg_514_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 4 + var_517_14 and arg_514_1.time_ < 4 + var_517_14 + arg_517_0 and not isNil(var_517_13) and arg_514_1.var_.characterEffect1066ui_story then
				arg_514_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 4 < arg_514_1.time_ and arg_514_1.time_ <= 4 + arg_517_0 then
				arg_514_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 4 < arg_514_1.time_ and arg_514_1.time_ <= 4 + arg_517_0 then
				arg_514_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_517_16 = arg_514_1.actors_["1066ui_story"].transform

			if 2 < arg_514_1.time_ and arg_514_1.time_ <= 2 + arg_517_0 then
				arg_514_1.var_.moveOldPos1066ui_story = var_517_16.localPosition
			end

			local var_517_17 = 0.001

			if 2 <= arg_514_1.time_ and arg_514_1.time_ < 2 + var_517_17 then
				var_517_16.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_514_1.time_ - 2) / var_517_17)
				var_517_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_16.position).x, (manager.ui.mainCamera.transform.position - var_517_16.position).y, (manager.ui.mainCamera.transform.position - var_517_16.position).z)
				var_517_16.localEulerAngles.z = 0
				var_517_16.localEulerAngles.x = 0
				var_517_16.localEulerAngles = var_517_16.localEulerAngles
			end

			if arg_514_1.time_ >= 2 + var_517_17 and arg_514_1.time_ < 2 + var_517_17 + arg_517_0 then
				var_517_16.localPosition = Vector3.New(0, 100, 0)
				var_517_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_16.position).x, (manager.ui.mainCamera.transform.position - var_517_16.position).y, (manager.ui.mainCamera.transform.position - var_517_16.position).z)
				var_517_16.localEulerAngles.z = 0
				var_517_16.localEulerAngles.x = 0
				var_517_16.localEulerAngles = var_517_16.localEulerAngles
			end

			if arg_514_1.frameCnt_ <= 1 then
				arg_514_1.dialog_:SetActive(false)
			end

			local var_517_18 = 4
			local var_517_19 = 1.325

			if 4 < arg_514_1.time_ and arg_514_1.time_ <= var_517_18 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0

				arg_514_1.dialog_:SetActive(true)

				arg_514_1.dialogCg_.alpha = 0

				local var_517_20 = LeanTween.value(arg_514_1.dialog_, 0, 1, 0.3)

				var_517_20:setOnUpdate(LuaHelper.FloatAction(function(arg_518_0)
					arg_514_1.dialogCg_.alpha = arg_518_0
				end))
				var_517_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_514_1.dialog_)
					var_517_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_514_1.duration_ = arg_514_1.duration_ + 0.3

				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_21 = arg_514_1:GetWordFromCfg(1106606131)
				local var_517_22 = arg_514_1:FormatText(var_517_21.content)

				arg_514_1.text_.text = var_517_22

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_24 = 53 <= 0 and var_517_19 or var_517_19 * (utf8.len(var_517_22) / 53)

				if (53 <= 0 and var_517_19 or var_517_19 * (utf8.len(var_517_22) / 53)) > 0 and var_517_19 < var_517_24 then
					arg_514_1.talkMaxDuration = var_517_24
					var_517_18 = var_517_18 + 0.3

					if var_517_24 + var_517_18 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_24 + var_517_18
					end
				end

				arg_514_1.text_.text = var_517_22
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606131", "story_v_side_new_1106606.awb") ~= 0 then
					local var_517_25 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606131", "story_v_side_new_1106606.awb") / 1000

					if var_517_25 + var_517_18 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_25 + var_517_18
					end

					if var_517_21.prefab_name ~= "" and arg_514_1.actors_[var_517_21.prefab_name] ~= nil then
						local var_517_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_21.prefab_name].transform, "story_v_side_new_1106606", "1106606131", "story_v_side_new_1106606.awb")

						arg_514_1:RecordAudio("1106606131", var_517_26)
						arg_514_1:RecordAudio("1106606131", var_517_26)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606131", "story_v_side_new_1106606.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606131", "story_v_side_new_1106606.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_27 = var_517_18 + 0.3
			local var_517_28 = math.max(var_517_19, arg_514_1.talkMaxDuration)

			if var_517_18 + 0.3 <= arg_514_1.time_ and arg_514_1.time_ < var_517_27 + var_517_28 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_27) / var_517_28

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_27 + var_517_28 and arg_514_1.time_ < var_517_27 + var_517_28 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play1106606132 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1106606132
		arg_520_1.duration_ = 4.43

		local var_520_0 = {
			zh = 4.2,
			ja = 4.433
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1106606133(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos1066ui_story = arg_520_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_523_0 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_0 then
				arg_520_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_520_1.time_ - 0) / var_523_0)
				arg_520_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_520_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1066ui_story"].transform.position).z)
				arg_520_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_520_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_520_1.actors_["1066ui_story"].transform.localEulerAngles = arg_520_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_520_1.time_ >= 0 + var_523_0 and arg_520_1.time_ < 0 + var_523_0 + arg_523_0 then
				arg_520_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_520_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_520_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1066ui_story"].transform.position).z)
				arg_520_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_520_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_520_1.actors_["1066ui_story"].transform.localEulerAngles = arg_520_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_523_1 = arg_520_1.actors_["1066ui_story"]

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(var_523_1) and arg_520_1.var_.characterEffect1066ui_story == nil then
				arg_520_1.var_.characterEffect1066ui_story = var_523_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_2 = 0.200000002980232

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_2 and not isNil(var_523_1) then
				if arg_520_1.var_.characterEffect1066ui_story and not isNil(var_523_1) then
					arg_520_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_520_1.time_ >= 0 + var_523_2 and arg_520_1.time_ < 0 + var_523_2 + arg_523_0 and not isNil(var_523_1) and arg_520_1.var_.characterEffect1066ui_story then
				arg_520_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_523_4 = 0
			local var_523_5 = 0.5

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_4 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_6 = arg_520_1:GetWordFromCfg(1106606132)
				local var_523_7 = arg_520_1:FormatText(var_523_6.content)

				arg_520_1.text_.text = var_523_7

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_9 = 20 <= 0 and var_523_5 or var_523_5 * (utf8.len(var_523_7) / 20)

				if (20 <= 0 and var_523_5 or var_523_5 * (utf8.len(var_523_7) / 20)) > 0 and var_523_5 < var_523_9 then
					arg_520_1.talkMaxDuration = var_523_9

					if var_523_9 + var_523_4 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_9 + var_523_4
					end
				end

				arg_520_1.text_.text = var_523_7
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606132", "story_v_side_new_1106606.awb") ~= 0 then
					local var_523_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606132", "story_v_side_new_1106606.awb") / 1000

					if var_523_10 + var_523_4 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_10 + var_523_4
					end

					if var_523_6.prefab_name ~= "" and arg_520_1.actors_[var_523_6.prefab_name] ~= nil then
						local var_523_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_6.prefab_name].transform, "story_v_side_new_1106606", "1106606132", "story_v_side_new_1106606.awb")

						arg_520_1:RecordAudio("1106606132", var_523_11)
						arg_520_1:RecordAudio("1106606132", var_523_11)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606132", "story_v_side_new_1106606.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606132", "story_v_side_new_1106606.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_12 = math.max(var_523_5, arg_520_1.talkMaxDuration)

			if var_523_4 <= arg_520_1.time_ and arg_520_1.time_ < var_523_4 + var_523_12 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_4) / var_523_12

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_4 + var_523_12 and arg_520_1.time_ < var_523_4 + var_523_12 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
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

		arg_520_1:InitPlayNodeList()
	end,
	Play1106606133 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1106606133
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play1106606134(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(arg_524_1.actors_["1066ui_story"]) and arg_524_1.var_.characterEffect1066ui_story == nil then
				arg_524_1.var_.characterEffect1066ui_story = arg_524_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_0 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 and not isNil(arg_524_1.actors_["1066ui_story"]) then
				if arg_524_1.var_.characterEffect1066ui_story and not isNil(arg_524_1.actors_["1066ui_story"]) then
					arg_524_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_524_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_524_1.time_ - 0) / var_527_0)
				end
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 and not isNil(arg_524_1.actors_["1066ui_story"]) and arg_524_1.var_.characterEffect1066ui_story then
				arg_524_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_524_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_527_1 = 0
			local var_527_2 = 1.05

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_3 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(1106606133).content)

				arg_524_1.text_.text = var_527_3

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 42 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 42)

				if (42 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 42)) > 0 and var_527_2 < var_527_5 then
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
	Play1106606134 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1106606134
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1106606135(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0.3

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(1, 1, 1)
				arg_528_1.icon_.color = Color.New(1, 1, 1)

				local var_531_1 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(1106606134).content)

				arg_528_1.text_.text = var_531_1

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_3 = 12 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 12)

				if (12 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 12)) > 0 and var_531_0 < var_531_3 then
					arg_528_1.talkMaxDuration = var_531_3

					if var_531_3 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_3 + 0
					end
				end

				arg_528_1.text_.text = var_531_1
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_4 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_4

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1106606135 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1106606135
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1106606136(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.75

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_1 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(1106606135).content)

				arg_532_1.text_.text = var_535_1

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_3 = 30 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 30)

				if (30 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 30)) > 0 and var_535_0 < var_535_3 then
					arg_532_1.talkMaxDuration = var_535_3

					if var_535_3 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_3 + 0
					end
				end

				arg_532_1.text_.text = var_535_1
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_4 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_4

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1106606136 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1106606136
		arg_536_1.duration_ = 2.33

		local var_536_0 = {
			zh = 2.333,
			ja = 2
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1106606137(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.var_.moveOldPos1066ui_story = arg_536_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_539_0 = 0.001

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 then
				arg_536_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_536_1.time_ - 0) / var_539_0)
				arg_536_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1066ui_story"].transform.position).z)
				arg_536_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["1066ui_story"].transform.localEulerAngles = arg_536_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 then
				arg_536_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_536_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1066ui_story"].transform.position).z)
				arg_536_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["1066ui_story"].transform.localEulerAngles = arg_536_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_539_1 = arg_536_1.actors_["1066ui_story"]

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(var_539_1) and arg_536_1.var_.characterEffect1066ui_story == nil then
				arg_536_1.var_.characterEffect1066ui_story = var_539_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_2 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_2 and not isNil(var_539_1) then
				if arg_536_1.var_.characterEffect1066ui_story and not isNil(var_539_1) then
					arg_536_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_536_1.time_ >= 0 + var_539_2 and arg_536_1.time_ < 0 + var_539_2 + arg_539_0 and not isNil(var_539_1) and arg_536_1.var_.characterEffect1066ui_story then
				arg_536_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_539_4 = 0
			local var_539_5 = 0.275

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_4 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_6 = arg_536_1:GetWordFromCfg(1106606136)
				local var_539_7 = arg_536_1:FormatText(var_539_6.content)

				arg_536_1.text_.text = var_539_7

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_9 = 11 <= 0 and var_539_5 or var_539_5 * (utf8.len(var_539_7) / 11)

				if (11 <= 0 and var_539_5 or var_539_5 * (utf8.len(var_539_7) / 11)) > 0 and var_539_5 < var_539_9 then
					arg_536_1.talkMaxDuration = var_539_9

					if var_539_9 + var_539_4 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_9 + var_539_4
					end
				end

				arg_536_1.text_.text = var_539_7
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606136", "story_v_side_new_1106606.awb") ~= 0 then
					local var_539_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606136", "story_v_side_new_1106606.awb") / 1000

					if var_539_10 + var_539_4 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_10 + var_539_4
					end

					if var_539_6.prefab_name ~= "" and arg_536_1.actors_[var_539_6.prefab_name] ~= nil then
						local var_539_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_6.prefab_name].transform, "story_v_side_new_1106606", "1106606136", "story_v_side_new_1106606.awb")

						arg_536_1:RecordAudio("1106606136", var_539_11)
						arg_536_1:RecordAudio("1106606136", var_539_11)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606136", "story_v_side_new_1106606.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606136", "story_v_side_new_1106606.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_12 = math.max(var_539_5, arg_536_1.talkMaxDuration)

			if var_539_4 <= arg_536_1.time_ and arg_536_1.time_ < var_539_4 + var_539_12 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_4) / var_539_12

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_4 + var_539_12 and arg_536_1.time_ < var_539_4 + var_539_12 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
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

		arg_536_1:InitPlayNodeList()
	end,
	Play1106606137 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1106606137
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1106606138(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.var_.moveOldPos1066ui_story = arg_540_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_543_0 = 0.001

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_0 then
				arg_540_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_540_1.time_ - 0) / var_543_0)
				arg_540_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_540_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1066ui_story"].transform.position).z)
				arg_540_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_540_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_540_1.actors_["1066ui_story"].transform.localEulerAngles = arg_540_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_540_1.time_ >= 0 + var_543_0 and arg_540_1.time_ < 0 + var_543_0 + arg_543_0 then
				arg_540_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_540_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_540_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1066ui_story"].transform.position).z)
				arg_540_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_540_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_540_1.actors_["1066ui_story"].transform.localEulerAngles = arg_540_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_543_1 = 0
			local var_543_2 = 1.075

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_3 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(1106606137).content)

				arg_540_1.text_.text = var_543_3

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 43 <= 0 and var_543_2 or var_543_2 * (utf8.len(var_543_3) / 43)

				if (43 <= 0 and var_543_2 or var_543_2 * (utf8.len(var_543_3) / 43)) > 0 and var_543_2 < var_543_5 then
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

		arg_540_1.nodeConfigList_ = {
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

		arg_540_1:InitPlayNodeList()
	end,
	Play1106606138 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1106606138
		arg_544_1.duration_ = 1

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"

			SetActive(arg_544_1.choicesGo_, true)

			for iter_545_0, iter_545_1 in ipairs(arg_544_1.choices_) do
				SetActive(iter_545_1.go, iter_545_0 <= 1)
			end

			arg_544_1.choices_[1].txt.text = arg_544_1:FormatText(StoryChoiceCfg[564].name)
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1106606139(arg_544_1)
			end

			arg_544_1:RecordChoiceLog(1106606138, 564)
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.allBtn_.enabled = false
			end

			if arg_544_1.time_ >= 0 + 0.5 and arg_544_1.time_ < 0 + 0.5 + arg_547_0 then
				arg_544_1.allBtn_.enabled = true
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play1106606139 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 1106606139
		arg_548_1.duration_ = 1.73

		local var_548_0 = {
			zh = 1.733,
			ja = 1.433
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play1106606140(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0.325

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_1 = arg_548_1:GetWordFromCfg(1106606139)
				local var_551_2 = arg_548_1:FormatText(var_551_1.content)

				arg_548_1.text_.text = var_551_2

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_4 = 13 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_2) / 13)

				if (13 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_2) / 13)) > 0 and var_551_0 < var_551_4 then
					arg_548_1.talkMaxDuration = var_551_4

					if var_551_4 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_4 + 0
					end
				end

				arg_548_1.text_.text = var_551_2
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606139", "story_v_side_new_1106606.awb") ~= 0 then
					local var_551_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606139", "story_v_side_new_1106606.awb") / 1000

					if var_551_5 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_5 + 0
					end

					if var_551_1.prefab_name ~= "" and arg_548_1.actors_[var_551_1.prefab_name] ~= nil then
						local var_551_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_1.prefab_name].transform, "story_v_side_new_1106606", "1106606139", "story_v_side_new_1106606.awb")

						arg_548_1:RecordAudio("1106606139", var_551_6)
						arg_548_1:RecordAudio("1106606139", var_551_6)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606139", "story_v_side_new_1106606.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606139", "story_v_side_new_1106606.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_7 = math.max(var_551_0, arg_548_1.talkMaxDuration)

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_7 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - 0) / var_551_7

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= 0 + var_551_7 and arg_548_1.time_ < 0 + var_551_7 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play1106606140 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1106606140
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play1106606141(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.175

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_1 = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(1106606140).content)

				arg_552_1.text_.text = var_555_1

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_3 = 7 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_1) / 7)

				if (7 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_1) / 7)) > 0 and var_555_0 < var_555_3 then
					arg_552_1.talkMaxDuration = var_555_3

					if var_555_3 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_3 + 0
					end
				end

				arg_552_1.text_.text = var_555_1
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_4 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_4 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_4

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_4 and arg_552_1.time_ < 0 + var_555_4 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play1106606141 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 1106606141
		arg_556_1.duration_ = 4

		local var_556_0 = {
			zh = 2.8,
			ja = 4
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play1106606142(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0.45

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_1 = arg_556_1:GetWordFromCfg(1106606141)
				local var_559_2 = arg_556_1:FormatText(var_559_1.content)

				arg_556_1.text_.text = var_559_2

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_4 = 18 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_2) / 18)

				if (18 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_2) / 18)) > 0 and var_559_0 < var_559_4 then
					arg_556_1.talkMaxDuration = var_559_4

					if var_559_4 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_4 + 0
					end
				end

				arg_556_1.text_.text = var_559_2
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606141", "story_v_side_new_1106606.awb") ~= 0 then
					local var_559_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606141", "story_v_side_new_1106606.awb") / 1000

					if var_559_5 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_5 + 0
					end

					if var_559_1.prefab_name ~= "" and arg_556_1.actors_[var_559_1.prefab_name] ~= nil then
						local var_559_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_1.prefab_name].transform, "story_v_side_new_1106606", "1106606141", "story_v_side_new_1106606.awb")

						arg_556_1:RecordAudio("1106606141", var_559_6)
						arg_556_1:RecordAudio("1106606141", var_559_6)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606141", "story_v_side_new_1106606.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606141", "story_v_side_new_1106606.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_7 = math.max(var_559_0, arg_556_1.talkMaxDuration)

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_7 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - 0) / var_559_7

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= 0 + var_559_7 and arg_556_1.time_ < 0 + var_559_7 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play1106606142 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 1106606142
		arg_560_1.duration_ = 4.6

		local var_560_0 = {
			zh = 3.166,
			ja = 4.6
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play1106606143(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0.225

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_1 = arg_560_1:GetWordFromCfg(1106606142)
				local var_563_2 = arg_560_1:FormatText(var_563_1.content)

				arg_560_1.text_.text = var_563_2

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_4 = 9 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 9)

				if (9 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 9)) > 0 and var_563_0 < var_563_4 then
					arg_560_1.talkMaxDuration = var_563_4

					if var_563_4 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_4 + 0
					end
				end

				arg_560_1.text_.text = var_563_2
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606142", "story_v_side_new_1106606.awb") ~= 0 then
					local var_563_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606142", "story_v_side_new_1106606.awb") / 1000

					if var_563_5 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + 0
					end

					if var_563_1.prefab_name ~= "" and arg_560_1.actors_[var_563_1.prefab_name] ~= nil then
						local var_563_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_1.prefab_name].transform, "story_v_side_new_1106606", "1106606142", "story_v_side_new_1106606.awb")

						arg_560_1:RecordAudio("1106606142", var_563_6)
						arg_560_1:RecordAudio("1106606142", var_563_6)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606142", "story_v_side_new_1106606.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606142", "story_v_side_new_1106606.awb")
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
	Play1106606143 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 1106606143
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play1106606144(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0.375

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
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

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_1 = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(1106606143).content)

				arg_564_1.text_.text = var_567_1

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_3 = 15 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_1) / 15)

				if (15 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_1) / 15)) > 0 and var_567_0 < var_567_3 then
					arg_564_1.talkMaxDuration = var_567_3

					if var_567_3 + 0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_3 + 0
					end
				end

				arg_564_1.text_.text = var_567_1
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_4 = math.max(var_567_0, arg_564_1.talkMaxDuration)

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_4 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - 0) / var_567_4

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= 0 + var_567_4 and arg_564_1.time_ < 0 + var_567_4 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play1106606144 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 1106606144
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play1106606145(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0.65

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, false)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_1 = arg_568_1:FormatText(arg_568_1:GetWordFromCfg(1106606144).content)

				arg_568_1.text_.text = var_571_1

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_3 = 26 <= 0 and var_571_0 or var_571_0 * (utf8.len(var_571_1) / 26)

				if (26 <= 0 and var_571_0 or var_571_0 * (utf8.len(var_571_1) / 26)) > 0 and var_571_0 < var_571_3 then
					arg_568_1.talkMaxDuration = var_571_3

					if var_571_3 + 0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_3 + 0
					end
				end

				arg_568_1.text_.text = var_571_1
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_4 = math.max(var_571_0, arg_568_1.talkMaxDuration)

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_4 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - 0) / var_571_4

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= 0 + var_571_4 and arg_568_1.time_ < 0 + var_571_4 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play1106606145 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 1106606145
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play1106606146(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0.6

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, false)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_1 = arg_572_1:FormatText(arg_572_1:GetWordFromCfg(1106606145).content)

				arg_572_1.text_.text = var_575_1

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_3 = 24 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_1) / 24)

				if (24 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_1) / 24)) > 0 and var_575_0 < var_575_3 then
					arg_572_1.talkMaxDuration = var_575_3

					if var_575_3 + 0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_3 + 0
					end
				end

				arg_572_1.text_.text = var_575_1
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_4 = math.max(var_575_0, arg_572_1.talkMaxDuration)

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_4 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - 0) / var_575_4

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= 0 + var_575_4 and arg_572_1.time_ < 0 + var_575_4 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play1106606146 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 1106606146
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play1106606147(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 0.7

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_1 = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(1106606146).content)

				arg_576_1.text_.text = var_579_1

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_3 = 28 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_1) / 28)

				if (28 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_1) / 28)) > 0 and var_579_0 < var_579_3 then
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
	Play1106606147 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 1106606147
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play1106606148(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action434")
			end

			local var_583_0 = 0
			local var_583_1 = 0.65

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_0 + arg_583_0 then
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

				arg_580_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_580_1.callingController_:SetSelectedState("normal")

				arg_580_1.keyicon_.color = Color.New(1, 1, 1)
				arg_580_1.icon_.color = Color.New(1, 1, 1)

				local var_583_2 = arg_580_1:FormatText(arg_580_1:GetWordFromCfg(1106606147).content)

				arg_580_1.text_.text = var_583_2

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_4 = 26 <= 0 and var_583_1 or var_583_1 * (utf8.len(var_583_2) / 26)

				if (26 <= 0 and var_583_1 or var_583_1 * (utf8.len(var_583_2) / 26)) > 0 and var_583_1 < var_583_4 then
					arg_580_1.talkMaxDuration = var_583_4

					if var_583_4 + var_583_0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_4 + var_583_0
					end
				end

				arg_580_1.text_.text = var_583_2
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_5 = math.max(var_583_1, arg_580_1.talkMaxDuration)

			if var_583_0 <= arg_580_1.time_ and arg_580_1.time_ < var_583_0 + var_583_5 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_0) / var_583_5

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_0 + var_583_5 and arg_580_1.time_ < var_583_0 + var_583_5 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play1106606148 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 1106606148
		arg_584_1.duration_ = 2.83

		local var_584_0 = {
			zh = 2.833,
			ja = 2.366666666666
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play1106606149(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.var_.moveOldPos1066ui_story = arg_584_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_587_0 = 0.001

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_0 then
				arg_584_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_584_1.time_ - 0) / var_587_0)
				arg_584_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_584_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_584_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_584_1.actors_["1066ui_story"].transform.position).z)
				arg_584_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_584_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_584_1.actors_["1066ui_story"].transform.localEulerAngles = arg_584_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_584_1.time_ >= 0 + var_587_0 and arg_584_1.time_ < 0 + var_587_0 + arg_587_0 then
				arg_584_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_584_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_584_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_584_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_584_1.actors_["1066ui_story"].transform.position).z)
				arg_584_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_584_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_584_1.actors_["1066ui_story"].transform.localEulerAngles = arg_584_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_587_1 = arg_584_1.actors_["1066ui_story"]

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 and not isNil(var_587_1) and arg_584_1.var_.characterEffect1066ui_story == nil then
				arg_584_1.var_.characterEffect1066ui_story = var_587_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_587_2 = 0.200000002980232

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_2 and not isNil(var_587_1) then
				if arg_584_1.var_.characterEffect1066ui_story and not isNil(var_587_1) then
					arg_584_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_584_1.time_ >= 0 + var_587_2 and arg_584_1.time_ < 0 + var_587_2 + arg_587_0 and not isNil(var_587_1) and arg_584_1.var_.characterEffect1066ui_story then
				arg_584_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_587_4 = 0

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_4 + arg_587_0 then
				arg_584_1.allBtn_.enabled = false
			end

			if arg_584_1.time_ >= var_587_4 + 2.36666666666667 and arg_584_1.time_ < var_587_4 + 2.36666666666667 + arg_587_0 then
				arg_584_1.allBtn_.enabled = true
			end

			local var_587_5 = 0
			local var_587_6 = 0.5

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_5 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				arg_584_1.leftNameTxt_.text = arg_584_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_7 = arg_584_1:GetWordFromCfg(1106606148)
				local var_587_8 = arg_584_1:FormatText(var_587_7.content)

				arg_584_1.text_.text = var_587_8

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_10 = 20 <= 0 and var_587_6 or var_587_6 * (utf8.len(var_587_8) / 20)

				if (20 <= 0 and var_587_6 or var_587_6 * (utf8.len(var_587_8) / 20)) > 0 and var_587_6 < var_587_10 then
					arg_584_1.talkMaxDuration = var_587_10

					if var_587_10 + var_587_5 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_10 + var_587_5
					end
				end

				arg_584_1.text_.text = var_587_8
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606148", "story_v_side_new_1106606.awb") ~= 0 then
					local var_587_11 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606148", "story_v_side_new_1106606.awb") / 1000

					if var_587_11 + var_587_5 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_11 + var_587_5
					end

					if var_587_7.prefab_name ~= "" and arg_584_1.actors_[var_587_7.prefab_name] ~= nil then
						local var_587_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_7.prefab_name].transform, "story_v_side_new_1106606", "1106606148", "story_v_side_new_1106606.awb")

						arg_584_1:RecordAudio("1106606148", var_587_12)
						arg_584_1:RecordAudio("1106606148", var_587_12)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606148", "story_v_side_new_1106606.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606148", "story_v_side_new_1106606.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_13 = math.max(var_587_6, arg_584_1.talkMaxDuration)

			if var_587_5 <= arg_584_1.time_ and arg_584_1.time_ < var_587_5 + var_587_13 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_5) / var_587_13

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_5 + var_587_13 and arg_584_1.time_ < var_587_5 + var_587_13 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
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

		arg_584_1:InitPlayNodeList()
	end,
	Play1106606149 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 1106606149
		arg_588_1.duration_ = 15.67

		local var_588_0 = {
			zh = 15.666,
			ja = 15
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play1106606150(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_591_0 = 0
			local var_591_1 = 1.675

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_2 = arg_588_1:GetWordFromCfg(1106606149)
				local var_591_3 = arg_588_1:FormatText(var_591_2.content)

				arg_588_1.text_.text = var_591_3

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_5 = 67 <= 0 and var_591_1 or var_591_1 * (utf8.len(var_591_3) / 67)

				if (67 <= 0 and var_591_1 or var_591_1 * (utf8.len(var_591_3) / 67)) > 0 and var_591_1 < var_591_5 then
					arg_588_1.talkMaxDuration = var_591_5

					if var_591_5 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_5 + var_591_0
					end
				end

				arg_588_1.text_.text = var_591_3
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606149", "story_v_side_new_1106606.awb") ~= 0 then
					local var_591_6 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606149", "story_v_side_new_1106606.awb") / 1000

					if var_591_6 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_6 + var_591_0
					end

					if var_591_2.prefab_name ~= "" and arg_588_1.actors_[var_591_2.prefab_name] ~= nil then
						local var_591_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_2.prefab_name].transform, "story_v_side_new_1106606", "1106606149", "story_v_side_new_1106606.awb")

						arg_588_1:RecordAudio("1106606149", var_591_7)
						arg_588_1:RecordAudio("1106606149", var_591_7)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606149", "story_v_side_new_1106606.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606149", "story_v_side_new_1106606.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_8 = math.max(var_591_1, arg_588_1.talkMaxDuration)

			if var_591_0 <= arg_588_1.time_ and arg_588_1.time_ < var_591_0 + var_591_8 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_0) / var_591_8

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_0 + var_591_8 and arg_588_1.time_ < var_591_0 + var_591_8 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play1106606150 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 1106606150
		arg_592_1.duration_ = 14.1

		local var_592_0 = {
			zh = 12.366,
			ja = 14.1
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play1106606151(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 1.25

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				arg_592_1.leftNameTxt_.text = arg_592_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_1 = arg_592_1:GetWordFromCfg(1106606150)
				local var_595_2 = arg_592_1:FormatText(var_595_1.content)

				arg_592_1.text_.text = var_595_2

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_4 = 50 <= 0 and var_595_0 or var_595_0 * (utf8.len(var_595_2) / 50)

				if (50 <= 0 and var_595_0 or var_595_0 * (utf8.len(var_595_2) / 50)) > 0 and var_595_0 < var_595_4 then
					arg_592_1.talkMaxDuration = var_595_4

					if var_595_4 + 0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_4 + 0
					end
				end

				arg_592_1.text_.text = var_595_2
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606150", "story_v_side_new_1106606.awb") ~= 0 then
					local var_595_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606150", "story_v_side_new_1106606.awb") / 1000

					if var_595_5 + 0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_5 + 0
					end

					if var_595_1.prefab_name ~= "" and arg_592_1.actors_[var_595_1.prefab_name] ~= nil then
						local var_595_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_1.prefab_name].transform, "story_v_side_new_1106606", "1106606150", "story_v_side_new_1106606.awb")

						arg_592_1:RecordAudio("1106606150", var_595_6)
						arg_592_1:RecordAudio("1106606150", var_595_6)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606150", "story_v_side_new_1106606.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606150", "story_v_side_new_1106606.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_7 = math.max(var_595_0, arg_592_1.talkMaxDuration)

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_7 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - 0) / var_595_7

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= 0 + var_595_7 and arg_592_1.time_ < 0 + var_595_7 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play1106606151 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 1106606151
		arg_596_1.duration_ = 11.4

		local var_596_0 = {
			zh = 11.4,
			ja = 4.833
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play1106606152(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_599_0 = 0
			local var_599_1 = 1.375

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_0 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_2 = arg_596_1:GetWordFromCfg(1106606151)
				local var_599_3 = arg_596_1:FormatText(var_599_2.content)

				arg_596_1.text_.text = var_599_3

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_5 = 55 <= 0 and var_599_1 or var_599_1 * (utf8.len(var_599_3) / 55)

				if (55 <= 0 and var_599_1 or var_599_1 * (utf8.len(var_599_3) / 55)) > 0 and var_599_1 < var_599_5 then
					arg_596_1.talkMaxDuration = var_599_5

					if var_599_5 + var_599_0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_5 + var_599_0
					end
				end

				arg_596_1.text_.text = var_599_3
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606151", "story_v_side_new_1106606.awb") ~= 0 then
					local var_599_6 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606151", "story_v_side_new_1106606.awb") / 1000

					if var_599_6 + var_599_0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_6 + var_599_0
					end

					if var_599_2.prefab_name ~= "" and arg_596_1.actors_[var_599_2.prefab_name] ~= nil then
						local var_599_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_2.prefab_name].transform, "story_v_side_new_1106606", "1106606151", "story_v_side_new_1106606.awb")

						arg_596_1:RecordAudio("1106606151", var_599_7)
						arg_596_1:RecordAudio("1106606151", var_599_7)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606151", "story_v_side_new_1106606.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606151", "story_v_side_new_1106606.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_8 = math.max(var_599_1, arg_596_1.talkMaxDuration)

			if var_599_0 <= arg_596_1.time_ and arg_596_1.time_ < var_599_0 + var_599_8 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_0) / var_599_8

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_0 + var_599_8 and arg_596_1.time_ < var_599_0 + var_599_8 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play1106606152 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 1106606152
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play1106606153(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 and not isNil(arg_600_1.actors_["1066ui_story"]) and arg_600_1.var_.characterEffect1066ui_story == nil then
				arg_600_1.var_.characterEffect1066ui_story = arg_600_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_0 = 0.200000002980232

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_0 and not isNil(arg_600_1.actors_["1066ui_story"]) then
				if arg_600_1.var_.characterEffect1066ui_story and not isNil(arg_600_1.actors_["1066ui_story"]) then
					arg_600_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_600_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_600_1.time_ - 0) / var_603_0)
				end
			end

			if arg_600_1.time_ >= 0 + var_603_0 and arg_600_1.time_ < 0 + var_603_0 + arg_603_0 and not isNil(arg_600_1.actors_["1066ui_story"]) and arg_600_1.var_.characterEffect1066ui_story then
				arg_600_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_600_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_603_1 = 0
			local var_603_2 = 0.475

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, false)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_3 = arg_600_1:FormatText(arg_600_1:GetWordFromCfg(1106606152).content)

				arg_600_1.text_.text = var_603_3

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_5 = 19 <= 0 and var_603_2 or var_603_2 * (utf8.len(var_603_3) / 19)

				if (19 <= 0 and var_603_2 or var_603_2 * (utf8.len(var_603_3) / 19)) > 0 and var_603_2 < var_603_5 then
					arg_600_1.talkMaxDuration = var_603_5

					if var_603_5 + var_603_1 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_5 + var_603_1
					end
				end

				arg_600_1.text_.text = var_603_3
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_6 = math.max(var_603_2, arg_600_1.talkMaxDuration)

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_6 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_1) / var_603_6

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_1 + var_603_6 and arg_600_1.time_ < var_603_1 + var_603_6 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play1106606153 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 1106606153
		arg_604_1.duration_ = 13.43

		local var_604_0 = {
			zh = 7.6,
			ja = 13.433
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play1106606154(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1.var_.moveOldPos1066ui_story = arg_604_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_607_0 = 0.001

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_0 then
				arg_604_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_604_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_604_1.time_ - 0) / var_607_0)
				arg_604_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_604_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_604_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_604_1.actors_["1066ui_story"].transform.position).z)
				arg_604_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_604_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_604_1.actors_["1066ui_story"].transform.localEulerAngles = arg_604_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_604_1.time_ >= 0 + var_607_0 and arg_604_1.time_ < 0 + var_607_0 + arg_607_0 then
				arg_604_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_604_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_604_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_604_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_604_1.actors_["1066ui_story"].transform.position).z)
				arg_604_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_604_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_604_1.actors_["1066ui_story"].transform.localEulerAngles = arg_604_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_607_1 = arg_604_1.actors_["1066ui_story"]

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 and not isNil(var_607_1) and arg_604_1.var_.characterEffect1066ui_story == nil then
				arg_604_1.var_.characterEffect1066ui_story = var_607_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_2 = 0.200000002980232

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_2 and not isNil(var_607_1) then
				if arg_604_1.var_.characterEffect1066ui_story and not isNil(var_607_1) then
					arg_604_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= 0 + var_607_2 and arg_604_1.time_ < 0 + var_607_2 + arg_607_0 and not isNil(var_607_1) and arg_604_1.var_.characterEffect1066ui_story then
				arg_604_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_607_4 = 0
			local var_607_5 = 0.875

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_4 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_6 = arg_604_1:GetWordFromCfg(1106606153)
				local var_607_7 = arg_604_1:FormatText(var_607_6.content)

				arg_604_1.text_.text = var_607_7

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_9 = 35 <= 0 and var_607_5 or var_607_5 * (utf8.len(var_607_7) / 35)

				if (35 <= 0 and var_607_5 or var_607_5 * (utf8.len(var_607_7) / 35)) > 0 and var_607_5 < var_607_9 then
					arg_604_1.talkMaxDuration = var_607_9

					if var_607_9 + var_607_4 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_9 + var_607_4
					end
				end

				arg_604_1.text_.text = var_607_7
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606153", "story_v_side_new_1106606.awb") ~= 0 then
					local var_607_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606153", "story_v_side_new_1106606.awb") / 1000

					if var_607_10 + var_607_4 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_10 + var_607_4
					end

					if var_607_6.prefab_name ~= "" and arg_604_1.actors_[var_607_6.prefab_name] ~= nil then
						local var_607_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_6.prefab_name].transform, "story_v_side_new_1106606", "1106606153", "story_v_side_new_1106606.awb")

						arg_604_1:RecordAudio("1106606153", var_607_11)
						arg_604_1:RecordAudio("1106606153", var_607_11)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606153", "story_v_side_new_1106606.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606153", "story_v_side_new_1106606.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_12 = math.max(var_607_5, arg_604_1.talkMaxDuration)

			if var_607_4 <= arg_604_1.time_ and arg_604_1.time_ < var_607_4 + var_607_12 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_4) / var_607_12

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_4 + var_607_12 and arg_604_1.time_ < var_607_4 + var_607_12 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {
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

		arg_604_1:InitPlayNodeList()
	end,
	Play1106606154 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 1106606154
		arg_608_1.duration_ = 5.73

		local var_608_0 = {
			zh = 4.933,
			ja = 5.733
		}
		local var_608_1 = manager.audio:GetLocalizationFlag()

		if var_608_0[var_608_1] ~= nil then
			arg_608_1.duration_ = var_608_0[var_608_1]
		end

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play1106606155(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1.var_.moveOldPos1066ui_story = arg_608_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_611_0 = 0.001

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_0 then
				arg_608_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_608_1.time_ - 0) / var_611_0)
				arg_608_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_608_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1066ui_story"].transform.position).z)
				arg_608_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_608_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_608_1.actors_["1066ui_story"].transform.localEulerAngles = arg_608_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_608_1.time_ >= 0 + var_611_0 and arg_608_1.time_ < 0 + var_611_0 + arg_611_0 then
				arg_608_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_608_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_608_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1066ui_story"].transform.position).z)
				arg_608_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_608_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_608_1.actors_["1066ui_story"].transform.localEulerAngles = arg_608_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_611_1 = arg_608_1.actors_["1066ui_story"]

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 and not isNil(var_611_1) and arg_608_1.var_.characterEffect1066ui_story == nil then
				arg_608_1.var_.characterEffect1066ui_story = var_611_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_611_2 = 0.200000002980232

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_2 and not isNil(var_611_1) then
				if arg_608_1.var_.characterEffect1066ui_story and not isNil(var_611_1) then
					arg_608_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_608_1.time_ >= 0 + var_611_2 and arg_608_1.time_ < 0 + var_611_2 + arg_611_0 and not isNil(var_611_1) and arg_608_1.var_.characterEffect1066ui_story then
				arg_608_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_611_4 = 0
			local var_611_5 = 0.525

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_4 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				arg_608_1.leftNameTxt_.text = arg_608_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_6 = arg_608_1:GetWordFromCfg(1106606154)
				local var_611_7 = arg_608_1:FormatText(var_611_6.content)

				arg_608_1.text_.text = var_611_7

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_9 = 21 <= 0 and var_611_5 or var_611_5 * (utf8.len(var_611_7) / 21)

				if (21 <= 0 and var_611_5 or var_611_5 * (utf8.len(var_611_7) / 21)) > 0 and var_611_5 < var_611_9 then
					arg_608_1.talkMaxDuration = var_611_9

					if var_611_9 + var_611_4 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_9 + var_611_4
					end
				end

				arg_608_1.text_.text = var_611_7
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606154", "story_v_side_new_1106606.awb") ~= 0 then
					local var_611_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606154", "story_v_side_new_1106606.awb") / 1000

					if var_611_10 + var_611_4 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_10 + var_611_4
					end

					if var_611_6.prefab_name ~= "" and arg_608_1.actors_[var_611_6.prefab_name] ~= nil then
						local var_611_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_608_1.actors_[var_611_6.prefab_name].transform, "story_v_side_new_1106606", "1106606154", "story_v_side_new_1106606.awb")

						arg_608_1:RecordAudio("1106606154", var_611_11)
						arg_608_1:RecordAudio("1106606154", var_611_11)
					else
						arg_608_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606154", "story_v_side_new_1106606.awb")
					end

					arg_608_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606154", "story_v_side_new_1106606.awb")
				end

				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_12 = math.max(var_611_5, arg_608_1.talkMaxDuration)

			if var_611_4 <= arg_608_1.time_ and arg_608_1.time_ < var_611_4 + var_611_12 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_4) / var_611_12

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_4 + var_611_12 and arg_608_1.time_ < var_611_4 + var_611_12 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
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

		arg_608_1:InitPlayNodeList()
	end,
	Play1106606155 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 1106606155
		arg_612_1.duration_ = 17.4

		local var_612_0 = {
			zh = 10.8,
			ja = 17.4
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play1106606156(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1.var_.moveOldPos1066ui_story = arg_612_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_615_0 = 0.001

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_0 then
				arg_612_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_612_1.time_ - 0) / var_615_0)
				arg_612_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_612_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["1066ui_story"].transform.position).z)
				arg_612_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_612_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_612_1.actors_["1066ui_story"].transform.localEulerAngles = arg_612_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_612_1.time_ >= 0 + var_615_0 and arg_612_1.time_ < 0 + var_615_0 + arg_615_0 then
				arg_612_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_612_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_612_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["1066ui_story"].transform.position).z)
				arg_612_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_612_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_612_1.actors_["1066ui_story"].transform.localEulerAngles = arg_612_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_615_1 = arg_612_1.actors_["1066ui_story"]

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 and not isNil(var_615_1) and arg_612_1.var_.characterEffect1066ui_story == nil then
				arg_612_1.var_.characterEffect1066ui_story = var_615_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_615_2 = 0.200000002980232

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_2 and not isNil(var_615_1) then
				if arg_612_1.var_.characterEffect1066ui_story and not isNil(var_615_1) then
					arg_612_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_612_1.time_ >= 0 + var_615_2 and arg_612_1.time_ < 0 + var_615_2 + arg_615_0 and not isNil(var_615_1) and arg_612_1.var_.characterEffect1066ui_story then
				arg_612_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_615_4 = 0
			local var_615_5 = 1.25

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_4 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_6 = arg_612_1:GetWordFromCfg(1106606155)
				local var_615_7 = arg_612_1:FormatText(var_615_6.content)

				arg_612_1.text_.text = var_615_7

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_9 = 50 <= 0 and var_615_5 or var_615_5 * (utf8.len(var_615_7) / 50)

				if (50 <= 0 and var_615_5 or var_615_5 * (utf8.len(var_615_7) / 50)) > 0 and var_615_5 < var_615_9 then
					arg_612_1.talkMaxDuration = var_615_9

					if var_615_9 + var_615_4 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_9 + var_615_4
					end
				end

				arg_612_1.text_.text = var_615_7
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606155", "story_v_side_new_1106606.awb") ~= 0 then
					local var_615_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606155", "story_v_side_new_1106606.awb") / 1000

					if var_615_10 + var_615_4 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_10 + var_615_4
					end

					if var_615_6.prefab_name ~= "" and arg_612_1.actors_[var_615_6.prefab_name] ~= nil then
						local var_615_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_6.prefab_name].transform, "story_v_side_new_1106606", "1106606155", "story_v_side_new_1106606.awb")

						arg_612_1:RecordAudio("1106606155", var_615_11)
						arg_612_1:RecordAudio("1106606155", var_615_11)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606155", "story_v_side_new_1106606.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606155", "story_v_side_new_1106606.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_12 = math.max(var_615_5, arg_612_1.talkMaxDuration)

			if var_615_4 <= arg_612_1.time_ and arg_612_1.time_ < var_615_4 + var_615_12 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_4) / var_615_12

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_4 + var_615_12 and arg_612_1.time_ < var_615_4 + var_615_12 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {
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

		arg_612_1:InitPlayNodeList()
	end,
	Play1106606156 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 1106606156
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play1106606157(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 and not isNil(arg_616_1.actors_["1066ui_story"]) and arg_616_1.var_.characterEffect1066ui_story == nil then
				arg_616_1.var_.characterEffect1066ui_story = arg_616_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_0 = 0.200000002980232

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_0 and not isNil(arg_616_1.actors_["1066ui_story"]) then
				if arg_616_1.var_.characterEffect1066ui_story and not isNil(arg_616_1.actors_["1066ui_story"]) then
					arg_616_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_616_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_616_1.time_ - 0) / var_619_0)
				end
			end

			if arg_616_1.time_ >= 0 + var_619_0 and arg_616_1.time_ < 0 + var_619_0 + arg_619_0 and not isNil(arg_616_1.actors_["1066ui_story"]) and arg_616_1.var_.characterEffect1066ui_story then
				arg_616_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_616_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_619_1 = 0
			local var_619_2 = 0.425

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_1 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, false)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_3 = arg_616_1:FormatText(arg_616_1:GetWordFromCfg(1106606156).content)

				arg_616_1.text_.text = var_619_3

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_5 = 17 <= 0 and var_619_2 or var_619_2 * (utf8.len(var_619_3) / 17)

				if (17 <= 0 and var_619_2 or var_619_2 * (utf8.len(var_619_3) / 17)) > 0 and var_619_2 < var_619_5 then
					arg_616_1.talkMaxDuration = var_619_5

					if var_619_5 + var_619_1 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_5 + var_619_1
					end
				end

				arg_616_1.text_.text = var_619_3
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_6 = math.max(var_619_2, arg_616_1.talkMaxDuration)

			if var_619_1 <= arg_616_1.time_ and arg_616_1.time_ < var_619_1 + var_619_6 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_1) / var_619_6

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_1 + var_619_6 and arg_616_1.time_ < var_619_1 + var_619_6 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play1106606157 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 1106606157
		arg_620_1.duration_ = 9.3

		local var_620_0 = {
			zh = 9.3,
			ja = 4.733
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play1106606158(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1.var_.moveOldPos1066ui_story = arg_620_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_623_0 = 0.001

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_0 then
				arg_620_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_620_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_620_1.time_ - 0) / var_623_0)
				arg_620_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_620_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_620_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_620_1.actors_["1066ui_story"].transform.position).z)
				arg_620_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_620_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_620_1.actors_["1066ui_story"].transform.localEulerAngles = arg_620_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_620_1.time_ >= 0 + var_623_0 and arg_620_1.time_ < 0 + var_623_0 + arg_623_0 then
				arg_620_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_620_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_620_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_620_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_620_1.actors_["1066ui_story"].transform.position).z)
				arg_620_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_620_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_620_1.actors_["1066ui_story"].transform.localEulerAngles = arg_620_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_623_1 = arg_620_1.actors_["1066ui_story"]

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 and not isNil(var_623_1) and arg_620_1.var_.characterEffect1066ui_story == nil then
				arg_620_1.var_.characterEffect1066ui_story = var_623_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_623_2 = 0.200000002980232

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_2 and not isNil(var_623_1) then
				if arg_620_1.var_.characterEffect1066ui_story and not isNil(var_623_1) then
					arg_620_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_620_1.time_ >= 0 + var_623_2 and arg_620_1.time_ < 0 + var_623_2 + arg_623_0 and not isNil(var_623_1) and arg_620_1.var_.characterEffect1066ui_story then
				arg_620_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_623_4 = 0
			local var_623_5 = 0.75

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_4 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				arg_620_1.leftNameTxt_.text = arg_620_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_6 = arg_620_1:GetWordFromCfg(1106606157)
				local var_623_7 = arg_620_1:FormatText(var_623_6.content)

				arg_620_1.text_.text = var_623_7

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_9 = 30 <= 0 and var_623_5 or var_623_5 * (utf8.len(var_623_7) / 30)

				if (30 <= 0 and var_623_5 or var_623_5 * (utf8.len(var_623_7) / 30)) > 0 and var_623_5 < var_623_9 then
					arg_620_1.talkMaxDuration = var_623_9

					if var_623_9 + var_623_4 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_9 + var_623_4
					end
				end

				arg_620_1.text_.text = var_623_7
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606157", "story_v_side_new_1106606.awb") ~= 0 then
					local var_623_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606157", "story_v_side_new_1106606.awb") / 1000

					if var_623_10 + var_623_4 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_10 + var_623_4
					end

					if var_623_6.prefab_name ~= "" and arg_620_1.actors_[var_623_6.prefab_name] ~= nil then
						local var_623_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_6.prefab_name].transform, "story_v_side_new_1106606", "1106606157", "story_v_side_new_1106606.awb")

						arg_620_1:RecordAudio("1106606157", var_623_11)
						arg_620_1:RecordAudio("1106606157", var_623_11)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606157", "story_v_side_new_1106606.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606157", "story_v_side_new_1106606.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_12 = math.max(var_623_5, arg_620_1.talkMaxDuration)

			if var_623_4 <= arg_620_1.time_ and arg_620_1.time_ < var_623_4 + var_623_12 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_4) / var_623_12

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_4 + var_623_12 and arg_620_1.time_ < var_623_4 + var_623_12 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {
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

		arg_620_1:InitPlayNodeList()
	end,
	Play1106606158 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 1106606158
		arg_624_1.duration_ = 5

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play1106606159(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 and not isNil(arg_624_1.actors_["1066ui_story"]) and arg_624_1.var_.characterEffect1066ui_story == nil then
				arg_624_1.var_.characterEffect1066ui_story = arg_624_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_627_0 = 0.200000002980232

			if 0 <= arg_624_1.time_ and arg_624_1.time_ < 0 + var_627_0 and not isNil(arg_624_1.actors_["1066ui_story"]) then
				if arg_624_1.var_.characterEffect1066ui_story and not isNil(arg_624_1.actors_["1066ui_story"]) then
					arg_624_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_624_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_624_1.time_ - 0) / var_627_0)
				end
			end

			if arg_624_1.time_ >= 0 + var_627_0 and arg_624_1.time_ < 0 + var_627_0 + arg_627_0 and not isNil(arg_624_1.actors_["1066ui_story"]) and arg_624_1.var_.characterEffect1066ui_story then
				arg_624_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_624_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_627_1 = arg_624_1.actors_["1066ui_story"].transform

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1.var_.moveOldPos1066ui_story = var_627_1.localPosition
			end

			local var_627_2 = 0.001

			if 0 <= arg_624_1.time_ and arg_624_1.time_ < 0 + var_627_2 then
				var_627_1.localPosition = Vector3.Lerp(arg_624_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_624_1.time_ - 0) / var_627_2)
				var_627_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_627_1.position).x, (manager.ui.mainCamera.transform.position - var_627_1.position).y, (manager.ui.mainCamera.transform.position - var_627_1.position).z)
				var_627_1.localEulerAngles.z = 0
				var_627_1.localEulerAngles.x = 0
				var_627_1.localEulerAngles = var_627_1.localEulerAngles
			end

			if arg_624_1.time_ >= 0 + var_627_2 and arg_624_1.time_ < 0 + var_627_2 + arg_627_0 then
				var_627_1.localPosition = Vector3.New(0, 100, 0)
				var_627_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_627_1.position).x, (manager.ui.mainCamera.transform.position - var_627_1.position).y, (manager.ui.mainCamera.transform.position - var_627_1.position).z)
				var_627_1.localEulerAngles.z = 0
				var_627_1.localEulerAngles.x = 0
				var_627_1.localEulerAngles = var_627_1.localEulerAngles
			end

			local var_627_3 = 0
			local var_627_4 = 0.65

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_3 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, false)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_5 = arg_624_1:FormatText(arg_624_1:GetWordFromCfg(1106606158).content)

				arg_624_1.text_.text = var_627_5

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_7 = 26 <= 0 and var_627_4 or var_627_4 * (utf8.len(var_627_5) / 26)

				if (26 <= 0 and var_627_4 or var_627_4 * (utf8.len(var_627_5) / 26)) > 0 and var_627_4 < var_627_7 then
					arg_624_1.talkMaxDuration = var_627_7

					if var_627_7 + var_627_3 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_7 + var_627_3
					end
				end

				arg_624_1.text_.text = var_627_5
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)
				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_8 = math.max(var_627_4, arg_624_1.talkMaxDuration)

			if var_627_3 <= arg_624_1.time_ and arg_624_1.time_ < var_627_3 + var_627_8 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_3) / var_627_8

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_3 + var_627_8 and arg_624_1.time_ < var_627_3 + var_627_8 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {
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

		arg_624_1:InitPlayNodeList()
	end,
	Play1106606159 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 1106606159
		arg_628_1.duration_ = 4.7

		local var_628_0 = {
			zh = 4.7,
			ja = 4.266
		}
		local var_628_1 = manager.audio:GetLocalizationFlag()

		if var_628_0[var_628_1] ~= nil then
			arg_628_1.duration_ = var_628_0[var_628_1]
		end

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play1106606160(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1.var_.moveOldPos1066ui_story = arg_628_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_631_0 = 0.001

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_0 then
				arg_628_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_628_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_628_1.time_ - 0) / var_631_0)
				arg_628_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_628_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1066ui_story"].transform.position).z)
				arg_628_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_628_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_628_1.actors_["1066ui_story"].transform.localEulerAngles = arg_628_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_628_1.time_ >= 0 + var_631_0 and arg_628_1.time_ < 0 + var_631_0 + arg_631_0 then
				arg_628_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_628_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_628_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_628_1.actors_["1066ui_story"].transform.position).z)
				arg_628_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_628_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_628_1.actors_["1066ui_story"].transform.localEulerAngles = arg_628_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_631_1 = arg_628_1.actors_["1066ui_story"]

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 and not isNil(var_631_1) and arg_628_1.var_.characterEffect1066ui_story == nil then
				arg_628_1.var_.characterEffect1066ui_story = var_631_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_2 = 0.200000002980232

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_2 and not isNil(var_631_1) then
				if arg_628_1.var_.characterEffect1066ui_story and not isNil(var_631_1) then
					arg_628_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_628_1.time_ >= 0 + var_631_2 and arg_628_1.time_ < 0 + var_631_2 + arg_631_0 and not isNil(var_631_1) and arg_628_1.var_.characterEffect1066ui_story then
				arg_628_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_631_4 = 0
			local var_631_5 = 0.325

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_4 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				arg_628_1.leftNameTxt_.text = arg_628_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_6 = arg_628_1:GetWordFromCfg(1106606159)
				local var_631_7 = arg_628_1:FormatText(var_631_6.content)

				arg_628_1.text_.text = var_631_7

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_9 = 13 <= 0 and var_631_5 or var_631_5 * (utf8.len(var_631_7) / 13)

				if (13 <= 0 and var_631_5 or var_631_5 * (utf8.len(var_631_7) / 13)) > 0 and var_631_5 < var_631_9 then
					arg_628_1.talkMaxDuration = var_631_9

					if var_631_9 + var_631_4 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_9 + var_631_4
					end
				end

				arg_628_1.text_.text = var_631_7
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606159", "story_v_side_new_1106606.awb") ~= 0 then
					local var_631_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606159", "story_v_side_new_1106606.awb") / 1000

					if var_631_10 + var_631_4 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_10 + var_631_4
					end

					if var_631_6.prefab_name ~= "" and arg_628_1.actors_[var_631_6.prefab_name] ~= nil then
						local var_631_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_628_1.actors_[var_631_6.prefab_name].transform, "story_v_side_new_1106606", "1106606159", "story_v_side_new_1106606.awb")

						arg_628_1:RecordAudio("1106606159", var_631_11)
						arg_628_1:RecordAudio("1106606159", var_631_11)
					else
						arg_628_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606159", "story_v_side_new_1106606.awb")
					end

					arg_628_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606159", "story_v_side_new_1106606.awb")
				end

				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_12 = math.max(var_631_5, arg_628_1.talkMaxDuration)

			if var_631_4 <= arg_628_1.time_ and arg_628_1.time_ < var_631_4 + var_631_12 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_4) / var_631_12

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_4 + var_631_12 and arg_628_1.time_ < var_631_4 + var_631_12 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {
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

		arg_628_1:InitPlayNodeList()
	end,
	Play1106606160 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 1106606160
		arg_632_1.duration_ = 5

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play1106606161(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 and not isNil(arg_632_1.actors_["1066ui_story"]) and arg_632_1.var_.characterEffect1066ui_story == nil then
				arg_632_1.var_.characterEffect1066ui_story = arg_632_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_0 = 0.200000002980232

			if 0 <= arg_632_1.time_ and arg_632_1.time_ < 0 + var_635_0 and not isNil(arg_632_1.actors_["1066ui_story"]) then
				if arg_632_1.var_.characterEffect1066ui_story and not isNil(arg_632_1.actors_["1066ui_story"]) then
					arg_632_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_632_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_632_1.time_ - 0) / var_635_0)
				end
			end

			if arg_632_1.time_ >= 0 + var_635_0 and arg_632_1.time_ < 0 + var_635_0 + arg_635_0 and not isNil(arg_632_1.actors_["1066ui_story"]) and arg_632_1.var_.characterEffect1066ui_story then
				arg_632_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_632_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_635_1 = 0
			local var_635_2 = 0.925

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				arg_632_1.leftNameTxt_.text = arg_632_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, true)
				arg_632_1.iconController_:SetSelectedState("hero")

				arg_632_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_632_1.callingController_:SetSelectedState("normal")

				arg_632_1.keyicon_.color = Color.New(1, 1, 1)
				arg_632_1.icon_.color = Color.New(1, 1, 1)

				local var_635_3 = arg_632_1:FormatText(arg_632_1:GetWordFromCfg(1106606160).content)

				arg_632_1.text_.text = var_635_3

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_5 = 37 <= 0 and var_635_2 or var_635_2 * (utf8.len(var_635_3) / 37)

				if (37 <= 0 and var_635_2 or var_635_2 * (utf8.len(var_635_3) / 37)) > 0 and var_635_2 < var_635_5 then
					arg_632_1.talkMaxDuration = var_635_5

					if var_635_5 + var_635_1 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_5 + var_635_1
					end
				end

				arg_632_1.text_.text = var_635_3
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)
				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_6 = math.max(var_635_2, arg_632_1.talkMaxDuration)

			if var_635_1 <= arg_632_1.time_ and arg_632_1.time_ < var_635_1 + var_635_6 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_1) / var_635_6

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_1 + var_635_6 and arg_632_1.time_ < var_635_1 + var_635_6 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play1106606161 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 1106606161
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play1106606162(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = 0.425

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				arg_636_1.leftNameTxt_.text = arg_636_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, true)
				arg_636_1.iconController_:SetSelectedState("hero")

				arg_636_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_636_1.callingController_:SetSelectedState("normal")

				arg_636_1.keyicon_.color = Color.New(1, 1, 1)
				arg_636_1.icon_.color = Color.New(1, 1, 1)

				local var_639_1 = arg_636_1:FormatText(arg_636_1:GetWordFromCfg(1106606161).content)

				arg_636_1.text_.text = var_639_1

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_3 = 17 <= 0 and var_639_0 or var_639_0 * (utf8.len(var_639_1) / 17)

				if (17 <= 0 and var_639_0 or var_639_0 * (utf8.len(var_639_1) / 17)) > 0 and var_639_0 < var_639_3 then
					arg_636_1.talkMaxDuration = var_639_3

					if var_639_3 + 0 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_3 + 0
					end
				end

				arg_636_1.text_.text = var_639_1
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)
				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_4 = math.max(var_639_0, arg_636_1.talkMaxDuration)

			if 0 <= arg_636_1.time_ and arg_636_1.time_ < 0 + var_639_4 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - 0) / var_639_4

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= 0 + var_639_4 and arg_636_1.time_ < 0 + var_639_4 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play1106606162 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 1106606162
		arg_640_1.duration_ = 4.1

		local var_640_0 = {
			zh = 2.7,
			ja = 4.1
		}
		local var_640_1 = manager.audio:GetLocalizationFlag()

		if var_640_0[var_640_1] ~= nil then
			arg_640_1.duration_ = var_640_0[var_640_1]
		end

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play1106606163(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1.var_.moveOldPos1066ui_story = arg_640_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_643_0 = 0.001

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_0 then
				arg_640_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_640_1.time_ - 0) / var_643_0)
				arg_640_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_640_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1066ui_story"].transform.position).z)
				arg_640_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_640_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_640_1.actors_["1066ui_story"].transform.localEulerAngles = arg_640_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_640_1.time_ >= 0 + var_643_0 and arg_640_1.time_ < 0 + var_643_0 + arg_643_0 then
				arg_640_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_640_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_640_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1066ui_story"].transform.position).z)
				arg_640_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_640_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_640_1.actors_["1066ui_story"].transform.localEulerAngles = arg_640_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_643_1 = arg_640_1.actors_["1066ui_story"]

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 and not isNil(var_643_1) and arg_640_1.var_.characterEffect1066ui_story == nil then
				arg_640_1.var_.characterEffect1066ui_story = var_643_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_2 = 0.200000002980232

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_2 and not isNil(var_643_1) then
				if arg_640_1.var_.characterEffect1066ui_story and not isNil(var_643_1) then
					arg_640_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_640_1.time_ >= 0 + var_643_2 and arg_640_1.time_ < 0 + var_643_2 + arg_643_0 and not isNil(var_643_1) and arg_640_1.var_.characterEffect1066ui_story then
				arg_640_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_643_4 = 0
			local var_643_5 = 0.225

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= var_643_4 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				arg_640_1.leftNameTxt_.text = arg_640_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, false)
				arg_640_1.callingController_:SetSelectedState("normal")

				local var_643_6 = arg_640_1:GetWordFromCfg(1106606162)
				local var_643_7 = arg_640_1:FormatText(var_643_6.content)

				arg_640_1.text_.text = var_643_7

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_9 = 9 <= 0 and var_643_5 or var_643_5 * (utf8.len(var_643_7) / 9)

				if (9 <= 0 and var_643_5 or var_643_5 * (utf8.len(var_643_7) / 9)) > 0 and var_643_5 < var_643_9 then
					arg_640_1.talkMaxDuration = var_643_9

					if var_643_9 + var_643_4 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_9 + var_643_4
					end
				end

				arg_640_1.text_.text = var_643_7
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606162", "story_v_side_new_1106606.awb") ~= 0 then
					local var_643_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606162", "story_v_side_new_1106606.awb") / 1000

					if var_643_10 + var_643_4 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_10 + var_643_4
					end

					if var_643_6.prefab_name ~= "" and arg_640_1.actors_[var_643_6.prefab_name] ~= nil then
						local var_643_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_640_1.actors_[var_643_6.prefab_name].transform, "story_v_side_new_1106606", "1106606162", "story_v_side_new_1106606.awb")

						arg_640_1:RecordAudio("1106606162", var_643_11)
						arg_640_1:RecordAudio("1106606162", var_643_11)
					else
						arg_640_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606162", "story_v_side_new_1106606.awb")
					end

					arg_640_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606162", "story_v_side_new_1106606.awb")
				end

				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_12 = math.max(var_643_5, arg_640_1.talkMaxDuration)

			if var_643_4 <= arg_640_1.time_ and arg_640_1.time_ < var_643_4 + var_643_12 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_4) / var_643_12

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_4 + var_643_12 and arg_640_1.time_ < var_643_4 + var_643_12 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {
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

		arg_640_1:InitPlayNodeList()
	end,
	Play1106606163 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 1106606163
		arg_644_1.duration_ = 5

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play1106606164(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 and not isNil(arg_644_1.actors_["1066ui_story"]) and arg_644_1.var_.characterEffect1066ui_story == nil then
				arg_644_1.var_.characterEffect1066ui_story = arg_644_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_647_0 = 0.200000002980232

			if 0 <= arg_644_1.time_ and arg_644_1.time_ < 0 + var_647_0 and not isNil(arg_644_1.actors_["1066ui_story"]) then
				if arg_644_1.var_.characterEffect1066ui_story and not isNil(arg_644_1.actors_["1066ui_story"]) then
					arg_644_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_644_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_644_1.time_ - 0) / var_647_0)
				end
			end

			if arg_644_1.time_ >= 0 + var_647_0 and arg_644_1.time_ < 0 + var_647_0 + arg_647_0 and not isNil(arg_644_1.actors_["1066ui_story"]) and arg_644_1.var_.characterEffect1066ui_story then
				arg_644_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_644_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_647_1 = 0
			local var_647_2 = 0.725

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= var_647_1 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, false)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_3 = arg_644_1:FormatText(arg_644_1:GetWordFromCfg(1106606163).content)

				arg_644_1.text_.text = var_647_3

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_5 = 29 <= 0 and var_647_2 or var_647_2 * (utf8.len(var_647_3) / 29)

				if (29 <= 0 and var_647_2 or var_647_2 * (utf8.len(var_647_3) / 29)) > 0 and var_647_2 < var_647_5 then
					arg_644_1.talkMaxDuration = var_647_5

					if var_647_5 + var_647_1 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_5 + var_647_1
					end
				end

				arg_644_1.text_.text = var_647_3
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)
				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_6 = math.max(var_647_2, arg_644_1.talkMaxDuration)

			if var_647_1 <= arg_644_1.time_ and arg_644_1.time_ < var_647_1 + var_647_6 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_1) / var_647_6

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_1 + var_647_6 and arg_644_1.time_ < var_647_1 + var_647_6 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play1106606164 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 1106606164
		arg_648_1.duration_ = 5

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play1106606165(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = 0.525

			if 0 < arg_648_1.time_ and arg_648_1.time_ <= 0 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				arg_648_1.leftNameTxt_.text = arg_648_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, true)
				arg_648_1.iconController_:SetSelectedState("hero")

				arg_648_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_648_1.callingController_:SetSelectedState("normal")

				arg_648_1.keyicon_.color = Color.New(1, 1, 1)
				arg_648_1.icon_.color = Color.New(1, 1, 1)

				local var_651_1 = arg_648_1:FormatText(arg_648_1:GetWordFromCfg(1106606164).content)

				arg_648_1.text_.text = var_651_1

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_3 = 21 <= 0 and var_651_0 or var_651_0 * (utf8.len(var_651_1) / 21)

				if (21 <= 0 and var_651_0 or var_651_0 * (utf8.len(var_651_1) / 21)) > 0 and var_651_0 < var_651_3 then
					arg_648_1.talkMaxDuration = var_651_3

					if var_651_3 + 0 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_3 + 0
					end
				end

				arg_648_1.text_.text = var_651_1
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)
				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_4 = math.max(var_651_0, arg_648_1.talkMaxDuration)

			if 0 <= arg_648_1.time_ and arg_648_1.time_ < 0 + var_651_4 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - 0) / var_651_4

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= 0 + var_651_4 and arg_648_1.time_ < 0 + var_651_4 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {}

		arg_648_1:InitPlayNodeList()
	end,
	Play1106606165 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1106606165
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1106606166(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = 0.775

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				arg_652_1.leftNameTxt_.text = arg_652_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, true)
				arg_652_1.iconController_:SetSelectedState("hero")

				arg_652_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_652_1.callingController_:SetSelectedState("normal")

				arg_652_1.keyicon_.color = Color.New(1, 1, 1)
				arg_652_1.icon_.color = Color.New(1, 1, 1)

				local var_655_1 = arg_652_1:FormatText(arg_652_1:GetWordFromCfg(1106606165).content)

				arg_652_1.text_.text = var_655_1

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_3 = 31 <= 0 and var_655_0 or var_655_0 * (utf8.len(var_655_1) / 31)

				if (31 <= 0 and var_655_0 or var_655_0 * (utf8.len(var_655_1) / 31)) > 0 and var_655_0 < var_655_3 then
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
	Play1106606166 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1106606166
		arg_656_1.duration_ = 7.9

		local var_656_0 = {
			zh = 7.9,
			ja = 6.833
		}
		local var_656_1 = manager.audio:GetLocalizationFlag()

		if var_656_0[var_656_1] ~= nil then
			arg_656_1.duration_ = var_656_0[var_656_1]
		end

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1106606167(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 then
				arg_656_1.var_.moveOldPos1066ui_story = arg_656_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_659_0 = 0.001

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_0 then
				arg_656_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_656_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_656_1.time_ - 0) / var_659_0)
				arg_656_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_656_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_656_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_656_1.actors_["1066ui_story"].transform.position).z)
				arg_656_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_656_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_656_1.actors_["1066ui_story"].transform.localEulerAngles = arg_656_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_656_1.time_ >= 0 + var_659_0 and arg_656_1.time_ < 0 + var_659_0 + arg_659_0 then
				arg_656_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_656_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_656_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_656_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_656_1.actors_["1066ui_story"].transform.position).z)
				arg_656_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_656_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_656_1.actors_["1066ui_story"].transform.localEulerAngles = arg_656_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_659_1 = arg_656_1.actors_["1066ui_story"]

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 and not isNil(var_659_1) and arg_656_1.var_.characterEffect1066ui_story == nil then
				arg_656_1.var_.characterEffect1066ui_story = var_659_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_659_2 = 0.200000002980232

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_2 and not isNil(var_659_1) then
				if arg_656_1.var_.characterEffect1066ui_story and not isNil(var_659_1) then
					arg_656_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_656_1.time_ >= 0 + var_659_2 and arg_656_1.time_ < 0 + var_659_2 + arg_659_0 and not isNil(var_659_1) and arg_656_1.var_.characterEffect1066ui_story then
				arg_656_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 then
				arg_656_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 then
				arg_656_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_659_4 = 0
			local var_659_5 = 0.85

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_4 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				arg_656_1.leftNameTxt_.text = arg_656_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_6 = arg_656_1:GetWordFromCfg(1106606166)
				local var_659_7 = arg_656_1:FormatText(var_659_6.content)

				arg_656_1.text_.text = var_659_7

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_9 = 34 <= 0 and var_659_5 or var_659_5 * (utf8.len(var_659_7) / 34)

				if (34 <= 0 and var_659_5 or var_659_5 * (utf8.len(var_659_7) / 34)) > 0 and var_659_5 < var_659_9 then
					arg_656_1.talkMaxDuration = var_659_9

					if var_659_9 + var_659_4 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_9 + var_659_4
					end
				end

				arg_656_1.text_.text = var_659_7
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606166", "story_v_side_new_1106606.awb") ~= 0 then
					local var_659_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606166", "story_v_side_new_1106606.awb") / 1000

					if var_659_10 + var_659_4 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_10 + var_659_4
					end

					if var_659_6.prefab_name ~= "" and arg_656_1.actors_[var_659_6.prefab_name] ~= nil then
						local var_659_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_6.prefab_name].transform, "story_v_side_new_1106606", "1106606166", "story_v_side_new_1106606.awb")

						arg_656_1:RecordAudio("1106606166", var_659_11)
						arg_656_1:RecordAudio("1106606166", var_659_11)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606166", "story_v_side_new_1106606.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606166", "story_v_side_new_1106606.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_12 = math.max(var_659_5, arg_656_1.talkMaxDuration)

			if var_659_4 <= arg_656_1.time_ and arg_656_1.time_ < var_659_4 + var_659_12 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_4) / var_659_12

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_4 + var_659_12 and arg_656_1.time_ < var_659_4 + var_659_12 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {
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

		arg_656_1:InitPlayNodeList()
	end,
	Play1106606167 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1106606167
		arg_660_1.duration_ = 6.3

		local var_660_0 = {
			zh = 5.3,
			ja = 6.3
		}
		local var_660_1 = manager.audio:GetLocalizationFlag()

		if var_660_0[var_660_1] ~= nil then
			arg_660_1.duration_ = var_660_0[var_660_1]
		end

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1106606168(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 then
				arg_660_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_1")
			end

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 then
				arg_660_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_663_0 = 0
			local var_663_1 = 0.5

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				arg_660_1.leftNameTxt_.text = arg_660_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_2 = arg_660_1:GetWordFromCfg(1106606167)
				local var_663_3 = arg_660_1:FormatText(var_663_2.content)

				arg_660_1.text_.text = var_663_3

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_5 = 20 <= 0 and var_663_1 or var_663_1 * (utf8.len(var_663_3) / 20)

				if (20 <= 0 and var_663_1 or var_663_1 * (utf8.len(var_663_3) / 20)) > 0 and var_663_1 < var_663_5 then
					arg_660_1.talkMaxDuration = var_663_5

					if var_663_5 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_5 + var_663_0
					end
				end

				arg_660_1.text_.text = var_663_3
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606167", "story_v_side_new_1106606.awb") ~= 0 then
					local var_663_6 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606167", "story_v_side_new_1106606.awb") / 1000

					if var_663_6 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_6 + var_663_0
					end

					if var_663_2.prefab_name ~= "" and arg_660_1.actors_[var_663_2.prefab_name] ~= nil then
						local var_663_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_660_1.actors_[var_663_2.prefab_name].transform, "story_v_side_new_1106606", "1106606167", "story_v_side_new_1106606.awb")

						arg_660_1:RecordAudio("1106606167", var_663_7)
						arg_660_1:RecordAudio("1106606167", var_663_7)
					else
						arg_660_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606167", "story_v_side_new_1106606.awb")
					end

					arg_660_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606167", "story_v_side_new_1106606.awb")
				end

				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_8 = math.max(var_663_1, arg_660_1.talkMaxDuration)

			if var_663_0 <= arg_660_1.time_ and arg_660_1.time_ < var_663_0 + var_663_8 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_0) / var_663_8

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_0 + var_663_8 and arg_660_1.time_ < var_663_0 + var_663_8 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1106606168 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1106606168
		arg_664_1.duration_ = 9.57

		local var_664_0 = {
			zh = 9.566,
			ja = 8.333
		}
		local var_664_1 = manager.audio:GetLocalizationFlag()

		if var_664_0[var_664_1] ~= nil then
			arg_664_1.duration_ = var_664_0[var_664_1]
		end

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play1106606169(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0.925

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				arg_664_1.leftNameTxt_.text = arg_664_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_1 = arg_664_1:GetWordFromCfg(1106606168)
				local var_667_2 = arg_664_1:FormatText(var_667_1.content)

				arg_664_1.text_.text = var_667_2

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_4 = 37 <= 0 and var_667_0 or var_667_0 * (utf8.len(var_667_2) / 37)

				if (37 <= 0 and var_667_0 or var_667_0 * (utf8.len(var_667_2) / 37)) > 0 and var_667_0 < var_667_4 then
					arg_664_1.talkMaxDuration = var_667_4

					if var_667_4 + 0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_4 + 0
					end
				end

				arg_664_1.text_.text = var_667_2
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606168", "story_v_side_new_1106606.awb") ~= 0 then
					local var_667_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606168", "story_v_side_new_1106606.awb") / 1000

					if var_667_5 + 0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_5 + 0
					end

					if var_667_1.prefab_name ~= "" and arg_664_1.actors_[var_667_1.prefab_name] ~= nil then
						local var_667_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_1.prefab_name].transform, "story_v_side_new_1106606", "1106606168", "story_v_side_new_1106606.awb")

						arg_664_1:RecordAudio("1106606168", var_667_6)
						arg_664_1:RecordAudio("1106606168", var_667_6)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606168", "story_v_side_new_1106606.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606168", "story_v_side_new_1106606.awb")
				end

				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_7 = math.max(var_667_0, arg_664_1.talkMaxDuration)

			if 0 <= arg_664_1.time_ and arg_664_1.time_ < 0 + var_667_7 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - 0) / var_667_7

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= 0 + var_667_7 and arg_664_1.time_ < 0 + var_667_7 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play1106606169 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1106606169
		arg_668_1.duration_ = 1

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"

			SetActive(arg_668_1.choicesGo_, true)

			for iter_669_0, iter_669_1 in ipairs(arg_668_1.choices_) do
				SetActive(iter_669_1.go, iter_669_0 <= 1)
			end

			arg_668_1.choices_[1].txt.text = arg_668_1:FormatText(StoryChoiceCfg[565].name)
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1106606170(arg_668_1)
			end

			arg_668_1:RecordChoiceLog(1106606169, 565)
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			if 0 < arg_668_1.time_ and arg_668_1.time_ <= 0 + arg_671_0 and not isNil(arg_668_1.actors_["1066ui_story"]) and arg_668_1.var_.characterEffect1066ui_story == nil then
				arg_668_1.var_.characterEffect1066ui_story = arg_668_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_671_0 = 0.200000002980232

			if 0 <= arg_668_1.time_ and arg_668_1.time_ < 0 + var_671_0 and not isNil(arg_668_1.actors_["1066ui_story"]) then
				if arg_668_1.var_.characterEffect1066ui_story and not isNil(arg_668_1.actors_["1066ui_story"]) then
					arg_668_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_668_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_668_1.time_ - 0) / var_671_0)
				end
			end

			if arg_668_1.time_ >= 0 + var_671_0 and arg_668_1.time_ < 0 + var_671_0 + arg_671_0 and not isNil(arg_668_1.actors_["1066ui_story"]) and arg_668_1.var_.characterEffect1066ui_story then
				arg_668_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_668_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_671_1 = 0

			if 0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_1 + arg_671_0 then
				arg_668_1.allBtn_.enabled = false
			end

			if arg_668_1.time_ >= var_671_1 + 0.5 and arg_668_1.time_ < var_671_1 + 0.5 + arg_671_0 then
				arg_668_1.allBtn_.enabled = true
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1106606170 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1106606170
		arg_672_1.duration_ = 6.1

		local var_672_0 = {
			zh = 4.066,
			ja = 6.1
		}
		local var_672_1 = manager.audio:GetLocalizationFlag()

		if var_672_0[var_672_1] ~= nil then
			arg_672_1.duration_ = var_672_0[var_672_1]
		end

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1106606171(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 then
				arg_672_1.var_.moveOldPos1066ui_story = arg_672_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_675_0 = 0.001

			if 0 <= arg_672_1.time_ and arg_672_1.time_ < 0 + var_675_0 then
				arg_672_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_672_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_672_1.time_ - 0) / var_675_0)
				arg_672_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_672_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_672_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_672_1.actors_["1066ui_story"].transform.position).z)
				arg_672_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_672_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_672_1.actors_["1066ui_story"].transform.localEulerAngles = arg_672_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_672_1.time_ >= 0 + var_675_0 and arg_672_1.time_ < 0 + var_675_0 + arg_675_0 then
				arg_672_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_672_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_672_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_672_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_672_1.actors_["1066ui_story"].transform.position).z)
				arg_672_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_672_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_672_1.actors_["1066ui_story"].transform.localEulerAngles = arg_672_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_675_1 = arg_672_1.actors_["1066ui_story"]

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 and not isNil(var_675_1) and arg_672_1.var_.characterEffect1066ui_story == nil then
				arg_672_1.var_.characterEffect1066ui_story = var_675_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_675_2 = 0.200000002980232

			if 0 <= arg_672_1.time_ and arg_672_1.time_ < 0 + var_675_2 and not isNil(var_675_1) then
				if arg_672_1.var_.characterEffect1066ui_story and not isNil(var_675_1) then
					arg_672_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_672_1.time_ >= 0 + var_675_2 and arg_672_1.time_ < 0 + var_675_2 + arg_675_0 and not isNil(var_675_1) and arg_672_1.var_.characterEffect1066ui_story then
				arg_672_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 then
				arg_672_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_2")
			end

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 then
				arg_672_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_675_4 = 0
			local var_675_5 = 0.4

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_4 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				arg_672_1.leftNameTxt_.text = arg_672_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_6 = arg_672_1:GetWordFromCfg(1106606170)
				local var_675_7 = arg_672_1:FormatText(var_675_6.content)

				arg_672_1.text_.text = var_675_7

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_9 = 16 <= 0 and var_675_5 or var_675_5 * (utf8.len(var_675_7) / 16)

				if (16 <= 0 and var_675_5 or var_675_5 * (utf8.len(var_675_7) / 16)) > 0 and var_675_5 < var_675_9 then
					arg_672_1.talkMaxDuration = var_675_9

					if var_675_9 + var_675_4 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_9 + var_675_4
					end
				end

				arg_672_1.text_.text = var_675_7
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606170", "story_v_side_new_1106606.awb") ~= 0 then
					local var_675_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606170", "story_v_side_new_1106606.awb") / 1000

					if var_675_10 + var_675_4 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_10 + var_675_4
					end

					if var_675_6.prefab_name ~= "" and arg_672_1.actors_[var_675_6.prefab_name] ~= nil then
						local var_675_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_672_1.actors_[var_675_6.prefab_name].transform, "story_v_side_new_1106606", "1106606170", "story_v_side_new_1106606.awb")

						arg_672_1:RecordAudio("1106606170", var_675_11)
						arg_672_1:RecordAudio("1106606170", var_675_11)
					else
						arg_672_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606170", "story_v_side_new_1106606.awb")
					end

					arg_672_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606170", "story_v_side_new_1106606.awb")
				end

				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_12 = math.max(var_675_5, arg_672_1.talkMaxDuration)

			if var_675_4 <= arg_672_1.time_ and arg_672_1.time_ < var_675_4 + var_675_12 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_4) / var_675_12

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_4 + var_675_12 and arg_672_1.time_ < var_675_4 + var_675_12 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {
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

		arg_672_1:InitPlayNodeList()
	end,
	Play1106606171 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 1106606171
		arg_676_1.duration_ = 5

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play1106606172(arg_676_1)
			end
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			if 0 < arg_676_1.time_ and arg_676_1.time_ <= 0 + arg_679_0 and not isNil(arg_676_1.actors_["1066ui_story"]) and arg_676_1.var_.characterEffect1066ui_story == nil then
				arg_676_1.var_.characterEffect1066ui_story = arg_676_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_679_0 = 0.200000002980232

			if 0 <= arg_676_1.time_ and arg_676_1.time_ < 0 + var_679_0 and not isNil(arg_676_1.actors_["1066ui_story"]) then
				if arg_676_1.var_.characterEffect1066ui_story and not isNil(arg_676_1.actors_["1066ui_story"]) then
					arg_676_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_676_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_676_1.time_ - 0) / var_679_0)
				end
			end

			if arg_676_1.time_ >= 0 + var_679_0 and arg_676_1.time_ < 0 + var_679_0 + arg_679_0 and not isNil(arg_676_1.actors_["1066ui_story"]) and arg_676_1.var_.characterEffect1066ui_story then
				arg_676_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_676_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_679_1 = 0
			local var_679_2 = 0.55

			if 0 < arg_676_1.time_ and arg_676_1.time_ <= var_679_1 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0
				arg_676_1.dialogCg_.alpha = 1

				arg_676_1.dialog_:SetActive(true)
				SetActive(arg_676_1.leftNameGo_, true)

				arg_676_1.leftNameTxt_.text = arg_676_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_676_1.leftNameTxt_.transform)

				arg_676_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_676_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_676_1:RecordName(arg_676_1.leftNameTxt_.text)
				SetActive(arg_676_1.iconTrs_.gameObject, true)
				arg_676_1.iconController_:SetSelectedState("hero")

				arg_676_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_676_1.callingController_:SetSelectedState("normal")

				arg_676_1.keyicon_.color = Color.New(1, 1, 1)
				arg_676_1.icon_.color = Color.New(1, 1, 1)

				local var_679_3 = arg_676_1:FormatText(arg_676_1:GetWordFromCfg(1106606171).content)

				arg_676_1.text_.text = var_679_3

				LuaForUtil.ClearLinePrefixSymbol(arg_676_1.text_)

				local var_679_5 = 22 <= 0 and var_679_2 or var_679_2 * (utf8.len(var_679_3) / 22)

				if (22 <= 0 and var_679_2 or var_679_2 * (utf8.len(var_679_3) / 22)) > 0 and var_679_2 < var_679_5 then
					arg_676_1.talkMaxDuration = var_679_5

					if var_679_5 + var_679_1 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_5 + var_679_1
					end
				end

				arg_676_1.text_.text = var_679_3
				arg_676_1.typewritter.percent = 0

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(false)
				arg_676_1:RecordContent(arg_676_1.text_.text)
			end

			local var_679_6 = math.max(var_679_2, arg_676_1.talkMaxDuration)

			if var_679_1 <= arg_676_1.time_ and arg_676_1.time_ < var_679_1 + var_679_6 then
				arg_676_1.typewritter.percent = (arg_676_1.time_ - var_679_1) / var_679_6

				arg_676_1.typewritter:SetDirty()
			end

			if arg_676_1.time_ >= var_679_1 + var_679_6 and arg_676_1.time_ < var_679_1 + var_679_6 + arg_679_0 then
				arg_676_1.typewritter.percent = 1

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(true)
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play1106606172 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 1106606172
		arg_680_1.duration_ = 6.77

		local var_680_0 = {
			zh = 3.633,
			ja = 6.766
		}
		local var_680_1 = manager.audio:GetLocalizationFlag()

		if var_680_0[var_680_1] ~= nil then
			arg_680_1.duration_ = var_680_0[var_680_1]
		end

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play1106606173(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 then
				arg_680_1.var_.moveOldPos1066ui_story = arg_680_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_683_0 = 0.001

			if 0 <= arg_680_1.time_ and arg_680_1.time_ < 0 + var_683_0 then
				arg_680_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_680_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_680_1.time_ - 0) / var_683_0)
				arg_680_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_680_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_680_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_680_1.actors_["1066ui_story"].transform.position).z)
				arg_680_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_680_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_680_1.actors_["1066ui_story"].transform.localEulerAngles = arg_680_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_680_1.time_ >= 0 + var_683_0 and arg_680_1.time_ < 0 + var_683_0 + arg_683_0 then
				arg_680_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_680_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_680_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_680_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_680_1.actors_["1066ui_story"].transform.position).z)
				arg_680_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_680_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_680_1.actors_["1066ui_story"].transform.localEulerAngles = arg_680_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_683_1 = arg_680_1.actors_["1066ui_story"]

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 and not isNil(var_683_1) and arg_680_1.var_.characterEffect1066ui_story == nil then
				arg_680_1.var_.characterEffect1066ui_story = var_683_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_683_2 = 0.200000002980232

			if 0 <= arg_680_1.time_ and arg_680_1.time_ < 0 + var_683_2 and not isNil(var_683_1) then
				if arg_680_1.var_.characterEffect1066ui_story and not isNil(var_683_1) then
					arg_680_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_680_1.time_ >= 0 + var_683_2 and arg_680_1.time_ < 0 + var_683_2 + arg_683_0 and not isNil(var_683_1) and arg_680_1.var_.characterEffect1066ui_story then
				arg_680_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 then
				arg_680_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 then
				arg_680_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_683_4 = 0
			local var_683_5 = 0.2

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= var_683_4 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, true)

				arg_680_1.leftNameTxt_.text = arg_680_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_680_1.leftNameTxt_.transform)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1.leftNameTxt_.text)
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_6 = arg_680_1:GetWordFromCfg(1106606172)
				local var_683_7 = arg_680_1:FormatText(var_683_6.content)

				arg_680_1.text_.text = var_683_7

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_9 = 8 <= 0 and var_683_5 or var_683_5 * (utf8.len(var_683_7) / 8)

				if (8 <= 0 and var_683_5 or var_683_5 * (utf8.len(var_683_7) / 8)) > 0 and var_683_5 < var_683_9 then
					arg_680_1.talkMaxDuration = var_683_9

					if var_683_9 + var_683_4 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_9 + var_683_4
					end
				end

				arg_680_1.text_.text = var_683_7
				arg_680_1.typewritter.percent = 0

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606172", "story_v_side_new_1106606.awb") ~= 0 then
					local var_683_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606172", "story_v_side_new_1106606.awb") / 1000

					if var_683_10 + var_683_4 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_10 + var_683_4
					end

					if var_683_6.prefab_name ~= "" and arg_680_1.actors_[var_683_6.prefab_name] ~= nil then
						local var_683_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_680_1.actors_[var_683_6.prefab_name].transform, "story_v_side_new_1106606", "1106606172", "story_v_side_new_1106606.awb")

						arg_680_1:RecordAudio("1106606172", var_683_11)
						arg_680_1:RecordAudio("1106606172", var_683_11)
					else
						arg_680_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606172", "story_v_side_new_1106606.awb")
					end

					arg_680_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606172", "story_v_side_new_1106606.awb")
				end

				arg_680_1:RecordContent(arg_680_1.text_.text)
			end

			local var_683_12 = math.max(var_683_5, arg_680_1.talkMaxDuration)

			if var_683_4 <= arg_680_1.time_ and arg_680_1.time_ < var_683_4 + var_683_12 then
				arg_680_1.typewritter.percent = (arg_680_1.time_ - var_683_4) / var_683_12

				arg_680_1.typewritter:SetDirty()
			end

			if arg_680_1.time_ >= var_683_4 + var_683_12 and arg_680_1.time_ < var_683_4 + var_683_12 + arg_683_0 then
				arg_680_1.typewritter.percent = 1

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(true)
			end
		end

		arg_680_1.nodeConfigList_ = {
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

		arg_680_1:InitPlayNodeList()
	end,
	Play1106606173 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 1106606173
		arg_684_1.duration_ = 5

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play1106606174(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			if 0 < arg_684_1.time_ and arg_684_1.time_ <= 0 + arg_687_0 and not isNil(arg_684_1.actors_["1066ui_story"]) and arg_684_1.var_.characterEffect1066ui_story == nil then
				arg_684_1.var_.characterEffect1066ui_story = arg_684_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_687_0 = 0.200000002980232

			if 0 <= arg_684_1.time_ and arg_684_1.time_ < 0 + var_687_0 and not isNil(arg_684_1.actors_["1066ui_story"]) then
				if arg_684_1.var_.characterEffect1066ui_story and not isNil(arg_684_1.actors_["1066ui_story"]) then
					arg_684_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_684_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_684_1.time_ - 0) / var_687_0)
				end
			end

			if arg_684_1.time_ >= 0 + var_687_0 and arg_684_1.time_ < 0 + var_687_0 + arg_687_0 and not isNil(arg_684_1.actors_["1066ui_story"]) and arg_684_1.var_.characterEffect1066ui_story then
				arg_684_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_684_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_687_1 = 0
			local var_687_2 = 0.525

			if 0 < arg_684_1.time_ and arg_684_1.time_ <= var_687_1 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0
				arg_684_1.dialogCg_.alpha = 1

				arg_684_1.dialog_:SetActive(true)
				SetActive(arg_684_1.leftNameGo_, false)

				arg_684_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_684_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_684_1:RecordName(arg_684_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_684_1.iconTrs_.gameObject, false)
				arg_684_1.callingController_:SetSelectedState("normal")

				local var_687_3 = arg_684_1:FormatText(arg_684_1:GetWordFromCfg(1106606173).content)

				arg_684_1.text_.text = var_687_3

				LuaForUtil.ClearLinePrefixSymbol(arg_684_1.text_)

				local var_687_5 = 21 <= 0 and var_687_2 or var_687_2 * (utf8.len(var_687_3) / 21)

				if (21 <= 0 and var_687_2 or var_687_2 * (utf8.len(var_687_3) / 21)) > 0 and var_687_2 < var_687_5 then
					arg_684_1.talkMaxDuration = var_687_5

					if var_687_5 + var_687_1 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_5 + var_687_1
					end
				end

				arg_684_1.text_.text = var_687_3
				arg_684_1.typewritter.percent = 0

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(false)
				arg_684_1:RecordContent(arg_684_1.text_.text)
			end

			local var_687_6 = math.max(var_687_2, arg_684_1.talkMaxDuration)

			if var_687_1 <= arg_684_1.time_ and arg_684_1.time_ < var_687_1 + var_687_6 then
				arg_684_1.typewritter.percent = (arg_684_1.time_ - var_687_1) / var_687_6

				arg_684_1.typewritter:SetDirty()
			end

			if arg_684_1.time_ >= var_687_1 + var_687_6 and arg_684_1.time_ < var_687_1 + var_687_6 + arg_687_0 then
				arg_684_1.typewritter.percent = 1

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(true)
			end
		end

		arg_684_1.nodeConfigList_ = {}

		arg_684_1:InitPlayNodeList()
	end,
	Play1106606174 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 1106606174
		arg_688_1.duration_ = 5

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
		end

		function arg_688_1.playNext_(arg_690_0)
			if arg_690_0 == 1 then
				arg_688_0:Play1106606175(arg_688_1)
			end
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			local var_691_0 = 0.8

			if 0 < arg_688_1.time_ and arg_688_1.time_ <= 0 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0
				arg_688_1.dialogCg_.alpha = 1

				arg_688_1.dialog_:SetActive(true)
				SetActive(arg_688_1.leftNameGo_, false)

				arg_688_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_688_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_688_1:RecordName(arg_688_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_688_1.iconTrs_.gameObject, false)
				arg_688_1.callingController_:SetSelectedState("normal")

				local var_691_1 = arg_688_1:FormatText(arg_688_1:GetWordFromCfg(1106606174).content)

				arg_688_1.text_.text = var_691_1

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.text_)

				local var_691_3 = 32 <= 0 and var_691_0 or var_691_0 * (utf8.len(var_691_1) / 32)

				if (32 <= 0 and var_691_0 or var_691_0 * (utf8.len(var_691_1) / 32)) > 0 and var_691_0 < var_691_3 then
					arg_688_1.talkMaxDuration = var_691_3

					if var_691_3 + 0 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_3 + 0
					end
				end

				arg_688_1.text_.text = var_691_1
				arg_688_1.typewritter.percent = 0

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(false)
				arg_688_1:RecordContent(arg_688_1.text_.text)
			end

			local var_691_4 = math.max(var_691_0, arg_688_1.talkMaxDuration)

			if 0 <= arg_688_1.time_ and arg_688_1.time_ < 0 + var_691_4 then
				arg_688_1.typewritter.percent = (arg_688_1.time_ - 0) / var_691_4

				arg_688_1.typewritter:SetDirty()
			end

			if arg_688_1.time_ >= 0 + var_691_4 and arg_688_1.time_ < 0 + var_691_4 + arg_691_0 then
				arg_688_1.typewritter.percent = 1

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(true)
			end
		end

		arg_688_1.nodeConfigList_ = {}

		arg_688_1:InitPlayNodeList()
	end,
	Play1106606175 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 1106606175
		arg_692_1.duration_ = 7.67

		local var_692_0 = {
			zh = 4.566,
			ja = 7.666
		}
		local var_692_1 = manager.audio:GetLocalizationFlag()

		if var_692_0[var_692_1] ~= nil then
			arg_692_1.duration_ = var_692_0[var_692_1]
		end

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
			arg_692_1.auto_ = false
		end

		function arg_692_1.playNext_(arg_694_0)
			arg_692_1.onStoryFinished_()
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			if 0 < arg_692_1.time_ and arg_692_1.time_ <= 0 + arg_695_0 then
				arg_692_1.var_.moveOldPos1066ui_story = arg_692_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_695_0 = 0.001

			if 0 <= arg_692_1.time_ and arg_692_1.time_ < 0 + var_695_0 then
				arg_692_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_692_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_692_1.time_ - 0) / var_695_0)
				arg_692_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_692_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_692_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_692_1.actors_["1066ui_story"].transform.position).z)
				arg_692_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_692_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_692_1.actors_["1066ui_story"].transform.localEulerAngles = arg_692_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_692_1.time_ >= 0 + var_695_0 and arg_692_1.time_ < 0 + var_695_0 + arg_695_0 then
				arg_692_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_692_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_692_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_692_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_692_1.actors_["1066ui_story"].transform.position).z)
				arg_692_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_692_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_692_1.actors_["1066ui_story"].transform.localEulerAngles = arg_692_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_695_1 = arg_692_1.actors_["1066ui_story"]

			if 0 < arg_692_1.time_ and arg_692_1.time_ <= 0 + arg_695_0 and not isNil(var_695_1) and arg_692_1.var_.characterEffect1066ui_story == nil then
				arg_692_1.var_.characterEffect1066ui_story = var_695_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_695_2 = 0.200000002980232

			if 0 <= arg_692_1.time_ and arg_692_1.time_ < 0 + var_695_2 and not isNil(var_695_1) then
				if arg_692_1.var_.characterEffect1066ui_story and not isNil(var_695_1) then
					arg_692_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_692_1.time_ >= 0 + var_695_2 and arg_692_1.time_ < 0 + var_695_2 + arg_695_0 and not isNil(var_695_1) and arg_692_1.var_.characterEffect1066ui_story then
				arg_692_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_692_1.time_ and arg_692_1.time_ <= 0 + arg_695_0 then
				arg_692_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 0 < arg_692_1.time_ and arg_692_1.time_ <= 0 + arg_695_0 then
				arg_692_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_695_4 = 0
			local var_695_5 = 0.35

			if 0 < arg_692_1.time_ and arg_692_1.time_ <= var_695_4 + arg_695_0 then
				arg_692_1.talkMaxDuration = 0
				arg_692_1.dialogCg_.alpha = 1

				arg_692_1.dialog_:SetActive(true)
				SetActive(arg_692_1.leftNameGo_, true)

				arg_692_1.leftNameTxt_.text = arg_692_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_692_1.leftNameTxt_.transform)

				arg_692_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_692_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_692_1:RecordName(arg_692_1.leftNameTxt_.text)
				SetActive(arg_692_1.iconTrs_.gameObject, false)
				arg_692_1.callingController_:SetSelectedState("normal")

				local var_695_6 = arg_692_1:GetWordFromCfg(1106606175)
				local var_695_7 = arg_692_1:FormatText(var_695_6.content)

				arg_692_1.text_.text = var_695_7

				LuaForUtil.ClearLinePrefixSymbol(arg_692_1.text_)

				local var_695_9 = 14 <= 0 and var_695_5 or var_695_5 * (utf8.len(var_695_7) / 14)

				if (14 <= 0 and var_695_5 or var_695_5 * (utf8.len(var_695_7) / 14)) > 0 and var_695_5 < var_695_9 then
					arg_692_1.talkMaxDuration = var_695_9

					if var_695_9 + var_695_4 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_9 + var_695_4
					end
				end

				arg_692_1.text_.text = var_695_7
				arg_692_1.typewritter.percent = 0

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606175", "story_v_side_new_1106606.awb") ~= 0 then
					local var_695_10 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606175", "story_v_side_new_1106606.awb") / 1000

					if var_695_10 + var_695_4 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_10 + var_695_4
					end

					if var_695_6.prefab_name ~= "" and arg_692_1.actors_[var_695_6.prefab_name] ~= nil then
						local var_695_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_692_1.actors_[var_695_6.prefab_name].transform, "story_v_side_new_1106606", "1106606175", "story_v_side_new_1106606.awb")

						arg_692_1:RecordAudio("1106606175", var_695_11)
						arg_692_1:RecordAudio("1106606175", var_695_11)
					else
						arg_692_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606175", "story_v_side_new_1106606.awb")
					end

					arg_692_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606175", "story_v_side_new_1106606.awb")
				end

				arg_692_1:RecordContent(arg_692_1.text_.text)
			end

			local var_695_12 = math.max(var_695_5, arg_692_1.talkMaxDuration)

			if var_695_4 <= arg_692_1.time_ and arg_692_1.time_ < var_695_4 + var_695_12 then
				arg_692_1.typewritter.percent = (arg_692_1.time_ - var_695_4) / var_695_12

				arg_692_1.typewritter:SetDirty()
			end

			if arg_692_1.time_ >= var_695_4 + var_695_12 and arg_692_1.time_ < var_695_4 + var_695_12 + arg_695_0 then
				arg_692_1.typewritter.percent = 1

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(true)
			end
		end

		arg_692_1.nodeConfigList_ = {
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

		arg_692_1:InitPlayNodeList()
	end,
	Play1106606109 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 1106606109
		arg_696_1.duration_ = 5.9

		local var_696_0 = {
			zh = 5.9,
			ja = 3.733
		}
		local var_696_1 = manager.audio:GetLocalizationFlag()

		if var_696_0[var_696_1] ~= nil then
			arg_696_1.duration_ = var_696_0[var_696_1]
		end

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play1106606110(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			local var_699_0 = 0.45

			if 0 < arg_696_1.time_ and arg_696_1.time_ <= 0 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0
				arg_696_1.dialogCg_.alpha = 1

				arg_696_1.dialog_:SetActive(true)
				SetActive(arg_696_1.leftNameGo_, true)

				arg_696_1.leftNameTxt_.text = arg_696_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_696_1.leftNameTxt_.transform)

				arg_696_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_696_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_696_1:RecordName(arg_696_1.leftNameTxt_.text)
				SetActive(arg_696_1.iconTrs_.gameObject, false)
				arg_696_1.callingController_:SetSelectedState("normal")

				local var_699_1 = arg_696_1:GetWordFromCfg(1106606109)
				local var_699_2 = arg_696_1:FormatText(var_699_1.content)

				arg_696_1.text_.text = var_699_2

				LuaForUtil.ClearLinePrefixSymbol(arg_696_1.text_)

				local var_699_4 = 18 <= 0 and var_699_0 or var_699_0 * (utf8.len(var_699_2) / 18)

				if (18 <= 0 and var_699_0 or var_699_0 * (utf8.len(var_699_2) / 18)) > 0 and var_699_0 < var_699_4 then
					arg_696_1.talkMaxDuration = var_699_4

					if var_699_4 + 0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_4 + 0
					end
				end

				arg_696_1.text_.text = var_699_2
				arg_696_1.typewritter.percent = 0

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606109", "story_v_side_new_1106606.awb") ~= 0 then
					local var_699_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606109", "story_v_side_new_1106606.awb") / 1000

					if var_699_5 + 0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_5 + 0
					end

					if var_699_1.prefab_name ~= "" and arg_696_1.actors_[var_699_1.prefab_name] ~= nil then
						local var_699_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_696_1.actors_[var_699_1.prefab_name].transform, "story_v_side_new_1106606", "1106606109", "story_v_side_new_1106606.awb")

						arg_696_1:RecordAudio("1106606109", var_699_6)
						arg_696_1:RecordAudio("1106606109", var_699_6)
					else
						arg_696_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606109", "story_v_side_new_1106606.awb")
					end

					arg_696_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606109", "story_v_side_new_1106606.awb")
				end

				arg_696_1:RecordContent(arg_696_1.text_.text)
			end

			local var_699_7 = math.max(var_699_0, arg_696_1.talkMaxDuration)

			if 0 <= arg_696_1.time_ and arg_696_1.time_ < 0 + var_699_7 then
				arg_696_1.typewritter.percent = (arg_696_1.time_ - 0) / var_699_7

				arg_696_1.typewritter:SetDirty()
			end

			if arg_696_1.time_ >= 0 + var_699_7 and arg_696_1.time_ < 0 + var_699_7 + arg_699_0 then
				arg_696_1.typewritter.percent = 1

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(true)
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	Play1106606110 = function(arg_700_0, arg_700_1)
		arg_700_1.time_ = 0
		arg_700_1.frameCnt_ = 0
		arg_700_1.state_ = "playing"
		arg_700_1.curTalkId_ = 1106606110
		arg_700_1.duration_ = 5

		SetActive(arg_700_1.tipsGo_, false)

		function arg_700_1.onSingleLineFinish_()
			arg_700_1.onSingleLineUpdate_ = nil
			arg_700_1.onSingleLineFinish_ = nil
			arg_700_1.state_ = "waiting"
		end

		function arg_700_1.playNext_(arg_702_0)
			if arg_702_0 == 1 then
				arg_700_0:Play1106606111(arg_700_1)
			end
		end

		function arg_700_1.onSingleLineUpdate_(arg_703_0)
			local var_703_0 = 0.925

			if 0 < arg_700_1.time_ and arg_700_1.time_ <= 0 + arg_703_0 then
				arg_700_1.talkMaxDuration = 0
				arg_700_1.dialogCg_.alpha = 1

				arg_700_1.dialog_:SetActive(true)
				SetActive(arg_700_1.leftNameGo_, false)

				arg_700_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_700_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_700_1:RecordName(arg_700_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_700_1.iconTrs_.gameObject, false)
				arg_700_1.callingController_:SetSelectedState("normal")

				local var_703_1 = arg_700_1:FormatText(arg_700_1:GetWordFromCfg(1106606110).content)

				arg_700_1.text_.text = var_703_1

				LuaForUtil.ClearLinePrefixSymbol(arg_700_1.text_)

				local var_703_3 = 37 <= 0 and var_703_0 or var_703_0 * (utf8.len(var_703_1) / 37)

				if (37 <= 0 and var_703_0 or var_703_0 * (utf8.len(var_703_1) / 37)) > 0 and var_703_0 < var_703_3 then
					arg_700_1.talkMaxDuration = var_703_3

					if var_703_3 + 0 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_3 + 0
					end
				end

				arg_700_1.text_.text = var_703_1
				arg_700_1.typewritter.percent = 0

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(false)
				arg_700_1:RecordContent(arg_700_1.text_.text)
			end

			local var_703_4 = math.max(var_703_0, arg_700_1.talkMaxDuration)

			if 0 <= arg_700_1.time_ and arg_700_1.time_ < 0 + var_703_4 then
				arg_700_1.typewritter.percent = (arg_700_1.time_ - 0) / var_703_4

				arg_700_1.typewritter:SetDirty()
			end

			if arg_700_1.time_ >= 0 + var_703_4 and arg_700_1.time_ < 0 + var_703_4 + arg_703_0 then
				arg_700_1.typewritter.percent = 1

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(true)
			end
		end

		arg_700_1.nodeConfigList_ = {}

		arg_700_1:InitPlayNodeList()
	end,
	Play1106606104 = function(arg_704_0, arg_704_1)
		arg_704_1.time_ = 0
		arg_704_1.frameCnt_ = 0
		arg_704_1.state_ = "playing"
		arg_704_1.curTalkId_ = 1106606104
		arg_704_1.duration_ = 5

		SetActive(arg_704_1.tipsGo_, false)

		function arg_704_1.onSingleLineFinish_()
			arg_704_1.onSingleLineUpdate_ = nil
			arg_704_1.onSingleLineFinish_ = nil
			arg_704_1.state_ = "waiting"
		end

		function arg_704_1.playNext_(arg_706_0)
			if arg_706_0 == 1 then
				arg_704_0:Play1106606105(arg_704_1)
			end
		end

		function arg_704_1.onSingleLineUpdate_(arg_707_0)
			local var_707_0 = 1.125

			if 0 < arg_704_1.time_ and arg_704_1.time_ <= 0 + arg_707_0 then
				arg_704_1.talkMaxDuration = 0
				arg_704_1.dialogCg_.alpha = 1

				arg_704_1.dialog_:SetActive(true)
				SetActive(arg_704_1.leftNameGo_, false)

				arg_704_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_704_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_704_1:RecordName(arg_704_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_704_1.iconTrs_.gameObject, false)
				arg_704_1.callingController_:SetSelectedState("normal")

				local var_707_1 = arg_704_1:FormatText(arg_704_1:GetWordFromCfg(1106606104).content)

				arg_704_1.text_.text = var_707_1

				LuaForUtil.ClearLinePrefixSymbol(arg_704_1.text_)

				local var_707_3 = 45 <= 0 and var_707_0 or var_707_0 * (utf8.len(var_707_1) / 45)

				if (45 <= 0 and var_707_0 or var_707_0 * (utf8.len(var_707_1) / 45)) > 0 and var_707_0 < var_707_3 then
					arg_704_1.talkMaxDuration = var_707_3

					if var_707_3 + 0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_3 + 0
					end
				end

				arg_704_1.text_.text = var_707_1
				arg_704_1.typewritter.percent = 0

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(false)
				arg_704_1:RecordContent(arg_704_1.text_.text)
			end

			local var_707_4 = math.max(var_707_0, arg_704_1.talkMaxDuration)

			if 0 <= arg_704_1.time_ and arg_704_1.time_ < 0 + var_707_4 then
				arg_704_1.typewritter.percent = (arg_704_1.time_ - 0) / var_707_4

				arg_704_1.typewritter:SetDirty()
			end

			if arg_704_1.time_ >= 0 + var_707_4 and arg_704_1.time_ < 0 + var_707_4 + arg_707_0 then
				arg_704_1.typewritter.percent = 1

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(true)
			end
		end

		arg_704_1.nodeConfigList_ = {}

		arg_704_1:InitPlayNodeList()
	end,
	Play1106606105 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 1106606105
		arg_708_1.duration_ = 4.37

		local var_708_0 = {
			zh = 4.366,
			ja = 3.8
		}
		local var_708_1 = manager.audio:GetLocalizationFlag()

		if var_708_0[var_708_1] ~= nil then
			arg_708_1.duration_ = var_708_0[var_708_1]
		end

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play1106606106(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			local var_711_0 = 0.2

			if 0 < arg_708_1.time_ and arg_708_1.time_ <= 0 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0
				arg_708_1.dialogCg_.alpha = 1

				arg_708_1.dialog_:SetActive(true)
				SetActive(arg_708_1.leftNameGo_, true)

				arg_708_1.leftNameTxt_.text = arg_708_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_708_1.leftNameTxt_.transform)

				arg_708_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_708_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_708_1:RecordName(arg_708_1.leftNameTxt_.text)
				SetActive(arg_708_1.iconTrs_.gameObject, false)
				arg_708_1.callingController_:SetSelectedState("normal")

				local var_711_1 = arg_708_1:GetWordFromCfg(1106606105)
				local var_711_2 = arg_708_1:FormatText(var_711_1.content)

				arg_708_1.text_.text = var_711_2

				LuaForUtil.ClearLinePrefixSymbol(arg_708_1.text_)

				local var_711_4 = 8 <= 0 and var_711_0 or var_711_0 * (utf8.len(var_711_2) / 8)

				if (8 <= 0 and var_711_0 or var_711_0 * (utf8.len(var_711_2) / 8)) > 0 and var_711_0 < var_711_4 then
					arg_708_1.talkMaxDuration = var_711_4

					if var_711_4 + 0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_4 + 0
					end
				end

				arg_708_1.text_.text = var_711_2
				arg_708_1.typewritter.percent = 0

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606105", "story_v_side_new_1106606.awb") ~= 0 then
					local var_711_5 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606105", "story_v_side_new_1106606.awb") / 1000

					if var_711_5 + 0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_5 + 0
					end

					if var_711_1.prefab_name ~= "" and arg_708_1.actors_[var_711_1.prefab_name] ~= nil then
						local var_711_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_708_1.actors_[var_711_1.prefab_name].transform, "story_v_side_new_1106606", "1106606105", "story_v_side_new_1106606.awb")

						arg_708_1:RecordAudio("1106606105", var_711_6)
						arg_708_1:RecordAudio("1106606105", var_711_6)
					else
						arg_708_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606105", "story_v_side_new_1106606.awb")
					end

					arg_708_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606105", "story_v_side_new_1106606.awb")
				end

				arg_708_1:RecordContent(arg_708_1.text_.text)
			end

			local var_711_7 = math.max(var_711_0, arg_708_1.talkMaxDuration)

			if 0 <= arg_708_1.time_ and arg_708_1.time_ < 0 + var_711_7 then
				arg_708_1.typewritter.percent = (arg_708_1.time_ - 0) / var_711_7

				arg_708_1.typewritter:SetDirty()
			end

			if arg_708_1.time_ >= 0 + var_711_7 and arg_708_1.time_ < 0 + var_711_7 + arg_711_0 then
				arg_708_1.typewritter.percent = 1

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(true)
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play1106606069 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 1106606069
		arg_712_1.duration_ = 6.43

		local var_712_0 = {
			zh = 6.366,
			ja = 6.433
		}
		local var_712_1 = manager.audio:GetLocalizationFlag()

		if var_712_0[var_712_1] ~= nil then
			arg_712_1.duration_ = var_712_0[var_712_1]
		end

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play1106606070(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			if 0 < arg_712_1.time_ and arg_712_1.time_ <= 0 + arg_715_0 then
				arg_712_1.var_.moveOldPos1066ui_story = arg_712_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_715_0 = 0.001

			if 0 <= arg_712_1.time_ and arg_712_1.time_ < 0 + var_715_0 then
				arg_712_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_712_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_712_1.time_ - 0) / var_715_0)
				arg_712_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_712_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_712_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_712_1.actors_["1066ui_story"].transform.position).z)
				arg_712_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_712_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_712_1.actors_["1066ui_story"].transform.localEulerAngles = arg_712_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_712_1.time_ >= 0 + var_715_0 and arg_712_1.time_ < 0 + var_715_0 + arg_715_0 then
				arg_712_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_712_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_712_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_712_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_712_1.actors_["1066ui_story"].transform.position).z)
				arg_712_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_712_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_712_1.actors_["1066ui_story"].transform.localEulerAngles = arg_712_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_715_1 = arg_712_1.actors_["1066ui_story"]

			if 0 < arg_712_1.time_ and arg_712_1.time_ <= 0 + arg_715_0 and not isNil(var_715_1) and arg_712_1.var_.characterEffect1066ui_story == nil then
				arg_712_1.var_.characterEffect1066ui_story = var_715_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_715_2 = 0.200000002980232

			if 0 <= arg_712_1.time_ and arg_712_1.time_ < 0 + var_715_2 and not isNil(var_715_1) then
				if arg_712_1.var_.characterEffect1066ui_story and not isNil(var_715_1) then
					arg_712_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_712_1.time_ >= 0 + var_715_2 and arg_712_1.time_ < 0 + var_715_2 + arg_715_0 and not isNil(var_715_1) and arg_712_1.var_.characterEffect1066ui_story then
				arg_712_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_715_4 = "1066ui_story"

			if arg_712_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_715_5 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_712_1.stage_.transform)

				var_715_5.name = var_715_4
				var_715_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_712_1.actors_[var_715_4] = var_715_5

				local var_715_6 = var_715_5:GetComponentInChildren(typeof(CharacterEffect))

				var_715_6.enabled = true

				local var_715_7 = GameObjectTools.GetOrAddComponent(var_715_5, typeof(DynamicBoneHelper))

				if var_715_7 then
					var_715_7:EnableDynamicBone(false)
				end

				arg_712_1:ShowWeapon(var_715_6.transform, false)

				arg_712_1.var_[var_715_4 .. "Animator"] = var_715_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_712_1.var_[var_715_4 .. "Animator"].applyRootMotion = true
				arg_712_1.var_[var_715_4 .. "LipSync"] = var_715_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_712_1.time_ and arg_712_1.time_ <= 0 + arg_715_0 then
				arg_712_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			local var_715_8 = "1066ui_story"

			if arg_712_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_715_9 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_712_1.stage_.transform)

				var_715_9.name = var_715_8
				var_715_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_712_1.actors_[var_715_8] = var_715_9

				local var_715_10 = var_715_9:GetComponentInChildren(typeof(CharacterEffect))

				var_715_10.enabled = true

				local var_715_11 = GameObjectTools.GetOrAddComponent(var_715_9, typeof(DynamicBoneHelper))

				if var_715_11 then
					var_715_11:EnableDynamicBone(false)
				end

				arg_712_1:ShowWeapon(var_715_10.transform, false)

				arg_712_1.var_[var_715_8 .. "Animator"] = var_715_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_712_1.var_[var_715_8 .. "Animator"].applyRootMotion = true
				arg_712_1.var_[var_715_8 .. "LipSync"] = var_715_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_712_1.time_ and arg_712_1.time_ <= 0 + arg_715_0 then
				arg_712_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_715_12 = 0
			local var_715_13 = 0.65

			if 0 < arg_712_1.time_ and arg_712_1.time_ <= var_715_12 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, true)

				arg_712_1.leftNameTxt_.text = arg_712_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_712_1.leftNameTxt_.transform)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1.leftNameTxt_.text)
				SetActive(arg_712_1.iconTrs_.gameObject, false)
				arg_712_1.callingController_:SetSelectedState("normal")

				local var_715_14 = arg_712_1:GetWordFromCfg(1106606069)
				local var_715_15 = arg_712_1:FormatText(var_715_14.content)

				arg_712_1.text_.text = var_715_15

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_17 = 26 <= 0 and var_715_13 or var_715_13 * (utf8.len(var_715_15) / 26)

				if (26 <= 0 and var_715_13 or var_715_13 * (utf8.len(var_715_15) / 26)) > 0 and var_715_13 < var_715_17 then
					arg_712_1.talkMaxDuration = var_715_17

					if var_715_17 + var_715_12 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_17 + var_715_12
					end
				end

				arg_712_1.text_.text = var_715_15
				arg_712_1.typewritter.percent = 0

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606069", "story_v_side_new_1106606.awb") ~= 0 then
					local var_715_18 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606069", "story_v_side_new_1106606.awb") / 1000

					if var_715_18 + var_715_12 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_18 + var_715_12
					end

					if var_715_14.prefab_name ~= "" and arg_712_1.actors_[var_715_14.prefab_name] ~= nil then
						local var_715_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_712_1.actors_[var_715_14.prefab_name].transform, "story_v_side_new_1106606", "1106606069", "story_v_side_new_1106606.awb")

						arg_712_1:RecordAudio("1106606069", var_715_19)
						arg_712_1:RecordAudio("1106606069", var_715_19)
					else
						arg_712_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606069", "story_v_side_new_1106606.awb")
					end

					arg_712_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606069", "story_v_side_new_1106606.awb")
				end

				arg_712_1:RecordContent(arg_712_1.text_.text)
			end

			local var_715_20 = math.max(var_715_13, arg_712_1.talkMaxDuration)

			if var_715_12 <= arg_712_1.time_ and arg_712_1.time_ < var_715_12 + var_715_20 then
				arg_712_1.typewritter.percent = (arg_712_1.time_ - var_715_12) / var_715_20

				arg_712_1.typewritter:SetDirty()
			end

			if arg_712_1.time_ >= var_715_12 + var_715_20 and arg_712_1.time_ < var_715_12 + var_715_20 + arg_715_0 then
				arg_712_1.typewritter.percent = 1

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(true)
			end
		end

		arg_712_1.nodeConfigList_ = {
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

		arg_712_1:InitPlayNodeList()
	end,
	Play1106606070 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 1106606070
		arg_716_1.duration_ = 5

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play1106606071(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			if 0 < arg_716_1.time_ and arg_716_1.time_ <= 0 + arg_719_0 and not isNil(arg_716_1.actors_["1066ui_story"]) and arg_716_1.var_.characterEffect1066ui_story == nil then
				arg_716_1.var_.characterEffect1066ui_story = arg_716_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_719_0 = 0.200000002980232

			if 0 <= arg_716_1.time_ and arg_716_1.time_ < 0 + var_719_0 and not isNil(arg_716_1.actors_["1066ui_story"]) then
				if arg_716_1.var_.characterEffect1066ui_story and not isNil(arg_716_1.actors_["1066ui_story"]) then
					arg_716_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_716_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_716_1.time_ - 0) / var_719_0)
				end
			end

			if arg_716_1.time_ >= 0 + var_719_0 and arg_716_1.time_ < 0 + var_719_0 + arg_719_0 and not isNil(arg_716_1.actors_["1066ui_story"]) and arg_716_1.var_.characterEffect1066ui_story then
				arg_716_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_716_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_719_1 = 0
			local var_719_2 = 0.225

			if 0 < arg_716_1.time_ and arg_716_1.time_ <= var_719_1 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0
				arg_716_1.dialogCg_.alpha = 1

				arg_716_1.dialog_:SetActive(true)
				SetActive(arg_716_1.leftNameGo_, true)

				arg_716_1.leftNameTxt_.text = arg_716_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_716_1.leftNameTxt_.transform)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1.leftNameTxt_.text)
				SetActive(arg_716_1.iconTrs_.gameObject, true)
				arg_716_1.iconController_:SetSelectedState("hero")

				arg_716_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_716_1.callingController_:SetSelectedState("normal")

				arg_716_1.keyicon_.color = Color.New(1, 1, 1)
				arg_716_1.icon_.color = Color.New(1, 1, 1)

				local var_719_3 = arg_716_1:FormatText(arg_716_1:GetWordFromCfg(1106606070).content)

				arg_716_1.text_.text = var_719_3

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_5 = 9 <= 0 and var_719_2 or var_719_2 * (utf8.len(var_719_3) / 9)

				if (9 <= 0 and var_719_2 or var_719_2 * (utf8.len(var_719_3) / 9)) > 0 and var_719_2 < var_719_5 then
					arg_716_1.talkMaxDuration = var_719_5

					if var_719_5 + var_719_1 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_5 + var_719_1
					end
				end

				arg_716_1.text_.text = var_719_3
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)
				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_6 = math.max(var_719_2, arg_716_1.talkMaxDuration)

			if var_719_1 <= arg_716_1.time_ and arg_716_1.time_ < var_719_1 + var_719_6 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - var_719_1) / var_719_6

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= var_719_1 + var_719_6 and arg_716_1.time_ < var_719_1 + var_719_6 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	Play1106606015 = function(arg_720_0, arg_720_1)
		arg_720_1.time_ = 0
		arg_720_1.frameCnt_ = 0
		arg_720_1.state_ = "playing"
		arg_720_1.curTalkId_ = 1106606015
		arg_720_1.duration_ = 8.57

		local var_720_0 = {
			zh = 4.533,
			ja = 8.566
		}
		local var_720_1 = manager.audio:GetLocalizationFlag()

		if var_720_0[var_720_1] ~= nil then
			arg_720_1.duration_ = var_720_0[var_720_1]
		end

		SetActive(arg_720_1.tipsGo_, false)

		function arg_720_1.onSingleLineFinish_()
			arg_720_1.onSingleLineUpdate_ = nil
			arg_720_1.onSingleLineFinish_ = nil
			arg_720_1.state_ = "waiting"
		end

		function arg_720_1.playNext_(arg_722_0)
			if arg_722_0 == 1 then
				arg_720_0:Play1106606016(arg_720_1)
			end
		end

		function arg_720_1.onSingleLineUpdate_(arg_723_0)
			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 then
				arg_720_1.var_.moveOldPos1066ui_story = arg_720_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_723_0 = 0.001

			if 0 <= arg_720_1.time_ and arg_720_1.time_ < 0 + var_723_0 then
				arg_720_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_720_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_720_1.time_ - 0) / var_723_0)
				arg_720_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_720_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_720_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_720_1.actors_["1066ui_story"].transform.position).z)
				arg_720_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_720_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_720_1.actors_["1066ui_story"].transform.localEulerAngles = arg_720_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_720_1.time_ >= 0 + var_723_0 and arg_720_1.time_ < 0 + var_723_0 + arg_723_0 then
				arg_720_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_720_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_720_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_720_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_720_1.actors_["1066ui_story"].transform.position).z)
				arg_720_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_720_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_720_1.actors_["1066ui_story"].transform.localEulerAngles = arg_720_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_723_1 = arg_720_1.actors_["1066ui_story"]

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 and not isNil(var_723_1) and arg_720_1.var_.characterEffect1066ui_story == nil then
				arg_720_1.var_.characterEffect1066ui_story = var_723_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_723_2 = 0.200000002980232

			if 0 <= arg_720_1.time_ and arg_720_1.time_ < 0 + var_723_2 and not isNil(var_723_1) then
				if arg_720_1.var_.characterEffect1066ui_story and not isNil(var_723_1) then
					arg_720_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_720_1.time_ >= 0 + var_723_2 and arg_720_1.time_ < 0 + var_723_2 + arg_723_0 and not isNil(var_723_1) and arg_720_1.var_.characterEffect1066ui_story then
				arg_720_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_723_4 = "1066ui_story"

			if arg_720_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_723_5 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_720_1.stage_.transform)

				var_723_5.name = var_723_4
				var_723_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_720_1.actors_[var_723_4] = var_723_5

				local var_723_6 = var_723_5:GetComponentInChildren(typeof(CharacterEffect))

				var_723_6.enabled = true

				local var_723_7 = GameObjectTools.GetOrAddComponent(var_723_5, typeof(DynamicBoneHelper))

				if var_723_7 then
					var_723_7:EnableDynamicBone(false)
				end

				arg_720_1:ShowWeapon(var_723_6.transform, false)

				arg_720_1.var_[var_723_4 .. "Animator"] = var_723_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_720_1.var_[var_723_4 .. "Animator"].applyRootMotion = true
				arg_720_1.var_[var_723_4 .. "LipSync"] = var_723_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 then
				arg_720_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action436")
			end

			local var_723_8 = "1066ui_story"

			if arg_720_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_723_9 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_720_1.stage_.transform)

				var_723_9.name = var_723_8
				var_723_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_720_1.actors_[var_723_8] = var_723_9

				local var_723_10 = var_723_9:GetComponentInChildren(typeof(CharacterEffect))

				var_723_10.enabled = true

				local var_723_11 = GameObjectTools.GetOrAddComponent(var_723_9, typeof(DynamicBoneHelper))

				if var_723_11 then
					var_723_11:EnableDynamicBone(false)
				end

				arg_720_1:ShowWeapon(var_723_10.transform, false)

				arg_720_1.var_[var_723_8 .. "Animator"] = var_723_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_720_1.var_[var_723_8 .. "Animator"].applyRootMotion = true
				arg_720_1.var_[var_723_8 .. "LipSync"] = var_723_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 then
				arg_720_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_723_12 = 0

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= var_723_12 + arg_723_0 then
				arg_720_1.allBtn_.enabled = false
			end

			if arg_720_1.time_ >= var_723_12 + 2.66666666666667 and arg_720_1.time_ < var_723_12 + 2.66666666666667 + arg_723_0 then
				arg_720_1.allBtn_.enabled = true
			end

			local var_723_13 = 0
			local var_723_14 = 0.575

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= var_723_13 + arg_723_0 then
				arg_720_1.talkMaxDuration = 0
				arg_720_1.dialogCg_.alpha = 1

				arg_720_1.dialog_:SetActive(true)
				SetActive(arg_720_1.leftNameGo_, true)

				arg_720_1.leftNameTxt_.text = arg_720_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_720_1.leftNameTxt_.transform)

				arg_720_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_720_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_720_1:RecordName(arg_720_1.leftNameTxt_.text)
				SetActive(arg_720_1.iconTrs_.gameObject, false)
				arg_720_1.callingController_:SetSelectedState("normal")

				local var_723_15 = arg_720_1:GetWordFromCfg(1106606015)
				local var_723_16 = arg_720_1:FormatText(var_723_15.content)

				arg_720_1.text_.text = var_723_16

				LuaForUtil.ClearLinePrefixSymbol(arg_720_1.text_)

				local var_723_18 = 23 <= 0 and var_723_14 or var_723_14 * (utf8.len(var_723_16) / 23)

				if (23 <= 0 and var_723_14 or var_723_14 * (utf8.len(var_723_16) / 23)) > 0 and var_723_14 < var_723_18 then
					arg_720_1.talkMaxDuration = var_723_18

					if var_723_18 + var_723_13 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_18 + var_723_13
					end
				end

				arg_720_1.text_.text = var_723_16
				arg_720_1.typewritter.percent = 0

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606015", "story_v_side_new_1106606.awb") ~= 0 then
					local var_723_19 = manager.audio:GetVoiceLength("story_v_side_new_1106606", "1106606015", "story_v_side_new_1106606.awb") / 1000

					if var_723_19 + var_723_13 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_19 + var_723_13
					end

					if var_723_15.prefab_name ~= "" and arg_720_1.actors_[var_723_15.prefab_name] ~= nil then
						local var_723_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_720_1.actors_[var_723_15.prefab_name].transform, "story_v_side_new_1106606", "1106606015", "story_v_side_new_1106606.awb")

						arg_720_1:RecordAudio("1106606015", var_723_20)
						arg_720_1:RecordAudio("1106606015", var_723_20)
					else
						arg_720_1:AudioAction("play", "voice", "story_v_side_new_1106606", "1106606015", "story_v_side_new_1106606.awb")
					end

					arg_720_1:RecordHistoryTalkVoice("story_v_side_new_1106606", "1106606015", "story_v_side_new_1106606.awb")
				end

				arg_720_1:RecordContent(arg_720_1.text_.text)
			end

			local var_723_21 = math.max(var_723_14, arg_720_1.talkMaxDuration)

			if var_723_13 <= arg_720_1.time_ and arg_720_1.time_ < var_723_13 + var_723_21 then
				arg_720_1.typewritter.percent = (arg_720_1.time_ - var_723_13) / var_723_21

				arg_720_1.typewritter:SetDirty()
			end

			if arg_720_1.time_ >= var_723_13 + var_723_21 and arg_720_1.time_ < var_723_13 + var_723_21 + arg_723_0 then
				arg_720_1.typewritter.percent = 1

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(true)
			end
		end

		arg_720_1.nodeConfigList_ = {
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

		arg_720_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/R6602",
		"TextureConfig/Background/R6602a"
	},
	voices = {
		"story_v_side_new_1106606.awb"
	}
}
